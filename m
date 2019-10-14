Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FAF207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P4RITGS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfJNK6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:58:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35748 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbfJNK6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:58:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EAsdlB049219;
        Mon, 14 Oct 2019 10:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=JxNFKJQ1/TwQHwpYDoccS955n/1smajXveBFvYBY/vw=;
 b=P4RITGS+ZeZG4xTWChbqpoa27cvsqfcCtMiMAxd6XEZvSWrXomL1tlJgad458jnITTa7
 LQcm1T4mVWtbk5Dd7r6u7Avs2N6T9zkCyurErBEWN5MVSz1xvxvRC/mrK2pzFGOuz8Am
 9u+xqY0G9jFRP+G5uSKreboIG8RWOP7AU+Q4MFd2I/iAZvPVadrtfx1Ch/h4gJQvQfnY
 NPB9CjNJfydgBD2+UaiyiPSEYQCgdk2IBkRPK4BuhtQ+lUaboVtAQtlc6k5OAzLs0coS
 GPc8VczDz4o7ocgnm/V2bReHcd4BZTF+5TG+pLqw6N+INOPKsjhincNuLk38lPLq8F8H eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vk68u83mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 10:58:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EAvhr6185611;
        Mon, 14 Oct 2019 10:58:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vks06j1xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 10:58:12 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9EAw9WQ011035;
        Mon, 14 Oct 2019 10:58:09 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 10:58:08 +0000
Date:   Mon, 14 Oct 2019 13:58:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Darren Hart <dvhart@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>, Takashi Iwai <tiwai@suse.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/x86: huawei-wmi: Fix a precision vs width printf bug
Message-ID: <20191014105801.GA31759@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was supposed to be precision "%.*s" instead of width "%*s".  It's
possible that this results in printing beyond the end of the string.

Fixes: a970b95345ab ("platform/x86: huawei-wmi: Add debugfs support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/platform/x86/huawei-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 6720f78c60c2..69a7be8dafcd 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -612,7 +612,7 @@ static void huawei_wmi_debugfs_call_dump(struct seq_file *m, void *data,
 		seq_printf(m, "0x%llx", obj->integer.value);
 		break;
 	case ACPI_TYPE_STRING:
-		seq_printf(m, "\"%*s\"", obj->string.length, obj->string.pointer);
+		seq_printf(m, "\"%.*s\"", obj->string.length, obj->string.pointer);
 		break;
 	case ACPI_TYPE_BUFFER:
 		seq_puts(m, "{");
-- 
2.20.1

