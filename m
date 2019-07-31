Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B9BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EE3206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DcgTkZKI";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KrWm/+e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfGaIij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:38:39 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:10820 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfGaIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:38:38 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V8avZj015562;
        Wed, 31 Jul 2019 01:36:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=BAgwjQjO1Zk+db4EjTTzLgaR4SjQpmrcLHxsKFZFIcc=;
 b=DcgTkZKI5kjEhg5NtotyA5V4KsvNc/jydiKYBIpqy0HqvNXaQcjn+HwuKy0H3K1Ga74S
 XeMwO4O72iM/AaFY5gr/Q8VGUT4w51cnGdlxd3RN7TMNlKk+eGn0gCaT4oatb6wJ6Y3f
 MxpseVSqoHneACtF5+bCCDWwmoGfBoTH77cAx2jcal5NUjlht7+eZLmtRrRTK4CR/HRx
 vlJQFMp9hLsf8A87TDm/Wa7Z/iHlfHr9yqVsH7GwEllZR855SxhmwH7AeP1U7ZMBF6Ev
 MCMkIHX36nQYx4BsQlzw/PYtcrR5I87tH7gXvRNvBpqDJqIfPz+ghbzJKluWi4QgnqDE dg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=aniljoy@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u2ryh31fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 01:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxhR+n9qecrtJ9g8Co7FcTzQ5adf3ewozMlngNm16TQkRzYKW4uznqCpEr9ldbHXciWWXSX12hLT5dCyfz1DAY03QC1er8QfBFBD7eyBZfzrsmw2G5PQSEFcxO349DQvPaf/tXFw76QvsxAyOLRM1C4jYA9eLdrk1n6HlN3VTSBxVymFPgYyYqf1689KhcskqnNUyc4Nm4fShaImAgm0SLBKUVVDUw6nzEqsjqipp8Vgn/lOYnLRVNi/LBE6fLT/uhLZLhYSNzyKionVw0FFBGzIqyAvSfnoX6Hmc8sSc9Hh6ARKgk/NjdDY0ialf1GKdOY6ZRIa6QVTExaY8WC+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAgwjQjO1Zk+db4EjTTzLgaR4SjQpmrcLHxsKFZFIcc=;
 b=BuGIuAasMPkXxm+y9y5fi+VkEvrLzGczFu7aMx9TdeRH5x3O6E+ZqtT9gxGsjkVWhL95UNBX9fY1rhr6ZR4gbJWF8xstB3RakuS50h0VVwmVTYYC1+RuNbq/hKUDZU3urS5tbvNMbmb+/UFkCs5IruVWu9X4Y3ASNHZNcvXXhjyeXz8JpLcRdecW7uwjpF+N87xvXXQvR5Kd8dxAJQB/af7T0h8wvddzLZcFWyAXJ8bZzO4OArWwfCTMDfTw3dTU0TUj3yBHoqdINFxDECWfP8InpCPu1GJ71iiI2Y8B19kQ+hrRD1vOzVIgu9jlKRrGmxLGvgCnHAgQimPhwf6WAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 199.43.4.28) smtp.rcpttodomain=synopsys.com
 smtp.mailfrom=cadence.com;dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAgwjQjO1Zk+db4EjTTzLgaR4SjQpmrcLHxsKFZFIcc=;
 b=KrWm/+e2ymaW6MfV+PnYiAPrSIYx02c0l1bF/zSh0X/pjKTaT7ejQGKb+Q+zmakIMcu9LJN8GRH2tO8N7V04Vses3lmMjhpOXCv0DQmIsm3YtoB+OvGhk/sdXHwu2GzBQhZDcF75V38me8LoK6dCRAYAQBqe4Er8l9GFoCaNzek=
Received: from BYAPR07CA0054.namprd07.prod.outlook.com (2603:10b6:a03:60::31)
 by SN6PR07MB4462.namprd07.prod.outlook.com (2603:10b6:805:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.13; Wed, 31 Jul
 2019 08:36:54 +0000
Received: from DM3NAM05FT017.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by BYAPR07CA0054.outlook.office365.com
 (2603:10b6:a03:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.15 via Frontend
 Transport; Wed, 31 Jul 2019 08:36:53 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT017.mail.protection.outlook.com (10.152.98.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.7 via Frontend Transport; Wed, 31 Jul 2019 08:36:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x6V8amf5031811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 31 Jul 2019 04:36:50 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 31 Jul 2019 10:36:47 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 31 Jul 2019 10:36:47 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x6V8alfK028414;
        Wed, 31 Jul 2019 09:36:47 +0100
Received: (from aniljoy@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x6V8aiNM028290;
        Wed, 31 Jul 2019 09:36:44 +0100
From:   Anil Varughese <aniljoy@cadence.com>
To:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <aniljoy@cadence.com>, <rafalc@cadence.com>, <mparab@cadence.com>,
        <jank@cadence.com>, <vigneshr@ti.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: ufs: Additional clock initialization in Cadence UFS
Date:   Wed, 31 Jul 2019 09:36:14 +0100
Message-ID: <20190731083614.25926-1-aniljoy@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(36092001)(199004)(189003)(53936002)(81156014)(305945005)(81166006)(316002)(336012)(478600001)(16586007)(186003)(110136005)(54906003)(42186006)(87636003)(26826003)(26005)(76130400001)(50226002)(8936002)(70586007)(51416003)(8676002)(70206006)(5660300002)(126002)(486006)(476003)(2906002)(1076003)(14444005)(2616005)(356004)(6666004)(2201001)(426003)(47776003)(86362001)(50466002)(36756003)(48376002)(68736007)(69596002)(4326008)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4462;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8992f172-e0fe-4a7f-44fe-08d715923d26
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:SN6PR07MB4462;
X-MS-TrafficTypeDiagnostic: SN6PR07MB4462:
X-Microsoft-Antispam-PRVS: <SN6PR07MB44624637C89F8D5601F18A28A8DF0@SN6PR07MB4462.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 011579F31F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1IuNX/45ToGyEmDbdVNn6VVh+gJyEuee3Buk3a19RNPzcwXzf6d8yY2WLsGuSIl2Hn8B4Nv3k1LsmbJnljqgq22DkmDhK8DsJbEoIz+UvMPWtFa4mkOrEzaUan0A2sVRCUbkBgRXBt/dwuoAehuNwdhENAOmEnYHJAhzWXJRTfwg4nS8IR9Dqi1coH9VZkjPZByWzCf9gh48jcDehhLGlrcsL7MkxrMOSYfAZGJB1rhmGNywy9dLbiOgkcu1q5UuNMIUzepCuwcSPmzUOWKzTecWB+UtEzDIS+0w6zYd8kLlliL+SCIKE2+A9BAevUjM7ShekjFVEcYpox9aLfuQ29fd6b/JLt17AnzPa/S+6zO7PZoeFFrcpnHmszPCYOt48OpqwdR0Q2ybVckYFvtZYVxRJsQR8Smhus2LxRbyXko=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2019 08:36:52.7328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8992f172-e0fe-4a7f-44fe-08d715923d26
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4462
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure CDNS_UFS_REG_HCLKDIV in .hce_enable_notify()
because if UFSHCD resets the controller ip because of
phy or device related errors then CDNS_UFS_REG_HCLKDIV
is reset to default value and .setup_clock() is not
called later in the sequence whereas hce_enable_notify
will be called everytime controller is reenabled.

Signed-off-by: Anil Varughese <aniljoy@cadence.com>
---
 drivers/scsi/ufs/cdns-pltfrm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
index 86dbb723f..15ee54d28 100644
--- a/drivers/scsi/ufs/cdns-pltfrm.c
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -78,6 +78,22 @@ static int cdns_ufs_setup_clocks(struct ufs_hba *hba, bool on,
 	return cdns_ufs_set_hclkdiv(hba);
 }
 
+/**
+ * Called before and after HCE enable bit is set.
+ * @hba: host controller instance
+ * @status: notify stage (pre, post change)
+ *
+ * Return zero for success and non-zero for failure
+ */
+static int cdns_ufs_hce_enable_notify(struct ufs_hba *hba,
+				      enum ufs_notify_change_status status)
+{
+	if (status != PRE_CHANGE)
+		return 0;
+
+	return cdns_ufs_set_hclkdiv(hba);
+}
+
 /**
  * cdns_ufs_init - performs additional ufs initialization
  * @hba: host controller instance
@@ -115,12 +131,14 @@ static int cdns_ufs_m31_16nm_phy_initialization(struct ufs_hba *hba)
 static const struct ufs_hba_variant_ops cdns_ufs_pltfm_hba_vops = {
 	.name = "cdns-ufs-pltfm",
 	.setup_clocks = cdns_ufs_setup_clocks,
+	.hce_enable_notify = cdns_ufs_hce_enable_notify,
 };
 
 static const struct ufs_hba_variant_ops cdns_ufs_m31_16nm_pltfm_hba_vops = {
 	.name = "cdns-ufs-pltfm",
 	.init = cdns_ufs_init,
 	.setup_clocks = cdns_ufs_setup_clocks,
+	.hce_enable_notify = cdns_ufs_hce_enable_notify,
 	.phy_initialization = cdns_ufs_m31_16nm_phy_initialization,
 };
 
-- 
2.15.0

