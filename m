Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BDBC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A492186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="OriXx9gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfGSSyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:54:04 -0400
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:28056
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbfGSSyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:54:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgP3eypHd/TSr/O/iusWlEeIrvPqf3GDhnsaG0w9Uyun7SIIxJldlrjA/Js0vZwox24ZognRloc2I0xa0jvTFYznxgNfuszSipTkITeMqgwlAC3Z/kiEgvlLnDE08PiiRuU0JDjWFHNODQWBYLopMzDqz8xXWgBmbzd23Gtkid3Z00bTJeVkXiii2/p9fSU/Prp9Q+qZvKKEqeK3NGZ4JoqM/af+usq51EEWE1hwVoJFXhNdN9iVVVoaUwrp3RjtZ71Is0U1DM6EIWB2wP1ZhztRcKmErLNvrj6Hx/3ZFIW+egBOPgnkYCPmhSVp5lOtJt5f75XgvTkZ1W1qUyfE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkaapBRDXnLXp/cCO6S0+L30bnpluLc1ARq7H0G0eLs=;
 b=Uqz5XsQ5GGSRAIUexWbyE5Oe0kDcpoZMfIQGuLK48SaUWbtG6pQOtVXclda3eJjN6hofGcgG2J41kwI4PPjk23Z8/J5T9XXshvtIlSRZb/nnEPklgfJNusaFgGssT62MUocuMMfB3GEUBE1OQBETJjo1/cqWBCItw+DZzFbbz23VJoydriFqhHnnK8uBKkor6ZkGdY+AsMUPKsdZ/5GOY7lX6XdNEhy5dH50aO0CoXgmxxcqJsiJYXhhcUQfOR6fPVBGze5xKik9pN5Sh0D7LsQM1u2QC+9QJgVqHyh0343Ul1pMbqfofmIF18mGNLtGpkOkcw51UHJt6BmRq3bkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkaapBRDXnLXp/cCO6S0+L30bnpluLc1ARq7H0G0eLs=;
 b=OriXx9gdDx+oMdce20P0Ww+BGm/GAtrnvk/5yxPNOOzOICinVBDvnaDa03i7u4sP835mRkk0HpHcnkjSUaTTwytWBgEI4IFYJeJyPPbQkvtVOA1rZWWASFATFlprkasP0NrUaZLNTfJSLcFVMMBM9ae7zA+Ev+5iLSBI6QU84Uk=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYASPR01MB0021.namprd05.prod.outlook.com (20.177.126.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.9; Fri, 19 Jul 2019 18:54:01 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Fri, 19 Jul 2019
 18:54:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Thread-Topic: [PATCH v3 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Thread-Index: AQHVPc0sdRp3u9Eq6kyTg9bchPzdrKbSRpyAgAABgICAAAFSgIAAAZ4A
Date:   Fri, 19 Jul 2019 18:54:00 +0000
Message-ID: <92B64D24-04DD-45A6-86A4-758CD73E0909@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-6-namit@vmware.com>
 <052e9e57-8f72-d005-f0f7-4060bc665ba4@intel.com>
 <FCEC2890-40B8-4114-913E-7C05B021C4EA@vmware.com>
 <5c4b7bd2-ea0e-dc8d-edbb-1b1b739b963e@intel.com>
In-Reply-To: <5c4b7bd2-ea0e-dc8d-edbb-1b1b739b963e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f08ea5c-3633-4845-65f5-08d70c7a768c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYASPR01MB0021;
x-ms-traffictypediagnostic: BYASPR01MB0021:
x-microsoft-antispam-prvs: <BYASPR01MB00210451C597509B100140DFD0CB0@BYASPR01MB0021.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(6246003)(4326008)(2906002)(86362001)(68736007)(4744005)(71200400001)(71190400001)(102836004)(36756003)(11346002)(446003)(53546011)(186003)(26005)(6506007)(76176011)(8936002)(81166006)(81156014)(14454004)(6116002)(3846002)(316002)(54906003)(476003)(5660300002)(6486002)(2616005)(6436002)(99286004)(76116006)(25786009)(66556008)(66476007)(33656002)(66446008)(478600001)(305945005)(66946007)(64756008)(7736002)(8676002)(229853002)(66066001)(53936002)(486006)(256004)(6916009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYASPR01MB0021;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +4Lu1hCbyoqexAW7NLRHGnhKIgqLfLyGdnzV9uI/7Qg0zjXbPPLDrfgY08DwMkrD5JX2k8CYX8fwua3/R8hrekUQZohhJbDsZbWlp6aR4dcxqkV0eLOAtU4dbOy9waVLC40S6K0VM3bqalU4H7HRPxYoL7WLg8mB99wVNvKiLnRTkQjuKfoUdRtdJ89PiyNtJz+BTiKjf7CiUev4JxO024XGsWGPnXAf369sTKEd0GaS9+3B4sAnm1BbZXcqmOmm1XPbHdp3AmfMVwAhmJs9Fj2v4n3psscfcQ5KMO1m7fv3sRUD0C7SKlLSgfQuYv4HjnWmRrZZ5izBgZmdWz7X8lRd3k/+x7PRVtV+umOVlU5IHMjrSPlo9EOtbNH9oYQGiynY7bdE6mjpYbTcUWzHH3z1APjw91/Vqu1lrsMmqus=
Content-Type: text/plain; charset="utf-8"
Content-ID: <850FD53C021B0E47A8BF1966C4B3C5BB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f08ea5c-3633-4845-65f5-08d70c7a768c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 18:54:00.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTksIDIwMTksIGF0IDExOjQ4IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDcvMTkvMTkgMTE6NDMgQU0sIE5hZGF2IEFtaXQg
d3JvdGU6DQo+PiBBbmR5IHNhaWQgdGhhdCBmb3IgdGhlIGxhenkgdGxiIG9wdGltaXphdGlvbnMg
dGhlcmUgbWlnaHQgc29vbiBiZSBtb3JlDQo+PiBzaGFyZWQgc3RhdGUuIElmIHlvdSBwcmVmZXIs
IEkgY2FuIG1vdmUgaXNfbGF6eSBvdXRzaWRlIG9mIHRsYl9zdGF0ZSwgYW5kDQo+PiBub3Qgc2V0
IGl0IGluIGFueSBhbHRlcm5hdGl2ZSBzdHJ1Y3QuDQo+IA0KPiBJIGp1c3Qgd2FudGVkIHRvIG1h
a2Ugc3VyZSB0aGF0IHdlIGNhcHR1cmUgdGhlc2UgcnVsZXM6DQo+IA0KPiAxLiBJZiB0aGUgZGF0
YSBpcyBvbmx5IGV2ZXIgYWNjZXNzZWQgb24gdGhlICJvd25pbmciIENQVSB2aWENCj4gICB0aGlz
X2NwdV8qKCksIHB1dCBpdCBpbiAndGxiX3N0YXRlJy4NCj4gMi4gSWYgdGhlIGRhdGEgaXMgcmVh
ZCBieSBvdGhlciBDUFVzLCBwdXQgaXQgaW4gJ3RsYl9zdGF0ZV9zaGFyZWQnLg0KPiANCj4gSSBh
Y3R1YWxseSBsaWtlIHRoZSBpZGVhIG9mIGhhdmluZyB0d28gc3RydWN0cy4NCg0KWWVzLCB0aGF0
4oCZcyBleGFjdGx5IHRoZSBpZGVhLiBJbiB0aGUgKDEpIGNhc2UsIHdlIG1heSBldmVuIGJlIGFi
bGUgdG8gbWFyaw0KdGhlIHN0cnVjdCB3aXRoIF9fdGhyZWFkIHF1YWxpZmllciwgd2hpY2ggSUlS
QyB3b3VsZCBwcmV2ZW50IG1lbW9yeSBiYXJyaWVycw0KZnJvbSBjYXVzaW5nIHRoZXNlIHZhbHVl
cyBiZWluZyByZXJlYWQu
