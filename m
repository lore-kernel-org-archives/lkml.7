Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB43EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C16020718
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rOPlxb/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKOVcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:32:09 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40559 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOVcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:32:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id o49so12319722qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 13:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVaaJcLYrWRFqqCe4W5rXCAMdbtRizSfE1vw/gf5upc=;
        b=rOPlxb/pc8syvhJhSoeS2jVmrjy31meZn+EI4/C7HLEXoSs+xg+aYVYDFoJNUUHJun
         gn+kLTldDZKHU7lWP6bEfxGN4jrfWJfjexaTeMPDGnZmFBpKE3pFW/d1cWyvpw1OAFYA
         IcyonvOqoaLyyphNSH8JzYTgCXVPOpn5Xa+moDExkbl2hGBPstbK5mu3yxuT3yyGyGXi
         t0ShdE4KmcxPVUZ/zGLYRXsjwjOqOEiIsPgsqSrWO+93slNxH5GPzjsaP7ofkgM38Z6L
         BtRRfzutRIrLKoDIxyB8/vNvUgUYspUl0oTacRSKB95SLdztCjuAUghj52WW6Ucv2mMu
         Ce2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVaaJcLYrWRFqqCe4W5rXCAMdbtRizSfE1vw/gf5upc=;
        b=dsu+k5ZmWo9YuaI/rGKbgBlVTQ+aWy2vyhbdcVFdlEkEmKAM1NvpzsHhHXRH5y+o6k
         GR11IiZVde4q3R2PHFFGvimomKKw6FOZ+sc3d0xXvOn3lKanzCPNkyp4AUf6FLRv2DI6
         jsWwp+ykIwQfAJSR6Fksy+rLhNviiJ6r+gMMmG+z0AaCqnSFBD2LLVF68n71DtNYSrQh
         hwq2Mhn0Kxh/6UpCG5DADQDCl/6Eg7q1hzb02/gHYh+7YSPuj0f/kEK8aTpusaGCHtgo
         t/LehahgrfsiIqx8UixC/BJ8pjdRbJwBCippwe1JwvkEa5hckZouOuwD5a1tq5H2fVur
         8TSw==
X-Gm-Message-State: APjAAAXN5bdbfSv3Gbq82Cmm0G/2fVxvuJur5PKSy41yZSB0zFW6r53z
        WevXvMk/jrD/xI+H2/y8OuxqxWl+1+I=
X-Google-Smtp-Source: APXvYqzJqhZRKYrgMgg/K5bkeWCA2aP5LUGaeYRQRdobH9pWbaGpI4cFcY0oEogXXKd5qSXvs+MMfw==
X-Received: by 2002:ac8:293a:: with SMTP id y55mr16455538qty.118.1573853527778;
        Fri, 15 Nov 2019 13:32:07 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o10sm4629749qkg.83.2019.11.15.13.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:32:07 -0800 (PST)
Message-ID: <1573853525.5937.140.camel@lca.pw>
Subject: Re: [PATCH] iommu/iova: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Joe Perches <joe@perches.com>, jroedel@suse.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Nov 2019 16:32:05 -0500
In-Reply-To: <f15994ec5b9c311677064583ff968b3cf881d4ab.camel@perches.com>
References: <1573851046-32384-1-git-send-email-cai@lca.pw>
         <f15994ec5b9c311677064583ff968b3cf881d4ab.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 13:13 -0800, Joe Perches wrote:
> On Fri, 2019-11-15 at 15:50 -0500, Qian Cai wrote:
> > When running heavy memory pressure workloads, this 5+ old system is
> > throwing endless warnings below because disk IO is too slow to recover
> > from swapping. Since the volume from alloc_iova_fast() could be large,
> > once it calls printk(), it will trigger disk IO (writing to the log
> > files) and pending softirqs which could cause a loop and no progress
> > from memory reclaim for days.
> 
> []
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> 
> []
> > @@ -233,7 +233,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
> >  
> >  struct iova *alloc_iova_mem(void)
> >  {
> > -	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
> > +	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN);
> >  }
> >  EXPORT_SYMBOL(alloc_iova_mem);
> 
> Is notification ever useful?
> 
> If so, maybe something like:
> 
> struct iova *alloc_iova_mem(void)
> {
> 	void *mem = kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN)_
> 
> 	WARN_RATELIMIT(!mem, "%s: unable to alloc cache\n", __func__);
> 
> 	return mem;
> }
> 
> or maybe use printk_deferred or prink_deferred_once
> 
> ?
> 

Forgot to mentioned that errors are also reported in hpsa driver which is fine.

hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed

but warn_alloc() is way too expense for this old server.
