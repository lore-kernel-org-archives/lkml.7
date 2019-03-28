Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858FB206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuGBn7iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfC1RLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:11:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45632 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfC1RLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:11:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so10786128pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+luZLveOgW0ezcsj4kzoCAaYqh/zxiLbPom43ySTdYE=;
        b=TuGBn7iqwM5v0B4Bm40K5s7yE4HVHgUiAGzeNUmTNkQX2u0Pac6aMuoldukAlxjlf0
         C+MG9KzehokpacpUTzp1R9wt5XVszcEjV9gj9ch0CtYN717yHeg+68wvH6qo5bLetrh4
         ELDKDq/OT+P6lgOQQKHV+q+h+9JdACVWYQnIhVg7aJn9WibEp70dyMZb5WA9kDC9rQ7w
         IAjtcrvS/GjZ4eautGSBOSW+NDy19qBtJMA/d4x1oEdTy/GPz1uCuSssus3mhV6SSSed
         1xNfA3y1WKGGO8DA8svueZGnozmXBqMGoqnG3sGF283Z8HdcFqUQjq8TiI2XeeapkGW5
         g/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+luZLveOgW0ezcsj4kzoCAaYqh/zxiLbPom43ySTdYE=;
        b=JDWs+SMgvs/LLHQb0eRthw7QgA+3I/drBKTwWfWuhpKlpEWu8Hw7deGuibaSUONgRp
         klJves3t3gmz2cLmVn1El9a78K+yZO7YMStJaP+uldrAakcXcOX9NKupLq6dcXQVIPob
         tm8NR6dfNMrGLcZyGzXjv5DIs8FuYp8x4kmL/GC8S5sac+3buNvNZvFLsJyuy/0RIMXT
         Ov5mJ1pcJV3kE+XOZyNGCC1MkDfX+4GCFg1o6yR5Hznu/tIlCLA7B0acKBXp4u0NPRm7
         v854GeiYrmsIB8IkRKbKyiuzv1QKGLVBAzUZPlsNJvxRFX/wWaPR3gnoXg18d3d6qLPo
         ZW2Q==
X-Gm-Message-State: APjAAAXlhvVBuyKoVs5CaBsrowmUNVVltXTWmX0W/H9DKEgKSTtf/klG
        /4VDJ3OCLlWcWIcYZl+YaFA=
X-Google-Smtp-Source: APXvYqwoVGBdqOQrZ211qCAOLuoK3EBPGHId4CjdJALXQEp8Op4SFemamW5WUJRJXJcgL804P6WXtw==
X-Received: by 2002:aa7:8694:: with SMTP id d20mr41695287pfo.81.1553793096585;
        Thu, 28 Mar 2019 10:11:36 -0700 (PDT)
Received: from CentOS76.localdomain ([49.205.222.128])
        by smtp.gmail.com with ESMTPSA id n65sm89286677pfb.160.2019.03.28.10.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:11:35 -0700 (PDT)
Date:   Fri, 29 Mar 2019 00:32:03 +0530
From:   Jagadeesh Pagadala <jagdsh.linux@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        a.hajda@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] gpu:drm: Remove duplicate headers
Message-ID: <20190328190203.GA27353@CentOS76.localdomain>
References: <1553721116-37832-1-git-send-email-jagdsh.linux@gmail.com>
 <20190328065124.GB4846@pendragon.ideasonboard.com>
 <20190328160206.GA94653@CentOS76.localdomain>
 <20190328141210.GA4813@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20190328141210.GA4813@pendragon.ideasonboard.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2019 at 04:12:10PM +0200, Laurent Pinchart wrote:
> Hi Jagadeesh,
> 
> On Thu, Mar 28, 2019 at 09:32:06PM +0530, Jagadeesh Pagadala wrote:
> > On Thu, Mar 28, 2019 at 08:51:24AM +0200, Laurent Pinchart wrote:
> > > On Thu, Mar 28, 2019 at 02:41:56AM +0530, jagdsh.linux@gmail.com wrote:
> > > > From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> > > > 
> > > > Remove duplicate headers which are included twice.
> > > 
> > > Could you, while at it, also sort the existing #include statements
> > > alphabetically ? This should help avoiding similar issues in the future.
> > > 
> > > > Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/panel.c       | 1 -
> > > >  drivers/gpu/drm/i915/intel_display.c | 7 -------
> > > >  2 files changed, 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> > > > index 38eeaf8..eb9567d 100644
> > > > --- a/drivers/gpu/drm/bridge/panel.c
> > > > +++ b/drivers/gpu/drm/bridge/panel.c
> > > > @@ -15,7 +15,6 @@
> > > >  #include <drm/drm_encoder.h>
> > > >  #include <drm/drm_modeset_helper_vtables.h>
> > > >  #include <drm/drm_probe_helper.h>
> > > > -#include <drm/drm_panel.h>
> > > >  
> > > >  struct panel_bridge {
> > > >  	struct drm_bridge bridge;
> > > > diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> > > > index ccb6163..1166342 100644
> > > > --- a/drivers/gpu/drm/i915/intel_display.c
> > > > +++ b/drivers/gpu/drm/i915/intel_display.c
> > > > @@ -51,14 +51,7 @@
> > > >  #include "intel_dsi.h"
> > > >  #include "intel_frontbuffer.h"
> > > >  
> > > > -#include "intel_drv.h"
> > > > -#include "intel_dsi.h"
> > > > -#include "intel_frontbuffer.h"
> > > > -
> > > > -#include "i915_drv.h"
> > > > -#include "i915_gem_clflush.h"
> > > >  #include "i915_reset.h"
> > > > -#include "i915_trace.h"
> > > >  
> > > >  /* Primary plane formats for gen <= 3 */
> > > >  static const u32 i8xx_primary_formats[] = {
> 
> > From c9a68b204fe4bb013c2b8481ca8239c957dd69cc Mon Sep 17 00:00:00 2001
> > From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> > Date: Thu, 28 Mar 2019 21:20:12 +0530
> > Subject: [PATCH] gpu:drm: sort the existing #includes alphabetically
> > 
> > Hi Laurent,
> > 
> > Hopefully this helps.
> 
> It does, thanks. If you squash it with your original patch and send a
> v2, you can add my
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/panel.c       | 2 +-
> >  drivers/gpu/drm/i915/intel_display.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> > index eb9567d..000ba7c 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -9,11 +9,11 @@
> >   */
> >  
> >  #include <drm/drmP.h>
> > -#include <drm/drm_panel.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_connector.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> > +#include <drm/drm_panel.h>
> >  #include <drm/drm_probe_helper.h>
> >  
> >  struct panel_bridge {
> > diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> > index 1166342..7956e89 100644
> > --- a/drivers/gpu/drm/i915/intel_display.c
> > +++ b/drivers/gpu/drm/i915/intel_display.c
> > @@ -46,13 +46,13 @@
> >  
> >  #include "i915_drv.h"
> >  #include "i915_gem_clflush.h"
> > +#include "i915_reset.h"
> >  #include "i915_trace.h"
> > +
> >  #include "intel_drv.h"
> >  #include "intel_dsi.h"
> >  #include "intel_frontbuffer.h"
> >  
> > -#include "i915_reset.h"
> > -
> >  /* Primary plane formats for gen <= 3 */
> >  static const u32 i8xx_primary_formats[] = {
> >  	DRM_FORMAT_C8,
> 
> -- 
> Regards,
> 
> Laurent Pinchart

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-gpu-drm-Remove-duplicate-headers.patch"

From 25776c74d289f8c2e6c89d8838f3110981ce2515 Mon Sep 17 00:00:00 2001
From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Date: Fri, 29 Mar 2019 00:04:29 +0530
Subject: [PATCH v2] gpu:drm: Remove duplicate headers

1. Remove duplicate headers which are included twice.
2. Sort the existing #includes alphabetically

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/bridge/panel.c       | 3 +--
 drivers/gpu/drm/i915/intel_display.c | 9 +--------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 38eeaf8..000ba7c 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -9,13 +9,12 @@
  */
 
 #include <drm/drmP.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
-#include <drm/drm_probe_helper.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
 
 struct panel_bridge {
 	struct drm_bridge bridge;
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index ccb6163..7956e89 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -46,20 +46,13 @@
 
 #include "i915_drv.h"
 #include "i915_gem_clflush.h"
+#include "i915_reset.h"
 #include "i915_trace.h"
-#include "intel_drv.h"
-#include "intel_dsi.h"
-#include "intel_frontbuffer.h"
 
 #include "intel_drv.h"
 #include "intel_dsi.h"
 #include "intel_frontbuffer.h"
 
-#include "i915_drv.h"
-#include "i915_gem_clflush.h"
-#include "i915_reset.h"
-#include "i915_trace.h"
-
 /* Primary plane formats for gen <= 3 */
 static const u32 i8xx_primary_formats[] = {
 	DRM_FORMAT_C8,
-- 
1.8.3.1


--1yeeQ81UyVL57Vl7--
