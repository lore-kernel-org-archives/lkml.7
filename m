Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA6CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35521214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Mce0aphU";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Y7GKJSR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbfJ2MZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:25:19 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:16788 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728465AbfJ2MZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:25:18 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TCOOCx012978;
        Tue, 29 Oct 2019 05:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=4+uNHNZMCuHr78Ch5A0sZUDIpOVEPr5bijMdomAySbw=;
 b=Mce0aphUjYgMhYlKzSfc27dY3qP+MPDrccXJqF3YiWxtoZ4+HVxyaEKIuJBIV5av/wZf
 QJkz0oNyui5ATPAuRIv9oJIs4ITfXZKKaqhIcSEcJiXf7BHJ7RYrGgDFEcm9BVRmF7Mg
 hYl6sD//SCffU1nDCkkxoz4Qz6LvKbF6JecywUqAKrWANHNobGXvqykL826sQXy0iCDM
 zsro5fGenttSKpIRF57KYhgTPhskiszPat+sqEV+espDJoNy3Z6euCo6iZ6pbP+TArOc
 WQAr0e3QoKt6x9zsor9GinfW+1gYLyL2GhcqmlbZhPSrKXRRHUI2mKYgBafD2UidsF7N VA== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2053.outbound.protection.outlook.com [104.47.40.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vvhqx9qnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 05:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6LjQe0TroPQUM5ylECFl25rymy3h3id6KYnyn9ut3mxey5CIqDuJF5cJ380Ozv/vknGuHomchuHe+mjNFwWMeBtXuNhftmxyV1k3wqYwWwtW+r1CjXL3rFSvM5g4ckNXkIbBQfl4vgb3LOtOb8JMFo2dtF/dpytFAXg6oISI0LLdB/9dQlSP3samsTe05e6N0Uugk9h1ToSDIxb+/bY5oKuCiSe0CicBZqtjZ38B+Tft1BrBt7xpdQTwdyL4vzvUStkerl0H3ZMKNNJMbWHh2TDmWqlP8HnFIa3pYar/U7jkKiGS5SpiYTQZsHuBXjo3vRc1tGqRZNeoOFGyxu5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+uNHNZMCuHr78Ch5A0sZUDIpOVEPr5bijMdomAySbw=;
 b=B1e+DjDkHVeDtGFGG7Uu4BDa6211gPjI6i3/4buIk0u7TTfzqVQXAnS3t4ATihDNnBHO7RBQMH56P+gsFwhs207800zgYdww4BBWeZ6Bnlszq8V/rF9vTGxgJHSlAy+utVhtgXcJgHcuXZnGQcQfZNWRkZNgxqX1DJd/f1+FDsvWxdivSn62zMQU8AsSzMtY3eRwnBlvvKXsticlB49dhJ+XnWTrW8HN1QZ5Ggcx3s1tZYSJbAVcnciv6VmpeihQyyYs0smpV+i3aYi2RaYNtE2RkKhLNYdk3W7wMBREIubysxCfjaHNrbdYQvE/aQuC2+xegZldvFwvJUkvYeCebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+uNHNZMCuHr78Ch5A0sZUDIpOVEPr5bijMdomAySbw=;
 b=Y7GKJSR0fPMuEw72XVqPknqAfnnDWwsNDy/J9ljO7/EnhYXEQacIvq393YQL26N4LoGj3w1xnl8Rv58Rx6tkfMrOpVUq3oMMLGux/pmQbZbGsszsWazDM/V1cs1/xMDss/l0Ao+Lm6gGlGhkzuzYyL9HQLvuzUMCWu2Hd/46YoE=
Received: from BYAPR07CA0081.namprd07.prod.outlook.com (2603:10b6:a03:12b::22)
 by BN7PR07MB4306.namprd07.prod.outlook.com (2603:10b6:406:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Tue, 29 Oct
 2019 12:25:06 +0000
Received: from CO1NAM05FT025.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by BYAPR07CA0081.outlook.office365.com
 (2603:10b6:a03:12b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Tue, 29 Oct 2019 12:25:05 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT025.mail.protection.outlook.com (10.152.96.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.9 via Frontend Transport; Tue, 29 Oct 2019 12:25:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x9TCP0Ql027498
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 05:25:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 29 Oct 2019 13:25:00 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 29 Oct 2019 13:25:00 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x9TCP09G006587;
        Tue, 29 Oct 2019 12:25:00 GMT
Received: (from sparmar@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x9TCOw3D006572;
        Tue, 29 Oct 2019 12:24:58 GMT
From:   Sanket Parmar <sparmar@cadence.com>
To:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>
CC:     <sparmar@cadence.com>, <pawell@cadence.com>,
        <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <peter.chen@nxp.com>, <nsekhar@ti.com>
Subject: [PATCH] usb: cdns3: gadget: reset EP_CLAIMED flag while unloading
Date:   Tue, 29 Oct 2019 12:24:41 +0000
Message-ID: <20191029122441.5816-1-sparmar@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(396003)(136003)(376002)(36092001)(199004)(189003)(50226002)(2906002)(316002)(16586007)(26826003)(478600001)(87636003)(42186006)(356004)(6666004)(336012)(50466002)(51416003)(26005)(186003)(36756003)(48376002)(8936002)(54906003)(110136005)(126002)(476003)(305945005)(486006)(426003)(4326008)(47776003)(86362001)(246002)(76130400001)(7636002)(4744005)(70586007)(70206006)(2616005)(5660300002)(8676002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4306;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:3;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c27aab6-f6ca-4c56-f927-08d75c6b06cd
X-MS-TrafficTypeDiagnostic: BN7PR07MB4306:
X-Microsoft-Antispam-PRVS: <BN7PR07MB43061CFB209E8ADA74DAF89AB0610@BN7PR07MB4306.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwFo9c8HgkJQPXbVUiIeDfIB8Ow4vUDYNfkynLMXXaCQSQeeW6OZMEFcK7AGD47owdLke0KPp1m5BWNX/lZeumrtBBtYsVZkPeGoFz1cOUegi08+wPYc8T1stywZ4/Avkbo0ICpX0YmmEC+j0hPif+NGrhB1e5iw72cS05c/fywW5Qg17HYSPzskBReN2uXN/YVrqlT5HUDAG/YQQSfx0cSHGKislDhsz54FYFW25uvAodse7GHMccFByAFDgj4bUpXOrKlkFPDxeLLzBTr99Jnp6us/7z1pjdojM0godaYr0EXiuTzxs1+xSpozUbwRQJSjfVRKpjf8soRWucC0n83DGqyk+DJonYyiuE3mEaGvEgB4pODwy3/Xy3reuJEQbzVTdtDe+XxIXvDwg8qzac90U+WLgmkRB1tKdWy1f6hp5H6O8C4p9CZsT+XD2MycSpHH4vB01HmDxJ0F1oBEoA==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 12:25:04.0941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c27aab6-f6ca-4c56-f927-08d75c6b06cd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4306
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 mlxlogscore=589 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EP_CLAIMED flag is used to track the claimed endpoints. While unloading the
module, Reset EP_CLAIMED flag for all enabled endpoints. So that it can be
reused.

Signed-off-by: Sanket Parmar <sparmar@cadence.com>
---
Hi Greg/Felipe,

This can be used for -rc as it is bug fix.

Regards,
Sanket

 drivers/usb/cdns3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 9050b380ab83..2fb78322ed3c 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2381,6 +2381,8 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 		writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
 		readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
 					  !(val & EP_CMD_EPRST), 1, 100);
+
+		priv_ep->flags &= ~EP_CLAIMED;
 	}
 
 	/* disable interrupt for device */
-- 
2.17.1

