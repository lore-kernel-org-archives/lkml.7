Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF52C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB2B2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556965579;
	bh=/VLryxNAOQ7i+D8vtOLwhoK4JVjHjDNuF8b8vv87mG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kVcr7NbNi3veMcIxM4RQsqzqy+NBVPM6gCsZYCdbE/IfTsBgJPY9CE18EOkJa4zW9
	 8lGUshyTnIJ3F0EuEya4luwIU/ktRX45WQ6b9KoMBqVs8bC6rTZH151NzsNw0k6u7C
	 rmh9dfO/z5tDY/hg0S3lCI7ZUNXIBB1kXrtlNTLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfEDK0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfEDK0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:26:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFE22084A;
        Sat,  4 May 2019 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556965574;
        bh=/VLryxNAOQ7i+D8vtOLwhoK4JVjHjDNuF8b8vv87mG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOHzvNoSHFv3Ai73bqBPodxjgDNys+edoni5GeNDevMWpH36fbzJZ5KIR6HqGaqLF
         45Al7GjAMIQTARAD8+YKbpAZ6yMr9s85I4KWiBIN8Y9XNMVz34XU9OZxosG03lWJpd
         e/0SmCr7mnGLQ2ZeFF7R6wKPLFE1WMW2jdBwLzcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 23/32] bnxt_en: Pass correct extended TX port statistics size to firmware.
Date:   Sat,  4 May 2019 12:25:08 +0200
Message-Id: <20190504102453.210019339@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504102452.523724210@linuxfoundation.org>
References: <20190504102452.523724210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit ad361adf0d08f1135f3845c6b3a36be7cc0bfda5 ]

If driver determines that extended TX port statistics are not supported
or allocation of the data structure fails, make sure to pass 0 TX stats
size to firmware to disable it.  The firmware returned TX stats size should
also be set to 0 for consistency.  This will prevent
bnxt_get_ethtool_stats() from accessing the NULL TX stats pointer in
case there is mismatch between firmware and driver.

Fixes: 36e53349b60b ("bnxt_en: Add additional extended port statistics.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6745,6 +6745,7 @@ static int bnxt_hwrm_port_qstats_ext(str
 	struct hwrm_queue_pri2cos_qcfg_input req2 = {0};
 	struct hwrm_port_qstats_ext_input req = {0};
 	struct bnxt_pf_info *pf = &bp->pf;
+	u32 tx_stat_size;
 	int rc;
 
 	if (!(bp->flags & BNXT_FLAG_PORT_STATS_EXT))
@@ -6754,13 +6755,16 @@ static int bnxt_hwrm_port_qstats_ext(str
 	req.port_id = cpu_to_le16(pf->port_id);
 	req.rx_stat_size = cpu_to_le16(sizeof(struct rx_port_stats_ext));
 	req.rx_stat_host_addr = cpu_to_le64(bp->hw_rx_port_stats_ext_map);
-	req.tx_stat_size = cpu_to_le16(sizeof(struct tx_port_stats_ext));
+	tx_stat_size = bp->hw_tx_port_stats_ext ?
+		       sizeof(*bp->hw_tx_port_stats_ext) : 0;
+	req.tx_stat_size = cpu_to_le16(tx_stat_size);
 	req.tx_stat_host_addr = cpu_to_le64(bp->hw_tx_port_stats_ext_map);
 	mutex_lock(&bp->hwrm_cmd_lock);
 	rc = _hwrm_send_message(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT);
 	if (!rc) {
 		bp->fw_rx_stats_ext_size = le16_to_cpu(resp->rx_stat_size) / 8;
-		bp->fw_tx_stats_ext_size = le16_to_cpu(resp->tx_stat_size) / 8;
+		bp->fw_tx_stats_ext_size = tx_stat_size ?
+			le16_to_cpu(resp->tx_stat_size) / 8 : 0;
 	} else {
 		bp->fw_rx_stats_ext_size = 0;
 		bp->fw_tx_stats_ext_size = 0;


