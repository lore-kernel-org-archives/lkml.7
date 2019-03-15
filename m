Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32872C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E707A21873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="eIdH5E2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfCOC2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:28:25 -0400
Received: from mail-eopbgr820111.outbound.protection.outlook.com ([40.107.82.111]:63572
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726571AbfCOC2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 22:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeZj0gBZA/FHZZxI6PQnQyg6Mm9xkgXixRz7xAQGRLM=;
 b=eIdH5E2Dkjnxvqc9+xih2Bfu0OSTFn1M2YDOB+WO215MqM4TdOw6VTZI0F2qzxy+97KQZG0JHtrAPTminX6Yff8siGjgO5PNvV9o5dAdXquZNe9c/WkOQExcEcGu19DQGZdJn5jNCVYJBD4gTg6vpbf5/bR2fbExg++D1a7cBdE=
Received: from MWHPR1301CA0035.namprd13.prod.outlook.com
 (2603:10b6:301:29::48) by MN2PR13MB3136.namprd13.prod.outlook.com
 (2603:10b6:208:137::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.10; Fri, 15 Mar
 2019 02:28:22 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MWHPR1301CA0035.outlook.office365.com
 (2603:10b6:301:29::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.8 via Frontend
 Transport; Fri, 15 Mar 2019 02:28:22 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.44)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.44; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.44) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1709.13 via Frontend Transport; Fri, 15 Mar 2019 02:28:21 +0000
Received: from JPYOKXHT103.jp.sony.com (117.103.191.50) by
 JPYOKXEG104.jp.sony.com (117.103.190.44) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Fri, 15 Mar 2019 02:28:14 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.233]) by
 JPYOKXHT103.jp.sony.com ([117.103.191.50]) with mapi id 14.03.0435.000; Fri,
 15 Mar 2019 02:28:14 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>
CC:     <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcAAQQqsgAB7RvcA
Date:   Fri, 15 Mar 2019 02:28:13 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE5873FFB@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
         <1552063928.29776.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
 <1552405047.21557.7.camel@suse.com>
In-Reply-To: <1552405047.21557.7.camel@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.22.105.123]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.44;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(2980300002)(199004)(189003)(5660300002)(86152003)(86362001)(4744005)(2906002)(305945005)(72206003)(37786003)(478600001)(14444005)(4326008)(55846006)(356004)(106466001)(2201001)(8676002)(2876002)(3846002)(6116002)(229853002)(50466002)(8936002)(54906003)(33656002)(23676004)(2171002)(106002)(47776003)(2486003)(6246003)(246002)(7636002)(476003)(126002)(486006)(316002)(7736002)(436003)(93886005)(76176011)(55016002)(110136005)(336012)(102836004)(426003)(26005)(186003)(77096007)(11346002)(66066001)(7696005)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR13MB3136;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg104.jp.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3546528d-b0c4-4c03-31a7-08d6a8ede4da
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7193020);SRVR:MN2PR13MB3136;
X-MS-TrafficTypeDiagnostic: MN2PR13MB3136:
X-Microsoft-Antispam-PRVS: <MN2PR13MB3136FFCE855F1A8B8576AB50C9440@MN2PR13MB3136.namprd13.prod.outlook.com>
X-Forefront-PRVS: 09778E995A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Lb+qkN5mzgouGXQih2WUtZz/q68umtcJZuDd7HovErmlaEgqMDd2pdOUQaK4OdMChaVgE5KJlCSGHCt8KJ+4NqerIO22/JJMOYowgXWrB7i1WtA+BOvs+P+Y3KXk1kgDQN7Xrenq4ATdyxMg7KKUQs0c6ZWoa7iOatukgSqOrthfi8FpW2gEZA6d2El4RWty166YXBF1+0a68vpRZaw1DLoQEhbwsBsR0/xAmpjiGEx4iS1qnWJP24+sJ40EOzEPbemcc87Ho+stMNCEkaqVPPHj863QD4UvEvzvu1cDPQ95TKr89m8gojtvy3Ca6ts5PF5SUC6qrbVbQ7ZtPi457o476FLNHKeChQSHcOZCYc8OK0rWFI1cU3Oz2KVt7XPvZEMbpgOW9Xwucg+2aORjVh6szAuV2FjO+9xhtK5QvmU=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2019 02:28:21.4460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3546528d-b0c4-4c03-31a7-08d6a8ede4da
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.44];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4+IEFuZCB0aGUgcmV0dXJuIHZhbHVlKC1FTk9ERVYpIHdpbGwgYmUgcmV0dXJuZWQg
dG8gZXJyb3IgaGFuZGxlci4NCj4+IHVhc19laF9kZXZpY2VfcmVzZXRfaGFuZGxlci0+dXNiX3Jl
c2V0X2RldmljZSAtPiB1c2JfcmVzZXRfYW5kX3ZlcmlmeV9kZXZpY2UgKHJldHVybiAtRU5PREVW
KSBUaGVuIEkgd3JvdGUgdGhhdCBjb21taXQgbWVzc2FnZSB0aGF0IHdlIHRoaW5rIGV2ZW4gaWYg
d2UgaWdub3JlICJFTk9ERVYiIGluIHBvc3QgcmVzZXQgdG8gYXZvaWQgaGFuZyBpc3N1ZSBidXQg
dGhlIGVycm9yIHdpbGwgYWxzbyBiZSByZXBvcnRlZCB0byBlcnJvciBoYW5kbGVyLg0KPj4gI0lm
IGlnbm9yZSBhbiBlcnJvciBhbmQgdGhlIGVycm9yIHdpbGwgbm90IGJlIHJlcG9ydGVkIHRoZW4g
aXQgaXMgbm90IGdvb2QuDQo+DQo+V2VsbCwgd2hhdCBkbyB3ZSBkbyBub3c/IEFyZSB5b3Ugc2F5
aW5nIHRoYXQgdGhlIHN0YXRlIG1vZGVsIFNDU0kgaXMgdXNpbmcgaXMgd3Jvbmc/DQoNCk5vLCBp
dCBpcyBub3Qgd3JvbmcuDQpCdXQgSSB0aGluayB3ZSBtYXkgd2FudCB0byBwcmV2ZW5kIGhhbmcg
Ynkgc2xlZXAgcGVvY2VzcyB3aXRoIGNvbnRpbnVpbmcgdG8gdGFrZSBhIGxvY2sgYXQgYmxrX2V4
ZWN1dGVfcnEoKSBmcm9tIHVzYl91bmJpbmRfYW5kX3JlYmluZF9tYXJkZWRfaW50ZXJmYWNlcygp
Lg0KDQpSZWdhcmRzLA0KS2VudG8gS29iYXlhc2hpDQo=
