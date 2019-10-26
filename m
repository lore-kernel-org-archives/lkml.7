Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C93CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A7C206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096903;
	bh=+WTnZQS0Xpw/cwwprl/VCxCd2cyIC1hhCuyGvhbOqmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDzb4s5Xc4v8HB9mBzifMJd+9fqiGZX1diy0w5OVDOrxOmjsOFxkdXXhTwLhOVZ31
	 5tPNlbLQOuDrbMwyj13eNLfSKIojWAdPfgaZLeHCjhoVaHjqsbRoflAeHLpvhgT5Vi
	 4Vebkl936PlCPRYv5hFD8wYxMYZ84RRGnv+wI7ZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfJZNfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfJZNR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:17:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BFE62070B;
        Sat, 26 Oct 2019 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095846;
        bh=+WTnZQS0Xpw/cwwprl/VCxCd2cyIC1hhCuyGvhbOqmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubjm0FioqdfZUkImMyBH5X0566wLUvqGxeHyDSUOBl3zJRCKhqu3Jnor9R1/N8V67
         FgnEGxGwiNVXDDKm4uTKrKbvTdRJGpmfeplND4AFKFkJq+tiBqujJsiS1ka+2WfPz+
         1a0IVIfTNgKuBOY2N7ihp1VZeTxc/A18g8qy/vyQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 45/99] s390/qeth: Fix initialization of vnicc cmd masks during set online
Date:   Sat, 26 Oct 2019 09:15:06 -0400
Message-Id: <20191026131600.2507-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit be40a86c319706f90caca144343c64743c32b953 ]

Without this patch, a command bit in the supported commands mask is only
ever set to unsupported during set online. If a command is ever marked as
unsupported (e.g. because of error during qeth_l2_vnicc_query_cmds),
subsequent successful initialization (offline/online) would not bring it
back.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index f011e2c43f00d..d5d0b2408a6b2 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2063,11 +2063,15 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 			sup_cmds = 0;
 			error = true;
 		}
-		if (!(sup_cmds & IPA_VNICC_SET_TIMEOUT) ||
-		    !(sup_cmds & IPA_VNICC_GET_TIMEOUT))
+		if ((sup_cmds & IPA_VNICC_SET_TIMEOUT) &&
+		    (sup_cmds & IPA_VNICC_GET_TIMEOUT))
+			card->options.vnicc.getset_timeout_sup |= vnicc;
+		else
 			card->options.vnicc.getset_timeout_sup &= ~vnicc;
-		if (!(sup_cmds & IPA_VNICC_ENABLE) ||
-		    !(sup_cmds & IPA_VNICC_DISABLE))
+		if ((sup_cmds & IPA_VNICC_ENABLE) &&
+		    (sup_cmds & IPA_VNICC_DISABLE))
+			card->options.vnicc.set_char_sup |= vnicc;
+		else
 			card->options.vnicc.set_char_sup &= ~vnicc;
 	}
 	/* enforce assumed default values and recover settings, if changed  */
-- 
2.20.1

