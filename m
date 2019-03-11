Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC722087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IXjiUrGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfCKPFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:05:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55098 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfCKPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:05:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BExMnA196164;
        Mon, 11 Mar 2019 15:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=dkNTI9hfL7yMYgz3bH/3kpbhgtMq3F+gihiXrcFhaGQ=;
 b=IXjiUrGnlb8Q6JuBJTPKUDeudR6ltQG2LLaLVnAANxCcnLrE/TN0LX5AM7s5xSn30q9I
 8qLdnSBKu7ahoWsF8SMGBWVZ45t3HgANkuLHlAlITmGBT63kzpGwhjZMQ0kNhd1asUE5
 6YbJPZ/2ty522sV8vokOvoCi1FuJmTWyPzVGGzT7fbgWrUiBwEh1HO22L2vRWRe/ve1g
 CjuG1vA6JQGb0YpYv1kZ/350up6AGI/zhE3On6d3l3Lem+ZtGUyvlwc/s4XffrT9C8CB
 FRZX+opQmj7+1hRBHyxIXxo7xbYnsvpyrYiResKs8jIsH+izkT+GByZSq29Go+xfyugu nQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r464r6xmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 15:04:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2BF4kaS014055
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 15:04:46 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2BF4hxZ016688;
        Mon, 11 Mar 2019 15:04:43 GMT
Received: from jambi.us.oracle.com (/10.152.34.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 08:04:43 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, corbet@lwn.net, konrad.wilk@oracle.com,
        kanth.ghatraju@oracle.com, daniel.kiper@oracle.com,
        boris.ostrovsky@oracle.com, dpsmith@apertussolutions.com,
        ross.philipson@oracle.com
Subject: [PATCH 0/1] [RFC] Secure Launch boot protocol
Date:   Mon, 11 Mar 2019 11:04:22 -0400
Message-Id: <20190311150423.15979-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

As is noted in the patch that follows, the open source project called
Trenchboot aims to make Linux directly bootable into a secure late launch
environment via Intel TXT or AMD SKINIT. This new feature is referred to as
Secure Launch as seen in the subject lines. In addition to changes to the
Linux kernel to support this feature, boot loaders will also have additional
functionality to initiate the secure late launch.

The patch that follows introduces a new boot parameter. There are of course
other patches that add further functionality to achieve our aims including the
changes to boot loaders that consume this parameter. This posting is as an early
RFC to elicit feedback on whether this is an acceptable approach for our boot
protocol and an acceptable usage of boot parameters.

The project is in its early stages; it is hosted here:

https://github.com/trenchboot

For an overview of the Secure Launch architecture:

https://github.com/TrenchBoot/documentation/blob/master/documentation/Architecture.md"

Links:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://www.amd.com/system/files/TechDocs/24593.pdf

Thank you,
Ross Philipson


Ross Philipson (1):
  x86: Secure Launch boot protocol

 Documentation/x86/boot.txt            | 15 +++++++++++++++
 arch/x86/Kconfig                      |  7 +++++++
 arch/x86/boot/Makefile                |  2 +-
 arch/x86/boot/header.S                |  3 ++-
 arch/x86/boot/tools/build.c           | 16 ++++++++++++++++
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 6 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.13.6

