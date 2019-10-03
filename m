Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FBFC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1452070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121744;
	bh=YFcpQ5DlkoOtVD/DRuruBohEHaSxFNyUrtc9wrJsp8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IBZ/0kDKwVu4uKlhKqpc8Pdnpgd2hMf+M3BB7oKvgtIIIiPWwkh+/ZoWwwF+Dg0k6
	 UJPYusewQqQJVj7dudVGVx1QHuaivS14iVPPaVjn2XOlDF3HJN2Hj2kBQ3f37dmDBT
	 1UHLXRoOteuA7yUSp1Hr5NABq9BB92UdCSf6QmG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405104AbfJCQwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406133AbfJCQv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:51:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2FC62054F;
        Thu,  3 Oct 2019 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121515;
        bh=YFcpQ5DlkoOtVD/DRuruBohEHaSxFNyUrtc9wrJsp8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpSJYrnINUllIl4GQ2ZzlzvNqK90TfydbrXnMg3Fte0dXThCGDnrKp8kYNgVx1d1U
         qoG5kMoBra4oIngWZ5gk3K7csO2OMF07Jqu05dRdkpJzDJugWu/Od4laKCOLrFxRkp
         owuzWaZCvgw3HgUXlo8Anb81CiqjJbTTZ3oa+9BU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.3 300/344] ath10k: fix channel info parsing for non tlv target
Date:   Thu,  3 Oct 2019 17:54:25 +0200
Message-Id: <20191003154609.079936462@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Pillai <pillair@codeaurora.org>

commit 6be6c04bcc2e8770b8637632789ff15765124894 upstream.

The tlv targets such as WCN3990 send more data in the chan info event, which is
not sent by the non tlv targets. There is a minimum size check in the wmi event
for non-tlv targets and hence we cannot update the common channel info
structure as it was done in commit 13104929d2ec ("ath10k: fill the channel
survey results for WCN3990 correctly"). This broke channel survey results on
10.x firmware versions.

If the common channel info structure is updated, the size check for chan info
event for non-tlv targets will fail and return -EPROTO and we see the below
error messages

   ath10k_pci 0000:01:00.0: failed to parse chan info event: -71

Add tlv specific channel info structure and restore the original size of the
common channel info structure to mitigate this issue.

Tested HW: WCN3990
	   QCA9887
Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
	   10.2.4-1.0-00037

Fixes: 13104929d2ec ("ath10k: fill the channel survey results for WCN3990 correctly")
Cc: stable@vger.kernel.org # 5.0
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |    2 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |   16 ++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi.h     |    8 --------
 3 files changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -841,7 +841,7 @@ static int ath10k_wmi_tlv_op_pull_ch_inf
 					     struct wmi_ch_info_ev_arg *arg)
 {
 	const void **tb;
-	const struct wmi_chan_info_event *ev;
+	const struct wmi_tlv_chan_info_event *ev;
 	int ret;
 
 	tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -1615,6 +1615,22 @@ struct chan_info_params {
 
 #define WMI_TLV_FLAG_MGMT_BUNDLE_TX_COMPL	BIT(9)
 
+struct wmi_tlv_chan_info_event {
+	__le32 err_code;
+	__le32 freq;
+	__le32 cmd_flags;
+	__le32 noise_floor;
+	__le32 rx_clear_count;
+	__le32 cycle_count;
+	__le32 chan_tx_pwr_range;
+	__le32 chan_tx_pwr_tp;
+	__le32 rx_frame_count;
+	__le32 my_bss_rx_cycle_count;
+	__le32 rx_11b_mode_data_duration;
+	__le32 tx_frame_cnt;
+	__le32 mac_clk_mhz;
+} __packed;
+
 struct wmi_tlv_mgmt_tx_compl_ev {
 	__le32 desc_id;
 	__le32 status;
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6533,14 +6533,6 @@ struct wmi_chan_info_event {
 	__le32 noise_floor;
 	__le32 rx_clear_count;
 	__le32 cycle_count;
-	__le32 chan_tx_pwr_range;
-	__le32 chan_tx_pwr_tp;
-	__le32 rx_frame_count;
-	__le32 my_bss_rx_cycle_count;
-	__le32 rx_11b_mode_data_duration;
-	__le32 tx_frame_cnt;
-	__le32 mac_clk_mhz;
-
 } __packed;
 
 struct wmi_10_4_chan_info_event {


