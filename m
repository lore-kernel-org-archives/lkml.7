Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C369FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C2320870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="HQrbYO/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfCYKVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:21:52 -0400
Received: from mail-eopbgr680092.outbound.protection.outlook.com ([40.107.68.92]:39488
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730465AbfCYKVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDQLYDZsExt5VlGBpjoVN4uis+UfoefPAqqRukg9lN8=;
 b=HQrbYO/Z67bS9PHh3R/iO+xj1MYAfeMdGfgcLfP/otP3L81CryuWd0g44EY3Hcbh4oPa++AD4yC/v8fxjGnO+g3HddX/umXIelkO6+A+5NRk3dWRkdH5jsDwPYRWRwetIsUAjEaKguXeBnR81cd/RAQ9wvcXf1lnUG+VchN1BeM=
Received: from MN2PR13CA0017.namprd13.prod.outlook.com (2603:10b6:208:160::30)
 by DM5PR13MB1468.namprd13.prod.outlook.com (2603:10b6:3:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.14; Mon, 25 Mar
 2019 10:21:49 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MN2PR13CA0017.outlook.office365.com
 (2603:10b6:208:160::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.14 via Frontend
 Transport; Mon, 25 Mar 2019 10:21:48 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.42)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.42 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.42; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.42) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1750.11 via Frontend Transport; Mon, 25 Mar 2019 10:21:48 +0000
Received: from JPYOKXHT101.jp.sony.com (117.103.191.48) by
 JPYOKXEG102.jp.sony.com (117.103.190.42) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 25 Mar 2019 10:21:46 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.107]) by
 JPYOKXHT101.jp.sony.com ([117.103.191.48]) with mapi id 14.03.0439.000; Mon,
 25 Mar 2019 10:21:46 +0000
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
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcAAQQqsgAB7RvcAAgdcBTA=
Date:   Mon, 25 Mar 2019 10:21:45 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE588EA40@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
         <1552063928.29776.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
 <1552405047.21557.7.camel@suse.com>
 <AE5419EAB4965843B3C0C1FE29F1FFE5873FFB@JPYOKXMS103.jp.sony.com>
In-Reply-To: <AE5419EAB4965843B3C0C1FE29F1FFE5873FFB@JPYOKXMS103.jp.sony.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:539:0:dddd:1bac:d758]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.42;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(189003)(199004)(186003)(4744005)(14444005)(26005)(77096007)(426003)(336012)(47776003)(2171002)(305945005)(102836004)(229853002)(55846006)(6246003)(55016002)(86152003)(86362001)(2201001)(72206003)(436003)(478600001)(6116002)(76176011)(7696005)(446003)(486006)(11346002)(126002)(476003)(2486003)(23676004)(37786003)(246002)(2876002)(50466002)(8936002)(106466001)(5660300002)(8676002)(356004)(2906002)(4326008)(33656002)(106002)(7636002)(7736002)(316002)(54906003)(110136005)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1468;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg102.jp.sony.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96b61f30-4eb7-4742-6a91-08d6b10bb0ab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:DM5PR13MB1468;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1468:
X-Microsoft-Antispam-PRVS: <DM5PR13MB1468E2CC9BE595F47AD2B312C95E0@DM5PR13MB1468.namprd13.prod.outlook.com>
X-Forefront-PRVS: 0987ACA2E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Jxy8omLUhxyjgVVx6kXyuNIXHU+ggK27evHLnjNrn9oONbS1d2tFVJaZUuZ2cg4yb4tw3vdLNWoZADljbYrLhPmiFe9dL19BI54QYBPJqRAikrWtdFx6ihOhVptQ7vHrYKgJkPj7Zc+rG2wEH8owYkfeKY8uIeHVqkbgCEe5KAxXgNfsjsxaLuv5dx98cU7DI7cZmoFzlhfeIYsGaBQ4MQnqfNp+oDm9od8PF818OJ5jGOz8jrOEiEawt2VXIt25SxWYh+Mr5fd63deG9rkQIdoSUsEKkYlgHfriWjpPUtLpqATbEWAdGUxd7fAyZmUthRE/tsuJlo3Dk8BcsoD6z+02owE2TvA6jF7jl5ITCS4iSXQRzqs/xPmqPMXaYBV6fmztNKT3B4uleaz/Q1rt5hpIVEOjJ1prs9pZF9yTAtY=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2019 10:21:48.0893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b61f30-4eb7-4742-6a91-08d6b10bb0ab
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.42];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1468
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4+PiBBbmQgdGhlIHJldHVybiB2YWx1ZSgtRU5PREVWKSB3aWxsIGJlIHJldHVybmVk
IHRvIGVycm9yIGhhbmRsZXIuDQo+Pj4gdWFzX2VoX2RldmljZV9yZXNldF9oYW5kbGVyLT51c2Jf
cmVzZXRfZGV2aWNlIC0+IHVzYl9yZXNldF9hbmRfdmVyaWZ5X2RldmljZSAocmV0dXJuIC1FTk9E
RVYpIFRoZW4gSSB3cm90ZSB0aGF0IGNvbW1pdCBtZXNzYWdlIHRoYXQgd2UgdGhpbmsgZXZlbiBp
ZiB3ZSBpZ25vcmUgIkVOT0RFViIgaW4gcG9zdCByZXNldCB0byBhdm9pZCBoYW5nIGlzc3VlIGJ1
dCB0aGUgZXJyb3Igd2lsbCBhbHNvIGJlIHJlcG9ydGVkIHRvIGVycm9yIGhhbmRsZXIuDQo+Pj4g
I0lmIGlnbm9yZSBhbiBlcnJvciBhbmQgdGhlIGVycm9yIHdpbGwgbm90IGJlIHJlcG9ydGVkIHRo
ZW4gaXQgaXMgbm90IGdvb2QuDQo+Pg0KPj5XZWxsLCB3aGF0IGRvIHdlIGRvIG5vdz8gQXJlIHlv
dSBzYXlpbmcgdGhhdCB0aGUgc3RhdGUgbW9kZWwgU0NTSSBpcyB1c2luZyBpcyB3cm9uZz8NCg0K
Pk5vLCBpdCBpcyBub3Qgd3JvbmcuDQo+QnV0IEkgdGhpbmsgd2UgbWF5IHdhbnQgdG8gcHJldmVu
ZCBoYW5nIGJ5IHNsZWVwIHBlb2Nlc3Mgd2l0aCBjb250aW51aW5nIHRvIHRha2UgYSBsb2NrIGF0
IGJsa19leGVjdXRlX3JxKCkgZnJvbSA+dXNiX3VuYmluZF9hbmRfcmViaW5kX21hcmRlZF9pbnRl
cmZhY2VzKCkuDQoNCkNvdWxkIHlvdSBwbGVhc2UgeW91IGNhbiBhcHBseSB0aGlzIHBhdGNoIGZv
ciBtYWlubGluZSBvciBub3Q/DQpJZiBub3QsIGNvdWxkIHlvdSBwbGVhc2UgdGVsbCBtZSB3aHkg
eW91IGNhbid0IGFsbG93IHRvIGFwcGx5IHRoaXMgcGF0Y2g/DQoNClJlZ2FyZHMsDQpLZW50byBL
b2JheWFzaGkNCg==
