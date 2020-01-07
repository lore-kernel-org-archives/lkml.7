Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB0C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E2E2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgAGJkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:40:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:8931 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgAGJkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:40:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 01:40:21 -0800
X-IronPort-AV: E=Sophos;i="5.69,405,1571727600"; 
   d="scan'208";a="215493331"
Received: from twgeistx-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.50.72])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 01:40:18 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Maxime Ripard <maxime@cerno.tech>, Julia.Lawall@lip6.fr,
        Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] coccinnelle: Remove ptr_ret script
In-Reply-To: <20200107073629.325249-1-maxime@cerno.tech>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200107073629.325249-1-maxime@cerno.tech>
Date:   Tue, 07 Jan 2020 11:40:31 +0200
Message-ID: <8736crli40.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2020, Maxime Ripard <maxime@cerno.tech> wrote:
> The ptr_ret script script addresses a number of situations where we end up
> testing an error pointer, and if it's an error returning it, or return 0
> otherwise to transform it into a PTR_ERR_OR_ZERO call.
>
> So it will convert a block like this:
>
> if (IS_ERR(err))
>     return PTR_ERR(err);
>
> return 0;
>
> into
>
> return PTR_ERR_OR_ZERO(err);
>
> While this is technically correct, it has a number of drawbacks. First, it
> merges the error and success path, which will make it harder for a reviewer
> or reader to grasp.
>
> It's also more difficult to extend if we were to add some code between the
> error check and the function return, making the author essentially revert
> that patch before adding new lines, while it would have been a trivial
> addition otherwise for the rewiever.
>
> Therefore, since that script is only about cosmetic in the first place,
> let's remove it since it's not worth it.

I guess Julia's patch [1] never got merged then?

Reaffirming my ack on the removal, regardless of whose patch it is,

Acked-by: Jani Nikula <jani.nikula@intel.com>


[1] http://lore.kernel.org/r/1574179017-23787-1-git-send-email-Julia.Lawall@lip6.fr


>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  scripts/coccinelle/api/ptr_ret.cocci | 97 ----------------------------
>  1 file changed, 97 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/ptr_ret.cocci
>
> diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/api/ptr_ret.cocci
> deleted file mode 100644
> index e76cd5d90a8a..000000000000
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

-- 
Jani Nikula, Intel Open Source Graphics Center
