Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB91C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D22206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sM2WgBUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfDCE2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:28:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36780 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDCE2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:28:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id o74so14257599ota.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWQPucjki5PAvBUykdibUbjnXNzSh8OpfroliNXG7Ss=;
        b=sM2WgBUUWWM7hDZwzjSQzfa/OYKoKF4YdFf5Z2dplbCGYCqIwWsnoOHKrNH+XYNry2
         je+Oh/Xxtru0ojxRJeP2wVnSiupqxuEvID/hzqNj3ylG9sG6PA88h20LPFUvbpN5uITK
         galNIb+9Q4sklX0D5VFuR3MRDSsC1HI/gcwAxfDsZwonDvyQe2PYI2rafOgcsilTlR6t
         TwXdyDBElydIQ8MXAVG+4IplFORV6jdU7Ctra5JzkUjw3C/Wz/qk9lzjsElmDxLMvjnN
         MR6wbMHJoFnTy0VGvb73ix5pElPtGKg+6RxowAUhqnnIjUyCUXkE/Chizlpdm5tKbLRL
         /oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWQPucjki5PAvBUykdibUbjnXNzSh8OpfroliNXG7Ss=;
        b=MS7FCF0keWy3Nl/BJzfZI5GKKMj1DEM63gtQ5i7lRBM6Pa4neaGvsIqgcuggZOh4vL
         tCiCyPBjBqD2/nNBgAckZmWyo0mtHFIy9ynFf1J+D/nzbRKV9rGeNPzjbFcfF88saVJT
         yTYO51+xc04hOiQ6NiCZRUWTcFe3X81xNLQ9n89f0LmaHfrc7CbtGUudD38lLhAVEznA
         XciapxMCgmFVgcwGa83321tqI2oSWuPVFBUI5Dd4VQuMSQ3n/Phlfzbxh46XS+JdU37N
         Xpo+qtATh2wZQ7N//Qq1N1yOHIWeBurX32Iez1vy48seMdS8JzrOY083jHqGzwf0Krzc
         6UtA==
X-Gm-Message-State: APjAAAXeDdECpeuPt9uIWp7TBu8c73Y6jiqszuDjk1fTcNugTHcItq1p
        peUf0eXZ8RPEhikngre6Zf08shPNmk/kaAMDHj65Vw==
X-Google-Smtp-Source: APXvYqyE9vkQBdneTX1KT6m1tc2kehhtE90YhBmiE2ZMSfYtd2xfqD5u6rNTX8i6fo17zqonCyNNaflXaq1GsC+8ZCE=
X-Received: by 2002:a9d:730f:: with SMTP id e15mr21459402otk.22.1554265684396;
 Tue, 02 Apr 2019 21:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190403111108.2ff4a309@canb.auug.org.au> <CAMz4ku+17HAZfh-03+y=WUy1NdsL7sQHK_XyzeToBh5-RAUSQg@mail.gmail.com>
 <20190403033518.GI2059@sirena.org.uk>
In-Reply-To: <20190403033518.GI2059@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 3 Apr 2019 12:27:53 +0800
Message-ID: <CAMz4kuLyAKwRLWu3+cfpDsLwCtJS21BN0xmL-DNxfmPYXC_tZA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yintang Ren <yintang.ren@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 at 11:35, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Apr 03, 2019 at 10:12:47AM +0800, Baolin Wang wrote:
>
> > snd-soc-sprd-platform-objs := sprd-pcm-dma.o sprd-pcm-compress.o
>
> > obj-$(CONFIG_SND_SOC_SPRD) += snd-soc-sprd-platform.o
>
> > I will send out one incremental patch to fix this issue after my
> > business trip. Thanks.
>
> We can't leave this broken in -next for that long, can you please post
> the patch now if you've already got it?

OK, but I need some time to setup my environment to send this patch
and I'll try to fix this ASAP. Thanks.

-- 
Baolin Wang
Best Regards
