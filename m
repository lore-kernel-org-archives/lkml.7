Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB35C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE3E2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xywa0rTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfC1N6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:58:09 -0400
Received: from mail-eopbgr710056.outbound.protection.outlook.com ([40.107.71.56]:41440
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbfC1N6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFhSSeqZDDzd7cxQ6jH2+sA+9HID3wTq6rw1pcJFOqk=;
 b=xywa0rTb2WKvp/o9a3KHvq0POAX6DBI6fDfZO2ulynv6Gl4cxi/ZYXP9M71IKF6HnVxviqApogrpnqTUBc1fHz8Ixdpe5RJyf/7vnNC2R36WKSB6EyNKNPqQZtboPOmyZEYAEm/CQdwPl16Ey9D8zivPLLqH1XVAToiuYglhCc8=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3226.namprd12.prod.outlook.com (20.179.105.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 28 Mar 2019 13:58:06 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755%5]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019
 13:58:06 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     David Rientjes <rientjes@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] KVM: SVM: prevent DBG_DECRYPT and DBG_ENCRYPT overflow
Thread-Topic: [patch] KVM: SVM: prevent DBG_DECRYPT and DBG_ENCRYPT overflow
Thread-Index: AQHU4zs2G/SIKrvFgkGxQAzIKjw/j6YhFg+A
Date:   Thu, 28 Mar 2019 13:58:05 +0000
Message-ID: <0ba6d873-6567-f20a-c5c1-59fc2c97968e@amd.com>
References: <alpine.DEB.2.21.1903251146160.188887@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1903251146160.188887@chino.kir.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0044.namprd04.prod.outlook.com
 (2603:10b6:803:2a::30) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6d2f87b-636c-4a07-7fdf-08d6b38566ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3226;
x-ms-traffictypediagnostic: DM6PR12MB3226:
x-microsoft-antispam-prvs: <DM6PR12MB32267DA94E0ED3A346222CCDE5590@DM6PR12MB3226.namprd12.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(6246003)(386003)(53546011)(6506007)(6436002)(76176011)(52116002)(7736002)(102836004)(8936002)(305945005)(25786009)(6486002)(8676002)(81166006)(6512007)(3846002)(2906002)(53936002)(68736007)(81156014)(6116002)(105586002)(99286004)(229853002)(4326008)(5660300002)(31686004)(256004)(446003)(106356001)(36756003)(4744005)(11346002)(476003)(2616005)(86362001)(486006)(97736004)(26005)(54906003)(31696002)(110136005)(186003)(478600001)(71190400001)(14454004)(71200400001)(66066001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3226;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9rOUH4IeInk/EpYTh0h//zkFK7478RWR1GXsHrWz32gbXcRgN9p4LPeJwQO6sgnG2FHHZ2AwH7Uy5G/ruRE8027C02pAidUWmtcFWFRpagPDlQ2V2wrkmaS44LyO0u3Ug+eRkIqbZA5DoZXOZxyH2bFLwl2VqZzjBVadUn1715LQPFafCi/8lmZbaI87I29IDtSZ7bbc7vcGQ8fgmx/fmg5lL24mn4O1VlWwvvRQkTLrGUp5LWmY1kzVE7TR65S1YO7Y90hodPxcXa/N0kMHkMfEzvL+e9xbH+WiSG3QwdMvLl1GQm7s76Q1MulcFmfkgqqdgH34IRSU0rMGRPJ9TnGBa+H2R/pXtOUqiKEfHF/bPc02veiyR/QCgBFl4nBM9el8XKATcvD7/EacVzFKyPxUIY/EPCz8dVZ24juHJNk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9B95685FF3A1E44A276FCCEF455283D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d2f87b-636c-4a07-7fdf-08d6b38566ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 13:58:05.8925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMjUvMTkgMTo0NyBQTSwgRGF2aWQgUmllbnRqZXMgd3JvdGU6DQo+IFRoaXMgZW5z
dXJlcyB0aGF0IHRoZSBhZGRyZXNzIGFuZCBsZW5ndGggcHJvdmlkZWQgdG8gREJHX0RFQ1JZUFQg
YW5kDQo+IERCR19FTkNSWVBUIGRvIG5vdCBjYXVzZSBhbiBvdmVyZmxvdy4NCj4gDQo+IEF0IHRo
ZSBzYW1lIHRpbWUsIHBhc3MgdGhlIGFjdHVhbCBudW1iZXIgb2YgcGFnZXMgcGlubmVkIGluIG1l
bW9yeSB0bw0KPiBzZXZfdW5waW5fbWVtb3J5KCkgYXMgYSBjbGVhbnVwLg0KPiANCj4gUmVwb3J0
ZWQtYnk6IENmaXIgQ29oZW4gPGNmaXJAZ29vZ2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGF2
aWQgUmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gveDg2L2t2
bS9zdm0uYyB8IDEyICsrKysrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KDQoNClJldmlld2VkLWJ5OiBCcmlqZXNoIFNpbmdo
IDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQoNCnRoYW5rcw0K
