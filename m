Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C33C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E545120863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2mPajXvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfFQTG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:06:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50140 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfFQTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:06:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HJ3dlE006806;
        Mon, 17 Jun 2019 19:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=OaHbeR0lOY/DEBGaqTG6p1kztv8w3JP2A32htJKCwpk=;
 b=2mPajXvU+J9LkdGoyF0fTtoih1vrC3SprPxHN7uv4HsbySfuNvTMb6s/CfDyjexfzd6s
 EvXOHmymsiQ1GEXA/73SDyJeimba5snAnfo9eFEsUjXFkucunwSY7O4JLxgbLUP3PXT3
 kcUMM6OyxqFWbcHgR/qcUrA3IhIArNdPZfGJejszE0f7Nfd8Gha1erlHdEk6OU9UFKRo
 cshsbDlc09VoJ/UJto5SiqRhse8e6NPhgUvRFKiOZM9L7oImbTzYYuKLjUiH2NxKRWoh
 RIEkELcWKDeYtCxmmkpxL9INKUxeYfgKDaBKdXsyJW8cdIJ8kY6Jtx/PE2IJeEMN1yEo Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t4saq86qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 19:06:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HJ4PY0118043;
        Mon, 17 Jun 2019 19:06:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t5mgbh6nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 19:06:16 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HJ6ECm024547;
        Mon, 17 Jun 2019 19:06:14 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Jun 2019 12:06:13 -0700
Date:   Mon, 17 Jun 2019 22:06:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: stmfx: Fix an endian bug in stmfx_irq_handler()
Message-ID: <20190617190605.GA21332@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not okay to cast a "u32 *" to "unsigned long *" when you are
doing a for_each_set_bit() loop because that will break on big
endian systems.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 386145601b82 ("mfd: stmfx: Uninitialized variable in stmfx_irq_handler()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mfd/stmfx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 7c419c078688..857991cb3cbb 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -204,6 +204,7 @@ static struct irq_chip stmfx_irq_chip = {
 static irqreturn_t stmfx_irq_handler(int irq, void *data)
 {
 	struct stmfx *stmfx = data;
+	unsigned long bits;
 	u32 pending, ack;
 	int n, ret;
 
@@ -222,7 +223,8 @@ static irqreturn_t stmfx_irq_handler(int irq, void *data)
 			return IRQ_NONE;
 	}
 
-	for_each_set_bit(n, (unsigned long *)&pending, STMFX_REG_IRQ_SRC_MAX)
+	bits = pending;
+	for_each_set_bit(n, &bits, STMFX_REG_IRQ_SRC_MAX)
 		handle_nested_irq(irq_find_mapping(stmfx->irq_domain, n));
 
 	return IRQ_HANDLED;
-- 
2.20.1

