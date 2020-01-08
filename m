Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390BCC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CD6206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578484476;
	bh=NXthFco7ad6tLrkq/mqqUzKnsabkdjCknz+f+ncpN+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YNyDEDyszFaA/D7VeX62PzOFX18UM6GbC9aEhlQTTKVaogDVRNq+yD+KI5cRVgCsU
	 9CP3sBrWjURZlJM/KLIEYkios47kg5oqB8KGTdCu6EfCI15GnuKKXNS/Q01GBNCKjW
	 VvxLyy3AVL1NyTbVtlyYWowhgH9pyjW39kuIefQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgAHLye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:54:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39312 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgAHLye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:54:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so2180326wmj.4;
        Wed, 08 Jan 2020 03:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ml+uPc3URz8hniItnTAxtQ8gvJipo7FyGt8CdYgqhS8=;
        b=S1jSzrB0kPlH6z3Px5sO4+12scG4yf1fud4c6NHOniE49Ycg3dfX2E+SvWwhsFFd6k
         3ooZRxm/POKhHurT7o0Xzg8k2RVvspAqA5jDN2+yvZMhvIsH1EINkIujyrav26OdbSE9
         kRk0/KDOx3vbZ9BaPasjgkMFHlJsVXZzRmd2LBQFBpTPTfJhDqBLP8S9fCtPpLR5vXar
         Fe/hFgm3Ta5erVompNvBSJfMuaomDt5e4VNtbzROZuduEUzboB+XZZG+JheTpTQGuNUA
         ZSJLUoiPlcaIESn6TOYnpNyNzmAzhZOEDxlOZXxwBZET2D8ucPZC6lxsAypP8mdqcyDx
         FgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ml+uPc3URz8hniItnTAxtQ8gvJipo7FyGt8CdYgqhS8=;
        b=Vj4B00u5sdxvPlGKD1/P85XZvTlTZcpyS2KcUsk2OHgpsqDbDVi6kNzGOB5GwDb6UP
         7H1HWi92nQ+HbuEsIq4YaWGCBCQ4Oz03CS5fl2gwsJ2lLu+LtBtjaXO3UA2IVAEPfcrx
         zXBKmV1uNnPiZBYJ/MddpkQhQzBlxgMLI8kY8tBW2esVt0y0M+54rOPIPWXNWUQjcOKZ
         qPOLkNddbnHM2zLJDHjGVhcuXMUCLaRBqVlU2+nTb8DGiSHPA636EBtReHUVzwCiVbxS
         6S20XmphDhzHfQhoULVwhVIJc4gxh725cfYSIhfbd2df8zNc6LaYxBHLjV9Te8DptCfY
         6+Sw==
X-Gm-Message-State: APjAAAUZqy8pIc0gbwHD5GaFtqH4nC1RsK+BbipEi39ypYfIgFSTO2rl
        FXEdJTKNFiOrG0bJNRZ/UnKgiFu2
X-Google-Smtp-Source: APXvYqzExp1XsdTC1+JsEavuJpBkVRfUxmBPrxW2OHdr7wK8xqoAA2krdy6q5RhCUk2/5CLpgvTWqA==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3438585wmi.31.1578484472103;
        Wed, 08 Jan 2020 03:54:32 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u24sm3528053wml.10.2020.01.08.03.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:54:31 -0800 (PST)
Date:   Wed, 8 Jan 2020 12:54:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [tip: x86/asm] x86/cpufeatures: Add support for fast short REP;
 MOVSB
Message-ID: <20200108115429.GA96801@gmail.com>
References: <20191216214254.26492-1-tony.luck@intel.com>
 <157847991723.30329.17038297307002446505.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157847991723.30329.17038297307002446505.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Tony Luck <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/asm branch of tip:
> 
> Commit-ID:     f444a5ff95dce07cf4353cbb85fc3e785019d430
> Gitweb:        https://git.kernel.org/tip/f444a5ff95dce07cf4353cbb85fc3e785019d430
> Author:        Tony Luck <tony.luck@intel.com>
> AuthorDate:    Mon, 16 Dec 2019 13:42:54 -08:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Wed, 08 Jan 2020 11:29:25 +01:00
> 
> x86/cpufeatures: Add support for fast short REP; MOVSB
> 
> >From the Intel Optimization Reference Manual:
> 
> 3.7.6.1 Fast Short REP MOVSB
> Beginning with processors based on Ice Lake Client microarchitecture,
> REP MOVSB performance of short operations is enhanced. The enhancement
> applies to string lengths between 1 and 128 bytes long.  Support for
> fast-short REP MOVSB is enumerated by the CPUID feature flag: CPUID
> [EAX=7H, ECX=0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] = 1. There is no change
> in the REP STOS performance.
> 
> Add an X86_FEATURE_FSRM flag for this.
> 
> memmove() avoids REP MOVSB for short (< 32 byte) copies. Check FSRM and
> use REP MOVSB for short copies on systems that support it.
> 
>  [ bp: Massage and add comment. ]
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20191216214254.26492-1-tony.luck@intel.com

BTW., just for the record, the 32-bit version of memmove() has a similar 
cut-off as well, at 680 bytes (!):

                /*
                 * movs instruction have many startup latency
                 * so we handle small size by general register.
                 */
                "cmp  $680, %0\n\t"
                "jb 3f\n\t"

...

                /*
                 * Start to prepare for backward copy.
                 */
                ".p2align 4\n\t"
                "2:\n\t"
                "cmp  $680, %0\n\t"
                "jb 5f\n\t"

This logic was introduced in 2010 via:

   3b4b682becdf: ("x86, mem: Optimize memmove for small size and unaligned cases")

However because those patches came without actual performance 
measurements, I'd be inclined to switch back to the old REP MOVSB version 
- which would also automatically improve it should anyone run 32-bit 
kernels on the very latest CPUs.

Thanks,

	Ingo
