Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECB2C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7C21721
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+/LnDb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGDQjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:39:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54846 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:39:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64GXtXs024868;
        Thu, 4 Jul 2019 16:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=5+6c9J5hsLXAS3y9QhZ2laqXZP49w96VU6nbreUKrFg=;
 b=K+/LnDb4B4jkTz2kamodwT13+Opqq+Rwvb16SM+8S9GMvS7u/+iv5YPIPiYnTlzyZn+p
 lVTUEj9bY2ebxWc5IgAGNXcXekJ38PxBCsCfnEYuaOeWso8qK3Dp3VUVipqVaBrprN0w
 kmDtB8bPVqs9UDPJDv7m4f6Ftiw+fPqiZlU/hevAFQIxwamdn0Q1YSAZ53sorO/38oqL
 kiB7VgYSbnI3jpZJWax/5NrI3HGevLDETME80cjx7LgiuHziv2zmCmPPZePS+KDVk9nR
 IgRX4YKnBXUWlsjATsnTzgGBqjCjOYR4HHP+AaNRR9XPb7ETh2mw9I91oKxbUgZauZb3 Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbymx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 16:38:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64GX9gl098425;
        Thu, 4 Jul 2019 16:36:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2th5qm49at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 16:36:44 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x64GaZkL023461;
        Thu, 4 Jul 2019 16:36:35 GMT
Received: from tomti.i.net-space.pl (/10.175.209.195)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 09:36:35 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, corbet@lwn.net, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, hpa@zytor.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v2 0/3] x86/boot: Introduce the kernel_info et consortes
Date:   Thu,  4 Jul 2019 18:36:09 +0200
Message-Id: <20190704163612.14311-1-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040210
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=721 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Due to very limited space in the setup_header this patch series introduces new
kernel_info struct which will be used to convey information from the kernel to
the bootloader. This way the boot protocol can be extended regardless of the
setup_header limitations. Additionally, the patch series introduces some
convenience features like the setup_indirect struct and the
kernel_info.setup_type_max field.

Daniel

 Documentation/x86/boot.rst             | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/Makefile                 |   2 +-
 arch/x86/boot/compressed/Makefile      |   4 +--
 arch/x86/boot/compressed/kernel_info.S |  16 ++++++++++
 arch/x86/boot/header.S                 |   3 +-
 arch/x86/boot/tools/build.c            |   5 +++
 arch/x86/include/uapi/asm/bootparam.h  |  15 ++++++++-
 7 files changed, 173 insertions(+), 5 deletions(-)

Daniel Kiper (3):
      x86/boot: Introduce the kernel_info
      x86/boot: Introduce the setup_indirect
      x86/boot: Introduce the kernel_info.setup_type_max

