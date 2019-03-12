Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8999B2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412258;
	bh=+8ctW+2qXH320z6c5JUZ/YoVcwovt44UhvquksN3woI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sK5MkqifvhN3qRJgdfZBLe0nZXsfir3aI4vN3jVJpiyA33DFIQ5r/rzxw5Zu/41zp
	 74A0ZMTjhce7xaBKlWTljvI4MroWjVSJLEPYCbajFSSHKHeOOZ2/PnvKkKBs1xMxKF
	 v4CrcfISWroO9J6wVrNahB6AwtvjBA7N5yh++UuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfCLRhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbfCLRQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:37 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12BD82183F;
        Tue, 12 Mar 2019 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410997;
        bh=+8ctW+2qXH320z6c5JUZ/YoVcwovt44UhvquksN3woI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMcHCLQbFM+xjtK0BoOlQJTaONnh/LJbOwdoZ8ncuHKbQuixP7r0m2fZnkhLHmgYY
         YoYsZMo7IQsOkiC+2Y7LZcgPfp12aMqapaTwx9veuKIzf4OU43aZn4PRtTh4umsWJd
         l5vAinFSd+cdGM7CWc5PPe2WyLiXysXmQF7sYOMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 069/135] qed: Fix VF probe failure while FLR
Date:   Tue, 12 Mar 2019 10:08:36 -0700
Message-Id: <20190312170347.652869918@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index dd8ebf6d380f..3220086f99de 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -261,6 +261,7 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 	struct pfvf_acquire_resp_tlv *resp = &p_iov->pf2vf_reply->acquire_resp;
 	struct pf_vf_pfdev_info *pfdev_info = &resp->pfdev_info;
 	struct vf_pf_resc_request *p_resc;
+	u8 retry_cnt = VF_ACQUIRE_THRESH;
 	bool resources_acquired = false;
 	struct vfpf_acquire_tlv *req;
 	int rc = 0, attempts = 0;
@@ -314,6 +315,15 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 
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



