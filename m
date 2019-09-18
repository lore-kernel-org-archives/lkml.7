Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD54C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E26420856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8Dp9vC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfIRFSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:18:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42920 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfIRFSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:18:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so4501902wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cjIjHnXm58P1zO4oY7wd4+yUsPOW1veEt4hwLPpO2MY=;
        b=K8Dp9vC/OdSO9BAKVo9xeWWUiq2GDluYa2bLJ6eA0T9Jx7oTWgtTuS+aw8jzpbEZED
         JtfNz/iXeCdnyNgIKTNFiek7ijuz0E6YXmCeywGkS78IkEBRsO0h0bLdzrlTUuPNQsOY
         Ht0ezrew4y5yiyHfA52s2TuHHixni67GN23+E9m5YB9xKy3NpLJZ5VZIF7YCobCVeIvA
         ZFM8scx6LXHSI7Y5aFYKyQzUB/eB5MaTBLISGqatmi5SkNUqo1zk+X/MZDf66V+UhWyh
         BLBx0BugJNVz3Ha8NJW4zrhsmxEWz86jZFpHIrgOslr8gn+38AYcVBkL7pyilVw2ys2T
         ut2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cjIjHnXm58P1zO4oY7wd4+yUsPOW1veEt4hwLPpO2MY=;
        b=Yw3VrpCeF/q0CyUT9OaxPk7CafPqJNLCIrt8U4qyqpDQ4bMrI9QgBoBGzEjj71ijj7
         gYTBPQDZZ3tulJdoHZAKA8S4NyYUipfBnW0S5IEKBN6y2YhLCG2qr64XXOoaaW9fsxwQ
         2AhBJmhFlwVfKWGkX+tW2Sm41NXNsmF4lh6YvvAkSTn4XAWlGbRMr9jlpKnOLahWxJ2n
         L2+i9CnqB0fLjCu68JONTgvGiP+kkOk+g7sDEUIStgttHZBjUZObA91j4sg7SE9LZ56b
         zEwCKRrenk6PkpF/P3m67VJjqn/vRuBZ6X3rsFYjMZtCdIuTTRwq4GKtxnXXG1HL/glY
         +Cvg==
X-Gm-Message-State: APjAAAXulb9EhUqY5dVK2XGKTpc7icg6F8hunwWlaWkEU8t3AA46kAf+
        NlqvEbkYPlHZSkoAiY344lJjMg==
X-Google-Smtp-Source: APXvYqxe0Xdy3auX9QiGXRBhoUsU0XIKBmVZD/cFRMqsg4PH78ZQCps1oiVnhWgZI4OdV5Pp92p4Ng==
X-Received: by 2002:a5d:6049:: with SMTP id j9mr1253419wrt.213.1568783932195;
        Tue, 17 Sep 2019 22:18:52 -0700 (PDT)
Received: from [192.168.0.102] (146-241-104-100.dyn.eolo.it. [146.241.104.100])
        by smtp.gmail.com with ESMTPSA id n7sm67149wrt.59.2019.09.17.22.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 22:18:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
Date:   Wed, 18 Sep 2019 07:18:50 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        Angelo Ruocco <angeloruocco90@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 17 set 2019, alle ore 23:32, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Tue, Sep 17, 2019 at 06:51:48PM +0200, Paolo Valente wrote:
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
>=20
> So, I wrote the iocost switching patch and don't have a strong
> interest in whether bfq prefix should get dropped or not.  However, I
> gotta point out that flipping interface this way is way out of the
> norm.
>=20
> In the previous release cycle, the right thing to do was dropping the
> bfq prefix but that wasn't possible because bfq's interface wasn't
> compatible at that point and didn't made to be compatible in time.
> Non-obviously different interface with the same name is a lot worse
> than giving it a new name, so the only acceptable course of action at
> that point was keeping the bfq prefix.
>=20
> Now that the interface has already been published in a released
> kernel, dropping the prefix would be something extremely unusual as
> there would already be users who will be affected by the interface
> flip-flop.  We sometimes do change interfaces but I'm having a
> difficult time seeing the overriding rationales in this case.
>=20

This issue is a nightmare :)

Userspace wants the weight to be called weight (I'm not reporting
links to threads again).  *Any* solution that gets to this is ok for me.

A solution that both fulfills userspace request and doesn't break
anything for hypothetical users of the current interface already made
it to mainline, and Linus liked it too.  It is:
19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight cgroup =
parameter")

But it was then reverted on Tejun's request to do exactly what we
don't want do any longer now:
cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")

So, Jens, Tejun, can we please just revert that revert?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

