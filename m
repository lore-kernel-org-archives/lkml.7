Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780AFC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8232173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="nmDPlv4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfEWAIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:08:10 -0400
Received: from mail-eopbgr730110.outbound.protection.outlook.com ([40.107.73.110]:38144
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727638AbfEWAIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2/zgex45m0ypMq21oU7H/fZbO7DFxpmjPQQZm3apRU=;
 b=nmDPlv4DfPGkeq6mwBH6LrvSsCKlUBDV6WIl4qrY1KRhQgkZ0aSY+oZ1E1Kszisb+qitVCUJZd7eUXTbDEuhFmyNmUQbYKemOBdfqo60CEEtlSdIkLj7I7h6ZzRRul2039kdDE5CmhP2ywkNqW6p6ZOUCi/wDbtlUI8u36tkP+E=
Received: from CY4PR13CA0011.namprd13.prod.outlook.com (2603:10b6:903:32::21)
 by BN6PR13MB3203.namprd13.prod.outlook.com (2603:10b6:405:78::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.10; Thu, 23 May
 2019 00:08:06 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by CY4PR13CA0011.outlook.office365.com
 (2603:10b6:903:32::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.10 via Frontend
 Transport; Thu, 23 May 2019 00:08:05 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Thu, 23 May 2019 00:08:04 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x4N082Ai022269;
        Thu, 23 May 2019 00:08:02 GMT
Received: from USCULXHUB08V.am.sony.com (usculxhub08v.am.sony.com [146.215.231.169])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x4N081ri012075;
        Thu, 23 May 2019 00:08:02 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB08V.am.sony.com ([146.215.231.169]) with mapi id 14.03.0439.000;
 Wed, 22 May 2019 20:08:01 -0400
From:   <Tim.Bird@sony.com>
To:     <dvyukov@google.com>, <tbird20d@gmail.com>
CC:     <vkabatov@redhat.com>, <dhaval.giani@gmail.com>,
        <alexander.levin@microsoft.com>, <shuah@kernel.org>,
        <khilman@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>, <dan.carpenter@oracle.com>,
        <willy@infradead.org>, <gustavo.padovan@collabora.co.uk>,
        <knut.omang@oracle.com>, <eslobodo@redhat.com>
Subject: RE: Linux Testing Microconference at LPC
Thread-Topic: Linux Testing Microconference at LPC
Thread-Index: AQHU/HOdrYJ31qGl6EuNFEVWpVDaoaZ3tcEAgABICAA=
Date:   Thu, 23 May 2019 00:07:53 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF97726E9E@USCULXMSG01.am.sony.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
 <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
 <CACT4Y+a_wLnB_f1bfNy_HAipF4iHFiyraogMHWdK285oxgJr+g@mail.gmail.com>
In-Reply-To: <CACT4Y+a_wLnB_f1bfNy_HAipF4iHFiyraogMHWdK285oxgJr+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(448002)(13464003)(199004)(189003)(316002)(85326001)(336012)(76176011)(23676004)(2486003)(55846006)(7696005)(26005)(186003)(37786003)(33656002)(4744005)(7416002)(5660300002)(70586007)(70206006)(86152003)(55016002)(356004)(478600001)(6666004)(72206003)(229853002)(2876002)(2906002)(4326008)(8936002)(53546011)(102836004)(8676002)(486006)(6116002)(3846002)(246002)(305945005)(7736002)(6246003)(66066001)(436003)(426003)(11346002)(126002)(476003)(47776003)(446003)(110136005)(54906003)(86362001)(50466002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR13MB3203;H:usculsndmail03v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail03.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee64dc3b-e30d-422f-ada3-08d6df12bafd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR13MB3203;
X-MS-TrafficTypeDiagnostic: BN6PR13MB3203:
X-Microsoft-Antispam-PRVS: <BN6PR13MB32037F3CCEF5361058D87302FD010@BN6PR13MB3203.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 00462943DE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: oW9GzxT2STiWs7D70CaJaVrCbVFLhFQWqmL9IAqPihBJ0BBupQShs98OI5oELGsgQ1Wd/7uxxySwUpznrB6a4ogD+DbiOYU+wbSgC7xqW3qHNVPOoFWKztgMkXIrnWiXSKUf1AbAPv+lKEo/ff758xWBlX5BXM/t0NZWEGTDM/EZNIIWfkI6NX8027UEvGxYsLIyhoaE0kixQpYvLfiEodtg0vP5hrSwQkxLC0Qz75vou565YVAIFTrm5DlOn5rviKNES4YOeNRJDTI/cU2ZqQgRuZkFNa3/JeCNoCjkFh3JGSMClSQpiZptZ3r4TfHJ0483nWQQRtLHNiUlGIb4wQ3a8YI5MOGmb0IjX4r/m4w22qROtYrlG/XHIxAO3aplLfaxAVM7OenI+NWufaO+pLEeQko3/+4/oyBPqU0ecyI=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2019 00:08:04.3613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee64dc3b-e30d-422f-ada3-08d6df12bafd
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB3203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG1pdHJ5IFZ5dWtvdiAN
Cj4gT24gRnJpLCBBcHIgMjYsIDIwMTkgYXQgMTE6MDMgUE0gVGltIEJpcmQgPHRiaXJkMjBkQGdt
YWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJJ20gaW4gdGhlIHByb2Nlc3Mgbm93IG9mIHBsYW5u
aW5nIEF1dG9tYXRlZCBUZXN0aW5nIFN1bW1pdCAyMDE5LA0KPiA+IHdoaWNoIGlzIHRlbnRhdGl2
ZWx5IHBsYW5uZWQgZm9yIEx5b24sIEZyYW5jZSBvbiBPY3RvYmVyIDMxLiAgVGhpcyBpcw0KPiAN
Cj4gVGhpcyBpcyBfTm92ZW1iZXJfIDEsIHJpZ2h0Pw0KTm8uICBUaHVyc2RheSwgT2N0b2JlciAz
MSwgMjAxOS4gIElzIHRoZXJlIHNvbWUgY29uZmxpY3Qgb24gVGh1cnNkYXk/DQoNCiAtLSBUaW0N
Cg0K
