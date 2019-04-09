Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19426C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40EC213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="WEmCei7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDIA2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:28:17 -0400
Received: from mail-eopbgr800090.outbound.protection.outlook.com ([40.107.80.90]:45168
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbfDIA2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8vCwMHLym3GpEVXFAq+1wea14V8Fys4EzKGuGrBdJU=;
 b=WEmCei7bEEJ2qbF1YsyOIsokxbx/2lJu0q+tUQIdJwrp4djleQxnwUtBpFtxOE1FAh0IziLWNs23XrqTWgAaMqMQusaVVLhKIqCg1LYa8ORhUO9lTyL+4Qo4hRCDuuHr3feXx+ueRTltoPyGm0wMmba0LFd7D5ngYNZG0zdYW2g=
Received: from DM6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:5:bc::46) by
 MN2PR13MB3136.namprd13.prod.outlook.com (2603:10b6:208:137::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.8; Tue, 9 Apr
 2019 00:28:14 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR13CA0033.outlook.office365.com
 (2603:10b6:5:bc::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.8 via Frontend
 Transport; Tue, 9 Apr 2019 00:28:13 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.44)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.44; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.44) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 00:28:12 +0000
Received: from JPYOKXHT205.jp.sony.com (117.103.191.83) by
 JPYOKXEG104.jp.sony.com (117.103.190.44) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 9 Apr 2019 00:28:11 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.107]) by
 JPYOKXHT205.jp.sony.com ([180.12.183.213]) with mapi id 14.03.0439.000; Tue,
 9 Apr 2019 00:28:11 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <stern@rowland.harvard.edu>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcAAQQqsgAB7RvcAAgdcBTAAAJSpAACOr4UQABH/lYAA3G8Q4AAdt7kAAE4ci4AAIMlyAADTcgoQ
Date:   Tue, 9 Apr 2019 00:28:10 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE5892A0D@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5891C86@JPYOKXMS103.jp.sony.com>
 <Pine.LNX.4.44L0.1904041522150.1288-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904041522150.1288-100000@iolanthe.rowland.org>
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
X-Forefront-Antispam-Report: CIP:117.103.190.44;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(199004)(189003)(486006)(186003)(76176011)(47776003)(6116002)(33656002)(77096007)(356004)(26005)(102836004)(246002)(336012)(106466001)(476003)(426003)(126002)(446003)(11346002)(436003)(478600001)(2486003)(72206003)(23676004)(86152003)(7696005)(6246003)(2171002)(7736002)(37786003)(4326008)(2201001)(5660300002)(2876002)(106002)(316002)(2906002)(54906003)(110136005)(305945005)(4744005)(8936002)(50466002)(86362001)(229853002)(55016002)(8676002)(55846006)(7636002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR13MB3136;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg104.jp.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 493e5495-4642-40e6-2506-08d6bc824093
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:MN2PR13MB3136;
X-MS-TrafficTypeDiagnostic: MN2PR13MB3136:
X-Microsoft-Antispam-PRVS: <MN2PR13MB3136B0D008F7987E339584C0C92D0@MN2PR13MB3136.namprd13.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XC+4JL3AlKAsYZZeYV+zyv/jlZwS22O1Y2cIpxdYFFF3aTg7ikr/LmuWJLTob/27XjUjhulAgigIg6DnxQ3WhRr6s+CpMXy7pm3FP8EjeLn6A68L5li2VY21O84+KonrWydBal8Sk6JxW7wT1kbxpmQ0ngsH6+Hkq2soZRc/EpdOWhmHmSeEv4hiSX2m7hVoG/Gf/3G+pGlNEPXcQaeBA/bNS6sqSFx3sOo38gEq1CjvvlRUY1og5lxoyN+5y0NJFcDk/gaNe4mJMYcUbALOSRlQQHdpRiRdkJxmwa15DOS5GPliXTW6X8dxLorF1/0DnnWiKzeXiPFXDvnFhsyXWlo5t3tZqd7UHLZeJWwf7KbQ3tPYbOYmcSuCq27dT6dbH9+HXcigAetvsAJeXJ7FKq4ITvSlmRbxMqBVbsjc5uE=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 00:28:12.9805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493e5495-4642-40e6-2506-08d6bc824093
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.44];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj5TbyBpdCBsb29rcyBhcyB0aG91Z2ggdGhlIFNDU0kgc3Vic3lzdGVtIGRvZXNuJ3Qg
bGlrZSB0byBoYXZlIGEgcmVzZXQgaGFuZGxlciBjYWxsIHNjc2lfcmVtb3ZlX2hvc3QuICBDb21t
YW5kcyBkaXNwYXRjaGVkIGJ5IHRoZSByZW1vdmFsIHJvdXRpbmVzIGFyZSBmb3JjZWQgdG8gd2Fp
dCBmb3IgdGhlIHJlc2V0IHJlY292ZXJ5IHRvIGZpbmlzaCwgd2hpY2ggd29uJ3QgaGFwcGVuIHVu
dGlsIHRob3NlIGNvbW1hbmRzIGhhdmUgYmVlbiBjb21wbGV0ZWQuDQoNCllvdSBtZWFuIHJlc2V0
IGhhbmRlbGVyIHNob3VsZCBub3QgY2FsbCBzY3NpX3JlbW92ZV9ob3N0LCByaWdodD8NCkJ1dCBh
Y3R1YWxseSwgc2NzaV9yZW1vdmVfaG9zdCBpcyBjYWxsZWQgZnJvbSByZXNldCBoYW5kbGVyIGlu
IHRoaXMgY2FzZS4NCg0KPklzIHRoaXMgYSBidWcgaW4gdGhlIFNDU0kgY29yZT8gDQpObywgSSB0
aGluayB0aGlzIGlzIGEgYnVnIGluIHVhcyBkcml2ZXIuDQoNClJlZ2FyZHMsDQpLZW50byBLb2Jh
eWFzaGkNCg==
