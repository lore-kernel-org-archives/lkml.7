Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6064EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7412173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wXddtp8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfC2GWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:22:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52968 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbfC2GWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:22:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2T6JFY0001981;
        Fri, 29 Mar 2019 06:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=zH8Mj1Zu3Pie+ckcbZLcW1X6I/uGxGm7+WTc1M1tiaM=;
 b=wXddtp8nd8H2SyozISUuwdGAGIYrI7Bb96bHoSCfQZFsCDUCRzw9ulL74N+b4fxwPW+E
 G4bNhBF6L5fjberrJZy3xq/kL7RNwPk7Y/ADgI8EvLwyYcBSizER2+fHTrYsUwOc4XfT
 A83+0EKDDH94uxvaMHSmmhgTZfMe93FHqACd/7UdXE8ZqDS3g60olF+NIZTTCK9Tg1sM
 BY4eQs4vX8lWvrybHTONXR5P61YI7ahDMnBo1fIhKVxj+7xde73pn86z9Ba6Pb4hdP8C
 3XryXfUzuyltv7q5VmTGJc06/S5/Vx4/HlHsFiSThamoP5WgLI/hKK7fnEqsqzojgaIk vw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2re6g1jgff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 06:22:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2T6LnbP022405
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 06:21:49 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2T6Lk8w030872;
        Fri, 29 Mar 2019 06:21:46 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 23:21:46 -0700
Date:   Fri, 29 Mar 2019 09:21:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH v2] irqchip/irq-ls1x: Missing error code in
 ls1x_intc_of_init()
Message-ID: <20190329062136.GQ32613@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90ad2ff-acc1-0baf-d7e4-1292bb1c8464@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when irq_domain_add_linear() fails, the error code does not
get so it returns zero which is wrong.  Fix it by setting appropriate
error code.

Fixes: 9e543e22e204 ("irqchip: Add driver for Loongson-1 interrupt controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
V2: Improve the commit message

 drivers/irqchip/irq-ls1x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
index 86b72fbd3b45..353111a10413 100644
--- a/drivers/irqchip/irq-ls1x.c
+++ b/drivers/irqchip/irq-ls1x.c
@@ -130,6 +130,7 @@ static int __init ls1x_intc_of_init(struct device_node *node,
 					     NULL);
 	if (!priv->domain) {
 		pr_err("ls1x-irq: cannot add IRQ domain\n");
+		err = -ENOMEM;
 		goto out_iounmap;
 	}
 
-- 
2.17.1
