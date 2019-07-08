Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F4C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E892208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ah2l47cR";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rc5DIx4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfGHNgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:36:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:26344 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728461AbfGHNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:36:12 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68DYJq4015536;
        Mon, 8 Jul 2019 06:36:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=KXP3dMOFLo8cuYRoiATOz+pEuXpO77cCq2mHrFkEQD0=;
 b=Ah2l47cRhLaF9dGuOZ7/GatW0ZjE1jENFuQ/RWqybLVg14g7yU55F7EFZy/BvHGYNmw5
 Rc7ZpevlVA4TnvDmfgPiZanh94sVTSc554vHjI5GCRUTCNbhhWy3dY6QSUXX1El/NXJM
 /HB0BTPEQ7E1S5lt6J7Xv3odcHQngYMaXbEZtBFINnx4KiyQDQeJz3+igL5vvLI0/JHG
 9a2gFR2jhx0VvbbLTPKMFESj87va5K3SJGQZ5aOEbhZRlYb+Sd4vWyM3NvauLRScd4Or
 vFenY5x+eEGqZIVn6R2vWVQhb5yNBlhbLAbWo1BcQ4vxF6aSS+6dScKqlDtMPj4QapjS rQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2058.outbound.protection.outlook.com [104.47.40.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tjq7wff47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 06:36:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXP3dMOFLo8cuYRoiATOz+pEuXpO77cCq2mHrFkEQD0=;
 b=rc5DIx4B36AUpxVkp1FDTrVPH+c5cCjcZymK476NxjHHIXps1+ljNIBGAZ7+xxM/M/yrcQyZvL1uIJg8TQpqg6ncauu9WYUR/BVzoW6Pxcat9LsgQQrgSREB0H35YzU02+Up38FF5Uk4NTaQrT393sqhsvHS28SdP+KWYJRc8Ts=
Received: from BYAPR07CA0067.namprd07.prod.outlook.com (2603:10b6:a03:60::44)
 by BN6PR07MB3042.namprd07.prod.outlook.com (2603:10b6:404:ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.19; Mon, 8 Jul
 2019 13:36:05 +0000
Received: from DM3NAM05FT031.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by BYAPR07CA0067.outlook.office365.com
 (2603:10b6:a03:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Mon, 8 Jul 2019 13:36:05 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT031.mail.protection.outlook.com (10.152.98.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.8 via Frontend Transport; Mon, 8 Jul 2019 13:36:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x68Da0sE014214
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 8 Jul 2019 09:36:01 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 8 Jul 2019 15:35:58 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 8 Jul 2019 15:35:58 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x68DZvnF018625;
        Mon, 8 Jul 2019 14:35:57 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x68DZutm018622;
        Mon, 8 Jul 2019 14:35:56 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 1/3] usb: common: Add usb_get_dr_mode_from_string and usb_dr_mode_to_string.
Date:   Mon, 8 Jul 2019 14:35:24 +0100
Message-ID: <1562592924-17528-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <all>
References: <all>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(36092001)(189003)(199004)(446003)(486006)(2616005)(26826003)(426003)(87636003)(478600001)(126002)(476003)(11346002)(6916009)(54906003)(5790100002)(2906002)(316002)(68736007)(4720700003)(42186006)(14444005)(4326008)(50226002)(16586007)(305945005)(26005)(356004)(6666004)(36756003)(186003)(76130400001)(48376002)(70586007)(70206006)(336012)(11926002)(81156014)(2351001)(53936002)(107886003)(69596002)(5660300002)(51416003)(47776003)(50466002)(76176011)(86362001)(8676002)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3042;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f3d0fef-87de-46de-e976-08d703a93995
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN6PR07MB3042;
X-MS-TrafficTypeDiagnostic: BN6PR07MB3042:
X-Microsoft-Antispam-PRVS: <BN6PR07MB304287041D679F3773DBAF28DDF60@BN6PR07MB3042.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 00922518D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1K8eY6hUZV5Xa7yrcBUnpaXoNwwUFl8OdtyJYQtfyh6qT5PXNPIN9iCFsbRgVQ3ESOnB+rZaoR4EmOy5FQ/I1V2HvSrQuw65MgY0QSAV3hnWkwH+0kvO571Z8sFauZgcdN9odDnUKe6AjzYGfgZ0RwnOz7bYjwh8yfzq8IER7M1nl5xVOxxHniQ24wD0HCdBHy9hK52aT7EcZFkkmDDFqiLPGI5ijRk6AigYSKyj2PWbvLX2r0tolpVeK3hcfCJm1ed1MxOj0joPCl7m/0e3dnBijO7kSOjGeq5fjdrpEhpHg77HoNJTFRxyQxj/IuCmXLVEcmuW0wHMINhFGeZaRE3tOQGKQlV9YavyLs7yjIsG8ynE9LYIZQG4MNz2aUqy3jFVRES+eNFLJe44nMZQT8qsJvM+sF7Cv73hpGiwEJU=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2019 13:36:04.0902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3d0fef-87de-46de-e976-08d703a93995
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3042
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=422 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch introduces new function usb_dr_mode_to_string for converting dual
role mod to string and removes static from usb_dr_mode_to_string
definition.

Both changes have made to avoid duplication of code by cdns3 driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/common.c | 12 +++++++++++-
 include/linux/usb/otg.h     | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 18f5dcf58b0d..a485071325b3 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -118,13 +118,14 @@ static const char *const usb_dr_modes[] = {
 	[USB_DR_MODE_OTG]		= "otg",
 };
 
-static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
+enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
 {
 	int ret;
 
 	ret = match_string(usb_dr_modes, ARRAY_SIZE(usb_dr_modes), str);
 	return (ret < 0) ? USB_DR_MODE_UNKNOWN : ret;
 }
+EXPORT_SYMBOL_GPL(usb_get_dr_mode_from_string);
 
 enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 {
@@ -139,6 +140,15 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_get_dr_mode);
 
+const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_mode)
+{
+	if (dr_mode > USB_DR_MODE_UNKNOWN || dr_mode <= USB_DR_MODE_PERIPHERAL)
+		return usb_dr_modes[dr_mode];
+
+	return usb_dr_modes[USB_DR_MODE_UNKNOWN];
+}
+EXPORT_SYMBOL_GPL(usb_dr_mode_to_string);
+
 #ifdef CONFIG_OF
 /**
  * of_usb_get_dr_mode_by_phy - Get dual role mode for the controller device
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 69f1b6328532..c156817672c4 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -129,4 +129,20 @@ enum usb_dr_mode {
  */
 extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
 
+/**
+ * usb_get_dr_mode_from_string - Convert string to dual role mode.
+ * @str: Pointer to the given string
+ *
+ * The function gets string and returns the correspondig enum usb_dr_mode.
+ */
+extern enum usb_dr_mode usb_get_dr_mode_from_string(const char *str);
+
+/**
+ * usb_dr_mode_to_string - Convert dual role mode to string.
+ * @dr_mode: Pointer to the given dual role mode
+ *
+ * The function gets enum usb_dr_mode, and returns the correspondig string.
+ */
+extern const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_mode);
+
 #endif /* __LINUX_USB_OTG_H */
-- 
2.17.1

