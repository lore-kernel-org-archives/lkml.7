Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AEDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D87B2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+wIlQAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDCCNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:13:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35044 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfDCCNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:13:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id m10so14065278otp.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqnDfPlbwAm5Ic60Ql1GXZctCzHFOF1c/VrpB6kjlMI=;
        b=C+wIlQAmOK5v9iPkSgMjOEucrx/XpzHQUTPb+dhaw7UZ8aGoy6gP8xhC0rWXmt0esY
         qyJeuqjSiu6+15RmVU3jGdepH2ugSxRfKLFSLvVRXu4w/N4bawAKx/7OOX5DzK3nQX0z
         TAJA+irdgqz/wgHqo/I8dCnReb9l62msGaODnyCXYHSYWp2Uff1rM8p6efgy/6SNz1wT
         Aq5W2RAY5s4kBfH5O5jPzCNErAOU5UPcl7dXqQUpv5tqwiKnfS5fQd2LGy4/ukkV7896
         vsCqYFhdFpOCELIxiq0F6fzb3XJsxzCMecyjLQUCDSACs0rGMH5hujxbvBV3y6x/lN8u
         Z0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqnDfPlbwAm5Ic60Ql1GXZctCzHFOF1c/VrpB6kjlMI=;
        b=R4K7SZ2EBAN5EVkzffFwUP3ySVj0QhvJhR0jwHcxsIygRudmnvH0L4UL2o/Hvd/a1c
         kfOD02TIMokGGb+2V/fhN3grW1qcTs9E7Jv0CCBJzRIufHqQE9MzbaxQHkzQZQqgZNM2
         3BIkWNkfBIrFITRSK8ZVXzS/O6J0taQ57rQfi/3yAzNlqwiqrHochrBl1exXxA85NxNc
         puqqu1lsONhxxpf9mSoSfRoRhhUzTJfYyMlPpaoMhOmr9wgyD6F9iuTSIOR4KevQtaOQ
         yrcYNrrxtIJFmw78VFdFt4NWt1rji0wJ4a87D3z3cA0f8IKZQ+Rci99py36wpos7weM8
         v7Pg==
X-Gm-Message-State: APjAAAUK5Y17uFM2tp9tf+JTPn8Z4R1SgMGkdFnkdBGv6oL60GtVcTuT
        3qvGfkoI4K9v93IhXInaIg+IK0i5ZoZsznemlKFhCA==
X-Google-Smtp-Source: APXvYqzRlAKLgF40ajHuftImIPOxwS2cpW+uIFlmDA+ZO7nP309vkFl+dmnIG8bWsIHYtu8mygdm5I4VPYfL+DmLX+A=
X-Received: by 2002:a05:6830:1310:: with SMTP id p16mr42981919otq.110.1554257580770;
 Tue, 02 Apr 2019 19:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190403111108.2ff4a309@canb.auug.org.au>
In-Reply-To: <20190403111108.2ff4a309@canb.auug.org.au>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 3 Apr 2019 10:12:47 +0800
Message-ID: <CAMz4ku+17HAZfh-03+y=WUy1NdsL7sQHK_XyzeToBh5-RAUSQg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yintang Ren <yintang.ren@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Apr 2019 at 08:11, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the sound-asoc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> ERROR: "sprd_platform_compr_ops" [sound/soc/sprd/sprd-pcm-dma.ko] undefined!
>
> Caused by commit
>
>   cce1396936ef ("ASoC: sprd: Add Spreadtrum audio compress offload support")
>
> I have used the sound-asoc tree from next-20190402 for today.
>

Thanks for pointing this out. I think I should fix the Makefile like this

snd-soc-sprd-platform-objs := sprd-pcm-dma.o sprd-pcm-compress.o

obj-$(CONFIG_SND_SOC_SPRD) += snd-soc-sprd-platform.o

I will send out one incremental patch to fix this issue after my
business trip. Thanks.
-- 
Baolin Wang
Best Regards
