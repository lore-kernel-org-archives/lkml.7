Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEE2C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1944B20844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfHMO65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:58:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729586AbfHMO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:58:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7DEsiCw150961
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:58:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubxy7shcj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:58:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Tue, 13 Aug 2019 15:58:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Aug 2019 15:58:50 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7DEwnN552560044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 14:58:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A592D42045;
        Tue, 13 Aug 2019 14:58:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EF7642041;
        Tue, 13 Aug 2019 14:58:49 +0000 (GMT)
Received: from localhost (unknown [9.152.212.112])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 13 Aug 2019 14:58:49 +0000 (GMT)
Date:   Tue, 13 Aug 2019 16:58:48 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracefs: avoid crash when open callback is not set
References: <your-ad-here.call-01565708256-ext-1951@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <your-ad-here.call-01565708256-ext-1951@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
x-cbid: 19081314-0020-0000-0000-0000035F30A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081314-0021-0000-0000-000021B445EC
Message-Id: <patch.git-ff7e3ec62cff.your-ad-here.call-01565708219-ext-8038@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=954 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some tracefs files, e.g. tracing/events/syscalls/*/id do not define
"open" file operation. Yet commit 757ff7244358 ("tracefs: Restrict
tracefs when the kernel is locked down") introduces "open" proxy which
unconditionally calls original open callback, which causes kernel crash
when the callback is 0.

Fix that by simply returning 0, if open callback is not set.

Fixes: 757ff7244358 ("tracefs: Restrict tracefs when the kernel is locked down")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 fs/tracefs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 12a325fb4cbd..77407632c916 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -43,7 +43,9 @@ static int default_open_file(struct inode *inode, struct file *filp)
 		return ret;
 
 	real_fops = dentry->d_fsdata;
-	return real_fops->open(inode, filp);
+	if (real_fops->open)
+		return real_fops->open(inode, filp);
+	return 0;
 }
 
 static ssize_t default_read_file(struct file *file, char __user *buf,
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿

