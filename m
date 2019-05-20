Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF082C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806D620815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="X0rJDgs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfETUMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:12:24 -0400
Received: from mout.web.de ([212.227.17.12]:38761 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETUMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558383122;
        bh=ff64PCuMJeBfpkk5ZZwdYDpdPR3e6g8dV4UJpwufT4Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X0rJDgs17KqFeTaibKUPyNLzp1cvO9x93ldqahpZxK08+Zb6xi2mjP84DJtbiIq2q
         31Z4UY6YP9ONlWcMt0F/rMu1Cq9IYKJ3OQiYdcNM2FieqwB4puGPHvazyieyz1wX2/
         vS6QtgkY7e4Zh1Ac9x8yS9jkAjuNV0ZRHjpi+0OM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.172.132]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbrQm-1gm5yQ31e8-00jGoZ; Mon, 20
 May 2019 22:12:02 +0200
Subject: Re: Coccinelle: semantic patch for missing of_node_put
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Sasha Levin <sashal@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
References: <201905171432571474636@zte.com.cn>
 <alpine.DEB.2.20.1905170912590.4014@hadrien>
 <20190520093303.GA9320@atrey.karlin.mff.cuni.cz>
 <alpine.DEB.2.21.1905201152040.2543@hadrien>
 <20190520172041.GH11972@sasha-vm>
 <alpine.DEB.2.21.1905202151140.2561@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <60d87dff-3b4e-d77b-a4e5-e00b010d414b@web.de>
Date:   Mon, 20 May 2019 22:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905202151140.2561@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:MzYnUDWMSddPVS8EDeHy/BnJM/s4AmRJ/26NNrm2Vv49L+mbLdR
 GVrclo8i+4q8d75iwT8gp3gjZtcpV7zyAdXHjaa/7EYD4xd/7V743rRlQDa9HE87QDh5Gmj
 rs6ATqUTt/OK7IDepSWQ6KGDCl9Op/Syi8qTrL2sGEE7HiEjU7F8OI/vZHGGMRiW8HMqXSq
 t2QhCC3Lx+tOzr5TyJAFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ee762KM2lFk=:BlIMdCVXl9hw+8RJzrZ2A5
 3OljbS3qotNWh/15GcfArxWYdm/D/4hBJgDBdfgMfvhn1aYJ+OJYzikYuWkqhloJeUpu9ITdI
 6ENZNj5ilvvgJIJ2oh4ipk3HF3FblmvyUbAXqeaA+mjrHYaOGP3GS7425YSkiLbBIpElAQhli
 /fmggdvQLaHexN5ZM/TKBi1wP1jnXLgO0ZKezsPIZo9I/Ko2ZmzPrCZWDxhpxzDnt5stnkEHn
 qePJEjr6Y1VgmC3J3VvWVr0O1EOpE1mw4ptMNDExU6XN9R/dpbC/pRWCTw0yiNkr6vxCIoZpA
 cRnJ+9fuxN24UCUQac3fRHa3XN6wg+SABVBPBBWEo/krNdjAgAeI726sOdW6thZQG8MEGvEZd
 93JkNL+YMNbbdJGtIGvC6ZuGNpdJIfVrMWyARY6hGvjiu7lcgXx1C40dsc0seFY5ltsuQhOQk
 1y8Fa/dq1n3xjRZv6owaAeP4gK0pEAWY1K0SNRuGolLedIZJGMVdhMl4uybNTWjpbFSW1LseM
 kHw/ANWFqN2V0mh4WbI1uG7T0DzwqlGC9wK7fAazgLSg4YvF2OXekRlOoC9iXL5jhSplrm88S
 5kB+0bnPeqshhtOgvK95qKaMJf+m0nnszWl+Yi8Na/QmwnrwIYyYG9kR7Cof/HrD49CoHHKrQ
 8AOgcM1Qvskvo5zmQIWRb3+kOyM3eO0tpmLcq2eLsR1VIF1twqqZig6bOdnXY/kPggWtfIEhs
 HjOK1K1HMZBPnqxiuecL0L7hGG69pcPh7MKKq92yM9TwJiorEm0jd+nXjHUA/V/U4aRMdyhbQ
 t5G/5u7kQ34lYI0Gkv7zlR0m9t3e8Mj9BTcYPR68NXJtsRR18yMDcluWtYwBZB+juXMHErsX7
 RxsWCn6q3EiiM9WCxd2FIVuOpjxYMHJIQ7OYSJ4NkUHLMgxIIbisgwaF16dBiIYfX5LILTXE6
 mbp9ZE7SOqQqUvBDCqTETW0Pmh8qpIWdOth7pGFkP2uhbaoicjhbq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On the other hand, I don't know if the one that seemed to cause a crash
> really caused a crash.  It was detected by syzkaller, and it is also
> possible that git bisect ended up at the wrong place.

Do you refer to any known bug report here?


> In any case, forgetting an of_node_put will normally just waste a little
> memory, so probably stable kernels don't care.

Will it be nice to achieve better exception handling also for these
software versions over time?

Regards,
Markus
