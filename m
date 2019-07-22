Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E7DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A454D21911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HAH0Ep3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfGVOLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:11:15 -0400
Received: from mail-eopbgr680075.outbound.protection.outlook.com ([40.107.68.75]:52334
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729083AbfGVOLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:11:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz6dwmj9NQBmVuHcsCCix+Op+IfRavw+miQ4uEwxgSsPZHrAp2i36+ITatWUxepgs3oPMFgbXuMWnNSW9kLQ9let2lPg3uyChUnVI2ujxr82Iq9ZPjkYdRn2rGf0cGnFcl1Wh1ZMwXytzn6lSLsOzIWxm2wv9DsxfijXUdo2zdoVKn7AX+8xqw+n4mHZR+rJtpA3FqOeU7fg+oewvQgE+gFpAn/2vxF0FnX8hrFTxxDOfIYDl6mE26ckRR3394DppfvkAV/aBVaukhUPJy7A3XRe2/+PKI0rhjMuTXkt+cajQK9MH+k0b2c1xxqYqOZhFFk9Dj+h4fIBXnf7+jC9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjb/ICxqEZMZilcXVvvPx1bApYy3kbd/JfqsG268c1o=;
 b=jj6kHsHaBO5kNSSYrp0S9sREI/F8Zo/XpHOZHIa1Rn41eheGbSZnZMehfUh1BFBfd1/6IdaSApzarwdXOhbjKUC6BBbWXQ79dZ7qMTrztz7roJc1InmQOPwHEYEh/+D+y1Ce2mybpL+q2K3BjWHYjXPudsbYlKU4JNudbRBPHVaCbEGp85tNYWldxK6WvIjdn/b5MPx38+JHM1GBpKecqlfoecHvbBkomb8oPckRnBrPF+W7jc5w72wtRo83cr+3QzJKLpXokV4by629WBlq7AGg7lqgcR5ArJNH74Wmj4CcpQyPI78DS6mxOagCl0pMuWgYouST9xwPR9OTsASb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjb/ICxqEZMZilcXVvvPx1bApYy3kbd/JfqsG268c1o=;
 b=HAH0Ep3vUih5FONKIp/Y1uvofw+RCK5ZcblbglnbOi+j7Wv7jahltSAhpr0NQTq7/BZNOr4qdKflK2QR1ydD+R5YqIuUSfbexhE+vkJKK8eBel0sof3HrNXYTY9EmPUO+KKbHr8xpw+QzdcV+m9z8iEwTbYvMu1Alj87Tvqvwno=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3529.namprd12.prod.outlook.com (20.179.106.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 14:11:12 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::a91d:8752:288:ed5f]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::a91d:8752:288:ed5f%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 14:11:12 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Matt Fleming <matt@codeblueprint.co.uk>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Thread-Topic: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Thread-Index: AQHVG7eoxI4KuIDvfEiZt9H+t4SB36aNWbaAgAgVJQCAAU4pgIAKkNWAgAAeuwCAAimSgIAHY3AAgAOYOwCAAr9KAIAlphUA
Date:   Mon, 22 Jul 2019 14:11:12 +0000
Message-ID: <35845e45-0513-085f-9848-3dca92391c76@amd.com>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
 <20190610212620.GA4772@codeblueprint.co.uk>
 <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
 <20190618104319.GB4772@codeblueprint.co.uk>
 <20190618123318.GG3419@hirez.programming.kicks-ass.net>
 <20190619213437.GA6909@codeblueprint.co.uk>
 <20190624142420.GC2978@techsingularity.net>
 <989944bc-6c3a-43b5-4f95-0bdfcc6d6c29@amd.com>
 <20190628151508.GB6909@codeblueprint.co.uk>
In-Reply-To: <20190628151508.GB6909@codeblueprint.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [165.204.77.11]
x-clientproxiedby: DM5PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:3:ef::12) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3e25a67-7fd2-4acf-9e83-08d70eae735e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3529;
x-ms-traffictypediagnostic: DM6PR12MB3529:
x-microsoft-antispam-prvs: <DM6PR12MB35299B1F6C3E46C50BE11701F3C40@DM6PR12MB3529.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(66946007)(66476007)(66446008)(66556008)(256004)(14444005)(64756008)(99286004)(65826007)(64126003)(31686004)(316002)(4744005)(71190400001)(54906003)(486006)(8936002)(6116002)(3846002)(58126008)(2906002)(71200400001)(81166006)(81156014)(478600001)(7736002)(6512007)(26005)(186003)(5660300002)(25786009)(65806001)(66066001)(65956001)(2616005)(11346002)(6246003)(305945005)(36756003)(8676002)(53936002)(476003)(446003)(6916009)(76176011)(4326008)(68736007)(229853002)(52116002)(86362001)(6436002)(102836004)(6486002)(53546011)(6506007)(14454004)(31696002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3529;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kH2+RmcA3TwwsyuLIOEVC8IUXyhjjMRYVmiNO+TJhWrk42dKt84rTLjK4kO2Alk8YWIsHAHB0j/3TWpvLUzKou2iIsiVa52dYUFAHM6JIQ4l1Ax7qjg21WI30j36VczMiutjwcWWWARy3Pbp5yfUBfp+Lx2K55gHw8xkjsKgga5+OwVv8t/zwIygYEBE2bEvQBRSd0SxJFPcDGXcSzpPkopG3VvkA32BKcQG/LJ1kXY8S8hN9boxpkEF1wwe2S1FkvI5rnbos3bJ5RAgBtedvlWNOtd9ywIRhlts2b2z0D3OPdq5NKvB2UD8yPedYL8wUsY5c47oUNoCgNA4+WO8eJydl5xHbM++/vWgdbRiTp/UMmApt5662KXRO4oPjIAVkjKME2ecVQ04VH9y6WADB1jZXvRvEajk04HV+X/Rw2k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91C067AEF85E8C4C93751689F9C4B39A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e25a67-7fd2-4acf-9e83-08d70eae735e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 14:11:12.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssuthiku@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWF0dA0KDQpPbiA2LzI4LzIwMTkgMTA6MTUgQU0sIE1hdHQgRmxlbWluZyB3cm90ZToNCj4gT24g
V2VkLCAyNiBKdW4sIGF0IDA5OjE4OjAxUE0sIFN1dGhpa3VscGFuaXQsIFN1cmF2ZWUgd3JvdGU6
DQo+Pg0KPj4gV2UgdXNlIDE2IHRvIGRlc2lnbmF0ZSAxLWhvcCBsYXRlbmN5IChmb3IgZGlmZmVy
ZW50IG5vZGUgd2l0aGluIHRoZSBzYW1lIHNvY2tldCkuDQo+PiBGb3IgYWNyb3NzLXNvY2tldCBh
Y2Nlc3MsIHNpbmNlIHRoZSBsYXRlbmN5IGlzIGdyZWF0ZXIsIHdlIHNldCB0aGUgbGF0ZW5jeSB0
byAzMg0KPj4gKHR3aWNlIHRoZSBsYXRlbmN5IG9mIDEtaG9wKSBub3QgYXdhcmUgb2YgdGhlIFJF
Q0xBSU1fRElTVEFOQ0UgYXQgdGhlIHRpbWUuDQo+ICAgDQo+IEkgZ3Vlc3MgdGhlIHF1ZXN0aW9u
IGlzOiBJcyB0aGUgbWVtb3J5IGxhdGVuY3kgb2YgYSByZW1vdGUgbm9kZSAxIGhvcA0KPiBhd2F5
IDEuNnggdGhlIGxvY2FsIG5vZGUgbGF0ZW5jeT8NCj4gDQoNClllcywgcmVtb3RlIG5vZGUgMSBo
b3AgaXMgMS42eCB0aGUgbG9jYWwgbm9kZSBsYXRlbmN5IGZvciBBTUQgRVBZQy4NCg0KU3VyYXZl
ZQ0K
