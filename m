Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED9DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C812147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obnO+0Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfDHOyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:54:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34457 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfDHOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:54:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so16820172wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z/2RmRNtPgKwy1Rq5NgLuc4ghN93/5Qas/l/yLOSyxM=;
        b=obnO+0Altk7PyU+mrtRKy+0ywg877ntUuQuLPnEqil0Hm4Np6xNGa9RIYB8bj4ehPd
         skRtvUJGp787bHJBzlYz2dKWRheDIvAPdmO/vozu02s+9auYYHi1Wox2hfjH/SSQymKF
         +kN8kUhcjuWh5ffh7Zl5R22LuREsZMA+Xe9f3iBd8zB3xMTWb2dDfeCb0yqGr43KQcUN
         Lw7L/V30TWCnb/FutLdgaDAQ5bDf8CW5foZJdnqEkT/Udu1KxUcLjCsQUFaILx8Hkqcd
         W2YSvWT+ycNKzulbXLl4A9FVCOtR8WgsD6Xr77pntkbLDtwoeqLR8hrPpSt9VwIhJv4u
         2OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z/2RmRNtPgKwy1Rq5NgLuc4ghN93/5Qas/l/yLOSyxM=;
        b=GbRFK1ld3P7ALjFxYKFL7EG+90N3aaK/RLRE60q+s++SoJEWDVdDc5DUBOqJsm2En1
         scPFjXa7QbBJ2Bc/whq7VAv814Sx+lXU7+dzjW4WaQgBHY9dAlXZO9tO7On7AifItLVh
         TxausgwG5j77znKbTHWhMYi4kSWUV8s6/e2CDQN2y6i2vVhbA9jcQl0dSQDxEOwn6pBm
         sVXcmRbfOmEFIcqnfS0bdLn2rR1DuqRFj4stoDmUpbEiJ0j0pRHxDdxP324vNs7lUN4+
         ez4N33QNiZ9L5BQudMNqM3wikH5FR0iII8byAR2mLJ1l7ug0snLVidgN0LH94sfcfxva
         tQlA==
X-Gm-Message-State: APjAAAWkTZahVjQM/qYUcbV6o7G2a8vg40YRDzsOcQWH0+FbH8mqeSIA
        4O4LMmHXovpEu8g5Ro9DfS22nQ==
X-Google-Smtp-Source: APXvYqyregy2gJj5n6ki7YwmxuOLLNvSxgdS+wg0BBsta9wZPMgFabS5w8MwQTqKLvkeU3VZ2pqGYw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr11725809wrp.72.1554735281340;
        Mon, 08 Apr 2019 07:54:41 -0700 (PDT)
Received: from [192.168.0.100] ([88.147.51.116])
        by smtp.gmail.com with ESMTPSA id w11sm89463124wre.15.2019.04.08.07.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:54:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190408144925.GA23021@linux-x5ow.site>
Date:   Mon, 8 Apr 2019 16:54:39 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
To:     Johannes Thumshirn <jthumshirn@suse.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 8 apr 2019, alle ore 16:49, Johannes Thumshirn =
<jthumshirn@suse.de> ha scritto:
>=20
> On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
>> From: Angelo Ruocco <angeloruocco90@gmail.com>
>>=20
>> When bfq was merged into mainline, there were two I/O schedulers that
>> implemented the proportional-share policy: bfq for blk-mq and cfq for
>> legacy blk. bfq's interface files in the blkio/io controller have the
>> same names as cfq. But the cgroups interface doesn't allow two
>> entities to use the same name for their files, so for bfq we had to
>> prepend the "bfq" prefix to each of its files. However no legacy code
>> uses these modified file names. This naming also causes confusion, =
as,
>> e.g., in [1].
>>=20
>> Now cfq has gone with legacy blk, so there is no need any longer for
>> these prefixes in (the never used) bfq names. In view of this fact, =
this
>> commit removes these prefixes, thereby enabling legacy code to truly
>> use the proportional share policy in blk-mq.
>>=20
>> [1] https://github.com/systemd/systemd/issues/7057
>=20
> Hmm, but isn't this a user-space facing interface and thus some sort =
of ABI?
> Do you know what's using it and what breaks due to this conversion?
>=20

Yep, but AFAIK, the problem is exactly the opposite: nobody uses these
names for the proportional-share policy, or wants to use these names.  =
I'm
CCing Lennart too, in case he has some improbable news on this.

So the idea is to align names to what people expect, possibly before
more confusion arises.

Thanks,
Paolo

> --=20
> Johannes Thumshirn                            SUSE Labs Filesystems
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=C3=BCrnberg)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

