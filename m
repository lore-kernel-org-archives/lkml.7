Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE16C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADAB206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rCsmatqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfEWPZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:25:59 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:49569 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfEWPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:25:58 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Don.Brace@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Don.Brace@microchip.com";
  x-sender="Don.Brace@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Don.Brace@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Don.Brace@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,503,1549954800"; 
   d="scan'208";a="34344722"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 May 2019 08:25:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 23 May 2019 08:25:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8puLPXCNYA/+uZgztRV/M5ABTGBQh2fcLQYj44T2bz4=;
 b=rCsmatqBP1TLNtZEdzF6DlgqCGtRNNRuYjyem6BupNQz3oWJB1z+w35mQVCruNI/LeFgh4NXNhzhOehYC/RgO9+ogHV5+7+FWm/W3OkaiykJMdXEUl1fDuHrFZPHQ48L5SxBrEGh5tYGQGeYA2v0Ix0/gJTWPalYMLT3ptvGpoo=
Received: from SN6PR11MB2767.namprd11.prod.outlook.com (52.135.92.154) by
 SN6PR11MB3119.namprd11.prod.outlook.com (52.135.127.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 23 May 2019 15:25:48 +0000
Received: from SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::d415:48f:41b6:1ae8]) by SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::d415:48f:41b6:1ae8%6]) with mapi id 15.20.1922.018; Thu, 23 May 2019
 15:25:48 +0000
From:   <Don.Brace@microchip.com>
To:     <colin.king@canonical.com>, <don.brace@microsemi.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <esc.storagedev@microsemi.com>, <linux-scsi@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] scsi: hpsa: fix an uninitialized read and
 dereference of pointer dev
Thread-Topic: [PATCH][next] scsi: hpsa: fix an uninitialized read and
 dereference of pointer dev
Thread-Index: AQHVEHpBQxBuxxIZgEeWRpYmBxaPFaZ41iow
Date:   Thu, 23 May 2019 15:25:48 +0000
Message-ID: <SN6PR11MB27672A7C88FE3EB111B4FF64E1010@SN6PR11MB2767.namprd11.prod.outlook.com>
References: <20190522083903.18849-1-colin.king@canonical.com>
In-Reply-To: <20190522083903.18849-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d17aa04a-768f-40b1-852f-08d6df92eeac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR11MB3119;
x-ms-traffictypediagnostic: SN6PR11MB3119:
x-microsoft-antispam-prvs: <SN6PR11MB311979950020AD8A281AD2BBE1010@SN6PR11MB3119.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(13464003)(189003)(199004)(71200400001)(71190400001)(11346002)(66446008)(14444005)(66556008)(64756008)(66476007)(72206003)(4326008)(2906002)(2501003)(478600001)(256004)(7736002)(8676002)(102836004)(81156014)(25786009)(66946007)(186003)(486006)(8936002)(73956011)(2201001)(81166006)(14454004)(68736007)(5660300002)(76116006)(446003)(86362001)(316002)(229853002)(33656002)(74316002)(52536014)(9686003)(26005)(76176011)(3846002)(6116002)(54906003)(305945005)(6436002)(6246003)(53936002)(53546011)(66066001)(55016002)(7696005)(6506007)(110136005)(476003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3119;H:SN6PR11MB2767.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZFppXqt3BhmD7HaoL8jsojlY7zKZMBSXMs5WfFvMFTzHoUPLet7BDo3cOjZ0D57vVbxlE1PKHP0krPXB/K76vnXvnVi0pypNeZhmRKqmv5mWhD4zUCiyzPIhvXdEjKuy2NK2opZJvW4a3VCtITR5DUJw0QtPf4ShbKg217Gsgy3/j8HH1rG4LR5Me5P7yJ0FmyY1Ps84UL4Y5xzA8jDq8LrU1FD3PiiSbu0vBKEgv8z14M76+mujvcd7XrYj397ZA32llG035N2s8k5PjMG6kgCTpBfBvE8euCpOlRz+yepTuriGil+3c7ieZK6GubGcLCnF5k2ugJ+TKbqUEg/oOFRAuazKG7xzl2eayutJigek48sW7ajMop5+4q0Fpi83bqiQ9bholLklJ9ODHVupj5rbfpk6aefW+1VGVYmUwrQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d17aa04a-768f-40b1-852f-08d6df92eeac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 15:25:48.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Don.Brace@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3119
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogbGludXgtc2NzaS1vd25lckB2Z2VyLmtl
cm5lbC5vcmcgW21haWx0bzpsaW51eC1zY3NpLW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVo
YWxmIE9mIENvbGluIEtpbmcNClNlbnQ6IFdlZG5lc2RheSwgTWF5IDIyLCAyMDE5IDM6MzkgQU0N
ClRvOiBEb24gQnJhY2UgPGRvbi5icmFjZUBtaWNyb3NlbWkuY29tPjsgSmFtZXMgRSAuIEogLiBC
b3R0b21sZXkgPGplamJAbGludXguaWJtLmNvbT47IE1hcnRpbiBLIC4gUGV0ZXJzZW4gPG1hcnRp
bi5wZXRlcnNlbkBvcmFjbGUuY29tPjsgZXNjLnN0b3JhZ2VkZXZAbWljcm9zZW1pLmNvbTsgbGlu
dXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbUEFUQ0hdW25leHRd
IHNjc2k6IGhwc2E6IGZpeCBhbiB1bmluaXRpYWxpemVkIHJlYWQgYW5kIGRlcmVmZXJlbmNlIG9m
IHBvaW50ZXIgZGV2DQoNCkZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNh
bC5jb20+DQoNCkN1cnJlbnRseSB0aGUgY2hlY2sgZm9yIGEgbG9ja3VwX2RldGVjdGVkIGZhaWx1
cmUgZXhpdHMgdmlhIHRoZSBsYWJlbCByZXR1cm5fcmVzZXRfc3RhdHVzIHRoYXQgcmVhZHMgYW5k
IGRlcmVmZXJlbmNlcyBhbiB1bmluaXRpYWxpemVkIHBvaW50ZXIgZGV2LiAgRml4IHRoaXMgYnkg
ZW5zdXJpbmcgZGV2IGlzIGluaW50aWFsaXplZCB0byBudWxsLg0KDQpBZGRyZXNzZXMtQ292ZXJp
dHk6ICgiVW5pbml0aWFsaXplZCBwb2ludGVyIHJlYWQiKQ0KRml4ZXM6IDE0OTkxYTViYWRlNSAo
InNjc2k6IGhwc2E6IGNvcnJlY3QgZGV2aWNlIHJlc2V0cyIpDQpTaWduZWQtb2ZmLWJ5OiBDb2xp
biBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KDQpJIHNlbnQgdXAgYSBzaW1p
bGFyIHBhdGNoIG9uIDUvMTYsIGJ1dCB0aGlzIGlzIGp1c3QgYXMgZ29vZC4NCkFja2VkLWJ5OiBE
b24gQnJhY2UgPGRvbi5icmFjZUBtaWNyb3NlbWkuY29tPg0KDQpUaGFua3MgZm9yIHlvdXIgcGF0
Y2guDQoNCi0tLQ0KIGRyaXZlcnMvc2NzaS9ocHNhLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Nj
c2kvaHBzYS5jIGIvZHJpdmVycy9zY3NpL2hwc2EuYyBpbmRleCBjNTYwYTQ1MzI3MzMuLmFjODMz
OGIwNTcxYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS9ocHNhLmMNCisrKyBiL2RyaXZlcnMv
c2NzaS9ocHNhLmMNCkBAIC01OTQ3LDcgKzU5NDcsNyBAQCBzdGF0aWMgaW50IGhwc2FfZWhfZGV2
aWNlX3Jlc2V0X2hhbmRsZXIoc3RydWN0IHNjc2lfY21uZCAqc2NzaWNtZCkNCiAJaW50IHJjID0g
U1VDQ0VTUzsNCiAJaW50IGk7DQogCXN0cnVjdCBjdGxyX2luZm8gKmg7DQotCXN0cnVjdCBocHNh
X3Njc2lfZGV2X3QgKmRldjsNCisJc3RydWN0IGhwc2Ffc2NzaV9kZXZfdCAqZGV2ID0gTlVMTDsN
CiAJdTggcmVzZXRfdHlwZTsNCiAJY2hhciBtc2dbNDhdOw0KIAl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KLS0NCjIuMjAuMQ0KDQo=
