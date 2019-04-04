Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4931C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36242075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfDDMjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbfDDMjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D78999CDF;
        Thu,  4 Apr 2019 12:39:21 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-19.ams2.redhat.com [10.36.117.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2A6019C68;
        Thu,  4 Apr 2019 12:39:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] virt: vbox: Sanity-check parameter types for hgcm-calls coming from userspace
Date:   Thu,  4 Apr 2019 14:39:09 +0200
Message-Id: <20190404123909.30684-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 04 Apr 2019 12:39:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can make host function calls, called hgcm-calls through the
/dev/vboxguest device.

In this case we should not accept all hgcm-function-parameter-types, some
are only valid for in kernel calls.

This commit adds proper hgcm-function-parameter-type validation to the
ioctl for doing a hgcm-call from userspace.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 8ca333f21292..2307b0329aec 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1298,6 +1298,20 @@ static int vbg_ioctl_hgcm_disconnect(struct vbg_dev *gdev,
 	return ret;
 }
 
+static bool vbg_param_valid(enum vmmdev_hgcm_function_parameter_type type)
+{
+	switch (type) {
+	case VMMDEV_HGCM_PARM_TYPE_32BIT:
+	case VMMDEV_HGCM_PARM_TYPE_64BIT:
+	case VMMDEV_HGCM_PARM_TYPE_LINADDR:
+	case VMMDEV_HGCM_PARM_TYPE_LINADDR_IN:
+	case VMMDEV_HGCM_PARM_TYPE_LINADDR_OUT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
 			       struct vbg_session *session, bool f32bit,
 			       struct vbg_ioctl_hgcm_call *call)
@@ -1333,6 +1347,23 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
 	}
 	call->hdr.size_out = actual_size;
 
+	/* Validate parameter types */
+	if (f32bit) {
+		struct vmmdev_hgcm_function_parameter32 *parm =
+			VBG_IOCTL_HGCM_CALL_PARMS32(call);
+
+		for (i = 0; i < call->parm_count; i++)
+			if (!vbg_param_valid(parm[i].type))
+				return -EINVAL;
+	} else {
+		struct vmmdev_hgcm_function_parameter *parm =
+			VBG_IOCTL_HGCM_CALL_PARMS(call);
+
+		for (i = 0; i < call->parm_count; i++)
+			if (!vbg_param_valid(parm[i].type))
+				return -EINVAL;
+	}
+
 	/*
 	 * Validate the client id.
 	 */
-- 
2.21.0

