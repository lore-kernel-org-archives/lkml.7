Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAFEC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D0E227BF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004181;
	bh=wmsXCaWocJrWhOtzuqB0VXZ+o3Vvr/D8GkqS097UfTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lPPHxd/IE1SIGbKiikx4+7e/oQSKHVcGEemmKKRKeV5WtBMhgwQnKH9AVFx3khU67
	 2MbUbnI4NBzH1Ao4SQnTyMHri1JQk/EG4WZS0y98P0JFnQukZMy4Yby2nYy2H6o01Q
	 YnIul2HQdJuqAqLzLPtadvPR2wbGT+RPqwwOovj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgABW3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgABW3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:29:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4232021835;
        Thu,  2 Jan 2020 22:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004176;
        bh=wmsXCaWocJrWhOtzuqB0VXZ+o3Vvr/D8GkqS097UfTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0fOgMpM9UPF1BDKx3xCtRRVLxXbAqmZKwInZDYQmIhoWWUiw+bl/qYIDT3L+rh7A
         2vkf8RpbLWewisrCtnkdxNitK1FLmrKxO1yVpKPHQ34jKFUv/uKpckukdqd2VL8eAF
         boa+tAhWBAYGdAa/OeO4PLTlQnRNnkf2b1NBKJfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 045/171] Bluetooth: Fix advertising duplicated flags
Date:   Thu,  2 Jan 2020 23:06:16 +0100
Message-Id: <20200102220553.167854533@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
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
index 1015d9c8d97d..4a89e121d662 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1093,6 +1093,14 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
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
@@ -1125,6 +1133,7 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 	}
 
+skip_flags:
 	if (adv_instance) {
 		memcpy(ptr, adv_instance->adv_data,
 		       adv_instance->adv_data_len);
-- 
2.20.1



