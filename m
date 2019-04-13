Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F554C282DA
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BD920850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PiK709CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDMCT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 22:19:56 -0400
Received: from mail-eopbgr810118.outbound.protection.outlook.com ([40.107.81.118]:6345
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbfDMCT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 22:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpWpmeQW7Qo2mW2f7foDfy/pnl3XuakGyHR0hjHbo7M=;
 b=PiK709CYz23JLyOTcboZxqV8KNaO4tKXrQM6ZI4IwkXxcegnBHVuCSYGEzFhWur8hDeFWrpdekrhiFwwZSZ5nBP3O1w/iT144l+FKUov8a0XT20if06U5qXalxOGo9azSw1jb6qf4almiPj0knsKCJeiZtC9BvPmBdapRJh5Puo=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0903.namprd21.prod.outlook.com (52.132.132.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.2; Sat, 13 Apr 2019 02:19:52 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::41f8:5e99:8d3:1370]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::41f8:5e99:8d3:1370%5]) with mapi id 15.20.1813.005; Sat, 13 Apr 2019
 02:19:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] vmbus: Remove the undesired put_cpu_ptr() in
 hv_synic_cleanup()
Thread-Topic: [PATCH] vmbus: Remove the undesired put_cpu_ptr() in
 hv_synic_cleanup()
Thread-Index: AQHU8YhPOJo/Dt+Ohk2Vxh0PedeQDaY5W1xw
Date:   Sat, 13 Apr 2019 02:19:52 +0000
Message-ID: <DM5PR2101MB09185C3019B33BB0866007B9D7290@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190412233429.29146-1-decui@microsoft.com>
In-Reply-To: <20190412233429.29146-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-13T02:19:50.0815700Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c22f366a-3cc5-439e-b61c-87ce38609489;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [12.31.71.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16824b4d-dc79-41f2-99d4-08d6bfb6835c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0903CA8A8FC7531CB111A7DFD7290@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 00064751B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(4326008)(476003)(5660300002)(71200400001)(6506007)(486006)(102836004)(2201001)(229853002)(76176011)(71190400001)(6436002)(446003)(11346002)(86612001)(22452003)(316002)(4744005)(99286004)(256004)(2906002)(14444005)(68736007)(186003)(110136005)(26005)(52536014)(86362001)(7696005)(6116002)(3846002)(54906003)(9686003)(7736002)(66066001)(81166006)(1511001)(81156014)(74316002)(6246003)(8990500004)(97736004)(33656002)(10290500003)(14454004)(8936002)(2501003)(55016002)(8676002)(478600001)(10090500001)(106356001)(25786009)(105586002)(53936002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hDK6GLen9XKQf5KH4bU68up0rgpVgcTeidBAtiyciCzNlbKQxoXnKfEAPFqBEHG8JWLD7Yrr+0o/MGCWH1Wo0HWgueZqHb6qdzWGq8uOXdGlP/2vPFz0VmWqwzkL41tcPhmXfZgcd3imUpgtBxOlT37ZvTxauEXrghHYSRY+jhdkqizYOXc+SsNhLNK/pSGaJBVz5jjE/JMkehCstPIyVBqw+uVI49qBdOv8eoyUSvbqVCHf56oHtXwyZ6pU/Mb3AX++fEhDpj6ZOc4n0cVjEcHVRdJ9g294YEmfibjKDxyTv2lwuRSza4V2BpS+AueUn/k30XCnBCws4G3eMur6pUI5pV5Jpgta64bGbvs1wBFUazQUtggITJEsEXZi7L2c/J9sLspVXlhCNjjVke/yvv5RghHi5ATvDYVgg1hr6aQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16824b4d-dc79-41f2-99d4-08d6bfb6835c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2019 02:19:52.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gIFNlbnQ6IEZyaWRheSwgQXBy
aWwgMTIsIDIwMTkgNDozNSBQTQ0KPiANCj4gV2l0aCBDT05GSUdfREVCVUdfUFJFRU1QVD15LCB0
aGUgcHV0X2NwdV9wdHIoKSB0cmlnZ2llcnMgYW4gdW5kZXJmbG93DQo+IHdhcm5pbmcgaW4gcHJl
ZW1wdF9jb3VudF9zdWIoKS4NCj4gDQo+IEZpeGVzOiAzN2NkZDk5MWZhYzggKCJ2bWJ1czogcHV0
IHJlbGF0ZWQgcGVyLWNwdSB2YXJpYWJsZSB0b2dldGhlciIpDQo+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0K
