Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2675D21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="Kv/s6nSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfC1HxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:53:20 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:6160
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1HxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATZCSTfNBLMWNfzr4Mi4KrMDdTG+o/oUeWVYggcOjtw=;
 b=Kv/s6nSx/EhYZy6rmOoIIici2rA7GH8kYgLqvtohP0kZ4/N3szPmOd0FZ0snKp3Sd8bJyiw/f2jCJXhRju8XKztbwcpFfirriK12dDovPIcykfwtKI+ED/rf9CnM3G3zXIGI5awOp5Sf6u55MZgpB5GCe37rrVIN0H//Gnj7NHg=
Received: from CY4PR13CA0086.namprd13.prod.outlook.com (2603:10b6:903:152::24)
 by CY4PR13MB1464.namprd13.prod.outlook.com (2603:10b6:903:13c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.6; Thu, 28 Mar
 2019 07:53:17 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by CY4PR13CA0086.outlook.office365.com
 (2603:10b6:903:152::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.15 via Frontend
 Transport; Thu, 28 Mar 2019 07:53:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.41; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.41) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1750.16 via Frontend Transport; Thu, 28 Mar 2019 07:53:17 +0000
Received: from JPYOKXHT201.jp.sony.com (117.103.191.79) by
 JPYOKXEG101.jp.sony.com (117.103.190.41) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 28 Mar 2019 07:53:15 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.107]) by
 JPYOKXHT201.jp.sony.com ([180.12.183.209]) with mapi id 14.03.0439.000; Thu,
 28 Mar 2019 07:53:14 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>
CC:     <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <Kento.A.Kobayashi@sony.com>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcAAQQqsgAB7RvcAAgdcBTAAAJSpAACOr4UQ
Date:   Thu, 28 Mar 2019 07:53:14 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE588FCC9@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
         <1552063928.29776.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
         <1552405047.21557.7.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE5873FFB@JPYOKXMS103.jp.sony.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE588EA40@JPYOKXMS103.jp.sony.com>
 <1553510086.2668.2.camel@suse.com>
In-Reply-To: <1553510086.2668.2.camel@suse.com>
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
X-Forefront-Antispam-Report: CIP:117.103.190.41;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(199004)(189003)(110136005)(6246003)(8676002)(2171002)(86362001)(55016002)(8936002)(107886003)(4326008)(86152003)(2906002)(316002)(6116002)(3846002)(37786003)(5660300002)(2201001)(93886005)(106466001)(2876002)(14444005)(229853002)(47776003)(66066001)(126002)(476003)(486006)(446003)(11346002)(54906003)(426003)(436003)(336012)(55846006)(7636002)(7736002)(2486003)(23676004)(305945005)(4744005)(356004)(26005)(50466002)(6346003)(77096007)(106002)(33656002)(246002)(72206003)(478600001)(102836004)(76176011)(186003)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR13MB1464;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg101.jp.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e5fd21d-9a61-46c3-6f3e-08d6b3527087
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:CY4PR13MB1464;
X-MS-TrafficTypeDiagnostic: CY4PR13MB1464:
X-Microsoft-Antispam-PRVS: <CY4PR13MB1464CA1961CB9F6B24F258D0C9590@CY4PR13MB1464.namprd13.prod.outlook.com>
X-Forefront-PRVS: 0990C54589
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xcGhHgagv5yIHipubH9T4I04dLHu//j1HBObdaJFIMDGWBd94q2TicPhWkbk0ZJoEgdGQs0/cBcan46gXPgmEfrvDR1i7CeHfZUqVmBUyoRZYqRWa/mqUW08oZt+xutnNlPV81RVJK6mCZkH343adHyRzYV1PzdNC8p2/3M+Qjp5vtHYGD3a4tuzBJfgzwEc21Dn8XgE+Am2kC/oeGdihqTJMBENZdz5YSGFeV2u4fP91Dz0zYJEIp5Yo/ffXjbW82TUvwNLTa74tSdkPpmwLNK1gtPAVfqs3RuKD/7hnCSxRZTOb4DcoTRxm9Tjq44raACWPFOule1N8CMsU/whxJqfQ51Brh0eLbMqMB6FTTHvbSgJvy6ZG+klF3kfmFw/Nf9H/filHUlbCboQoBy75470i2IX6KgymurjjD1HhIE=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2019 07:53:17.1254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5fd21d-9a61-46c3-6f3e-08d6b3527087
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.41];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj5Tb3JyeSwNCj4NCj5JIHRob3VnaHQgdGhpcyB3YXMgY2xlYXIuIFlvdXIgcGF0Y2gg
aXMgbWFraW5nIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHJlc2V0IGlzIHRyaWdnZXJlZCBieSB0
aGUgU0NTSSBsYXllci4gWW91IGNhbm5vdCBtYWtlIHRoYXQgYXNzdW1wdGlvbiwgYXMgdGhlcmUg
aXMgYW4gaW9jdGwgZm9yIHJlc2V0dGluZyBhIFVTQiBkZXZpY2UuDQo+SW4gY2FzZSB3ZSBhcmUg
Z2V0dGluZyBhbiBlcnJvciBkdXJpbmcgdGhlIHJlc2V0IChvdXIgZW5kcG9pbnRzIHZhbmlzaCks
IHRoZSBkZXZpY2UgZHJpdmVyIG11c3QgcmVwb3J0IHRoYXQgdG8gdGhlIFVTQiBsYXllciwgc28g
dGhlIGRyaXZlciB3aWxsIGFsd2F5cyBiZSBkaXNjb25uZWN0ZWQuDQo+V2UgY2Fubm90IGRyb3Ag
ZXJyb3JzLg0KPg0KPglSZWdhcmRzDQo+CQlPbGl2ZXINCg0KVGhpcyBwYXRjaCBtb2RpZmllZCB1
YXNfcG9zdF9yZXNldCB0byBza2lwIHJlYmluZCBvcGVyYXRpb24gdG8gYXZvaWQgZXhjZXB0aW9u
IHdoaWxlIC1FTk9ERVYgaGFwcGVucyBub3QgZHJvcCBlcnJvci4NCklmIHVhc19wb3N0X3Jlc2V0
IGhhcHBlbnMgLUVOT0RFViwgdXNiX3Jlc2V0X2FuZF92ZXJpZnlfZGV2aWNlIG11c3QgaGFwcGVu
IGVycm9yLg0KU28sd2hlbiB3ZSB1c2UgaW9jdGwoVVNCREVWRlNfUkVTRVQpIHRvIHJlc2V0IGRl
dmljZSwgaWYgdXNiX3Jlc2V0X2FuZF92ZXJpZnlfZGV2aWNlIGhhcHBlbnMgZXJyb3IsIHRoZSBl
cnJvciB3aWxsIGJlIHJlcG9ydGVkIHRocm91Z2ggaW9jdGwgcmV0dXJuIHZhbHVlLiANCg0KUmVn
YXJkcywNCktlbnRvIEtvYmF5YXNoaQ0K
