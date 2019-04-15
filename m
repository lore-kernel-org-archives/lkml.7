Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97532C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A5A218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i3wHdbvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfDOSGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:06:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39941 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfDOSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:06:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so23166271wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkcG1ecxbRvbtTZp8pykP1WrSpDo5FL3IoRO1jdwX4A=;
        b=i3wHdbvuoVxt1LC2EUpNdj3M95LS7TyzrhgbGppZWVWnHDaHBVWDrEBfZItz/IEpmj
         3eCG15hLn0pJiWlrRV0+/QJzosPkdKhD8R6kRPMC3v+mXlBk/eWJiZbDkXeYXRyJgvnA
         kFO3X/OQADph8cOzNyl8ghHq8eNls4gmuYn3zD2caH4i6SyW+Lz1//QnXAwxHIkvF4yW
         6dchgbPcTwSNCBiTbGIMuTBmkEquKlAdwic7WWO4NAIKMXyOPJrP9171Uf2VUg0A4RJs
         SaNGmeLRvjUCJHdxf/+If6oudX4GNonpbvKHjIGuAQV4fGGVw/oJLm0PXWjpHiFZjgfU
         tL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkcG1ecxbRvbtTZp8pykP1WrSpDo5FL3IoRO1jdwX4A=;
        b=jFQGdQNSEcrZbXxxRCetejXl39byvwEnF1faq98YrcukD5xdwYpnsDxu6tIKG7R1PM
         WjRAnfoigdP6sUpNG7gNMwiRrMAqJbittVkTQ51N4yF7G3wTm1WMdJCN9EpZQP+vzws3
         OuFJHVETG6OlrWqlXiK8rOGqIZJgDdmuAilUq4HNgPuGMGYnyzUVTPdAUTW10EGeKdug
         VgT0du5okpuT2ysYWAoR7cwaQfcqBpDbEFqlXhzAxi3ZLA68ewLyrbsQxwi9RLcyc0Ab
         hfweg87+8vFWIOw0e4c8WcYXUe1nK7Pp7hXLG359dqoy4ZEc5OUIAjBX2zH+dvaU63D/
         cMqw==
X-Gm-Message-State: APjAAAVVVZF1psLp81uad6oN4RW4ee16k8Ef74GBlFQng0PLybsRO+Ph
        ktCl+/AvBgBkpPzKHpBcFdX9nbSHYZor7XD/qa/TPA==
X-Google-Smtp-Source: APXvYqzVHTURCpFodSDEVwDlFPrvJXAWwZaZ1ZcGTLFFboOAeqzMpHqKjqAGWTImBYBNh9/uPFXAlPRrxNpPAja/0iQ=
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr12937108wrw.22.1555351607916;
 Mon, 15 Apr 2019 11:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190411184741.27540-1-tmurphy@arista.com> <20190411184741.27540-10-tmurphy@arista.com>
 <20190415062316.GC18154@infradead.org>
In-Reply-To: <20190415062316.GC18154@infradead.org>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Mon, 15 Apr 2019 19:06:36 +0100
Message-ID: <CAPL0++4cvqD1gg=mDASrLRBv69ei75v-g3BWWW+Poz3_TUOkbQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] iommu/amd: Add allocated domain to global list earlier
To:     Christoph Hellwig <hch@infradead.org>
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

>This seems like a fix to the existing code and should probably go out first.

I'll send this patch out on it's own now.

On Mon, Apr 15, 2019 at 7:23 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 11, 2019 at 07:47:38PM +0100, Tom Murphy via iommu wrote:
> > dma_ops_domain_free() expects domain to be in a global list.
> > Arguably, could be called before protection_domain_init().
> >
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: Tom Murphy <tmurphy@arista.com>
>
> This seems like a fix to the existing code and should probably go
> out first.
