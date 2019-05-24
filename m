Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B9C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CB52184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESe6Zar0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390353AbfEXJ4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:56:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57882 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389913AbfEXJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:56:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O9relr154092;
        Fri, 24 May 2019 09:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=Xt2LRD1HTmFluvPLqEnx354Bp5/ZDUC/bcc9fFvWKiY=;
 b=ESe6Zar0QQPKmyyTR2grrFzsxEGzofp0c6vFZFOeHzNXAjqq7PTDqNH3hu6bk0RNuKWx
 kttZNP+Z+HukaWSlZjwoK24CIphPS0MOAU2ocefJ75quVnCyj6cK0IGIGfVCcaVYV/Tf
 nqi+XFpNUFcLDwQCS/F358FeytcfAhnpmhFyzBIIru7Nsn01P6aFWYH64LumUcbnRkLF
 xsI+dgbT5LdUbuOgIL1cs71IHD92j1UjLZVsdSWpZmoATqmK6L1DYCs5FIpax2hhrYpR
 8+8InIusDUSzybzEpxBdi/XFVcRIyejQQlekXkgcclWoxj6Y7ZBrlOBhEBuuP+u/tMOK iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2smsk5g2qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 09:56:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O9tcZG134996;
        Fri, 24 May 2019 09:56:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2smsgtsmvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 09:56:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4O9u0pb005353;
        Fri, 24 May 2019 09:56:01 GMT
Received: from tomti.i.net-space.pl (/10.175.163.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 09:56:00 +0000
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        hpa@zytor.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        ross.philipson@oracle.com
Subject: [PATCH RFC 0/2] x86/boot: Introduce the setup_header2
Date:   Fri, 24 May 2019 11:55:02 +0200
Message-Id: <20190524095504.12894-1-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=576
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=617 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This change is needed to properly start the Linux kernel in Intel TXT mode and
is a part of the TrenchBoot project (https://github.com/TrenchBoot).

Daniel

 Documentation/x86/boot.txt               | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/Kconfig                         |  7 +++++++
 arch/x86/boot/Makefile                   |  2 +-
 arch/x86/boot/compressed/Makefile        |  5 +++--
 arch/x86/boot/compressed/setup_header2.S | 18 ++++++++++++++++++
 arch/x86/boot/compressed/sl_stub.S       | 28 ++++++++++++++++++++++++++++
 arch/x86/boot/header.S                   |  3 ++-
 arch/x86/boot/tools/build.c              |  8 ++++++++
 arch/x86/include/uapi/asm/bootparam.h    |  1 +
 9 files changed, 123 insertions(+), 4 deletions(-)

Daniel Kiper (2):
      x86/boot: Introduce the setup_header2
      x86/boot: Introduce dummy MLE header

