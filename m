Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E23C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020EE217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427623;
	bh=I5zM+GozbT0bt9CqEAiv4Y3sfVcVo/KIvmIUaX75MXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mSAB9R/W4YrYb0320VF9iHlMpDbd6COj9ebwIgUhQyH44xFM0IIu/bL+4w4jnZ6Cy
	 x/9SH3oqTJzx4exd9og6uyMNdgxK9BeRl1jRSdmINI7nxWN/fOvoP+bEgUVG3qoxrl
	 P5H5yWPBnEZrdQAqmsBpDJFBknpYy3k4wumF7CRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfEISrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfEISq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:46:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE539217F5;
        Thu,  9 May 2019 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427618;
        bh=I5zM+GozbT0bt9CqEAiv4Y3sfVcVo/KIvmIUaX75MXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhH8eyek5lzndAtIyJFfDyxHTaLYH9hVyKZgNCar+F4uvfbMCUeuJdb4TpzCKx3AA
         /Iud8YO7VmIc1dE16el4990ooL5TeZGP5FESrs0Rif20CwG04ZyyUsfaLryTtxFPgG
         RoEj/gkcpT08H2kiU1BNJ4hngirge8W7BL1NjVtw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH 4.14 38/42] Bluetooth: Align minimum encryption key size for LE and BR/EDR connections
Date:   Thu,  9 May 2019 20:42:27 +0200
Message-Id: <20190509181259.990192481@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

commit d5bb334a8e171b262e48f378bd2096c0ea458265 upstream.

The minimum encryption key size for LE connections is 56 bits and to
align LE with BR/EDR, enforce 56 bits of minimum encryption key size for
BR/EDR connections as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/bluetooth/hci_core.h |    3 +++
 net/bluetooth/hci_conn.c         |    8 ++++++++
 2 files changed, 11 insertions(+)

--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -178,6 +178,9 @@ struct adv_info {
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
+/* Min encryption key size to match with SMP */
+#define HCI_MIN_ENC_KEY_SIZE		7
+
 /* Default LE RPA expiry time, 15 minutes */
 #define HCI_DEFAULT_RPA_TIMEOUT		(15 * 60)
 
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1165,6 +1165,14 @@ int hci_conn_check_link_mode(struct hci_
 	    !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 		return 0;
 
+	/* The minimum encryption key size needs to be enforced by the
+	 * host stack before establishing any L2CAP connections. The
+	 * specification in theory allows a minimum of 1, but to align
+	 * BR/EDR and LE transports, a minimum of 7 is chosen.
+	 */
+	if (conn->enc_key_size < HCI_MIN_ENC_KEY_SIZE)
+		return 0;
+
 	return 1;
 }
 


