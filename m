Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393FCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB23206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919603;
	bh=FEcgngtZEuyg9UX8fft4+eshJZJxiuhsK5c2ub4emgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=faq6NEXCsWrsli+14g5s/laZpfFZMv+g6voO/8mxA1g1OA616vsnD9z1I1giSyIUQ
	 doqDMJxLdVUvt/ge8K5Syqx18d69YADL3DBBWJn6V7miO5zmQP9kbVWepAO3/XtY5h
	 j6WOn7W51eH3vsgZEw4O6aywkqdnzzn0VSkKjTQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfEOL0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729499AbfEOL0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:26:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869D520843;
        Wed, 15 May 2019 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919599;
        bh=FEcgngtZEuyg9UX8fft4+eshJZJxiuhsK5c2ub4emgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGvCWY7Cte65FuTR1pMC7vQ1SPvQ2xgFOxKmrcA02tX+vGRI21UvDe+Wuq+YYlfKa
         tP0u5sTh6g63s5WAQT3CP7yDk6wZP5wNMYUXQdnr/NQBwdFPar3blLp8ZlCVugaVlW
         wC2vhJOEaA0K50GdV13cqpnv61Dw5Ui4JHZ8qLgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 022/137] mac80211: Increase MAX_MSG_LEN
Date:   Wed, 15 May 2019 12:55:03 +0200
Message-Id: <20190515090654.879914351@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 78be2d21cc1cd3069c6138dcfecec62583130171 ]

Looks that 100 chars isn't enough for messages, as we keep getting
warnings popping from different places due to message shortening.
Instead of trying to shorten the prints, just increase the buffer size.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/trace_msg.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/trace_msg.h b/net/mac80211/trace_msg.h
index 366b9e6f043e2..40141df09f255 100644
--- a/net/mac80211/trace_msg.h
+++ b/net/mac80211/trace_msg.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Portions of this file
+ * Copyright (C) 2019 Intel Corporation
+ */
+
 #ifdef CONFIG_MAC80211_MESSAGE_TRACING
 
 #if !defined(__MAC80211_MSG_DRIVER_TRACE) || defined(TRACE_HEADER_MULTI_READ)
@@ -11,7 +16,7 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM mac80211_msg
 
-#define MAX_MSG_LEN	100
+#define MAX_MSG_LEN	120
 
 DECLARE_EVENT_CLASS(mac80211_msg_event,
 	TP_PROTO(struct va_format *vaf),
-- 
2.20.1



