Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB20C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A37E20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctI5nV54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKVXQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:16:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22141 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbfKVXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574464592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h66orNIRlxipn9OanQ0e7UoO0EZyQRcJCeSlCInnFok=;
        b=ctI5nV54BuKgzA8CYkGiHvKmkoJm5K2A+NKdIck3ZWQmddHrBKvfzpe0TcAHnDCll9xpOq
        /XEYAElft3asYjFy4MZOYaSncdgRdphEuHv12tySO+6pnehwwVXDyBWqbbUWEmBeA/Gedq
        x77IUNCZxuwdQ9xnRNNRsQO9KUCo9FE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-nsI8QOLrMtq3qYavP0mS_Q-1; Fri, 22 Nov 2019 18:16:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC94100726A;
        Fri, 22 Nov 2019 23:16:28 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21F8B19C4F;
        Fri, 22 Nov 2019 23:16:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Imre Deak" <imre.deak@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Lee Shawn C" <shawn.c.lee@intel.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Maxime Ripard" <mripard@kernel.org>
Subject: [PATCH 0/5] drm/i915: eDP DPCD aux backlight fixes
Date:   Fri, 22 Nov 2019 18:15:58 -0500
Message-Id: <20191122231616.2574-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nsI8QOLrMtq3qYavP0mS_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got a ThinkPad X1 Extreme 2nd Generation for fixing some
issues on, and noticed that out of the box the backlight doesn't work.
Along the way of fixing that, I found a few issues with how i915 handles
DPCD AUX backlight control and fixed them. Now I've got working
backlight controls, hooray!

Note that this patch series also enables DPCD aux backlight control by
default based on what the VBT tells us.

Lyude Paul (5):
  drm/i915: Fix eDP DPCD aux max backlight calculations
  drm/i915: Assume 100% brightness when not in DPCD control mode
  drm/i915: Fix DPCD register order in intel_dp_aux_enable_backlight()
  drm/i915: Auto detect DPCD backlight support by default
  drm/i915: Force DPCD backlight mode on X1 Extreme 2nd Gen 4K AMOLED
    panel

 drivers/gpu/drm/drm_dp_helper.c               |   4 +
 .../drm/i915/display/intel_display_types.h    |   3 +
 .../drm/i915/display/intel_dp_aux_backlight.c | 167 ++++++++++++------
 drivers/gpu/drm/i915/i915_params.c            |   2 +-
 drivers/gpu/drm/i915/i915_params.h            |   2 +-
 include/drm/drm_dp_helper.h                   |   8 +
 6 files changed, 134 insertions(+), 52 deletions(-)

--=20
2.21.0

