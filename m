Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57432C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311212071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419598;
	bh=H/QK2cUXjuCxu5n5CCGkede3gAy2IzrRCqu9ad+BuOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ry+Bv4MwMiPXEdYT4yUxeVzKQgF2k/KJSs+K8vzAkis2Tf1MAjsqij4Mga0F7kjwI
	 OS8u2y1lmY7aibyxCeuY94M4/Hi5c6MOvoUUIEhT1gdV/OUtnV0md7YlEJ0fgE2h6M
	 tb6XW7IJbYaXnnY3wJBOL5yAJnOWZ2Q5AaL5gtZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfKVKqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbfKVKqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:46:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D2832071C;
        Fri, 22 Nov 2019 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419594;
        bh=H/QK2cUXjuCxu5n5CCGkede3gAy2IzrRCqu9ad+BuOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyKesEwLQ3Ehcyfg3s6Kih+n5Vo1vCV66qgm5f7QxjGPuwld3KBVosxjTpc///1sg
         m3LdF88ZdmiheYeIjDHnotZHeQe2oAnLNYWazy+LTtcGAqM6aJe9DcfAGK8hZpYj2y
         2YGT1z7+r6ksSMpMLMz8tLNIOlEiG0LaeQOvwtRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Qiang <liq3ea@gmail.com>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 122/222] vfio/pci: Fix potential memory leak in vfio_msi_cap_len
Date:   Fri, 22 Nov 2019 11:27:42 +0100
Message-Id: <20191122100911.902329529@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Qiang <liq3ea@gmail.com>

[ Upstream commit 30ea32ab1951c80c6113f300fce2c70cd12659e4 ]

Free allocated vdev->msi_perm in error path.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 7b8a957b008d2..06a20ea183dd6 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1182,8 +1182,10 @@ static int vfio_msi_cap_len(struct vfio_pci_device *vdev, u8 pos)
 		return -ENOMEM;
 
 	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
-	if (ret)
+	if (ret) {
+		kfree(vdev->msi_perm);
 		return ret;
+	}
 
 	return len;
 }
-- 
2.20.1



