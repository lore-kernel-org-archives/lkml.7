Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF8DC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1262168B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994196;
	bh=lwKR71ZRj7Zr9zES63ArSSUXvbi1ImHyvWXs/ZGcBfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qkToa2VzaEzsrYJOSzJ19EVc87JAxkaoP+jdudAZ9xtROkdSVFde2LjSlDGGDRXt6
	 vYaxRizE7Q2MBVtbzE8K8UGxw0hdtn2P0Hc1UB0U4eslNugLSvuV4rlFUwFnRTuo+n
	 Xbuf9nJzZn4iyHhCjstKAK42w+Zvgb8voHt6ApHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfFHLnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbfFHLnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:43:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C96AD214AF;
        Sat,  8 Jun 2019 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994189;
        bh=lwKR71ZRj7Zr9zES63ArSSUXvbi1ImHyvWXs/ZGcBfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWb29LW2GOFLlDpTN/RBIbysS1d/eJQJ1CzDx9Yxh9p4Bs1lSLJV6gLVnFUQ/7RPd
         eSUQYNfnuGV4lSJ0C4Jv1Le5gYb4eW1ITan6ONBXJHEXLjoHud54uqafVaNJ66mmwz
         h8rxdRRboX/qt4Lz3JZeIb4A6w0VtE27yui3N4hI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/49] usb: xhci: Fix a potential null pointer dereference in xhci_debugfs_create_endpoint()
Date:   Sat,  8 Jun 2019 07:41:51 -0400
Message-Id: <20190608114232.8731-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114232.8731-1-sashal@kernel.org>
References: <20190608114232.8731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 5bce256f0b528624a34fe907db385133bb7be33e ]

In xhci_debugfs_create_slot(), kzalloc() can fail and
dev->debugfs_private will be NULL.
In xhci_debugfs_create_endpoint(), dev->debugfs_private is used without
any null-pointer check, and can cause a null pointer dereference.

To fix this bug, a null-pointer check is added in
xhci_debugfs_create_endpoint().

This bug is found by a runtime fuzzing tool named FIZZER written by us.

[subjet line change change, add potential -Mathais]
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index cadc01336bf8..7ba6afc7ef23 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -440,6 +440,9 @@ void xhci_debugfs_create_endpoint(struct xhci_hcd *xhci,
 	struct xhci_ep_priv	*epriv;
 	struct xhci_slot_priv	*spriv = dev->debugfs_private;
 
+	if (!spriv)
+		return;
+
 	if (spriv->eps[ep_index])
 		return;
 
-- 
2.20.1

