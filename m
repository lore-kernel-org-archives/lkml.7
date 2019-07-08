Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200F5C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E495320665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600173;
	bh=aXj3z6IfKKrCdHytfIuFAzc+6Ul5/4UgWYTW5tMWF8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BgCgYLeQ+7vhOYzZyU3l4cxuu4i2f+XOEsi/UFej+XhT4x6eBW38EVbvSh4lRHp9X
	 9bc32RcpYK5GuygVRaigmFXoEA53EWMXpflPPpLfF5zdWtbhl7kDu7FELOZIYUUS6h
	 SB4ecakxl7QCwPCWbqNXZFHnhusVQTjy17i4nyIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390514AbfGHPeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390480AbfGHPeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:34:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F592204EC;
        Mon,  8 Jul 2019 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600046;
        bh=aXj3z6IfKKrCdHytfIuFAzc+6Ul5/4UgWYTW5tMWF8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TN0TPdX3j7TiAwwXypVnY2D7ZP5bcZ2cOzekpF1NC39AkfWa0bSzSO+uVzmQ4gmyG
         vg+435yiYh07WcxXfkKe3tC8W2LL0ZBW8KgNFt5FSc8UfpBT8/j7sUGzG9PsDzpqXx
         m7aEIBxkro7MWMrCcDv+sLhfV7X8B1nI/GEzyKOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 5.1 76/96] drm/virtio: move drm_connector_update_edid_property() call
Date:   Mon,  8 Jul 2019 17:13:48 +0200
Message-Id: <20190708150530.567539195@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerd Hoffmann <kraxel@redhat.com>

commit 41de4be6f6efa4132b29af51158cd672d93f2543 upstream.

drm_connector_update_edid_property can sleep, we must not
call it while holding a spinlock.  Move the callsite.

Fixes: b4b01b4995fb ("drm/virtio: add edid support")
Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20190405044602.2334-1-kraxel@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/virtio/virtgpu_vq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -620,11 +620,11 @@ static void virtio_gpu_cmd_get_edid_cb(s
 	output = vgdev->outputs + scanout;
 
 	new_edid = drm_do_get_edid(&output->conn, virtio_get_edid_block, resp);
+	drm_connector_update_edid_property(&output->conn, new_edid);
 
 	spin_lock(&vgdev->display_info_lock);
 	old_edid = output->edid;
 	output->edid = new_edid;
-	drm_connector_update_edid_property(&output->conn, output->edid);
 	spin_unlock(&vgdev->display_info_lock);
 
 	kfree(old_edid);


