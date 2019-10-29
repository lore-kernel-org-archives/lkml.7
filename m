Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A2BCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D122086D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="7UQnqQ0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJ2IcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:32:13 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:36994 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729409AbfJ2IcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:32:12 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9T8SHo4006710;
        Tue, 29 Oct 2019 04:31:49 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vvjs66y3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 04:31:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUCDN6nIFsIuzVoZqLWaSVobRlau6BORq2JyGVPrsWXlNxlNCezfTF18ouxyRGCJaA+nYCKI+jLnvn//rHiaNWmkdakBKLuYeOFw3EFv6lD/YWTsiwYs8ZVOH5mP58HcuVrYIFQQVsjpPNyZ7yhMx+nl6bhYVherqYtnMFO5AfbK1oSLv4EUjao+gDWECHsbO+e+rm94f9rtUHl7Ya7+1kFrBDCca+B1876+tLrN1TjRZV6YLRjsAwGnrpoLnokL5i1jKgCGt9Kr54J3SbIGlHEXs0iwXDbawZMLh/9cO0bcE6GTnggPtbNPjpTpO7+eIQ50/+foIrIQt/zNX8j41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KfcrFk7OTTlCjcHxawy7ZNrJKYnlZc0/Og+Zy+TVOc=;
 b=P//GW6sNliT1EAubnZrE6mJtTFDjRkzuMDvWqGldtSb72L+NEplQlt8LI0/l2hic96ZIVss+TafeYhfu90BFrRmcZaowKULUmJRIWYGRi1LMimSPSoK3yKk3DRtZG0R2NASozxLP56UfoDqterik0dQGhT9apEZxLahvMqaJTWPsI0oYG3zYkx1XImngDFGQxuQlR52LrP+dO0Kjt27Bxp+LdRrALug5/QQCt6lpqyQ5+3W/UtkZhq0yt2BFGD2D0sZ9CDyk3m5dAj+XLM26LkaW2jZYE5aT0/O17u+1KshA0AeJYZ8/ImYBKhIRflJ/8Mhw6aoBU2d70HWYVgGeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=baylibre.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KfcrFk7OTTlCjcHxawy7ZNrJKYnlZc0/Og+Zy+TVOc=;
 b=7UQnqQ0y7V2LCHIDzOM9QAXB34QTS6mC2/DkZNYdvxgOzwzOT9mGLg0yk5EAdLggzvdv7Qlj63BKqt9Vcz5VF/w9jISJevxvtaSJHYm8YX0efhbyF4xf62uAIi2LGvVGjMnNuqO+18bvlKEG/j94EUyRvd5Wrb+N7+TChamop6s=
Received: from DM6PR03CA0065.namprd03.prod.outlook.com (2603:10b6:5:100::42)
 by BN3PR03MB2386.namprd03.prod.outlook.com (2a01:111:e400:7bbc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Tue, 29 Oct
 2019 08:31:47 +0000
Received: from CY1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by DM6PR03CA0065.outlook.office365.com
 (2603:10b6:5:100::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22 via Frontend
 Transport; Tue, 29 Oct 2019 08:31:47 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT046.mail.protection.outlook.com (10.152.74.232) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 08:31:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x9T8Vklg006311
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 01:31:46 -0700
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 29 Oct 2019 04:31:46 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <narmstrong@baylibre.com>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>, <tglx@linutronix.de>,
        <alexios.zavras@intel.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [RESEND PATCH 2/2] drm: bridge: adv7511: Extend list of audio sample rates
Date:   Tue, 29 Oct 2019 10:30:37 +0200
Message-ID: <20191029083035.21310-2-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029083035.21310-1-bogdan.togorean@analog.com>
References: <20191029083035.21310-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(8936002)(478600001)(4326008)(6666004)(356004)(106002)(1076003)(4744005)(7416002)(316002)(47776003)(50226002)(86362001)(5660300002)(54906003)(8676002)(6916009)(2351001)(26005)(36756003)(486006)(305945005)(44832011)(246002)(76176011)(7696005)(70206006)(51416003)(70586007)(476003)(126002)(11346002)(2870700001)(2616005)(336012)(446003)(426003)(186003)(7636002)(107886003)(2906002)(48376002)(50466002)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2386;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a26e15d-9a37-4992-4089-08d75c4a702d
X-MS-TrafficTypeDiagnostic: BN3PR03MB2386:
X-Microsoft-Antispam-PRVS: <BN3PR03MB2386FC6E5B0F04FE2515CA779B610@BN3PR03MB2386.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hlw7+LstPUfCIMgF0CDBBh72y56fsFjkMulz8B2hFc6ueVR9prfcDphZnZDA+NJGKW9zNJsmo87O+HyzFHW8kX9FG0hHRaAX+jBLUoD+JmWW61v/urNxKuiS++FsfkbldXW79UymMh8hSYB2MEtLi3ntYqTRWKcHGH2r59MXAiw56DrfdMRFHel2eQdinBAt0osZiEYKS3JCQNndLyRv73Av5p2b/vUDUih4T4I96ogi2itGGrvGm8mUeaOL4xIJM6vK+SoXhzg3kBY++Cnb4ysVGqL3VE77vOjLEbPhs6VaRRp+gXoYZsOWqCOc+/lb3G8PUB07LOJQe+4tH/ri44UOB5tZo+0rwZP/6xPJIhD64ToJ5n83GXc8fWPZCmCzDK3Db4u+2xcG4Zxh2UiFSqTf2oBzLCfjsCxvtnGWLwa7cmDGFv9ww6LlkoO8cGHa
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 08:31:47.4232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a26e15d-9a37-4992-4089-08d75c4a702d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2386
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_03:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=1 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7511 support sample rates up to 192kHz. CTS and N parameters should
be computed accordingly so this commit extend the list up to maximum
supported sample rate.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 1e9b128d229b..13e8cee6e827 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -27,6 +27,18 @@ static void adv7511_calc_cts_n(unsigned int f_tmds, unsigned int fs,
 	case 48000:
 		*n = 6144;
 		break;
+	case 88200:
+		*n = 12544;
+		break;
+	case 96000:
+		*n = 12288;
+		break;
+	case 176400:
+		*n = 25088;
+		break;
+	case 192000:
+		*n = 24576;
+		break;
 	}
 
 	*cts = ((f_tmds * *n) / (128 * fs)) * 1000;
-- 
2.23.0

