Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6374AC31E49
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360EB20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ZWGiM6qW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfFNAq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:46:57 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:46408 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFNAqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:46:55 -0400
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x5E0gNC9023391;
        Fri, 14 Jun 2019 01:46:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=jan2016.eng;
 bh=tOwtey2gYWrcPQe7qjiJ8htKmCqIBJhoDAMwtMgMkc4=;
 b=ZWGiM6qWCu5hc/lQ76deJn5zDHffDeGuVb7SveKCfqd9UWGAKicxEnL0BekYuoE1MaSi
 g4bT7gVeBBIg+fonKzHHdCPXrE1+HF0Ar1Mfa1BIDk5NeL+nIE1u97uIsFUjccKzCmbZ
 YUOzCdWDVISQmRHfGIc2mvwXWW9t4Hf7FB9JzHEJzG/bBJo/L4xf9L8n0yU+itig6YVt
 0fCYOHO7HJ6ziz+2ohaj37kYQMVY9cC7gRS0KGv6+Q8c0XO7tSnjC8tK/2+CwJmPp5AU
 KpO8IFOhP0pFcSPmFCaPiU/yjqMDj3cuI7fyUEHtrFRGre51OMOdfGEKFLFjqQ/fYuFv ew== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050096.ppops.net-00190b01. with ESMTP id 2t3ky5jkpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 01:46:27 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x5E0Whhv003866;
        Thu, 13 Jun 2019 20:46:26 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.31])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2t08bxh9km-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 20:46:25 -0400
Received: from usma1ex-cas5.msg.corp.akamai.com (172.27.123.53) by
 usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Thu, 13 Jun 2019 20:45:28 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 usma1ex-cas5.msg.corp.akamai.com (172.27.123.53) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Thu, 13 Jun 2019 17:45:21 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 4E54261D59; Thu, 13 Jun 2019 20:45:21 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>,
        <linux-security-module@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Igor Lubashev <ilubashe@akamai.com>
Subject: [RFC PATCH 0/1] security: add SECURE_KEEP_FSUID to preserve fsuid/fsgid across execve
Date:   Thu, 13 Jun 2019 20:44:46 -0400
Message-ID: <1560473087-27754-1-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=865
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906140003
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=903 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906140005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted this in March but received no response. Reposting.

This patch introduces SECURE_KEEP_FSUID to allow fsuid/fsgid to be
preserved across execve. It is currently impossible to execve a
program such that effective and filesystem uid differ.

The need for this functionality arose from a desire to allow certain
non-privileged users to run perf. To do this, we install perf without
set-uid-root and have a set-uid-root wrapper decide who is allowed to
run perf (and with what arguments).

The wrapper must execve perf with real and effective root uid, because
perf and KASLR require this. However, that presently resets fsuid to
root, giving the user ability to read and overwrite any file owned by
root (perf report -i, perf record -o). Also, perf record will create
perf.data that cannot be deleted by the user.

We cannot reset /proc/sys/kernel/perf_event_paranoid to a permissive
level, since we must be selective which users have the permissions.

Of course, we could fix our problem by a patch to perf to allow
passing a username on the command line and having perf execute
setfsuid before opening files. However, perf is not the only program
that uses kernel features that require root uid/euid, so a general
solution that does not involve updating all such programs seems
warranted.

I will update man pages, if this patch is deemed a good idea.

Igor Lubashev (1):
  security: add SECURE_KEEP_FSUID to preserve fsuid/fsgid across execve

 include/uapi/linux/securebits.h | 10 +++++++++-
 security/commoncap.c            |  9 +++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.7.4

