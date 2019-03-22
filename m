Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D408C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C7721916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Outupez3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfCVNWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:22:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbfCVNWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pVMvJImQW0OeH4Rh98mg2ke73+cWCgSW7c1J8Xsu5cU=; b=Outupez3XLTGt1QElWjkzrYtj
        OS+shtHW6+ntvAHU6UUmXXrcSOm8CVIsleV3aqMHBgiNZ/03PlY31jodt8i9paxSXmVshoQUwEM2v
        PkiB/ixTsglqAC5IIhYbvg+jY6hRetrnRSG03YxOngCoVmJ+C1O6rztb2WWszX5zDmi51f9F5gsRO
        zBNv6WMNG0XgH25iSnfLlzkYCvhJIgfYWmLjAoNEOFBJls7zzqT6O1QNHoiRdF10HgM1/7YCJyQzX
        1VCotT7q39nXERmKEpbODBag0cNcPUZiJBhmbkLTBeDddmjyzgWW4eZtcEEUgwcb6dtmxI+HW8FTQ
        MNljU8lgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7K8E-0004vo-Md; Fri, 22 Mar 2019 13:22:46 +0000
Date:   Fri, 22 Mar 2019 06:22:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] riscv: Make mmap allocation top-down by default
Message-ID: <20190322132246.GB18602@infradead.org>
References: <20190322074225.22282-1-alex@ghiti.fr>
 <20190322074225.22282-5-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322074225.22282-5-alex@ghiti.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config HAVE_ARCH_MMAP_RND_BITS
> +	def_bool y

This already is defined in arch/Kconfig, no need to duplicate it
here, just add a select statement.
