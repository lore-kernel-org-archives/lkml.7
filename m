Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58663C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFF2214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QGfYPWJ2";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ab8ELwrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDAJKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:10:17 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43486 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfDAJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:10:16 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3191Y16013959;
        Mon, 1 Apr 2019 02:10:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=JD6YC7OcvdTHPfkI14yG9ZklqayT7Db+B+biyX0UYr0=;
 b=QGfYPWJ2W/zoUh5k6IRbQAXzkXQU9nGVW/9rPOygcNLWxV34lLtcT6hU1Aw7rXKV/EpS
 AvyyTQTQnrsySlIjDswTrNfPwfbvgZDhxxAdVl6YgNWiWW76RuuNBOn24Vhqx7LMOUB/
 +wrAiiYoQRlZRNAH8R8raZ6wo+Dehi2LR8eEjLfbwOXnh9nv8qOD6uWnmNcVhlwRRAUz
 CZt7APjFuLJJw+VKuIOMRwypb5yderABQAdVNS+zRniCkZHTm18qANLzqpEpc6NbY6b8
 +6fAAyu9DzP4jtXujdzWEz1D3Nl6/TM2KvPwqXOBJ/BLWMYNiCwCO78LYrCMPRtuGVS8 PA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2055.outbound.protection.outlook.com [104.47.50.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rj50w7vh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Apr 2019 02:10:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD6YC7OcvdTHPfkI14yG9ZklqayT7Db+B+biyX0UYr0=;
 b=Ab8ELwrVzFU6H519ZGFGbjxwFfCpmDX4AK6irxHdtgxs7sCMnCu1rtSxHeFzlTaeybRDfyN+lZfBd8zMULb11wb/FXyH5yNCqSmkbO7Gnk0hZSn6/Y/j3Exd+mbM2HfZiCkBYtfwWJesV+1KwWZ4346KlK5MyCC1IeybL8zpiq4=
Received: from SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) by SN1PR07MB2303.namprd07.prod.outlook.com
 (2a01:111:e400:7a45::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.20; Mon, 1 Apr
 2019 09:10:09 +0000
Received: from CO1NAM05FT018.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by SN4PR0701CA0004.outlook.office365.com
 (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.15 via Frontend
 Transport; Mon, 1 Apr 2019 09:10:09 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT018.mail.protection.outlook.com (10.152.96.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.6 via Frontend Transport; Mon, 1 Apr 2019 09:10:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x319A3tI007191
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 1 Apr 2019 05:10:05 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 1 Apr 2019 11:10:02 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 1 Apr 2019 11:10:02 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x319A2C7012778;
        Mon, 1 Apr 2019 10:10:02 +0100
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x319A1SH012734;
        Mon, 1 Apr 2019 10:10:01 +0100
From:   Jan Kotas <jank@cadence.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jan Kotas <jank@cadence.com>
Subject: [PATCH 1/1] gpio: mmio: Fix bgpio_get_set & bgpio_get_set_multiple
Date:   Mon, 1 Apr 2019 10:09:42 +0100
Message-ID: <20190401090942.12408-1-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(36092001)(2906002)(87636003)(42186006)(54906003)(8676002)(81156014)(81166006)(316002)(305945005)(105596002)(8936002)(106466001)(186003)(1076003)(26005)(36756003)(356004)(6666004)(16586007)(110136005)(86362001)(5660300002)(50226002)(51416003)(50466002)(97736004)(69596002)(336012)(126002)(486006)(426003)(107886003)(48376002)(2616005)(4326008)(476003)(478600001)(53936002)(47776003)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2303;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b06d9ff-5f63-412c-9a6a-08d6b681d5fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR07MB2303;
X-MS-TrafficTypeDiagnostic: SN1PR07MB2303:
X-Microsoft-Antispam-PRVS: <SN1PR07MB2303D16688FAF770C2FBE8E0D0550@SN1PR07MB2303.namprd07.prod.outlook.com>
X-Forefront-PRVS: 0994F5E0C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: d91GuC0ajPM8jMEjGVi6qxJHKoDUVMJ9GB5y5WYlr2LwBSiYIOKVLlMsTj9F0s7g+Pjhc+HsUuTJEDQZK+xw+WQvqYied59FqIkdU7m/8yZfFc7IZar273CUUgmmKWbVPQJ8Rw7k7SM/TajzavyjU1n9rATJWDP+SMcREUFojXaqJOqrID0mzKk2xeg+MXUwokD5VFbobz3odGB99ghSMDVvZfrXCGC96OngaOSy9Lx2xGMtujfsk2rXl5cc1cNWofh5MyBPrPNuBUIRXXn9XQQ+vEvZp/hi8ZYYvVv39hx+nEaC9Ae7qEdD/lXgszbPlNL4hgcGGRHhCMf4G/FUV9KHProkw30NHRdxCfxzmVfmswmR9hNzAiaZMJECpMXB9sB8gQNJ8UbdNl51CK9jqJZy5vuW6kI/f+zKaiRq0R4=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2019 09:10:07.3775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b06d9ff-5f63-412c-9a6a-08d6b681d5fd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2303
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During my regression testing I noticed the cadence GPIO driver
fails on the latest gpio for-next tree.

I think the reason is this patch:
commit 96cd559817f2 ("Merge branch 'devel' into for-next")

Here is a part of the test log:

Loopback 8 -> 24
TESTING: gpio: 488: output direction PASSED
TESTING: gpio: 504: input direction PASSED
TESTING: gpio: 488: 0 PASSED
TESTING: gpio: 488 -> 504: 0 PASSED
TESTING: gpio: 488: 1 FAILED
TESTING: gpio: 488 -> 504: 1 FAILED
TESTING: gpio: 488: 0 PASSED
TESTING: gpio: 488 -> 504: 0 PASSED

It looks like the issue is that gc->bgpio_dir has changed its meaning.
It used to be set to the register value (so it was being inverted).

Now it's always set to 1 for output and 0 for input.
However the bgpio_get_set functions were not updated.
So they invert the bit again, which means a wrong register
is being accessed.

This patch fixes that by removing the unnecessary inversion.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/gpio/gpio-mmio.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index f172b4382d..04be18b954 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -134,17 +134,6 @@ static int bgpio_get_set(struct gpio_chip *gc, unsigned int gpio)
 	unsigned long pinmask = bgpio_line2mask(gc, gpio);
 	bool dir = !!(gc->bgpio_dir & pinmask);
 
-	/*
-	 * If the direction is OUT we read the value from the SET
-	 * register, and if the direction is IN we read the value
-	 * from the DAT register.
-	 *
-	 * If the direction bits are inverted, naturally this gets
-	 * inverted too.
-	 */
-	if (gc->bgpio_dir_inverted)
-		dir = !dir;
-
 	if (dir)
 		return !!(gc->read_reg(gc->reg_set) & pinmask);
 	else
@@ -164,14 +153,8 @@ static int bgpio_get_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	/* Make sure we first clear any bits that are zero when we read the register */
 	*bits &= ~*mask;
 
-	/* Exploit the fact that we know which directions are set */
-	if (gc->bgpio_dir_inverted) {
-		set_mask = *mask & ~gc->bgpio_dir;
-		get_mask = *mask & gc->bgpio_dir;
-	} else {
-		set_mask = *mask & gc->bgpio_dir;
-		get_mask = *mask & ~gc->bgpio_dir;
-	}
+	set_mask = *mask & gc->bgpio_dir;
+	get_mask = *mask & ~gc->bgpio_dir;
 
 	if (set_mask)
 		*bits |= gc->read_reg(gc->reg_set) & set_mask;
-- 
2.15.0

