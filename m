Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEE824677
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186229;
	bh=qIatg2w5rVRztpZGU8uf42VZ0u7YextTtWcAnW0OJtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EBuPLDC2ND4XBzsDhMgS74uYtINY+YNd/t+NeQz1wOdwIz0tHd1ajXEXwfkVp5MWd
	 U2Bs5bFhsGirsQWW7+j6Xl8DP7qlTDz0bM/s3uIS/8wCRlTSkTJmwAXPIk9uDMllfh
	 wtuoZbe63k7XkclYwOqqpdfET4fRBhGZzS+StkxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbfE3DRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbfE3DNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:46 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6FE24556;
        Thu, 30 May 2019 03:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186026;
        bh=qIatg2w5rVRztpZGU8uf42VZ0u7YextTtWcAnW0OJtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDMeW/y1fDpzCVZ+UsYEvfprfiOb05BAEgASi2ukeAPH/YEr16AqnHfXPmVzMcTtF
         Y7XCxYzB8EtxOfJKI9rP3CAmV6YAv75W3qc/7fVfIgxvrkAx2GLPOVL0SDwJEjD7yS
         ijWsINi1iJ9q7q1crDMiB3VhFkWVxLDl/LRcGJV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 101/346] s390: qeth: address type mismatch warning
Date:   Wed, 29 May 2019 20:02:54 -0700
Message-Id: <20190530030546.266102240@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



