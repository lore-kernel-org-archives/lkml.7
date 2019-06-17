Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810A32063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806617;
	bh=ZZUzArcMjzp1ZUoNgnxq5kYOqQFnQ8BS0bQB27xlweo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V8OTt1vRPZazkR/7+S2wne1Jq91QoKcpXdZnvPaN3/wCfvNM0M+cnvcl1Gbj5iUE8
	 7qrEDBOMqi3gRKa4Ckp5WjskutuMJaO0TwDmMGLsBzo2rf7wFByNNSSJC1tq+BqcMl
	 SP1cIfCm9qRy2DATbK6fCq/ZpPhVunge1eBuJuSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfFQVXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbfFQVXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:23:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971D020673;
        Mon, 17 Jun 2019 21:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806612;
        bh=ZZUzArcMjzp1ZUoNgnxq5kYOqQFnQ8BS0bQB27xlweo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkmLtrOv7sPlqIui+q2loCKA/Fo3mDnskahn8sYcFj4Jn+xNW5SE50EPBe7Z2LhDu
         Ob2HEPq8MsJf9mCcaA6Fc1T7E4swZ/wpZthW7uaLiNjSb6UOmkZQtURdX5inoLApVW
         Daaoc7UTH+0Z45FOoVUmNYMybtwVzrIl9xVlcARI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Harish Chegondi <harish.chegondi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Tested-by: Paul Wise" <pabs3@bonedaddy.net>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.1 112/115] drm/edid: abstract override/firmware EDID retrieval
Date:   Mon, 17 Jun 2019 23:10:12 +0200
Message-Id: <20190617210805.590671194@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

commit 56a2b7f2a39a8d4b16a628e113decde3d7400879 upstream.

Abstract the debugfs override and the firmware EDID retrieval
function. We'll be needing it in the follow-up. No functional changes.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Harish Chegondi <harish.chegondi@intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Tested-by: Tested-by: Paul Wise <pabs3@bonedaddy.net>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190607110513.12072-1-jani.nikula@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1580,6 +1580,20 @@ static void connector_bad_edid(struct dr
 	}
 }
 
+/* Get override or firmware EDID */
+static struct edid *drm_get_override_edid(struct drm_connector *connector)
+{
+	struct edid *override = NULL;
+
+	if (connector->override_edid)
+		override = drm_edid_duplicate(connector->edid_blob_ptr->data);
+
+	if (!override)
+		override = drm_load_edid_firmware(connector);
+
+	return IS_ERR(override) ? NULL : override;
+}
+
 /**
  * drm_do_get_edid - get EDID data using a custom EDID block read function
  * @connector: connector we're probing
@@ -1607,15 +1621,10 @@ struct edid *drm_do_get_edid(struct drm_
 {
 	int i, j = 0, valid_extensions = 0;
 	u8 *edid, *new;
-	struct edid *override = NULL;
-
-	if (connector->override_edid)
-		override = drm_edid_duplicate(connector->edid_blob_ptr->data);
-
-	if (!override)
-		override = drm_load_edid_firmware(connector);
+	struct edid *override;
 
-	if (!IS_ERR_OR_NULL(override))
+	override = drm_get_override_edid(connector);
+	if (override)
 		return override;
 
 	if ((edid = kmalloc(EDID_LENGTH, GFP_KERNEL)) == NULL)


