Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F225CC46495
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D437121738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfGDX6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 19:58:06 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:32820 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727748AbfGDX6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 19:58:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4F990182CED2A;
        Thu,  4 Jul 2019 23:58:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: join74_63508f115542a
X-Filterd-Recvd-Size: 1508
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jul 2019 23:58:02 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] tty: hvcs: Fix odd use of strlcpy
Date:   Thu,  4 Jul 2019 16:57:47 -0700
Message-Id: <1be432798311378947ec4e6051cad1235b6eccbb.1562283944.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562283944.git.joe@perches.com>
References: <cover.1562283944.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the typical style of array, not the equivalent &array[0].

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/tty/hvc/hvcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index cb4db1b3ca3c..b6c1c1be06f9 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -871,8 +871,8 @@ static void hvcs_set_pi(struct hvcs_partner_info *pi, struct hvcs_struct *hvcsd)
 	hvcsd->p_partition_ID  = pi->partition_ID;
 
 	/* copy the null-term char too */
-	strlcpy(&hvcsd->p_location_code[0],
-			&pi->location_code[0], sizeof(hvcsd->p_location_code));
+	strlcpy(hvcsd->p_location_code, pi->location_code,
+		sizeof(hvcsd->p_location_code));
 }
 
 /*
-- 
2.15.0

