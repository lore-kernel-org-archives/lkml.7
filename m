Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFF6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD5120881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfEWUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:19:20 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:48007 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387524AbfEWUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:19:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A74F8182CED28;
        Thu, 23 May 2019 20:19:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lock32_6e24366692258
X-Filterd-Recvd-Size: 2246
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 May 2019 20:19:16 +0000 (UTC)
Message-ID: <f1fa87acecc7cb5329d28d42f7327742aceb04db.camel@perches.com>
Subject: Re: [PATCHv6 1/4] drm/omap: use DRM_DEBUG_DRIVER instead of CORE
From:   Joe Perches <joe@perches.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Thu, 23 May 2019 13:19:15 -0700
In-Reply-To: <20190523200756.25314-2-sebastian.reichel@collabora.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
         <20190523200756.25314-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-23 at 22:07 +0200, Sebastian Reichel wrote:
> This macro is only used by omapdrm, which should print
> debug messages using the DRIVER category instead of the
> default CORE category.
[]
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
[]
> @@ -37,8 +37,8 @@
>  #include "omap_irq.h"
>  #include "omap_plane.h"
>  
> -#define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
> -#define VERB(fmt, ...) if (0) DRM_DEBUG(fmt, ##__VA_ARGS__) /* verbose debug */
> +#define DBG(fmt, ...) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
> +#define VERB(fmt, ...) if (0) DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__) /* verbose debug */

Trivia:

Strictly, this should use do { if (0) etc... } while (0)

Also, none of the VERB uses have a terminating newline
so ideally, this should be:

#define VERB(fmt, ...) do { if (0) DRM_DEBUG_DRIVER(fmt "\n", ##__VA_ARGS__); } while (0) /* verbose debug */

And VERB isn't a particularly intelligible macro name.
Maybe VDBG instead.


