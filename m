Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1364C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A867C2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5c12qPUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfC1Oje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:39:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1Ojd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:39:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SEcU8m062086;
        Thu, 28 Mar 2019 14:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=r3pBlmtyZgeBbs6shLdIs1taw8wvRrTpkpltqeoDjao=;
 b=5c12qPUvf3oedK+vNG4u9SF1l6y51BWpZD8z2j33t4wa7qvtfJw2w2IMKqChbxkt/A5u
 LXq7gJALIqQV8+vnnYwT0dD2ghF7rWL6lJKf9KdZN3nCcFlHUp1M7c3o2p33rZlWqMH8
 4IszP2jwgwazvUCSyt8AIGx8LC/X9/hvxsW25lMbyH6ygjSGyBEGPa3gBAujNVOFIzag
 DuMK7Xhk44urA56i/9gC0CmV0/Jlb8GTVn6meu1nD3FD1+s43tPwfRiwnpzbyPZKaQKk
 s9aUs0xxGinUjaegPYp/KKywH8skV6+rV26jygfw/UXcAeIWZ031UNVxLMTlkUSZ8q1V mQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2re6g1f04b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 14:39:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2SEd7MP005429
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 14:39:07 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2SEd5cB021557;
        Thu, 28 Mar 2019 14:39:06 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 07:39:05 -0700
Date:   Thu, 28 Mar 2019 17:38:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] irqchip/irq-ls1x: Missing error code in ls1x_intc_of_init()
Message-ID: <20190328143854.GN32613@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=993 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We forgot to set "err" on this error path.

Fixes: 9e543e22e204 ("irqchip: Add driver for Loongson-1 interrupt controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
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

