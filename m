Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD64C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300D42084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920016;
	bh=5q/4lCuESOKzJV/pBrj6LtYk+b0+YBNGowgFkki6/z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BA0izUaUVV6FPPIa/HHKNcdZdP1ES93TUivRmh7FcRMtrqVisvhoVRLk+iPXoKrO4
	 j+/26+VQcbRiUth/SJWzuScbqMZtbvHu4xZJAnO4xJxu94t4gv1ZIZU00fXEkTC9B9
	 qyZzPAPMaOPRPqMecylUYXat3vQUWsPC/VZs0i1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfEOLde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733212AbfEOLdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:33:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6952053B;
        Wed, 15 May 2019 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557920013;
        bh=5q/4lCuESOKzJV/pBrj6LtYk+b0+YBNGowgFkki6/z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ohc5fPmz6rTnfiFxDMhf8rV3xpjkA2mOR5mf3HQrBiGNQ8YzS6pCuksFKShae7mnU
         uArtre4Flv8SHvD8zjcX2mzS6b40YEjdwDREC5hvx5C1REpZJQBOy2yiaL0oZQ/2hJ
         ev69tePJO295zMzmTrkcAnWz9S5ldxaNhcpzTOY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5.1 09/46] virt: vbox: Sanity-check parameter types for hgcm-calls coming from userspace
Date:   Wed, 15 May 2019 12:56:33 +0200
Message-Id: <20190515090621.462758083@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit cf4f2ad6b87dda2dbe0573b1ebeb0273f8d4aac6 upstream.

Userspace can make host function calls, called hgcm-calls through the
/dev/vboxguest device.

In this case we should not accept all hgcm-function-parameter-types, some
are only valid for in kernel calls.

This commit adds proper hgcm-function-parameter-type validation to the
ioctl for doing a hgcm-call from userspace.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virt/vboxguest/vboxguest_core.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1298,6 +1298,20 @@ static int vbg_ioctl_hgcm_disconnect(str
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
@@ -1333,6 +1347,23 @@ static int vbg_ioctl_hgcm_call(struct vb
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


