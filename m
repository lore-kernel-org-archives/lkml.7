Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ECC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E15206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="UN9ZeObC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfCYXs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:48:58 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:45276 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbfCYXs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:48:58 -0400
X-Greylist: delayed 1857 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 19:48:57 EDT
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x2PNH4Vc021187;
        Mon, 25 Mar 2019 23:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=jan2016.eng;
 bh=X7Yq7lzWiHoIVGny6a6yI9NtJiDITlYUlp8P78CG2P0=;
 b=UN9ZeObCJZKCK1BulL+2vqBUS796gPnE9DrZK9fEQjAr8Gi+poNwNTdohcxmr9PrkmfS
 ECp6rbQDeVRee2B9HK3gazeE6XJDlxy9uxLT2yCnc6F1sUeZu99yGd3EmYmq1x5en7+z
 Qfopo75GVTAOvOX0Z8QEfbQIEBtBAprrmo+40LZTBeCIV6NY/ingY2z3/bu7EcxzwiMy
 00teumz9jTpHBKWpj/+A4rlJy8T2ZMWgFVPoKY8JbO9NNI0evApeECO21+HcpU6FKFIC
 6mADlMVZOnssIm5UUpmSJ9dHBEj92Dv2gRSRT1iQvKX5y290BpCgvyT27eRvPadYMcg1 Nw== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
        by m0050095.ppops.net-00190b01. with ESMTP id 2rf30js1q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 23:17:50 +0000
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x2PNHS4m028796;
        Mon, 25 Mar 2019 19:17:49 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.34])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2rdg4vhyr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 19:17:48 -0400
Received: from usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) by
 usma1ex-dag1mb2.msg.corp.akamai.com (172.27.123.102) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Mon, 25 Mar 2019 19:17:46 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.123) by
 usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Mon, 25 Mar 2019 16:17:46 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 86C8161D63; Mon, 25 Mar 2019 19:17:46 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : CAPABILITIES" <linux-security-module@vger.kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: [PATCH 0/1] RFC: security: add SECURE_KEEP_FSUID to preserve fsuid/fsgid across execve
Date:   Mon, 25 Mar 2019 19:17:43 -0400
Message-ID: <1553555863-22455-1-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=1 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=687
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1903250163
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=717 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces SECURE_KEEP_FSUID to allow fsuid/fsgid to be
preserved across execve. I ran into a need for a patch trying to
implement a set-uid-root wrapper for perf.

My set-uid-root wrapper implements local policies, allowing only
certain users to run perf and only with certain arguments.

Perf, like a number of other kernel features, checks euid (and KASLR
access, required for perf top and perf report, also checks real uid)
in addition to checking capabilities.  Hence, I must execve perf from
my wrapper with root euid.

However, when I execve perf with root euid, it automatically obtains
root fsuid. This is very undesirable for a number of reasons:

1. 'perf record' will create perf.data file that cannot be deleted by
   the user.

2. 'perf record' becomes insecure, allowing the user an ability to
   overwrite any key file owned by root (and because of
   time-of-check/time-of-use principle, nothing I can check in the
   wrapper can reliably prevent the user from doing so).

3. 'perf report' can potentially read files that the user does not
   have permissions to read.


Perf and KASLR are not the only kernel features that check for root
uid/euid, so a general approach like the one in this patch seems
warranted.


This patch is the minimal set of changes required to achieve my goals.
However, I am wondering if we might want to go a bit further and have
a secure bit that stops fsuid/fsgid following euid/egid in all
contexts, including set*uid as well as ignoring uid/suid/euid in
setfsuid (and similarly for set*gid and setfsgid).

I will update man pages as needed.

Igor Lubashev (1):
  security: add SECURE_KEEP_FSUID to preserve fsuid/fsgid across execve

 include/uapi/linux/securebits.h | 10 +++++++++-
 security/commoncap.c            |  9 +++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.7.4

