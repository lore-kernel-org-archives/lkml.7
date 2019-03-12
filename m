Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A707C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB96206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411679;
	bh=no5+dMa7cF1DGZycwZB3vDKlFeEhSvN/wWFYk2JNa8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TznsxyLw5y3ZOyw/bMhyxmdQH7x7DDBATqxpX6onL9XijWfUm1L89k9QxwnhvHpBB
	 XtCBONWpPcUNSBopPs6Dwcu4/7+WlZu6AQX9gxN3VhVLNlF3l8xcGxfajLC7LRW11o
	 Put/4Pg2gyCBlKc4Vub1/qtq88o49SAn3k1bzGEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfCLR16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbfCLRRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:44 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1239206DF;
        Tue, 12 Mar 2019 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411064;
        bh=no5+dMa7cF1DGZycwZB3vDKlFeEhSvN/wWFYk2JNa8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZ7jRi4L+lT8yXZi1d5YpHSLe81aV1mulDAdoEIp0tFg1zES4gsE/shAnwLWHyVum
         TDLv7s7TPzrTqPwgVDdYYkBSJsCwE3huvpXNoSbgKtLdd+eor5pPqPoCE2KoViWGZC
         Il3uF5TG098EWjPMrgoJdmwRXW4Z/gqCvfG0J94I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 53/96] qed: Fix VF probe failure while FLR
Date:   Tue, 12 Mar 2019 10:10:11 -0700
Message-Id: <20190312171038.532807468@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 327852ec64205bb651be391a069784872098a3b2 ]

VFs may hit VF-PF channel timeout while probing, as in some
cases it was observed that VF FLR and VF "acquire" message
transaction (i.e first message from VF to PF in VF's probe flow)
could occur simultaneously which could lead VF to fail sending
"acquire" message to PF as VF is marked disabled from HW perspective
due to FLR, which will result into channel timeout and VF probe failure.

In such cases, try retrying VF "acquire" message so that in later
attempts it could be successful to pass message to PF after the VF
FLR is completed and can be probed successfully.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 9cc02b94328a..cf34908ec8e1 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -158,6 +158,7 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 	struct pfvf_acquire_resp_tlv *resp = &p_iov->pf2vf_reply->acquire_resp;
 	struct pf_vf_pfdev_info *pfdev_info = &resp->pfdev_info;
 	struct vf_pf_resc_request *p_resc;
+	u8 retry_cnt = VF_ACQUIRE_THRESH;
 	bool resources_acquired = false;
 	struct vfpf_acquire_tlv *req;
 	int rc = 0, attempts = 0;
@@ -203,6 +204,15 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 
 		/* send acquire request */
 		rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+
+		/* Re-try acquire in case of vf-pf hw channel timeout */
+		if (retry_cnt && rc == -EBUSY) {
+			DP_VERBOSE(p_hwfn, QED_MSG_IOV,
+				   "VF retrying to acquire due to VPC timeout\n");
+			retry_cnt--;
+			continue;
+		}
+
 		if (rc)
 			goto exit;
 
-- 
2.19.1



