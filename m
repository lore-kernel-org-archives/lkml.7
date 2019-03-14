Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBED62184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="CaAJ7Gx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfCNGbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:31:09 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:44918 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfCNGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:31:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 7EA18C37
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RfsNv9mHVJUg for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 01:31:07 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 525DF9CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:31:07 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id u22so3566219iof.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=36CKkLmVNny2wjuxVGvx03TD4bmimonXB89SYTohLS8=;
        b=CaAJ7Gx7yvyqE9UoIMo2MQEZYGABjjRI8QJBJm4EfDCxcRV5qDnEunj5lDfxtwT4GL
         wRbiBTVbw7FZAys5Nk/oT4Nzpsy1RGwIpSIhHczlYLVpboyEnD2egkPsJuNArqgrr5QQ
         waNKoZBEQIWTWVuEvN+lM+EJe4zr6WMUSUzt9/Y6UasW/2XZnMwdpZf1jSEIlsBgS33T
         E5U+OyUYbNQ3VxwgyyHWWB0PXn5fuLlTMSIu1jsGl6vsFeNOFxyJjlJUCxZXXEj9X7a5
         rObz23ojlHtFvs2RTsiu632QV1eA7emA4Si/LsdiE8MLq3Qm21Qw+CIcQiKGzW+EYpKz
         1KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=36CKkLmVNny2wjuxVGvx03TD4bmimonXB89SYTohLS8=;
        b=fF/Gkps7Ro451+FD/uIK5bhnMCTxr2B+MI3ADeso7mlKqZmA3VxI5D1HgecczMvFrT
         lTuVd29MHBKIZgXA7L2Yt8UF/7XsoUqTnjKYmmOCxwL2hHtK/LoJYhBrJk96f+jvoRpW
         Vh4apNXOS/fbm231WOm5t9UCDJAs3y/DjA/reiLzuu4fMRA2vy8AjavPUkoqWJ7/a9EJ
         /99keYL14yDhc2M9hwvvjjJkPw28l7wyBfRiZHG2b/ghhc1KGw2XJi1HrKmMbgqvHDGZ
         1MbyczYogc6/2qsBJx+qHJDGsXHNMqN37J3KihTobNzuvxsf5QcQEorjZuD8O1EsWfvj
         xIdw==
X-Gm-Message-State: APjAAAU2NcH+ymfkpeP0pvdj5H9jRbhExXik71XD5BI6eoJ2jrnMffQx
        JDPm7ilBLRCjFBWmGolnX0v2a6SHh2LcjX5ZjhiXKu00abTk0VyCniVwbST1Dc+CIXqYfc+rZMv
        y5DNw9HaMngSxdMB1iprKPtyLntpK
X-Received: by 2002:a5d:8198:: with SMTP id u24mr13385165ion.177.1552545066958;
        Wed, 13 Mar 2019 23:31:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwlEwclIOlWdxSZ7ATvJVrDBm2uN82dauXmM6m3gkNdHucQiFWmBeZJYaRdvsa2z3PP9dvyzg==
X-Received: by 2002:a5d:8198:: with SMTP id u24mr13385152ion.177.1552545066655;
        Wed, 13 Mar 2019 23:31:06 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e10sm5293831iok.85.2019.03.13.23.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:31:05 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla4xxx: fix a potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 01:30:59 -0500
Message-Id: <20190314063100.12805-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case iscsi_lookup_endpoint fails, the fix returns -EINVAL to
avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index a77bfb224248..80289c885c07 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3203,6 +3203,8 @@ static int qla4xxx_conn_bind(struct iscsi_cls_session *cls_session,
 	if (iscsi_conn_bind(cls_session, cls_conn, is_leading))
 		return -EINVAL;
 	ep = iscsi_lookup_endpoint(transport_fd);
+	if (!ep)
+		return -EINVAL;
 	conn = cls_conn->dd_data;
 	qla_conn = conn->dd_data;
 	qla_conn->qla_ep = ep->dd_data;
-- 
2.17.1

