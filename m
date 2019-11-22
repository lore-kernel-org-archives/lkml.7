Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7202C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840ED2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UKE+8Fub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKVQrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:47:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45044 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKVQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:47:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id g24so1672936qtq.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsTJuTqF11V5Xau/fBV0ClzYOEHSzNeSG3ODcuTcgzk=;
        b=UKE+8FubEUdwrmMGQCVs7KfNO6ELGuJ2MiqMQQsgNPgCqPfL8Eqm4ts5CiivSlPm6l
         i+XKKMSbpfvdnqK5XwSzzmeLbfg8ZrmbE+gre4SdgpKqpBK4LRlD/yx4AxNX+PqR3QQ0
         1p+rotAmyz4ODuC9JejR/68hw/4fgViBJnoLYOr4qawwAM7xmtMawF/Q4u3FXtY5TXUV
         HwMJmtf7CCwgz7NsreHZaL5KRoAxsptgkhz+z843rOD2+PdWZEJXPncrGOx5uImlJoKG
         CvAw1OmybrAx7ugucnGHhC6MVFUn9KerlOieRko5bauQuczjnLAMxCtvsqh+mGUvr/gp
         Bx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsTJuTqF11V5Xau/fBV0ClzYOEHSzNeSG3ODcuTcgzk=;
        b=ck3sByL0E/kvkolPDPSqz1VxqVw32HaNZ9OYW4yowKdTieiqJAxgqgsaAzG42Ek4Cx
         5r8E4pQSEhUps25lI46wVeDS9uVC2YqucPRw/yYpZPnTIukRBNmv+wCyNu39O7YFTgd8
         JPXiiJwh8mVKI3TuPGNN9VN/HGXrDBXe55UaCDJI+xmg4hUBDsnUmkdlvE1qmgq1rxuu
         nxd5bvRjLAHDzt3CzqczMaX2BJPvrw419uvMfnMT9f54OYKGxptbGNcTY6dKMKMKPQgF
         frC3cqD3n7WAkgMysyBQlLJQl3xOYsDp3QwaAA4cYrJPWGFu4VZ1NWerejSGxbiaHHJB
         +Gaw==
X-Gm-Message-State: APjAAAXFA/Cm21SEXsefDIjsFfMd4X0a0Dz+vA7Na1PYLg3WO8J0Hd60
        IOwJCZsFJPeG6VVao936Ig0hMJtjI4g=
X-Google-Smtp-Source: APXvYqyxFPW/G2Gvt2o7A+CpxDAgcuTE3MRvzKe89NBeOH8qEb9tCk9eMhtu9fq3pEdoVRgg5aKagw==
X-Received: by 2002:ac8:6ec4:: with SMTP id f4mr15463482qtv.271.1574441221147;
        Fri, 22 Nov 2019 08:47:01 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q34sm3717314qte.50.2019.11.22.08.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 08:47:00 -0800 (PST)
Message-ID: <1574441218.9585.26.camel@lca.pw>
Subject: Re: [PATCH v2] iommu/iova: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Joe Perches <joe@perches.com>, jroedel@suse.de
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Nov 2019 11:46:58 -0500
In-Reply-To: <799a49ee8fc8041a00332e0866554ddc04a2b8b0.camel@perches.com>
References: <20191122025510.4319-1-cai@lca.pw>
         <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
         <1574434760.9585.18.camel@lca.pw>
         <799a49ee8fc8041a00332e0866554ddc04a2b8b0.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-22 at 08:28 -0800, Joe Perches wrote:
> On Fri, 2019-11-22 at 09:59 -0500, Qian Cai wrote:
> > On Thu, 2019-11-21 at 20:37 -0800, Joe Perches wrote:
> > > On Thu, 2019-11-21 at 21:55 -0500, Qian Cai wrote:
> > > > When running heavy memory pressure workloads, this 5+ old system is
> > > > throwing endless warnings below because disk IO is too slow to recover
> > > > from swapping. Since the volume from alloc_iova_fast() could be large,
> > > > once it calls printk(), it will trigger disk IO (writing to the log
> > > > files) and pending softirqs which could cause an infinite loop and make
> > > > no progress for days by the ongoimng memory reclaim. This is the counter
> > > > part for Intel where the AMD part has already been merged. See the
> > > > commit 3d708895325b ("iommu/amd: Silence warnings under memory
> > > > pressure"). Since the allocation failure will be reported in
> > > > intel_alloc_iova(), so just call printk_ratelimted() there and silence
> > > > the one in alloc_iova_mem() to avoid the expensive warn_alloc().
> > > 
> > > []
> > > > v2: use dev_err_ratelimited() and improve the commit messages.
> > > 
> > > []
> > > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > > 
> > > []
> > > > @@ -3401,7 +3401,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
> > > >  	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
> > > >  				   IOVA_PFN(dma_mask), true);
> > > >  	if (unlikely(!iova_pfn)) {
> > > > -		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
> > > > +		dev_err_ratelimited(dev, "Allocating %ld-page iova failed",
> > > > +				    nrpages);
> > > 
> > > Trivia:
> > > 
> > > This should really have a \n termination on the format string
> > > 
> > > 		dev_err_ratelimited(dev, "Allocating %ld-page iova failed\n",
> > > 
> > > 
> > 
> > Why do you say so? It is right now printing with a newline added anyway.
> > 
> >  hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
> 
> If another process uses pr_cont at the same time,
> it can be interleaved.

I lean towards fixing that in a separate patch if ever needed, as the origin
dev_err() has no "\n" enclosed either.
