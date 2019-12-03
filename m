Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E46C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F22C21556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414026;
	bh=DeXZqWfdQmpH8xcGCtSwtUO03nsd2mpATwa+Nni2ybc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VxKkdsvj9oJ3/KkQAshJFnM3sb85yy3OomZCMElc++daWakaaN++RdW9Oq3w6J1Kb
	 e7CseFGAa6TCj1rBjijtnk39jUBo/EnuR8RYoisyRQCzgeA3+BN/M+rMM4J+Xb5cQr
	 jYGsaSF/cPQ2EMS6ku/AN/F5oHnzXfw5jR7t3eLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfLCW5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbfLCW5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:57:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC20C2053B;
        Tue,  3 Dec 2019 22:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413863;
        bh=DeXZqWfdQmpH8xcGCtSwtUO03nsd2mpATwa+Nni2ybc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjZqJovLmcMD0CDW/vHQdiyq+cQ2cEVgCly3pjWhpnHJDP/heIXmWODoAWCd3TUiJ
         7o5WOA/9/cJqLBtAW3eI7uD52470/+gW5Eq1v7fvUntKizBbscehkK5quFHm0Bnl3N
         Dy5BPfDelGBUtDGxuRPmyqpjfFFXgZpGP3WgFtH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        John Rutherford <john.rutherford@dektech.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 290/321] tipc: fix link name length check
Date:   Tue,  3 Dec 2019 23:35:56 +0100
Message-Id: <20191203223442.233998868@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Rutherford <john.rutherford@dektech.com.au>

[ Upstream commit fd567ac20cb0377ff466d3337e6e9ac5d0cb15e4 ]

In commit 4f07b80c9733 ("tipc: check msg->req data len in
tipc_nl_compat_bearer_disable") the same patch code was copied into
routines: tipc_nl_compat_bearer_disable(),
tipc_nl_compat_link_stat_dump() and tipc_nl_compat_link_reset_stats().
The two link routine occurrences should have been modified to check
the maximum link name length and not bearer name length.

Fixes: 4f07b80c9733 ("tipc: check msg->reg data len in tipc_nl_compat_bearer_disable")
Signed-off-by: John Rutherford <john.rutherford@dektech.com.au>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/netlink_compat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -548,7 +548,7 @@ static int tipc_nl_compat_link_stat_dump
 	if (len <= 0)
 		return -EINVAL;
 
-	len = min_t(int, len, TIPC_MAX_BEARER_NAME);
+	len = min_t(int, len, TIPC_MAX_LINK_NAME);
 	if (!string_is_valid(name, len))
 		return -EINVAL;
 
@@ -830,7 +830,7 @@ static int tipc_nl_compat_link_reset_sta
 	if (len <= 0)
 		return -EINVAL;
 
-	len = min_t(int, len, TIPC_MAX_BEARER_NAME);
+	len = min_t(int, len, TIPC_MAX_LINK_NAME);
 	if (!string_is_valid(name, len))
 		return -EINVAL;
 


