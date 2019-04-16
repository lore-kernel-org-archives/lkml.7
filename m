Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49CAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F252077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UK9baa0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfDPNWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:22:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38567 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfDPNWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:22:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so25431323wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fE3sq5IU7oDGUhvdqyQ/p1pwHsr+y+10jDtlKyi9nIM=;
        b=UK9baa0upvt8kExaNicRl4IW8pn8XtS1HGiXYDh/Cjh2In4WEONLA/YoRLDoQzJ8Vz
         PdVkVuOvfMVv5w4vUtdenpqz87O0364ncPkGp5V542ls7ftS3zZv6exRl2fjhcvDhsFO
         3kMGLNzDEN6PoD5wBYvbqj+cF33P3YKcjyEX6n0BEKE3pBXOF/yodJqYUnf2jHnNfCmk
         QZAp54PLBFZF2yttlJPMVIacIIQ5GnxIDa/xhqCLY41O8pLQVwhxzxCHbAnLPou7yTVc
         pYDxjwquiphiT/LmMpi76FuotYfoSeZoAjMTVdtujWTGpLoYutrlZEcGpwdTAxrxWVG5
         bicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fE3sq5IU7oDGUhvdqyQ/p1pwHsr+y+10jDtlKyi9nIM=;
        b=A22bUlbyOPoSjUEYb8vP9ARgfDkXSMpxK63oZUMa4Yhf0P74uK9oeoMoppiMtkFv1V
         UfZYIj9VyRYqdekNugW92NB6AGSw1hvc6Ctp5A7DKVKXGObHGOHASRZa3sNocE7xcRHv
         60Z6+38wgxmmQDNAtOaslX1x5oB1uKg/SwDoWrFIQSKFPAHMEspWN3HKRLuq56spC28j
         tvlIBftnp2+gv1AmlGqCCYN9Tez3/rTRdgLSaJSpSidjreVrupr7tAuFC2CB9EDeJ4vn
         fgyRD7rs+0uul1qGrzaJWKyZUkMtzQ06bcN0AKxvTJyfGQyRB6gZji46iNDNpN8t+ALi
         2PSQ==
X-Gm-Message-State: APjAAAUWYz/H4by9adLRQ5VsowbRXcWZOcMAKHlKEgf7brV+OPn5QqMt
        96vWj7FA+CB4yMoubLmIGOaKmCZjIRh2dSOmOP+bJQ==
X-Google-Smtp-Source: APXvYqxvliQB0p1msg/Kb91zHRXg1vpQBmsWsVI/s/OgwCDG1cNmK+qljRBsZ92RcWqDc4Oa8eQSKty5sw59nUVcpPQ=
X-Received: by 2002:a1c:9617:: with SMTP id y23mr26196661wmd.31.1555420970525;
 Tue, 16 Apr 2019 06:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190411184741.27540-1-tmurphy@arista.com> <20190411184741.27540-4-tmurphy@arista.com>
 <20190415063134.GB1377@infradead.org>
In-Reply-To: <20190415063134.GB1377@infradead.org>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Tue, 16 Apr 2019 14:22:38 +0100
Message-ID: <CAPL0++7Z=EMpYOvUn8yvcRqRT5iwJMD8zLhmFr4uFbH7W3WqXQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
 iommu_dma_apply_resv_region to the dma-iommu api
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

I hoped this could be an exception, it's easier to grok without the
line break and isn't crazy long. Because you mentioned it I'll fix it.

On Mon, Apr 15, 2019 at 7:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 11, 2019 at 07:47:32PM +0100, Tom Murphy via iommu wrote:
> > +
> > +     WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);
>
> Overly long line..
