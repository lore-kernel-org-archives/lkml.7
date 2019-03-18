Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A41DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AC8205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ELqlztEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCRRAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:00:34 -0400
Received: from mail-eopbgr800070.outbound.protection.outlook.com ([40.107.80.70]:28704
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727368AbfCRRAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFbFbEYwsQCyxKHZO6PmPfj0v0y7Eg7FCl5WI5qkq2E=;
 b=ELqlztELh2pIkGBSeXrkx32wsSchOeiwkARu3eOV7RKDiug4lnjdB63f3xGiE4s8MlcG5YZoYYNvuV6v8pN0rgRJDy8hNNYv94dTI78ikAIZ9zC+fXQ41rnVtiTEodsre1OH+G0JWUQnTJjntgpWur5NjZ7WbG6zlbNgu/4Ly48=
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (20.179.92.82) by
 BYAPR12MB2918.namprd12.prod.outlook.com (20.179.91.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 17:00:25 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::e073:d670:f97c:3eb8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::e073:d670:f97c:3eb8%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 17:00:25 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Thread-Topic: [PATCH 00/10] HMM updates for 5.1
Thread-Index: AQHUt/NUFcw+4aF5pk+3POENbm0onKYJB9YAgAD2swCAB+mkgA==
Date:   Mon, 18 Mar 2019 17:00:25 +0000
Message-ID: <37e4baa7-715f-d231-c56a-b525be92daa6@amd.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
In-Reply-To: <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.121.133.36]
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
x-clientproxiedby: LO2P265CA0175.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:133::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47701b2d-e9d4-4c0e-2ab4-08d6abc3371c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2918;
x-ms-traffictypediagnostic: BYAPR12MB2918:
x-microsoft-antispam-prvs: <BYAPR12MB2918DF603A85DD306F429F9192470@BYAPR12MB2918.namprd12.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(106356001)(31686004)(14454004)(305945005)(53546011)(8676002)(4326008)(105586002)(11346002)(72206003)(54906003)(58126008)(110136005)(102836004)(55236004)(81166006)(2616005)(6506007)(386003)(26005)(478600001)(81156014)(186003)(25786009)(486006)(99286004)(7736002)(476003)(4744005)(446003)(229853002)(53936002)(65826007)(6436002)(71200400001)(71190400001)(97736004)(6246003)(6512007)(68736007)(6486002)(36756003)(8936002)(31696002)(2906002)(76176011)(3846002)(52116002)(66066001)(65806001)(65956001)(5660300002)(64126003)(316002)(86362001)(256004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2918;H:BYAPR12MB3176.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IqUQ7BBOliPYdkrhimmujiO3hOP6DkLE8rlfzbSqdh5gtix4I9fm49xF8dO7tKfI1wCAJm8IVoogIO8oZkDGkh7ImF3QGAZq7qT9uWahNQTSJWZA2P8TJt6F9+urckK0sff8tuI4KGtpbYtv4WBe8pfWxfJGRhkpaexVUmi0MZ+jHVZulwhe+VXV0CkaUj8nRuD7xJPA2vmzomGHOaXOOpm2GNdU+zrqIXCruQBzNXp27Yvl+u4a+Id+p9iVCUZYlown1VL9lC5qHEwCpPkV7J6pW7r+X3HuFDLz7MBJALIcqYv48vNV03eHYmjcNYhZ15fe/JwsgsMgKovDbv4Q4/f9ufHU3SrdoR1POp68heQczCf82jibVH/uCi7L8ML62jdeLmkYicZ9AFfpdOOgL0stLqhrr0wjZVZb/qzx0Tk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B857C01D75B584580973B095D0FD089@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47701b2d-e9d4-4c0e-2ab4-08d6abc3371c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 17:00:25.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIGFtZGdwdSBJIGxvb2tlZCBvdmVyIHRoZSBjaGFuZ2VzIGFuZCB0aGV5IGxvb2sgcmVhc29u
YWJsZSB0byBtZS4gDQpQaGlsaXAgWWFuZyAoQ0NlZCkgYWxyZWFkeSByZWJhc2VkIGFtZGdwdSBv
biB0b3Agb2YgSmVyb21lJ3MgcGF0Y2hlcyBhbmQgDQppcyBsb29raW5nIGZvcndhcmQgdG8gdXNp
bmcgdGhlIG5ldyBoZWxwZXJzIGFuZCBzaW1wbGlmeWluZyBvdXIgZHJpdmVyIGNvZGUuDQoNCkZl
ZWwgZnJlZSB0byBhZGQgbXkgQWNrZWQtYnkgdG8gdGhlIHBhdGNoZXMuDQoNClJlZ2FyZHMsDQog
wqAgRmVsaXgNCg0KT24gMy8xMy8yMDE5IDEyOjEwIFBNLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBUdWUsIDEyIE1hciAyMDE5IDIxOjI3OjA2IC0wNDAwIEplcm9tZSBHbGlzc2UgPGpnbGlz
c2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+DQo+PiBBbmRyZXcgeW91IHdpbGwgbm90IGJlIHB1c2hp
bmcgdGhpcyBwYXRjaHNldCBpbiA1LjEgPw0KPiBJJ2QgbGlrZSB0by4gIEl0IHNvdW5kcyBsaWtl
IHdlJ3JlIGNvbnZlcmdpbmcgb24gYSBwbGFuLg0KPg0KPiBJdCB3b3VsZCBiZSBnb29kIHRvIGhl
YXIgbW9yZSBmcm9tIHRoZSBkcml2ZXIgZGV2ZWxvcGVycyB3aG8gd2lsbCBiZQ0KPiBjb25zdW1p
bmcgdGhlc2UgbmV3IGZlYXR1cmVzIC0gbGlua3MgdG8gcGF0Y2hzZXRzLCByZXZpZXcgZmVlZGJh
Y2ssDQo+IGV0Yy4gIFdoaWNoIGluZGl2aWR1YWxzIHNob3VsZCB3ZSBiZSBhc2tpbmc/ICBGZWxp
eCwgQ2hyaXN0aWFuIGFuZA0KPiBKYXNvbiwgcGVyaGFwcz8NCj4NCg==
