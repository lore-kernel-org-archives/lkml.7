Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62373C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD19222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573609965;
	bh=lFx2rRdEIXn+jqFY622RjoZc/jkGHnSqXCd/YP8iTn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1vMDvHcTBFTamRx50wG86Age7lSLdlRfew9X6s7lqh8Ti18vvT117IzLP4eKfiOqx
	 dSrkCa5S28pnr3NAbvGok2ppkMvXtPOCi33dq63WAYxwBeT9x8t+4WTKMSCfxDUVI5
	 ItF8cNXwh1NnLXqGqpfYRIpphxLa4A58xYrBUxtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfKMBwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:52:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbfKMBwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:52:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6113222CA;
        Wed, 13 Nov 2019 01:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609951;
        bh=lFx2rRdEIXn+jqFY622RjoZc/jkGHnSqXCd/YP8iTn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSZgM8zUriS46F5p1w6n7m7Uz1sS6k+H7NGPt/0aArjbQ8cA/W91zKsnj9XshB9CB
         Gn3x94E8R0Y+H/B26vCHAGWtc7Jp2Oh3TLMujWjooBBALXR7ZKCbYPsopDu3Qdd1jt
         /ns1moxN01soZKJrSL091edW4/FvU/ZeGcojat+w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 088/209] qed: Avoid implicit enum conversion in qed_ooo_submit_tx_buffers
Date:   Tue, 12 Nov 2019 20:48:24 -0500
Message-Id: <20191113015025.9685-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8fa74e3c49204bdf788d99ef71840490cccc210d ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_ll2.c:799:32: warning: implicit
conversion from enumeration type 'enum core_tx_dest' to different
enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
                tx_pkt.tx_dest = p_ll2_conn->tx_dest;
                               ~ ~~~~~~~~~~~~^~~~~~~
1 warning generated.

Fix this by using a switch statement to convert between the enumerated
values since they are not 1 to 1, which matches how the rest of the
driver handles this conversion.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Suggested-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 015de1e0addd6..2847509a183d0 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -796,7 +796,18 @@ qed_ooo_submit_tx_buffers(struct qed_hwfn *p_hwfn,
 		tx_pkt.vlan = p_buffer->vlan;
 		tx_pkt.bd_flags = bd_flags;
 		tx_pkt.l4_hdr_offset_w = l4_hdr_offset_w;
-		tx_pkt.tx_dest = p_ll2_conn->tx_dest;
+		switch (p_ll2_conn->tx_dest) {
+		case CORE_TX_DEST_NW:
+			tx_pkt.tx_dest = QED_LL2_TX_DEST_NW;
+			break;
+		case CORE_TX_DEST_LB:
+			tx_pkt.tx_dest = QED_LL2_TX_DEST_LB;
+			break;
+		case CORE_TX_DEST_DROP:
+		default:
+			tx_pkt.tx_dest = QED_LL2_TX_DEST_DROP;
+			break;
+		}
 		tx_pkt.first_frag = first_frag;
 		tx_pkt.first_frag_len = p_buffer->packet_length;
 		tx_pkt.cookie = p_buffer;
-- 
2.20.1

