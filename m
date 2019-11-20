Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F488C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7E12230E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfKTITT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:19:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:62914 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKTITT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:19:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 00:19:17 -0800
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="200638084"
Received: from cmhaerte-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 00:19:14 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: ptr_ret: drop PTR_ERR_OR_ZERO semantic patch
In-Reply-To: <1574179017-23787-1-git-send-email-Julia.Lawall@lip6.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1574179017-23787-1-git-send-email-Julia.Lawall@lip6.fr>
Date:   Wed, 20 Nov 2019 10:19:26 +0200
Message-ID: <87y2wbgdtd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> This mostly made changes that made the code harder
> to read, so drop it.

FWIW, I welcome this change.

Acked-by: Jani Nikula <jani.nikula@intel.com>

>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  scripts/coccinelle/api/ptr_ret.cocci |   97 -----------------------------------
>  1 file changed, 97 deletions(-)
>
> diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/api/ptr_ret.cocci
> deleted file mode 100644
> index e76cd5d..0000000
> --- a/scripts/coccinelle/api/ptr_ret.cocci
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -///
> -/// Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> -///
> -// Confidence: High
> -// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.
> -// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.
> -// URL: http://coccinelle.lip6.fr/
> -// Options: --no-includes --include-headers
> -//
> -// Keywords: ERR_PTR, PTR_ERR, PTR_ERR_OR_ZERO
> -// Version min: 2.6.39
> -//
> -
> -virtual context
> -virtual patch
> -virtual org
> -virtual report
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> -+ return PTR_ERR_OR_ZERO(ptr);
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> -+ return PTR_ERR_OR_ZERO(ptr);
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
> -+ PTR_ERR_OR_ZERO(ptr)
> -
> -@r1 depends on !patch@
> -expression ptr;
> -position p1;
> -@@
> -
> -* if@p1 (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> -
> -@r2 depends on !patch@
> -expression ptr;
> -position p2;
> -@@
> -
> -* if@p2 (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> -
> -@r3 depends on !patch@
> -expression ptr;
> -position p3;
> -@@
> -
> -* IS_ERR@p3(ptr) ? PTR_ERR(ptr) : 0
> -
> -@script:python depends on org@
> -p << r1.p1;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -
> -@script:python depends on org@
> -p << r2.p2;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on org@
> -p << r3.p3;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r1.p1;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r2.p2;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r3.p3;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
>

-- 
Jani Nikula, Intel Open Source Graphics Center
