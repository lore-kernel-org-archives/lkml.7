Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76CC10F03
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0A20823
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iSJDCoT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCBAsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:48:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53490 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727717AbfCBAsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:48:42 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x220meJe029313
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 16:48:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=HEqAKDXsL77JCtLFjGr36U0htQ7pzs7zEaDJ0VKLAZM=;
 b=iSJDCoT4nrN252is1e7DGSdC1oNc0cpqOsEKzPlak8XTCH1uiXbmmiqeh9tbwWbpZKDB
 Yjqzm9RBK0lpZ0nsrpMOd2xMO3Z7rLOaq5F9kGKYEupbP5Kv3Qh9871/ifj58KapoB+I
 OL8L4I+Mn0EQ/dVNUk1ZMpIWc6SzxKG3bFs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2qye6v07sk-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 16:48:41 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 1 Mar 2019 16:48:33 -0800
Received: by devbig008.ftw2.facebook.com (Postfix, from userid 10532)
        id D711523A5AAE; Fri,  1 Mar 2019 16:48:31 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Hostname: devbig008.ftw2.facebook.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC][PATCH 0/4] Per-console loglevel support, console device bus
Date:   Fri, 1 Mar 2019 16:48:16 -0800
Message-ID: <cover.1551486732.git.calvinowens@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This is an extremely overdue refresh of this series:

	https://lkml.org/lkml/2017/9/28/770

The big change here is the 3rd patch, which actually wires up the console
drivers to support embedding a device structure, so we can place them on
a "console" bus and expose attributes in sysfs.

I left the very long list of driver maintainers off this first submission,
once there's agreement on the core idea here I'll add them.

Thanks,
Calvin


Calvin Owens (4):
  printk: Introduce per-console loglevel setting
  printk: Add ability to set loglevel via "console=" cmdline
  printk: Add consoles to a virtual "console" bus
  printk: Add a device attribute for the per-console loglevel

 131 files changed, 1859 insertions(+), 1061 deletions(-)

-- 
2.17.1

