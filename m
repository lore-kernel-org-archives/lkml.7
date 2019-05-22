Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF9CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFF120856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554909;
	bh=Fy9BgBVc74QAoCS/z7JOP+vBjrHz1G376Mmq3tq1ww8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqdFzq0PXqrwJdR/XVHEQtxHXsVT5N+LNkpxuVHF+IRThJiLcDO5dqZgGgIU7+Pzh
	 JB7kmmqzL5nXGibb5B05ybxIGNjC+wObepOckfx3Hvts48p4Q2O1biGBgvdJXVPrsI
	 vbetawx+cKStXEb6rnW+u8fnVMTpXIs9sJUS0Nc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbfEVTzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730865AbfEVTZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:25:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98C62173C;
        Wed, 22 May 2019 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553129;
        bh=Fy9BgBVc74QAoCS/z7JOP+vBjrHz1G376Mmq3tq1ww8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y83znSoCYrXFs8bMwLO7y7O3msUyEfeYX9gJGjr2eHvdybf3reCgbDosw4bNkrUkE
         xEIqEw1nmrn3cxWJfF6v1a1XvfUyDwdkSsN3rcp/+bQ+UJ+kn4BY5R88SIqvYCpl7n
         ATmEQk9Nrojrjxy5SSw9/rk74rbo/5RoS/7Nh/ss=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 063/317] s390: qeth: address type mismatch warning
Date:   Wed, 22 May 2019 15:19:24 -0400
Message-Id: <20190522192338.23715-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 46b83629dede262315aa82179d105581f11763b6 ]

clang produces a harmless warning for each use for the qeth_adp_supported
macro:

drivers/s390/net/qeth_l2_main.c:559:31: warning: implicit conversion from enumeration type 'enum qeth_ipa_setadp_cmd' to
      different enumeration type 'enum qeth_ipa_funcs' [-Wenum-conversion]
        if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/s390/net/qeth_core.h:179:41: note: expanded from macro 'qeth_adp_supported'
        qeth_is_ipa_supported(&c->options.adp, f)
        ~~~~~~~~~~~~~~~~~~~~~                  ^

Add a version of this macro that uses the correct types, and
remove the unused qeth_adp_enabled() macro that has the same
problem.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 122059ecad848..614bb0f34e8e2 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -215,6 +215,12 @@ struct qeth_vnicc_info {
 	bool rx_bcast_enabled;
 };
 
+static inline int qeth_is_adp_supported(struct qeth_ipa_info *ipa,
+		enum qeth_ipa_setadp_cmd func)
+{
+	return (ipa->supported_funcs & func);
+}
+
 static inline int qeth_is_ipa_supported(struct qeth_ipa_info *ipa,
 		enum qeth_ipa_funcs func)
 {
@@ -228,9 +234,7 @@ static inline int qeth_is_ipa_enabled(struct qeth_ipa_info *ipa,
 }
 
 #define qeth_adp_supported(c, f) \
-	qeth_is_ipa_supported(&c->options.adp, f)
-#define qeth_adp_enabled(c, f) \
-	qeth_is_ipa_enabled(&c->options.adp, f)
+	qeth_is_adp_supported(&c->options.adp, f)
 #define qeth_is_supported(c, f) \
 	qeth_is_ipa_supported(&c->options.ipa4, f)
 #define qeth_is_enabled(c, f) \
-- 
2.20.1

