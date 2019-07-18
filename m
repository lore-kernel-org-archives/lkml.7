Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04778C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C727420873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="UX1od561"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbfGRR7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:59:12 -0400
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:33768
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbfGRR7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4sLcr+ROmKyPYZKhlPUoWji3lvm1b+i77jyQ3fik6uXfF462CsRR7UWwFH0coZgOxn2qaop3WayM5rZIdTmbHaf/8/e0Tp47Mf36z0pympsSnjwde/nfFfCpslX99fr+3vQYPSS0XmLKJzQwwpuk16BLKBUU9vwFXbM6RvCxmjf1hLWr0QbWEMydecLUp42CFZwxVLpdIZ3Ec3Rpdl5xNSsEjD16X1Q7vWvqnzEV7bZx7NjzPovDjMSuW1w1ZalLAHpk6L+ibyyGx9dX2BZklIq9aqPn7Ijor1MOhSVeiwZZ9K8XLgZ4+IMqPxVWvLVRsugz0cIgGV0bGAiHIAbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVft7SUf77CIAqjbISltIoHdkkuLS5K/dy3N0XuXvg8=;
 b=PEKaAvcFWx7DOG7VXtwefCJMkKZeDnR8/7o1lRlsgjEbZDHdoxRo1AwE8YcYpeDF2xRA8mEjQ+S8mNJ1B64ta/ZIlryyv8n4Rqq73gQjLuJkY6Mh6bqOaQhCBVRiKkPqIR0ir1qGWKCGyidSQ5baRzr7FfuFIjVke1IiIsJNup8tn7nmuMbPC5FS0PhPS2im7BIYXldfSQGaZEAv7pvF6d9WPNp9Lq0U9WUYYcoyRGiFRYqF+YSbvY8FHPVcfmnyoCvG7ntye+NZ9doTp2HUVADXog7QFklyi/hspm53n5cH1LVLaoexEZ/lRYNaZXd/CpN6epSyse6Urhtpfhf+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVft7SUf77CIAqjbISltIoHdkkuLS5K/dy3N0XuXvg8=;
 b=UX1od561fFs8uAICOWWywpVE6cPWHygBLrNn5H7AncnAYtTboY5hN7iypRRTe5cmVEDGgC2TVKLBpd1JmenzhNfpcGOBFQ+YJ6myQKZapPpFarY+Yw5lLTCATKeucO0koSlu0mGQuEYUlJBEz/em2bqtwEL2/vs0SPmzaEZYhe8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6101.namprd05.prod.outlook.com (20.178.54.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.8; Thu, 18 Jul 2019 17:59:09 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Thu, 18 Jul 2019
 17:59:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     kernel test robot <rong.a.chen@intel.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>, "lkp@01.org" <lkp@01.org>
Subject: Re: [x86/modules]  f2c65fb322:  will-it-scale.per_process_ops -2.9%
 regression
Thread-Topic: [x86/modules]  f2c65fb322:  will-it-scale.per_process_ops -2.9%
 regression
Thread-Index: AQHVPU5F6lYNjXgCiU+to6YdZcl0X6bQqmEA
Date:   Thu, 18 Jul 2019 17:59:08 +0000
Message-ID: <52D013BF-9B4B-4D03-B56F-3F378E4A2BA4@vmware.com>
References: <20190718095037.GC27250@shao2-debian>
In-Reply-To: <20190718095037.GC27250@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30315812-cc51-45b5-6b3e-08d70ba9a1f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6101;
x-ms-traffictypediagnostic: BYAPR05MB6101:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR05MB6101C9E3F74B03C9D1678997D0C80@BYAPR05MB6101.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(11346002)(76116006)(26005)(316002)(476003)(14444005)(66946007)(66446008)(66556008)(66476007)(64756008)(2616005)(446003)(256004)(66066001)(486006)(186003)(7416002)(305945005)(71190400001)(54906003)(86362001)(8936002)(99286004)(76176011)(68736007)(71200400001)(81166006)(36756003)(81156014)(229853002)(102836004)(6486002)(45080400002)(7736002)(478600001)(53936002)(6506007)(8676002)(33656002)(4326008)(53546011)(14454004)(2906002)(6916009)(6512007)(6306002)(966005)(6246003)(25786009)(6116002)(3846002)(5660300002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6101;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TuMCkWNxnllCxLlsBJMGV0T+9ZQYqJtstJlmLcBhH3orGbQ5rNmrJU0+EDjIM0DD0HeJtU+K5RNioz0gMLzYjUKDQd/MmlHkUraYUqXQMTjcHXFf5wgmfYxb5N7bQKuzZf30dqllE3Lj/l5+zdSDAf3rT5zym1RPFyWqRpIj5TnE9648YBhq6d89TNmCfsOfV/QmFPNhTXQL+lX7f03vzuDMrQsaI6MZ8+2MAz7ea0lcE1Cg49rtpKQQP/EtK20U7Qg7Vlfs/4Ea31uZXbbzMfOiMge/yq/1/Sob3NbZQW2o8aRN6SU5t5qrTHw62Y3NhJyX+6SXIEg5BUw/Lzn7G7QAQFLmX4ASHu6v3DeDwAUaCwPon5xzn5A12oPi98+i9/F/pH/e6Tpv9C4L0tDVDAEQb9GOGI4gEHZqcSxLZwU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A0A6162A2C4E941977A3C1E4DEA879B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30315812-cc51-45b5-6b3e-08d70ba9a1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:59:08.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTgsIDIwMTksIGF0IDI6NTAgQU0sIGtlcm5lbCB0ZXN0IHJvYm90IDxyb25nLmEu
Y2hlbkBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gR3JlZXRpbmcsDQo+IA0KPiBGWUksIHdlIG5v
dGljZWQgYSAtMi45JSByZWdyZXNzaW9uIG9mIHdpbGwtaXQtc2NhbGUucGVyX3Byb2Nlc3Nfb3Bz
IGR1ZSB0byBjb21taXQ6DQo+IA0KPiANCj4gY29tbWl0OiBmMmM2NWZiMzIyMWFkYzZiNzNiMDU0
OWZjN2JhODkyMDIyZGI5Nzk3ICgieDg2L21vZHVsZXM6IEF2b2lkIGJyZWFraW5nIFdeWCB3aGls
ZSBsb2FkaW5nIG1vZHVsZXMiKQ0KPiBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZrZXJuZWwuZ29vZ2xlc291cmNlLmNvbSUy
RnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVsJTJGZ2l0JTJGdG9ydmFsZHMlMkZsaW51eC5naXQm
YW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2RmZTE5ZDcyZWVjZDQ2YTkz
ZmM1MDhkNzBiNjU2NTJiJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdD
MCU3QzYzNjk5MDQwMjQ2MDMyOTM2NyZhbXA7c2RhdGE9OU1IUGxoYTBNSWtEV0tlJTJCdXJERHIw
UVJETXRKM3BQQUNnRHRWWHk4cEw0JTNEJmFtcDtyZXNlcnZlZD0wIG1hc3Rlcg0KPiANCj4gaW4g
dGVzdGNhc2U6IHdpbGwtaXQtc2NhbGUNCj4gb24gdGVzdCBtYWNoaW5lOiAxOTIgdGhyZWFkcyBJ
bnRlbChSKSBYZW9uKFIpIENQVSBAIDIuMjBHSHogd2l0aCAxOTJHIG1lbW9yeQ0KPiB3aXRoIGZv
bGxvd2luZyBwYXJhbWV0ZXJzOg0KPiANCj4gCW5yX3Rhc2s6IDEwMCUNCj4gCW1vZGU6IHByb2Nl
c3MNCj4gCXRlc3Q6IHBvbGwxDQo+IAljcHVmcmVxX2dvdmVybm9yOiBwZXJmb3JtYW5jZQ0KPiAN
Cj4gdGVzdC1kZXNjcmlwdGlvbjogV2lsbCBJdCBTY2FsZSB0YWtlcyBhIHRlc3RjYXNlIGFuZCBy
dW5zIGl0IGZyb20gMSB0aHJvdWdoIHRvIG4gcGFyYWxsZWwgY29waWVzIHRvIHNlZSBpZiB0aGUg
dGVzdGNhc2Ugd2lsbCBzY2FsZS4gSXQgYnVpbGRzIGJvdGggYSBwcm9jZXNzIGFuZCB0aHJlYWRz
IGJhc2VkIHRlc3QgaW4gb3JkZXIgdG8gc2VlIGFueSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZSB0
d28uDQo+IHRlc3QtdXJsOiBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRodWIuY29tJTJGYW50b25ibGFuY2hhcmQlMkZ3
aWxsLWl0LXNjYWxlJmFtcDtkYXRhPTAyJTdDMDElN0NuYW1pdCU0MHZtd2FyZS5jb20lN0NkZmUx
OWQ3MmVlY2Q0NmE5M2ZjNTA4ZDcwYjY1NjUyYiU3Q2IzOTEzOGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5
ZGQ2MmYwJTdDMCU3QzAlN0M2MzY5OTA0MDI0NjAzMjkzNjcmYW1wO3NkYXRhPVltc0plYmYwdDN5
eW83S01DZFV1NlZJT3lzZWJtQiUyRmM3aHV4a09lNWNWMCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpJ
IGRvbuKAmXQgdW5kZXJzdGFuZCBob3cgdGhpcyBwYXRjaCBoYXMgYW55IGltcGFjdCBvbiB0aGlz
IHdvcmtsb2FkLg0KDQpJIHJhbiBpdCBhbmQgc2V0IGEgZnVuY3Rpb24gdHJhY2VyIGZvciBhbnkg
ZnVuY3Rpb24gdGhhdCBpcyBpbXBhY3RlZCBieSB0aGlzDQpwYXRjaDoNCg0KICAjIGNkIC9zeXMv
a2VybmVsL2RlYnVnL3RyYWNpbmcNCiAgIyBlY2hvIHRleHRfcG9rZV9lYXJseSA+IHNldF9mdHJh
Y2VfZmlsdGVyDQogICMgZWNobyBtb2R1bGVfYWxsb2MgPj4gc2V0X2Z0cmFjZV9maWx0ZXINCiAg
IyBlY2hvIGJwZl9pbnRfaml0X2NvbXBpbGUgPj4gc2V0X2Z0cmFjZV9maWx0ZXINCiAgIyB0YWls
IC1mIHRyYWNlDQoNCk5vdGhpbmcgY2FtZSB1cC4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgeW91
IHNlZSBhbnkgb2YgdGhlbSBpbnZva2VkIG9uIHlvdXINCnNldHVwPyBQZXJoYXBzIHlvdSBoYXZl
IHNvbWUgYnBmIGZpbHRlcnMgYmVpbmcgaW5zdGFsbGVkLCBhbHRob3VnaCBldmVuIHRoZW4NCnRo
aXMgaXMgYSBvbmUtdGltZSAoc21hbGwpIG92ZXJoZWFkIGZvciBlYWNoIHByb2Nlc3MgaW52b2Nh
dGlvbi4NCg0K
