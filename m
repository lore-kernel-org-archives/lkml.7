Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A7BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48AF22317
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574140866;
	bh=XCnfPc2s8bb/SIuHu3GKa5xfGnz4VZTQPA1j38DLLaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ETIrmQyniYUZTcHT0zYemHQCOYTPsUWgqdK9WR1Q6Akk3Qj141861hKh97gOQcchm
	 HmEOWdzWiuCZFXn37ug89WFhWh0MvTadsprRqHm/8882gojM0xOHCzl+YrbVTkaPtY
	 0QrRB9OE7jTWi1LEpJ10UvdVbpA9FD25MlbLifqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKSFVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:21:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfKSFVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:21:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C27922319;
        Tue, 19 Nov 2019 05:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140862;
        bh=XCnfPc2s8bb/SIuHu3GKa5xfGnz4VZTQPA1j38DLLaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOHEVkAHeKU0x42HGyD+IQAljuHeTH/voOZjD+8wnx8ghN+NOCgHAyxzcn3OnfOxt
         ydVJOxHMNdzlIkIGX1rWQ17pmn15xGLsv0vPyMkZeFld2ALAFQkhhrpAm54e6ckYhO
         mCL4S6cMqOLSoAg5OdMARTyn0FhENpJhV58HdAnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 12/48] devlink: Add method for time-stamp on reporters dump
Date:   Tue, 19 Nov 2019 06:19:32 +0100
Message-Id: <20191119050958.045190908@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit d279505b723cba058b604ed8cf9cd4c854e2a041 ]

When setting the dump's time-stamp, use ktime_get_real in addition to
jiffies. This simplifies the user space implementation and bypasses
some inconsistent behavior with translating jiffies to current time.
The time taken is transformed into nsec, to comply with y2038 issue.

Fixes: c8e1da0bf923 ("devlink: Add health report functionality")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/devlink.h |    1 +
 net/core/devlink.c           |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -348,6 +348,7 @@ enum devlink_attr {
 	DEVLINK_ATTR_PORT_PCI_PF_NUMBER,	/* u16 */
 	DEVLINK_ATTR_PORT_PCI_VF_NUMBER,	/* u16 */
 
+	DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS_NS,	/* u64 */
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -4577,6 +4577,7 @@ struct devlink_health_reporter {
 	bool auto_recover;
 	u8 health_state;
 	u64 dump_ts;
+	u64 dump_real_ts;
 	u64 error_count;
 	u64 recovery_count;
 	u64 last_recovery_ts;
@@ -4749,6 +4750,7 @@ static int devlink_health_do_dump(struct
 		goto dump_err;
 
 	reporter->dump_ts = jiffies;
+	reporter->dump_real_ts = ktime_get_real_ns();
 
 	return 0;
 
@@ -4911,6 +4913,10 @@ devlink_nl_health_reporter_fill(struct s
 			      jiffies_to_msecs(reporter->dump_ts),
 			      DEVLINK_ATTR_PAD))
 		goto reporter_nest_cancel;
+	if (reporter->dump_fmsg &&
+	    nla_put_u64_64bit(msg, DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS_NS,
+			      reporter->dump_real_ts, DEVLINK_ATTR_PAD))
+		goto reporter_nest_cancel;
 
 	nla_nest_end(msg, reporter_attr);
 	genlmsg_end(msg, hdr);


