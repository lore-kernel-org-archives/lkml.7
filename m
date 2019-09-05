Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9173CC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB1E206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="Nod9DXaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfIEESb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 00:18:31 -0400
Received: from mail-eopbgr720092.outbound.protection.outlook.com ([40.107.72.92]:37152
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730892AbfIEESa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBWNi0WnAQhFjLMUBy2Vj5dUtjWfrUVeWTYFfrAcm9EOCWiglIt36rlhmoqceHnA4KYyM20azh9rsu7PU/mXO5upyWYeTJCBRBlRGKr4R6YS4OWsE7G+qOJOYE3LQRzrFQHZltzkt2V6e/pxGibyAqXk2/K2am7DL8hCVJQhdUeWVouQfCFJkZOAillFi/ayS/zctTZRbz3FcYeF8fW7kMIsZvfz/uwvc4mw3yUSQblfAUxx29WHpupae7AUCn1s6vo04E8XMXA+6tgixyPulViFC6mJqXQItDAQFux163Vu0in5tl/zZ4Vu39DdynLcgTKiOOH/bdCYbUaOHDekHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKSKUntckuEnNBKQwI3aHoDI8QOHxasATl27Ew3WKjg=;
 b=UTXrMAroY9G/FGViIAoAzvmoH4e2O+5zoXsAqirnBMio+JWxHAcI0EYmpz7qt3/Hd4/DPMvUTnyM4QA7OQqcKwwjGyScnIqP72M4fWsaxLcZ6cTUPhDXTziyf/IH72teynXj9JG3hVPLY2WJR2IhiRv2fPim4Cxb+2YTtWr+ZqVYO4msCbRnIDUE6oRt9OqzsIxvRbjvujIvka8k5vYQ5YH7vkuPc56tLJjqq0onxbvh4sw3Sns2pN3CnP9maNv0bljf7TmbbxdXhy1fW3G+cUv0Siu0sXekqaQNhhaNxH731sbbGdTc676s6XFoaJeA4QyAv7artRx2ulYHfSJLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 117.103.190.105) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKSKUntckuEnNBKQwI3aHoDI8QOHxasATl27Ew3WKjg=;
 b=Nod9DXaY2fyDaBYfNqxMW+jLsbjV7pTA/8IE0ppde6/zWCKaWDbzqxqE0shoYpk7TbxD4JgFR6iwvj54Zi6ltYbXHgh6A1AxW8i6RKzyfwAy/E3TV33VOeqtH0AUpPAnn1ZkC9Zyu1ncvIKZSZpauNNekVJkAoSj+ASGKblcKxw=
Received: from CY4PR13CA0010.namprd13.prod.outlook.com (2603:10b6:903:32::20)
 by DM5PR13MB1595.namprd13.prod.outlook.com (2603:10b6:3:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.6; Thu, 5 Sep
 2019 04:18:27 +0000
Received: from SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY4PR13CA0010.outlook.office365.com
 (2603:10b6:903:32::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.6 via Frontend
 Transport; Thu, 5 Sep 2019 04:18:27 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.105)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.105; helo=ap.sony.com;
Received: from ap.sony.com (117.103.190.105) by
 SN1NAM02FT042.mail.protection.outlook.com (10.152.73.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 5 Sep 2019 04:18:26 +0000
Received: from APYOKXHT102.ap.sony.com (117.103.191.215) by
 APYOKXEG101.ap.sony.com (117.103.190.105) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 5 Sep 2019 04:18:25 +0000
Received: from APYOKXMS108.ap.sony.com ([169.254.3.47]) by
 APYOKXHT102.ap.sony.com ([117.103.191.215]) with mapi id 14.03.0468.000; Thu,
 5 Sep 2019 04:18:24 +0000
From:   <Jacky.Cao@sony.com>
To:     <stern@rowland.harvard.edu>, <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Kento.A.Kobayashi@sony.com>,
        <Jacky.Cao@sony.com>
Subject: RE: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdVi9W5+0ODcBoGLQOCjqUMWZobPywAAIucAAA2F1wAAHP/DkA==
Date:   Thu, 5 Sep 2019 04:18:24 +0000
Message-ID: <16EA1F625E922C43B00B9D82250220500871CDF9@APYOKXMS108.ap.sony.com>
References: <87sgpcmr7v.fsf@gmail.com>
 <Pine.LNX.4.44L0.1909041017180.1722-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909041017180.1722-100000@iolanthe.rowland.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.82.17.73]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.105;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(189003)(199004)(476003)(486006)(26005)(246002)(446003)(11346002)(126002)(37786003)(55846006)(305945005)(8676002)(7736002)(7636002)(426003)(86362001)(33656002)(336012)(50466002)(46406003)(8936002)(97756001)(102836004)(76176011)(186003)(6116002)(7696005)(14444005)(70206006)(70586007)(316002)(16586007)(356004)(107886003)(2171002)(110136005)(54906003)(66066001)(6246003)(23726003)(3846002)(106002)(2906002)(229853002)(2876002)(5660300002)(4326008)(47776003)(478600001)(55016002)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1595;H:ap.sony.com;FPR:;SPF:Pass;LANG:en;PTR:apyokxeg101.ap.sony.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ab3fb1-2856-45ba-d89b-08d731b819b4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR13MB1595;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1595:
X-Microsoft-Antispam-PRVS: <DM5PR13MB1595D891978737BAEE5A190F87BB0@DM5PR13MB1595.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: puM7E76h0U1laVc/Rik8jFT8FdnDug8exg3as42mJPTsSFuBsdwvXpGYSzsvS62P+raWCFWpQ8tq+21bnOwkyIIPizbfWPjjN6xQDVLD3Dck1S4J5I+gPFiAt+1TIIsi8YF8H1NRNc/rHXuVjQJ/0rYa1lVEKvxHL6EMsyGnxocfrHRTBx4BGwwLi2ykHY7E5cZ+ydwyB/2onFkQzqUPpvrNdCzfB1AeNrW8W4FglVlJdFSHDZgUGE7BDGQyIQYZwOA/ZKu8Oa6VhaN9ny2cxjNJ6fjxTLQ577NMdaZAwQ485rORVcjT84GGhSVaUY0dhfgx6e/DD5pSjjz571TePJ+DNOjoJ4LcQnSI2pE8WxIdu+EbDpVIhDpFG55fo8eHesUr7JXJxCFKcuStCvm3IS54rkH322WKhDJCQEOq9xs=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 04:18:26.6466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ab3fb1-2856-45ba-d89b-08d731b819b4
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.105];Helo=[ap.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1595
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

> Yes.  Except that I think the name POWER_BUDGET_3_0 is a little odd.
> It implies that this change is specific to USB 3.0 -- but it isn't.
> USB 3.1 and 3.2 also have a 900 mA limit, right?
> 
> So please consider changing the name to POWER_BUDGET_3.
> 
> Alan Stern

Thank you for your comment.
I updated the name from POWER_BUDGET_3_0 to POWER_BUDGET_3 in PATCH v3
and submitted it just now.

Regards
Jacky
