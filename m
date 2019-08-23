Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0A3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E73B2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="N1GeB/6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbfHWRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:24:27 -0400
Received: from mout.web.de ([212.227.15.14]:48513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388090AbfHWRY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 13:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566581057;
        bh=axaiOeUShbLcLslK7d9+vWY1/tIn2dxWmeYhqI286Jo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N1GeB/6c+DKmDV6l0JAMUJJGyA04U9jzOutwEmRUv1Hi8cdD/XH2p6j5u8EWl1ROY
         XKnFO+NqkWsyN7v91zfkXrUhmooPLCJS4RIp+SiKJHWbhJ6Zrxc57PeKgA7uvApDNP
         N9LLYenmQhZGxzKsXA6+YSqpODseMQPv19sS9WIs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.157.93]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfqC4-1hpCj71idw-00ND8W; Fri, 23
 Aug 2019 19:24:17 +0200
Subject: Re: staging: vt6656: Use common error handling code in
 vnt_alloc_bufs()
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <91e8a9b7-e79d-dafc-10b8-dd79eb59eff9@web.de>
 <20190823145540.GA2536@qd-ubuntu>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <10006e33-ed90-74ec-4d59-4074caf4ecd4@web.de>
Date:   Fri, 23 Aug 2019 19:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823145540.GA2536@qd-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f2OZOzRZwcMG9mCS05z3+J38Ecf6PmC5XXpes47trtjfqk5XosS
 lofMm55AzDrJ+EL5k3ZUEO0RSbTzm4wS32fb+9pv7cbnJIWDT3XPeiXnJa64xW74eMvT14V
 q7Ws/C46B+P8UTZoeCY6IoCZdwc/PcKZ2gM1mhybx/X3No7bbZehvx1SzARsNpt8EKbx+bU
 tz3B4CQyojGvfkqEmYQhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4bqdoIQTb5Q=:tNdzmmacaQ4bQBLHOuihVx
 T38EmW32SSpmoWMHhlBQkvxQhoAs/bgiyqn7dRZRtUCTvJFJQcbK3X9MmUdPMmRrN5dn6seqN
 P/qfZAsukPfR22hGXwzoF/awBcLRcqwnS02gzrngUUuNA3hLbNc39R0FYHsIdyJbFzsMGLGCa
 d9GNukuQFAzh67x+UOB6IVGrNrUwa4nn78rQhZ/XgTiIlt6oL3BkT12KCBS32uJP2a43dtRYX
 w9W4uEcMynUp267QIHhKZ5kQsxH+DQ9AgTNdxenizapokDUvLGDUg+ABL+47pgTeLdRSGa8r4
 SJ8H0a1PnL6ajqcV8khsTz/istsmeq+TwcsYa8it7WHkDv0Xd5cX42v+RWfJ0Ta30ETXvRm11
 E2p3S2fi3QQs22HHWur2rR1iGmQBeTrS4km/uDF4S7NVpl/rQOIbJmV49s5CGNZ9+C6mcQk0S
 4BKxM+K/jRw1uVfmOvHvfkjhUcixkx9ddA+IuXAB4wMrBvhp8D0RiGYegQW8JmulDslrc631/
 Y4wWDe3FqUBYWjeVuzzXEksbBHPMdOwE01+IzLRUU3dQVNpV5KOliNllHCmeNNstP+BtPcDOg
 mxjnwB7xzOJ816DDFe8sKEomTFGVlCsMr6MHwAAwQKnqLH84Rk8QEtZFE5r0aYy8pNz03ylas
 pvR+3WtR5qjrktN/LE495H7EVfheocXC0jFm9AbjXuTDFSysDiwfAumw1prXeypUttk3/qnXO
 HvF2+VlM7HeRnO+xyggDX3d25JjBuBCx4pKuxpj2xUfDQE81W9GDKTdsbeU2ro5jh+2duBG7b
 bPTvpZCZVYhFt4AqeC1W/Uo1xdHpTs+uzGEprT1IR76WA1gkjxlPnXDzgCusHQ1mWe0CPb26K
 K/KyDk8z9S8pNorhnnIyvpneWTAT+ebqY4knYP7XZlLL18LJa74hZdQExA0ptQtponEZSyr1p
 /jF0+0BmKl0cgaqvNZ1TZwE4w5LxZi/0oiyJuCq/g+RgYfzj0SE1fMJoG88WEVbtXE+4tE0rL
 VAYkypte0ixULGcUZt0zoCb11gm2epE/QAYYO+FLcGCy8rzqDYJ8MT7qwElFScD3dHAvlkerQ
 vvk+lellNVxgXJjsyqJk7Pmaos1iqex4qDcrB8+0eTv1pBBg5UH4/ff2y3I1a4U2GcD7+d7yW
 q6tec=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Your patch remove redundant code, which is fine.

Thanks for your constructive feedback.


> code you changed was simple enough to be understand quickly. I think rep=
lacing
> it with a crossed goto (even if it remove redundant code) might not be t=
he best
> option.
>
> A solution might be to move the second loop to the top of the function

I am unsure about the relevance of the loop ordering for the affected
resource allocations.


> so you should be able to replace the end of the cleanup calls with:
>
> enomem:
> 	ret =3D -ENOMEM;
> free_rx:
> 	vnt_free_rx_bufs(priv);
> 	return ret;

The exception handling can eventually adjusted another bit according
to your refactoring.


> This way, only a failed call to vnt_submit_rx_urb() should jump to free_=
rx,

It seems that a goto statement will still be needed in an error code
part by both discussed variants.


> another failed call should jump to enomem or previously defined
> label, so we can correctly forward errors.

This view sounds promising.


> With such solution it might be worth adding a comment to describe
> that all error should be ENOMEM except for vnt_submit_rx_urb().

Can this function implementation become clearer also without
such a comment?

Regards,
Markus
