Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9D9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8FB222C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640730;
	bh=V8+AX6NmgPrCd7u5ESCMAsVXX3stlJexHiOjmb4Ny5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ENKrLgScoB8k5fXih/qScWarQh+DtLyJcinooO/O9KRwT4NsaNC1/DHyFfM8JxdC6
	 dP9LL05bOH4DJhMwMYD1lQd5FQRnFqDXdJrNlqWu0FcRbQzLBdjlagphmsAlMf+SdE
	 9DF6M1ML+RA1KLzBG8piQDYDfKFr6cyY6E7ENYtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfL2RcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:32:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbfL2RcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:32:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D01920409;
        Sun, 29 Dec 2019 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640723;
        bh=V8+AX6NmgPrCd7u5ESCMAsVXX3stlJexHiOjmb4Ny5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ot52PBzfxAbKGNvxX02bdokgCkKawX8FiS8wK/ZmjbWSdYPENuV39GXcaqJe8tziI
         i1SjlwmxpesampiVh4J+eScnRp+r1Fn5XrNWeX6r/Wj2GAOUrOlX1G/6NyRychb36D
         P2lIr/GfCBHVoexwEHDuJH9YyC426fZx3Bm4Jtnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 112/219] Bluetooth: Fix advertising duplicated flags
Date:   Sun, 29 Dec 2019 18:18:34 +0100
Message-Id: <20191229162525.553429215@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 6012b9346d8959194c239fd60a62dfec98d43048 ]

Instances may have flags set as part of its data in which case the code
should not attempt to add it again otherwise it can cause duplication:

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x06
        Flags: 0x04
          BR/EDR Not Supported
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_request.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9448ebd3780a..a8ddd211e94c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1258,6 +1258,14 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 	instance_flags = get_adv_instance_flags(hdev, instance);
 
+	/* If instance already has the flags set skip adding it once
+	 * again.
+	 */
+	if (adv_instance && eir_get_data(adv_instance->adv_data,
+					 adv_instance->adv_data_len, EIR_FLAGS,
+					 NULL))
+		goto skip_flags;
+
 	/* The Add Advertising command allows userspace to set both the general
 	 * and limited discoverable flags.
 	 */
@@ -1290,6 +1298,7 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 	}
 
+skip_flags:
 	if (adv_instance) {
 		memcpy(ptr, adv_instance->adv_data,
 		       adv_instance->adv_data_len);
-- 
2.20.1



