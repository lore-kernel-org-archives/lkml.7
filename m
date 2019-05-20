Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E63C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F3F20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YJ92PSD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbfETMp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:45:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37758 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389437AbfETMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:45:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KCefq1019411;
        Mon, 20 May 2019 05:45:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=DnYcpObWTuNxMqWTKSiW08f0YpZsIp8D6UxdO7lCUao=;
 b=YJ92PSD/5kpBHZWp3ghsL3eNwSn1tYN73MnEeOqDz20ELgdI/ZxtL2DMpyRCHzHlfaJy
 zniTefqahjbilBInh3HIx7hcTn9bkw7OZ5yWJfERIiMhMdE266YiU1YTFDp6UHASgmVr
 VDZ7vfwSrM3nEFaxbw38KU5aIqMgSBFQ7EfexiRq/nHY05KFcaMVe0pJyEdil2YRN0AS
 Idf+EcciOJs4GLoXOhIAJfbQMug84ejnulE5Eht67dbAT3QeA34ejsK3HwTn+DhK2gF6
 FJ8e/VthJx3TPoH8WmD8o4UyDJI0Moo1L3N7wYjihKH98LE1OkPusOAMnmVUy+yAjlWC Bg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sjhjjr4bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 05:45:20 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 20 May
 2019 05:45:19 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 20 May 2019 05:45:19 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id EBB613F703F;
        Mon, 20 May 2019 05:45:17 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <leon@kernel.org>,
        <apw@canonical.com>, <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] checkpatch: add test for empty line after Fixes statement
Date:   Mon, 20 May 2019 15:42:38 +0300
Message-ID: <20190520124238.10298-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that there is no empty line after a fixes statement

Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a09333fd7cef..6cbc07364d4f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -62,6 +62,7 @@ my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
+my $fixes = 0;
 
 sub help {
 	my ($exitcode) = @_;
@@ -2792,6 +2793,18 @@ sub process {
 			}
 		}
 
+# Check if Fixes statement to make sure next line is not blank
+		if ($fixes) {
+			if ($line =~ /^\s*$/) {
+				WARN("EMPTY_LINE_AFTER_FIXES", "No Empty line after Fixes statement\n" . $here);
+			}
+			$fixes = 0;
+		}
+
+		if ($in_commit_log && $line =~ /Fixes/) {
+			$fixes = 1;
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.14.5

