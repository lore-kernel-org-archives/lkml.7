Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F25C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710DD2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054564;
	bh=vgsDzGUDj9eXwrIfUeDJq8jGG2+FUEtUFsElmbqhroQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6xGz4X9kt32dHv2pvWEHjg+nQMuat3jLPLphRaGNoN2FxWyW6cyk/7/sJlKkcLC7
	 eXAqW7+pHSBQPSfuPO/MfM3OFpu9JkV+CSwfjAwPfxbP7fCzn66gfvQq9Qc8yf1B1l
	 Zf9gF7BomVDyTXpZxs3h8iDpbhNN2sxrkDUswXcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGBICn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbfGBICk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:02:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0212D20659;
        Tue,  2 Jul 2019 08:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054559;
        bh=vgsDzGUDj9eXwrIfUeDJq8jGG2+FUEtUFsElmbqhroQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1gOggjjWBr4cA4wGhS89ttphFxXHxNSdxTUBpdaZaXC4dK1Iu8V8RT+6vfHVn4CY
         pcMEC4VSvHB4bhMPdq0ijKPPSb/6aKSwZzxqHKUbhbNb2WOcUvV+V0361Rqaazk4Oe
         XyCNIBnP6aa5OwYIeCOO+uGil4R6SHKxgbGJCnzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Imre Deak <imre.deak@intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 5.1 11/55] drm/i915: Remove redundant store of logical CDCLK state
Date:   Tue,  2 Jul 2019 10:01:19 +0200
Message-Id: <20190702080124.603759643@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.103022729@linuxfoundation.org>
References: <20190702080124.103022729@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imre Deak <imre.deak@intel.com>

commit 2b21dfbeee725778daed2c3dd45a3fc808176feb upstream.

We copied the original state into the atomic state already earlier in
the function, so no need to do it a second time.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190320135439.12201-3-imre.deak@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>

---
 drivers/gpu/drm/i915/intel_display.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -12828,8 +12828,6 @@ static int intel_modeset_checks(struct d
 		DRM_DEBUG_KMS("New voltage level calculated to be logical %u, actual %u\n",
 			      intel_state->cdclk.logical.voltage_level,
 			      intel_state->cdclk.actual.voltage_level);
-	} else {
-		to_intel_atomic_state(state)->cdclk.logical = dev_priv->cdclk.logical;
 	}
 
 	intel_modeset_clear_plls(state);


