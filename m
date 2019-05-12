Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDFC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3989D2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XafycKEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfELREg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:04:36 -0400
Received: from mail-eopbgr710049.outbound.protection.outlook.com ([40.107.71.49]:40774
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726531AbfELREg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfyVLu2qGg74JK2K0w7PiWm11VWD4WDbxcCYcgeYAlM=;
 b=XafycKEIgIVftzLfArJ1RTL+ScKDXerzF09UjTPSejiVwpFHJCPirQEhvyMM7ydDFXb7Gy+f5RugI2pEBEy15p7pu3AzWfavtVDI4IGidGSWwq4RWsZRyrPWb6HKPIdCkAq4RxgCu5qxIAfWSKMaIt152i3RlE+uXdzRr+P7ZiA=
Received: from DM5PR1201MB0268.namprd12.prod.outlook.com (10.174.106.16) by
 DM5PR1201MB2506.namprd12.prod.outlook.com (10.172.89.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Sun, 12 May 2019 17:04:29 +0000
Received: from DM5PR1201MB0268.namprd12.prod.outlook.com
 ([fe80::dc37:86c4:1bdf:19b8]) by DM5PR1201MB0268.namprd12.prod.outlook.com
 ([fe80::dc37:86c4:1bdf:19b8%6]) with mapi id 15.20.1878.024; Sun, 12 May 2019
 17:04:24 +0000
From:   "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>
CC:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Sen, Pankaj" <Pankaj.Sen@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
Thread-Topic: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
Thread-Index: AQHVAEcKD7OKGpBZiUm/fYqEd8sPHKZXYQMAgBBn3QA=
Date:   Sun, 12 May 2019 17:04:23 +0000
Message-ID: <495b70a3-0232-343b-9081-56869415986f@amd.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190501175457.195855-2-rrangel@chromium.org>
 <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
In-Reply-To: <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::23)
 To DM5PR1201MB0268.namprd12.prod.outlook.com (2603:10b6:4:54::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shyam-sundar.S-k@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [43.224.156.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5d6e26c-9390-4cd6-211b-08d6d6fbe1f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR1201MB2506;
x-ms-traffictypediagnostic: DM5PR1201MB2506:
x-microsoft-antispam-prvs: <DM5PR1201MB250607B79DE519D14FAEB0E19A0E0@DM5PR1201MB2506.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(366004)(136003)(376002)(199004)(189003)(110136005)(316002)(86362001)(31696002)(14454004)(54906003)(2501003)(53546011)(26005)(4744005)(305945005)(186003)(102836004)(2616005)(7736002)(386003)(6506007)(256004)(6246003)(11346002)(8676002)(81166006)(486006)(81156014)(476003)(8936002)(31686004)(71190400001)(71200400001)(6486002)(72206003)(446003)(6436002)(76176011)(99286004)(52116002)(64756008)(66556008)(25786009)(66476007)(66446008)(478600001)(6512007)(36756003)(68736007)(6636002)(6116002)(66946007)(2906002)(73956011)(3846002)(229853002)(66066001)(4326008)(5660300002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB2506;H:DM5PR1201MB0268.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ezyfCTFGWhMH+nZQbBEykoNfIcbhXLKyrNLIhh/NZZlQw3jJTrJlxSEz8PaDSSr7AnpD3EuxXu0GPCUge4SimyUC66NH21ibdqDAPjtc7GRDlykim9f6TZEAsZe44KAFlcOMNFiFSQuDhjbQYldKI5J5S2nOaTzpDW7keWhWjhcqzyTuP37dcRuPnkrDHWx6wv4YxLNDk1tBpjhcoUQu6RW/1D7tSUv1f1AiRSxZRV8tA0hJle7nmKSqt3Tt4uc/LDWqSRCwydZ/JHDdnCqP13BtXyq931PMYe/d55PFefhM5TBKT3ojRCecqHRK9vDdP64y+0L4CXg83/gRTaIuxxtdX+ZmaXFpvqMRNq9cCT4oEE0XZGeAZUPy/q8VYtpuaFjk9D6Nxq+K055rHi/7LiXfTshWRXtGtZdXDrP3TLc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BB949886EDC3441B2F9FD4488C45603@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d6e26c-9390-4cd6-211b-08d6d6fbe1f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 17:04:23.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yLzIwMTkgMTI6MDIgUE0sIEFkcmlhbiBIdW50ZXIgd3JvdGU6DQo+IENjOiBzb21lIEFN
RCBwZW9wbGUNCj4NCj4gT24gMS8wNS8xOSA4OjU0IFBNLCBSYXVsIEUgUmFuZ2VsIHdyb3RlOg0K
Pj4gQU1EIFNESEMgMHg3OTA2IHJlcXVpcmVzIGEgaGFyZCByZXNldCB0byBjbGVhciBhbGwgaW50
ZXJuYWwgc3RhdGUuDQo+PiBPdGhlcndpc2UgaXQgY2FuIGdldCBpbnRvIGEgYmFkIHN0YXRlIHdo
ZXJlIHRoZSBEQVRBIGxpbmVzIGFyZSBhbHdheXMNCj4+IHJlYWQgYXMgemVyb3MuDQo+Pg0KPj4g
VGhpcyBjaGFuZ2UgcmVxdWlyZXMgZmlybXdhcmUgdGhhdCBjYW4gdHJhbnNpdGlvbiB0aGUgZGV2
aWNlIGludG8NCj4+IEQzQ29sZCBmb3IgaXQgdG8gd29yayBjb3JyZWN0bHkuIElmIHRoZSBmaXJt
d2FyZSBkb2VzIG5vdCBzdXBwb3J0DQo+PiB0cmFuc2l0aW9uaW5nIHRvIEQzQ29sZCB0aGVuIHRo
ZSBwb3dlciBzdGF0ZSB0cmFuc2l0aW9ucyBhcmUgYSBuby1vcC4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBSYXVsIEUgUmFuZ2VsIDxycmFuZ2VsQGNocm9taXVtLm9yZz4NClNpZ25lZC1vZmYtYnk6
IFNoeWFtIFN1bmRhciBTIEsgPFNoeWFtLXN1bmRhci5TLWtAYW1kLmNvbT4NCg==
