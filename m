Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4341FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5C1204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mv4TEqYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfHNKpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:45:47 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:35967 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfHNKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:45:46 -0400
Received: by mail-vk1-f201.google.com with SMTP id o75so44644671vke.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 03:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=suzgW5VW6Ng90prgpz/ghvx/fVcho6Pl4urYZ0d0Q0c=;
        b=Mv4TEqYa23uJDtobaDY6OSoe+shBIF5XVxXALV+QFVPinFL0cqfxETuiYnTHfikeS0
         beLlJ1+BBIyTAhKd1JqnpQo3tivf3SZ9z9nk7oObNoNce/6RSi9vJcKeItZ2Ap6i16TF
         sO16PNkbi+BrhuokCdIAorhyUJfLy4AtshgXt9ebmMQnJJ4M0k+SuwLsbI7Bsm4wqfct
         I0WU4v/LGzR40UT/Gan8eztP4Nk3Z3k9qcxdtOaJVCJucEb4gb4HXBGf3mNS7bdkYmZf
         laScErz8C4mR2ZvF1JR64oYbIgVooQF19lNDFb3YDWHqMnlxLTlgGCYy+McMlra+GR7H
         AOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=suzgW5VW6Ng90prgpz/ghvx/fVcho6Pl4urYZ0d0Q0c=;
        b=F2uZES2E2lQK2BxNvYLgKQFZXO1xhZUNRX9vqKPjF2ekBuI2rpMklXtGGsvodNg1xu
         4h0lljgst1tuFXvxuiI88UG8wLSEv/DH6ysxVNc/B0WNZEjQM0+A9vyp+OQQyKqVP4hR
         n8VaAhth2y3FqUbsfkEUkZ0sm4OnqCLoBk+WDf+8S9o46y1h2kYG7fdTw8NA7ltRYiAJ
         9tmChl7qHTNB05FxlRjlCGWxCf6dHHyHaZEqy5AzvNjDE9/f8bX3StFChNOQP4L+B1fF
         wB5hDZ3Hjh6WjHQ99X0JbSZqNdjkagWj1j2vfhCtdbMiecIQSjoVh/ohWx0MV8DJYufG
         rE+w==
X-Gm-Message-State: APjAAAUCUnSllikaKxdnAL6wi5dVu56WvDhneuNyvXWSPdbT1yLTXOpv
        NHpuXFB6ukFG1saI/H1zMDl70XUBTfM=
X-Google-Smtp-Source: APXvYqy2T8ZzD5xkHgUSqk7raFy1jd0urGCFCByhxKXfqSbhhtzmjZm/8Oyftss+nvV1arSJ2jUJFkSDHpQ=
X-Received: by 2002:a1f:93cd:: with SMTP id v196mr11075937vkd.84.1565779544819;
 Wed, 14 Aug 2019 03:45:44 -0700 (PDT)
Date:   Wed, 14 Aug 2019 12:45:00 +0200
In-Reply-To: <20190814104520.6001-1-darekm@google.com>
Message-Id: <20190814104520.6001-3-darekm@google.com>
Mime-Version: 1.0
References: <20190814104520.6001-1-darekm@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v7 2/9] drm/i915/intel_hdmi: use cec_notifier_conn_(un)register
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     Dariusz Marcinkiewicz <darekm@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Shashank Sharma <shashank.sharma@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new cec_notifier_conn_(un)register() functions to
(un)register the notifier for the HDMI connector, and fill in
the cec_connector_info.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b1ca8e5bdb56d..9fcf2c58c29c5 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2752,8 +2752,9 @@ intel_hdmi_connector_register(struct drm_connector *connector)
 
 static void intel_hdmi_destroy(struct drm_connector *connector)
 {
-	if (intel_attached_hdmi(connector)->cec_notifier)
-		cec_notifier_put(intel_attached_hdmi(connector)->cec_notifier);
+	struct cec_notifier *n = intel_attached_hdmi(connector)->cec_notifier;
+
+	cec_notifier_conn_unregister(n);
 
 	intel_connector_destroy(connector);
 }
@@ -3068,6 +3069,7 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
 	struct drm_device *dev = intel_encoder->base.dev;
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	enum port port = intel_encoder->port;
+	struct cec_connector_info conn_info;
 
 	DRM_DEBUG_KMS("Adding HDMI connector on port %c\n",
 		      port_name(port));
@@ -3120,8 +3122,11 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
 		I915_WRITE(PEG_BAND_GAP_DATA, (temp & ~0xf) | 0xd);
 	}
 
-	intel_hdmi->cec_notifier = cec_notifier_get_conn(dev->dev,
-							 port_identifier(port));
+	cec_fill_conn_info_from_drm(&conn_info, connector);
+
+	intel_hdmi->cec_notifier =
+		cec_notifier_conn_register(dev->dev, port_identifier(port),
+					   &conn_info);
 	if (!intel_hdmi->cec_notifier)
 		DRM_DEBUG_KMS("CEC notifier get failed\n");
 }
-- 
2.23.0.rc1.153.gdeed80330f-goog

