Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C8ACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBB720700
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="N5X5La6o";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hkiVp87X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfJUGgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:36:36 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:59134 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726039AbfJUGgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:36:35 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9L6XbXD029570;
        Sun, 20 Oct 2019 23:36:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=r5eFgyGOC0ImaVwGK4I9koALcmz1cOgfXR7cAk2FaeI=;
 b=N5X5La6oKOLTCIPRFo9phkf5H5hzSnx24/0hnQXzLT/TrYVkbfHTMT2N0pmYMjvq9bUD
 BjbumOlfxdDvRLN6ITkPDZWXuHSPuZxRoNkGqNsEFi0zU7ygg1dt9veYDBNT74N5wfwM
 8jtudiEn7Cyuil7rH5Iu5C3nk/PY2Y76qi5J+fwtppuGY848ezmSpopEnBMQJaKGvrhL
 K0LKMaT0+tNlBpMoXp9l4RplfZrEKuhLtMZdqvGk5NeBQwmtpZJxDRA8jF6lDrmVWTUb
 mHjCvu+wjp3uUuboZOIW7b8k7lUv1NHjLwWXv9K+gqzx50tyQUCCqhN1UPa7OVv+zr58 5g== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vqx2x590v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Oct 2019 23:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X253Csi6byFyzu/2l8ekDqmM0+BQDspFUT3QzrKvkhNFeKJyK9FNjRTZr/Zl9PAWqwuqcTMLh93C72potSBxuUeKqn+YLB4A9+ZJXc1E/DnlckuJ4oWWECVw3TAjFyMtoDlZHyRp3b50c1cD2kyueuXmIIxDaIuFNcqX6/AMKScvL3wicmVDvr58pNJtC59f+Rl52IEYdDSvjZswOuhJOUXiCFT+4wgFp7B8JSwOh8VPTDt3vaEQ1RuelFj1eXf1dTW0IUvA0MWIKP2GgLcR4+1WT1DpxEezMGszjY2L/IGUm00pnK86SjRSWEZer+5nG8LspZQPDzElfgvjWucqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5eFgyGOC0ImaVwGK4I9koALcmz1cOgfXR7cAk2FaeI=;
 b=NKj9+AfS3liKJ867UX0gDK33XAxwxm3x7qsok/qRP6TRElLNVBKW3WfaxZ9jUeB58HxJ1DCNcFlYyrynITmgEywYfd3XdfqJVLY9ZPi76Z5009SVVG31Uei5wPXaB3nTwcRFfkqYYH9tbiE0OqhEyRYIKQg0/BidVXm6B8pP+U+OcRIUoJigwpy+xbNDIflprIJTCCIA6jekFLYHBO5Pz/vfBzn8SWwv/FHs+UhP26QfW0KvVfkDSz972qZK82xBx0J94yjUrGz3F9BEDsEoboKzlABt6bSTa00TsdC/RP/N0VvZpvHpbauukVc+FNaJmfJxFBREB3wTocPOJrJN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5eFgyGOC0ImaVwGK4I9koALcmz1cOgfXR7cAk2FaeI=;
 b=hkiVp87XNECQaKgNxY3V6mnTKdVbAcZabqs/U4CACzOGpadeqTByvX9b+vMnz1djf2yNT5WnkO8T94Yrnbo0SQ5LSi6ycf/Mf0cZtbM8CoUtLhvzvm9u/c5/p+N1AwLRAoRo3PLCmj9I1RStf6OZBKqYyXqjCfPrO2YjRzUnZ9Y=
Received: from CY1PR07CA0021.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::31) by BYAPR07MB5941.namprd07.prod.outlook.com
 (2603:10b6:a03:133::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Mon, 21 Oct
 2019 06:36:24 +0000
Received: from BY2NAM05FT046.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by CY1PR07CA0021.outlook.office365.com
 (2a01:111:e400:c60a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 06:36:24 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT046.mail.protection.outlook.com (10.152.100.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.9 via Frontend Transport; Mon, 21 Oct 2019 06:36:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x9L6aK0Q030521
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 20 Oct 2019 23:36:23 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 21 Oct 2019 08:36:20 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 21 Oct 2019 08:36:19 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x9L6aJ1d007113;
        Mon, 21 Oct 2019 07:36:19 +0100
Received: (from jpawar@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x9L6aI2W007105;
        Mon, 21 Oct 2019 07:36:18 +0100
From:   Jayshri Pawar <jpawar@cadence.com>
To:     <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <peter.chen@nxp.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>, <sparmar@cadence.com>,
        <jpawar@cadence.com>
Subject: [PATCH] usb: gadget: f_tcm: Provide support to get alternate setting in tcm function
Date:   Mon, 21 Oct 2019 07:35:00 +0100
Message-ID: <1571639700-5656-1-git-send-email-jpawar@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(36092001)(199004)(189003)(26826003)(305945005)(478600001)(7636002)(2906002)(42186006)(7416002)(47776003)(87636003)(50226002)(50466002)(316002)(2351001)(4326008)(26005)(5660300002)(16586007)(356004)(6666004)(14444005)(5024004)(2616005)(6916009)(51416003)(76130400001)(486006)(107886003)(246002)(126002)(476003)(36756003)(86362001)(8936002)(70586007)(70206006)(54906003)(48376002)(8676002)(426003)(336012)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5941;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed936c8-af50-45df-662b-08d755f0fe46
X-MS-TrafficTypeDiagnostic: BYAPR07MB5941:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5941B491BA9E21E3A76E826DC1690@BYAPR07MB5941.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0197AFBD92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1oF0SGRE3KgfLahm7xJre/ZK/IoBjm/S7KS0Gu8TOzcR+/F5iC1GMmf3oIHstqDhGN8bROh2OEBiuYaopI3KnNC06NEYXM/xpW5RYnrX50UHJ9wuygO3Q1o3WYAq42iladZZWLUHPhgQUU0zw8U4wWjg+Vi9sB5KZomTDRUO9A6Aw7O3JLZfin7VlUh8A08SKS54K1eLF8HqULkqlZ+9jKF0onSWmisQFNStvhokYJnUWqfyYPPAIqjImhnbB9KglD2tVsUjmUS4jVdo/uBttki/gON8k4snZvfk49WpCLm5GdCuqyNpsvvQAYo8QOxuZSh/7oi5cj4WH56+HqI4JnwWs4v0Taj4qQkAifRlqlxOP3bR4XOkFXyRWGN/9I84jCDoSGld2OAoiw8OWWOwwTVTHcaiIqYyx4MzvNRdP1R+zVyVP1igs9y+kEuRkb1wCtuEp5kYrJ2Hmh7nPybEw==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 06:36:24.2512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed936c8-af50-45df-662b-08d755f0fe46
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5941
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_02:2019-10-18,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=380
 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0 spamscore=0
 suspectscore=3 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing tcm_get_alt in tcm function to support Bulk only protocol and
USB Attached SCSI protocol

Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
---
 drivers/usb/gadget/function/f_tcm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 7f01f78b1d23..36504931b2d1 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -846,7 +846,7 @@ static void uasp_set_alt(struct f_uas *fu)
 
 	fu->flags = USBG_IS_UAS;
 
-	if (gadget->speed == USB_SPEED_SUPER)
+	if (gadget->speed >= USB_SPEED_SUPER)
 		fu->flags |= USBG_USE_STREAMS;
 
 	config_ep_by_speed(gadget, f, fu->ep_in);
@@ -2093,6 +2093,16 @@ static void tcm_delayed_set_alt(struct work_struct *wq)
 	usb_composite_setup_continue(fu->function.config->cdev);
 }
 
+static int tcm_get_alt(struct usb_function *f, unsigned intf)
+{
+	if (intf == bot_intf_desc.bInterfaceNumber)
+		return USB_G_ALT_INT_BBB;
+	if (intf == uasp_intf_desc.bInterfaceNumber)
+		return USB_G_ALT_INT_UAS;
+
+	return -EOPNOTSUPP;
+}
+
 static int tcm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 {
 	struct f_uas *fu = to_f_uas(f);
@@ -2300,6 +2310,7 @@ static struct usb_function *tcm_alloc(struct usb_function_instance *fi)
 	fu->function.bind = tcm_bind;
 	fu->function.unbind = tcm_unbind;
 	fu->function.set_alt = tcm_set_alt;
+	fu->function.get_alt = tcm_get_alt;
 	fu->function.setup = tcm_setup;
 	fu->function.disable = tcm_disable;
 	fu->function.free_func = tcm_free;
-- 
2.20.1

