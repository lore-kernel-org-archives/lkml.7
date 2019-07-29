Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA7120679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKAMRd+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfG2Ucv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:32:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50370 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfG2Ucv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:32:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so55051065wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ee1tMJewpz3aSk+3Cf8f90eAN6SRg/eYiUnStRjgYLc=;
        b=GKAMRd+sTnkw9Z5FKHUDESOtOokR4c4LKf+jO5xxjeSjB57EumDZ/CxDxRuPx5o04c
         OOkO4iV+suXKl3yH0dFExABiXBZteawHydX44sNNpKwCoNqPkRrjAcNWaUL1JPwHiXDt
         i9ODh5Q9p+tG2eaVD37/+XAMw/WcEH36Yo9Z+UvpDZ7FUdKsKch/axOhYZPg57pKoeQS
         Hyb4Uzezdex64lvLHXl5cVC0f2v1lfQan8CB1xPFNR6buLIGB/bq7uby93buNGR9leQB
         E7IXah2txsckO3Ju25p+/cJv0doqIxdkhbzw3zM+4CkbAf4HdVfFDABA/5uKlCk03eHY
         uKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ee1tMJewpz3aSk+3Cf8f90eAN6SRg/eYiUnStRjgYLc=;
        b=DwFg0tGFjwMHWQ+B8zFwdBCNoFeEfTh1TR0vRIFjzr3A584Bbe0XAvwiVR8HeQM879
         rTatJZXSSTbgvLYp74pYzxBpOQknLjL63gq+LXPrpoZNEc/t0exK3GbHOAoQx3pR1GiF
         xPxqHEjrWitm/bmli1y6bmc7ZtRGRCj2qVjq2qGPXi6b3N/blwnJ+pdcA+QKEAFp8GHN
         NTilO2WFPqDtrPAEeRcxgCoqPYDkL9zPIyymL/J0of7jrU081MBYUnJBheDFBAjxK7o7
         6iSzn+S8IwxRS8dsas/RkGc0HHuQjpshcPeHtlfbFn0MsqbDyUx9cAV1ruKlOqcE6LX5
         Bkbw==
X-Gm-Message-State: APjAAAVATCj1wu3MMqkNS/VSnJKxjHkyk1XyZAsj+2edhw0smyDiDyfg
        e7FzcPuCYAjGsyjm97BEd0A=
X-Google-Smtp-Source: APXvYqyo7SE3N8MZySPqPna98P9GkU1XLHH7+P2p4LKXp1/uIewGRNlsiTkEr1RxTwquxX5I1q0klQ==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr100975707wme.95.1564432368772;
        Mon, 29 Jul 2019 13:32:48 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id t24sm56680198wmj.14.2019.07.29.13.32.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 13:32:48 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:32:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     mpe@ellerman.id.au, christophe.leroy@c-s.fr,
        segher@kernel.crashing.org, arnd@arndb.de,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
Message-ID: <20190729203246.GA117371@archlinux-threadripper>
References: <20190729202542.205309-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729202542.205309-1-ndesaulniers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:25:41PM -0700, Nick Desaulniers wrote:
> Commit 6c5875843b87 ("powerpc: slightly improve cache helpers") exposed
> what looks like a codegen bug in Clang's handling of `%y` output
> template with `Z` constraint. This is resulting in panics during boot
> for 32b powerpc builds w/ Clang, as reported by our CI.
> 
> Add back the original code that worked behind a preprocessor check for
> __clang__ until we can fix LLVM.
> 
> Further, it seems that clang allnoconfig builds are unhappy with `Z`, as
> reported by 0day bot. This is likely because Clang warns about inline
> asm constraints when the constraint requires inlining to be semantically
> valid.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=42762
> Link: https://github.com/ClangBuiltLinux/linux/issues/593
> Link: https://lore.kernel.org/lkml/20190721075846.GA97701@archlinux-threadripper/
> Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Alternatively, we could just revert 6c5875843b87. It seems that GCC
> generates the same code for these functions for out of line versions.
> But I'm not sure how the inlined code generated would be affected.

For the record:

https://godbolt.org/z/z57VU7

This seems consistent with what Michael found so I don't think a revert
is entirely unreasonable.

Either way:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
