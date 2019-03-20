Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBFD21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4G3jOhlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfCTOHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:07:51 -0400
Received: from mail-eopbgr820074.outbound.protection.outlook.com ([40.107.82.74]:56859
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbfCTOHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3sz5biCU5od3gLor5iY8OxrfBAx7LDtAuStJcygPYk=;
 b=4G3jOhlhyH8ws69iYqHdzZVMg6PKN2k5c2QEMQ89zQUBGYVoJZYch6Vv4zKYep+c5S0nCUhYzYSBKqGGRIZLHSFld/5HFCgTSHkuGVPgHZdCrngtm5gAmErlAZsW/07Q1C295alAZ1aOMvAZnCNHf6t9Fzkc+ht3G1B62l4/e9g=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2732.namprd12.prod.outlook.com (20.176.118.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Wed, 20 Mar 2019 14:07:45 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755%5]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 14:07:45 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        Cfir Cohen <cfir@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kvm: svm: fix potential get_num_contig_pages overflow
Thread-Topic: [patch] kvm: svm: fix potential get_num_contig_pages overflow
Thread-Index: AQHU3qHkLZRZ0wfZAUOX0r1IvoYym6YUj06A
Date:   Wed, 20 Mar 2019 14:07:45 +0000
Message-ID: <f5f8e58b-dd19-158e-5428-6631e49cee8e@amd.com>
References: <alpine.DEB.2.21.1903191517380.256304@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1903191517380.256304@chino.kir.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:803:20::27) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ee69d57-0d1f-42bc-0cbd-08d6ad3d6d25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2732;
x-ms-traffictypediagnostic: DM6PR12MB2732:
x-microsoft-antispam-prvs: <DM6PR12MB2732831DAD2E7A3CA8A6FBBFE5410@DM6PR12MB2732.namprd12.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(39860400002)(346002)(199004)(189003)(478600001)(71190400001)(71200400001)(316002)(31696002)(229853002)(53936002)(52116002)(105586002)(6512007)(8936002)(486006)(102836004)(106356001)(476003)(2616005)(256004)(99286004)(2906002)(4326008)(25786009)(66066001)(26005)(31686004)(11346002)(446003)(86362001)(36756003)(6506007)(97736004)(305945005)(4744005)(53546011)(5660300002)(110136005)(6246003)(6486002)(54906003)(386003)(8676002)(186003)(6346003)(14454004)(76176011)(6116002)(3846002)(81166006)(6436002)(81156014)(68736007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2732;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IAuKcBNLWIT/v/rWY6Z6WKqn2bvM/eWgHUjtbB5y6esRnOksFctvGjJK/+unk8zbfW80R7C78Gj74RQYMecCh9faSReXTEsQMQF+zULJQjWZMeK9JbaUfwJ+ESiMZdiRjjonXxCP9D4pT4Kt9aPglQjs68K9+OK/z0y7A6e716CLRZ+/FQc7x2ZgWjn2DTVwuoUpj7e/2pKHk4old3lswdDoO8IWogV+7vOSygerRoOzeDhM5TcZvE6FUXkq70m+tIIoWzKWgIGptpkrqlhGL1skzTaZKoTG5VXX+srRVOMGGCFUqyUjGUliH6HnbzKDySeKePjDvZqJ1ShOnOEkqXn9d7gVF4DsIhl39TIosXxUDC8RsVzazr+4UGV7dgoBYLSbjsHSdkoDMzdXlLWsvcFVJDLQqtgpXZCPn5HrJEY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0AB22C01607904A8F68A829A170B24A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee69d57-0d1f-42bc-0cbd-08d6ad3d6d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 14:07:45.8971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMTkvMTkgNToxOSBQTSwgRGF2aWQgUmllbnRqZXMgd3JvdGU6DQo+IGdldF9udW1f
Y29udGlnX3BhZ2VzKCkgY291bGQgcG90ZW50aWFsbHkgb3ZlcmZsb3cgaW50IHNvIG1ha2UgaXRz
IHR5cGUNCj4gY29uc2lzdGVudCB3aXRoIGl0cyB1c2FnZS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBD
ZmlyIENvaGVuIDxjZmlyQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFJpZW50
amVzIDxyaWVudGplc0Bnb29nbGUuY29tPg0KPiAtLS0NCj4gICBhcmNoL3g4Ni9rdm0vc3ZtLmMg
fCAxMCArKysrKy0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQoNClJldmlld2VkLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNp
bmdoQGFtZC5jb20+DQo=
