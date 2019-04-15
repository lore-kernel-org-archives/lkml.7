Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FF0C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA91E205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lqM8lYOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfDOSSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:18:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34235 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfDOSSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:18:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so23217674wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 11:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1LJvGvqo7EljAGlBTh6710IRHlpdfD0Ibty+Og7VIs=;
        b=lqM8lYOIQB81gsmtbP1nJNVx4mZZO5/MZXUp4nrAfy5hCneDvE+LT7DRbcSZ+vT5w+
         8Z+fNRmscXd7SfXljaH0efEYbA+KkrUxKliSiPRWQAPBNgM1FIA906HvgxblReyYKTHU
         j8LeUtxto25qoK6+fw9eQv3BOIT6ARquaNiCohdgqpqDrGC6udqGA9mBG4jF53xIVtPL
         l3OD1MDU63TkjVGr7thOD4MUikHJQ8WbDu7MvOLwOEZwRNtxQeJGbzmakKx3gAHeKKM2
         gjZYEpQfL4ibR9od1F3Lg63SyP9zyA+GC0ox5wvadKD0M3QijlKCpH2+BdB05tV2yLQr
         tXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1LJvGvqo7EljAGlBTh6710IRHlpdfD0Ibty+Og7VIs=;
        b=ZUVDPIHsfGTl6Iu9rmip8gs5HMeLakn5kxrmCPiOTpb4KslEm1MiGggxu1kZ6jcndJ
         PtpG/GHTz+itWNGXlF1FyzogDJHVW1IK5c6Wq6sDWw06yRlNa0KQQpg8xZJ21Ut0AWeM
         H41OW2MrTMaWVDHGWKiRv8uDWYi8pZ7i7urD780aYLHCqRAY3NGX1vqxIE3U2s3FgStM
         gANbpiXZJiUvm3w20ygOuuP9OogwySuNqvGKP3Gn64PKj+Ew/0Ca5wQ2i43x8SLoIKHX
         3fpbMhgxlQD03W5pMQ4eiKiMPO86CSraiTY7MtFGG7FDUu/8RhX0YbeF9kl3Llo+2FOS
         gD/Q==
X-Gm-Message-State: APjAAAULTof/WvOgyM+0uu5hRJO4h4pXp8gO6X2av3HmDWP6HnN5MTAz
        KOI/oU5ZzvubIyE4v5l/nSRX+/HN5e3OhEdrdlGZvg==
X-Google-Smtp-Source: APXvYqxVk2bkWycU3o5K58SYGSp4ltI2LOn3syZyyGeORJ//WKM7JLPKIJw3GKGgcDj57E9sgAZ1FsR4Wuedc1W8lKs=
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr49415491wrm.225.1555352312329;
 Mon, 15 Apr 2019 11:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190411184741.27540-1-tmurphy@arista.com> <20190411184741.27540-6-tmurphy@arista.com>
 <20190415063351.GD1377@infradead.org>
In-Reply-To: <20190415063351.GD1377@infradead.org>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Mon, 15 Apr 2019 19:18:21 +0100
Message-ID: <CAPL0++49xZk=bfkBu4e0cS_NA3gs7_z0tiifZBL+Jp8d_6S1rg@mail.gmail.com>
Subject: Re: [PATCH 5/9] iommu/amd: Implement .flush_np_cache
To:     Christoph Hellwig <hch@infradead.org>, joerg.roedel@amd.com
Cc:     iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        David Brown <david.brown@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cut and paste from the current amd_iommu driver. I really
have no idea if it's a good idea or not. It looks like
joerg.roedel@amd.com might be the person to ask.

@Joerg Roedel should we keep this?

On Mon, Apr 15, 2019 at 7:33 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +static void amd_iommu_flush_np_cache(struct iommu_domain *domain,
> > +             unsigned long iova, size_t size)
> > +{
> > +     struct protection_domain *dom = to_pdomain(domain);
> > +
> > +     if (unlikely(amd_iommu_np_cache)) {
>
> Is this case really so unlikely that it needs a static branch prediction
> hint?
