Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA36C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47A021848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="luLNBxuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbfJNPeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:34:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37555 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbfJNPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:34:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id n17so6615371qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrqHEv4nHi+sN0Om5M3ZbJYqGC0cBLXNH2ku0StUbdE=;
        b=luLNBxuQTNJa+fKdTc/2LXZcaKkugTUKNdfTIidC2O5vKzTr/x90eFbx7j/9tUpbHm
         jliGJrGYg68iVwTVqc4XRBc22+JdQVpfqbmWvLAVUad1ne2cnPJlkzfjG/ycSU80xOUq
         pUQpruHDx1+UdtqpduYLHbw1QsUIfipQnO7z8xcjjLGYjp2RGIlNueOFGdfyicHWo5Ko
         AVP3v74tlOjWqstbVo7ntw6ElJT00qkeglTlvpHOmqdfVXoHE4e8mQNkg/zk02WgCNs3
         zSf+y6enISByXcWfQg5KiBKxAuRKdp1Y0im5IDdmON0tQdZ/yxgB1w1v7UZmQr51iEZF
         2IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrqHEv4nHi+sN0Om5M3ZbJYqGC0cBLXNH2ku0StUbdE=;
        b=ZliOuZejuLKV/CW44g107fn55JM//pokcm86vQ8uPYZ6F858n1VJ4zgv/7LHjDZ4s9
         t9YyoGAhRcRUEjPtNFPmnUZALsRZQ6IkfcBMAvp4n/Vw7narYIbmUTfEcJtoM2p6Czgj
         xB4YbMwFoyofn4mrIrKpxYKbxktx3aC2rr/Xe3nCpHYZN+BWVF8FLvE8SRT+ImnTisxg
         fvFTf2HrsgOF2ozGNTYeID4ItHM5K4RQZJ4TDs5BpcYpiPHqlIAkV5mTHNmVHBZGx92Q
         1KV3+RZ2y8fJ4uqAJOnNBW7een0yBJApX/U1Pvik4ky+VUBPFjoBN23u2ZLc1s9ednUg
         DQ4g==
X-Gm-Message-State: APjAAAX3nhs2ynU52aSQbAYIu6c8KCB/jiSF8Lnc6Q6vDhZBGckERZVY
        i5pwcDPXd9F+7DkNDdkfBiDjmA==
X-Google-Smtp-Source: APXvYqxekmzdMSjMjhAgFiOQx3s7qswq/tSgxGyi405nt2WbrxhaGdHGN9wmG5n7i0A7SErwbAiGnA==
X-Received: by 2002:ac8:2a66:: with SMTP id l35mr34457334qtl.340.1571067262099;
        Mon, 14 Oct 2019 08:34:22 -0700 (PDT)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id l15sm8985494qkj.16.2019.10.14.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:34:21 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:34:19 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
Subject: Re: [PATCH v6 08/17] arm64: hibernate: add trans_pgd public functions
Message-ID: <20191014153419.galjhum7amnyuiml@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-9-pasha.tatashin@soleen.com>
 <2ea69969-154d-fa55-767d-43ea8971dd0e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea69969-154d-fa55-767d-43ea8971dd0e@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +	memcpy(page, src_start, length);
> > +	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> > +
> > +	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
> > +	if (!trans_pgd)
> > +		return -ENOMEM;
> > +
> > +	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
> > +				PAGE_KERNEL_EXEC);
> > +	if (rc)
> > +		return rc;
> > +
> >  	/*
> >  	 * Load our new page tables. A strict BBM approach requires that we
> >  	 * ensure that TLBs are free of any entries that may overlap with the
> 
> (I suspect you are going to to duplicate this in the kexec code. Kexec has the same
> pattern: instructions that have to be copied to do the relocation of the rest of memory)
> 

Yes, the relocation function is also copied, but I do not see an easy
way to unify this particular code with kexec. We can discuss in kexec
part of this series what else can be unified with hibernate's code.

> 
> > @@ -462,6 +476,24 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
> 
> > +int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> > +			  unsigned long end)
> > +{
> > +	int rc;
> > +	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
> > +
> > +	if (!trans_pgd) {
> > +		pr_err("Failed to allocate memory for temporary page tables.\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	rc = copy_page_tables(trans_pgd, start, end);
> > +	if (!rc)
> > +		*dst_pgdp = trans_pgd;
> 
> *dst_pgdp was already allocated in swsusp_arch_resume().

Good catch, I forgot to remove allocation from swsusp_arch_resume().

 
> > +
> > +	return rc;
> > +}
> > +
> >  /*
> >   * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
> >   *
> > @@ -488,7 +520,7 @@ int swsusp_arch_resume(void)
> >  		pr_err("Failed to allocate memory for temporary page tables.\n");
> >  		return -ENOMEM;
> >  	}
> 
> If the allocation moves into 'trans_pgd_create_copy()', please move the code just above
> here (cut off by the diff) that allocates it in swsusp_arch_resume().
> 
> Its actually okay to leak memory like this, hibernate's allocator acts as a memory pool.
> It either gets freed if we fail to resume, or vanishes when the resumed kernel takes over.

I did.

> 
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you,
Pasha
