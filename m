Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A4AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241972158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Ag8+VU/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK1QDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:03:01 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:2478 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbfK1QDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:03:00 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASFwZug026777;
        Thu, 28 Nov 2019 11:02:04 -0500
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2whuvq36p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 11:02:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNb5UEJQlhugYZoo0Dwlyi9aXbxd3/qUydDqscnNSntvqHJ7V7hsJQ/WKYZCTONNjD71DMXUNZpOdEnjT7tgAPCCMqQfYSkY2QI6apR6AwypnHUNBsb4iNAU+jumVsCcYwcOsPy/+5qdeC5+CWaH5CCKwUhMjWGk1K/093ERNri8o/SYzEQ8EN7Zx5dnrrHoumx2hD90GUSWMI3xPEZBwjYMgB5BSDoAkEWZLbt4jnMO9C8PtkIBrbNoRhxmFghU2zgVCG1wn/Y6Tp1BPOLchWOJd89OFK0bgmHEk21V+uCBSBbTFSK+d8z/9RROTUbluz6m32/XbqWRt/2JTrJoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXONAl8khotmNpxZIDY9Jtj9dWE9GvxOwxoDyUMVbHw=;
 b=MiksocdMgVy9u3L03pfRLHOu7gck1mqqJVJwuu22b1GlBfknCq2cgqMAX1UWXZKCmDnTb063vadOeSTVdKIEgq1GGrxlvjRYswebBFK59ygz9dVXU9he0vNnsJi0FutEZ8qCPuF3Zu67+kXqzHUQ9XIsgZHld7NPX0CVrmjF8RgKSqToE7n0W1dQUtarKb1ZqVNqeyHlD2zIGGKUNKhfTPP1Rfqc0b2UfYmvgXLJHHJ9jElfN4cZPNvnJoqAiGU/IhVv5uU/FCCgVDjDd6XbYpOczEsZeTqkPMaQllCsTu+zO2Qbo9Xq6fVA2ZCVJqKqa4cPzBxSS/VhYdt00f1hxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=baylibre.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXONAl8khotmNpxZIDY9Jtj9dWE9GvxOwxoDyUMVbHw=;
 b=Ag8+VU/5rPHt4gf1bkJUmJvASx4xVkUxuQ1C3eieD+TmTV+CTDRnOk2ImUnpRjoTejq8HmTntrE4aeGg/vV5FUIqsJYt6tG08dy0rrZSRYIoVTNGt/N0Raa9PCsL4eHVGxedLNPTpstL31pOQQlpP+eJeoSyLC4ShzjIzspfpcE=
Received: from BYAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:a02:a8::33)
 by MN2PR03MB5232.namprd03.prod.outlook.com (2603:10b6:208:1e5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Thu, 28 Nov
 2019 16:02:02 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BYAPR03CA0020.outlook.office365.com
 (2603:10b6:a02:a8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Thu, 28 Nov 2019 16:02:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 16:02:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xASG1ol2004457
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 28 Nov 2019 08:01:51 -0800
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Nov 2019 11:01:57 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <sam@ravnborg.org>, <alexander.deucher@amd.com>,
        <matt.redfearn@thinci.com>, <robdclark@chromium.org>,
        <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH v3 0/2] drm: bridge: adv7511: Add support For ADV7535
Date:   Thu, 28 Nov 2019 20:00:17 +0200
Message-ID: <20191128180018.12073-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(8936002)(44832011)(186003)(6666004)(7636002)(2351001)(106002)(4744005)(86362001)(2870700001)(107886003)(356004)(54906003)(8676002)(305945005)(50466002)(316002)(47776003)(26005)(50226002)(70206006)(246002)(70586007)(2906002)(7416002)(5660300002)(4326008)(6916009)(36756003)(336012)(426003)(7696005)(2616005)(1076003)(48376002)(478600001)(51416003)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5232;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f463fd5c-ecd2-4ad1-ce26-08d7741c4e98
X-MS-TrafficTypeDiagnostic: MN2PR03MB5232:
X-Microsoft-Antispam-PRVS: <MN2PR03MB5232B601996C94195F302BB49B470@MN2PR03MB5232.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0235CBE7D0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwdVYN6gDbz8/38h807ztExhIqE7xq8dBngmwFpzvZ3LjnAZzrSjb0eoJ5n+hnNG6f1IeFlQQAV6JJQ4TSdP17c//hBDplQBmvYvaNNXe9yMmjcPYgf5jvDhsIRDacMg+0nOe5MthIiiE4zuJQ9a/W9kioW6TnHHDMFtAG0sZjp5ugJewwtKTp1iPHsAIA7vQILl+NjTJtA8doHx3Geux8/Yx5JS11peEhy/0+H+22PtAVphlHCoDuKVLgSlzhbZOp7czA2gA9ZBEUgQFELVhKA9fnJyYtVv+cJ2xIhkpT48mGQpO1VycJW9eLaxcRxsEJ8qHHdUdKsSmZGjtTI1fFVV32nJ/0XrYeGgKCA6Qt80QQVba2b3Jzo8Rfqkim/4mdcZeKq6hbtXObYdx4LVx1kBg/GfR6ZiSFAHjWos/mZykmfSg1WvvecU4WlHvJ4f
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 16:02:02.2007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f463fd5c-ecd2-4ad1-ce26-08d7741c4e98
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5232
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_04:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 suspectscore=1 mlxlogscore=807 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set add support for ADV7535 part in ADV7511 driver.

ADV7535 and ADV7533 are pin to pin compatible parts but ADV7535
support TMDS clock upto 148.5Mhz and resolutions up to 1080p@60Hz.

---
Changes in v3:
 - remove CONFIG_DRM_I2C_ADV7533 from Kconfig. Now driver support
all chip versions
 - create macros for v1p2 config registers
 - remove dummy functions from header

Bogdan Togorean (2):
  dt-bindings: drm: bridge: adv7511: Add ADV7535 support
  drm: bridge: adv7511: Add support for ADV7535

 .../bindings/display/bridge/adi,adv7511.txt   | 23 +++++-----
 drivers/gpu/drm/bridge/adv7511/Kconfig        | 13 ++----
 drivers/gpu/drm/bridge/adv7511/Makefile       |  3 +-
 drivers/gpu/drm/bridge/adv7511/adv7511.h      | 44 +++----------------
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  | 35 ++++++++++-----
 5 files changed, 44 insertions(+), 74 deletions(-)

-- 
2.23.0

