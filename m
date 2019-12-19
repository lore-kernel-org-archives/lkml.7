Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8DAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB9E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ijzysRJn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="hb22uj3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLSMfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:35:23 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:46432 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbfLSMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:35:23 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 032B6405CE;
        Thu, 19 Dec 2019 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1576758922; bh=q9nSCLKN+ybg3Iv5RrQnpSwQkN5PK6SW3QQlu+40y8Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ijzysRJnM3KoTw11JgnW/Lheka3u1nZvAzRtgPam42AWw6G6o0gFHBynITZJwOeYZ
         5sUS0G/o62LvfN7b5g3xuW7gp0q0/rFzZ9n/zZTMoeBJw6M+Da/X21C9j9hAO3wPE1
         Zow/7OV2mvJDhd1eNEVwJyLZFRS540jxz96N/FQLBLpR7w13Nm0uNPMcSinZibzbg/
         WEVHlh4YmqvaSmpH3D9DXFvHvkwrVxLBwKHPc2KOeyTumNIV/8hhKqM2u0GEt8aqfV
         COEOZQvItgYZ8FFaRQs9vJ3h7gSS/RnpNp5eXCTxL552SRny6sHEEyzH1yWWdHy9F+
         fiW9GMTtt0uxQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8175BA0067;
        Thu, 19 Dec 2019 12:35:19 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 19 Dec 2019 04:35:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 19 Dec 2019 04:35:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNqUnUo6nSGxU8c4DLIchKTSnNIv8Jbhy3+/+bvLpytaGGm8gycZbAZhP2IehVy9aSR71Sc+CylKA8Y+XJA5J7SJvesu89AkBkTQtmrqk0hP0qBp0XNZ0BLe+3Zcx/FDEtymU36bTdVtyYcM3fsC+mkyZlIqhF7AvmD9GgH+GoPq+C8G+OnMDQMUZHWnU14lTXdHoaSqc3y9yMsl6V5uqrdGa18ia1bW+k9KlFaav0VVuK91ggQjeYYI5m5jHoVYJyMZ966ES3QKD/o1ohyl2KiSWhPw7miOQI4fuYofMgHefeNzOxuSlBGNyd7IuK3o8smZIKJrIuXGa4IL3ZZpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9nSCLKN+ybg3Iv5RrQnpSwQkN5PK6SW3QQlu+40y8Q=;
 b=BCE6kdljgXiNS/cI8qTRbDr0HolzGKuMFt4Q0q/lcoCygvGb7ESZ0kCLwM6nfwhhDnmVs1JsvZz71p/ZshUChrt3gqhv/jC5atRcyHBpaQoIf+P8CyCp3yCoqNZf1vdiQ0TcU7Y/VN7wgADsks4v4ynpUVLSZYVpA0QhvEN+12rEntqyvTj0A9Awhy7Lygb1vbDUmg8+pizPrldnId3GiQbVr89f6mMk3hJI73pOi3E8QeF5mRlvJPQclm6NpNabXilEFjDnP6PGUSEYNOaofde/czUAyAkDt26nqLTEwbTHwSPOWFe0Juq37vJKoF792O3NVZQMf7oukQqB56rlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9nSCLKN+ybg3Iv5RrQnpSwQkN5PK6SW3QQlu+40y8Q=;
 b=hb22uj3EjAWXY4l0Nhj9Iq7fFW6fz6z4xI4inuxKB0JclDlFe4oBCoZ56hOO3r2jvIgDIC1selULcESeVrf1LqQc3MnLxb2FDDmgNZZ4Wsx5D2z357/hl1oPDxLB8hp2TNg8k79pqd8XanKWTSyxtTylziF1zq+m/h/vnRam9yA=
Received: from MN2PR12MB4093.namprd12.prod.outlook.com (52.135.51.203) by
 MN2PR12MB4160.namprd12.prod.outlook.com (10.255.125.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 12:34:59 +0000
Received: from MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::d0e:7272:4a88:ffeb]) by MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::d0e:7272:4a88:ffeb%5]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 12:34:59 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 1/2] usb: dwc2: Fix IN FIFO allocation
Thread-Topic: [PATCH 1/2] usb: dwc2: Fix IN FIFO allocation
Thread-Index: AQHVtmBmfU6CbvSImkS5xZoCE5ywbqfBZLEA
Date:   Thu, 19 Dec 2019 12:34:59 +0000
Message-ID: <69ae7364-391d-6075-27d8-7ed7c4aae2ff@synopsys.com>
References: <20191219113432.1229852-1-john@metanate.com>
In-Reply-To: <20191219113432.1229852-1-john@metanate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70f98fff-6926-43b6-f6e3-08d7847fdcb2
x-ms-traffictypediagnostic: MN2PR12MB4160:
x-microsoft-antispam-prvs: <MN2PR12MB41603F65379453B24489297DA7520@MN2PR12MB4160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(6506007)(53546011)(6916009)(26005)(36756003)(76116006)(31686004)(66946007)(66476007)(6486002)(478600001)(186003)(4326008)(8676002)(8936002)(31696002)(86362001)(81156014)(81166006)(2616005)(66446008)(91956017)(316002)(66556008)(64756008)(5660300002)(2906002)(71200400001)(54906003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB4160;H:MN2PR12MB4093.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMDta/CiIX8t47/Nw1RMlM8IBmGJfMt77xGE8M6hvNEL7nLzyMyLWXtnnpDM9D5uFuBX9BtwOY+rvyt1ZgpMaOrf2PnGBDuSns+MnL5Zn8wSWcZWnh7QsJqGJm4rkqlOD7nH8yri1zAhezGUXu8xFqIYDBiIorlyfGmDrLdZX1U+YAvXyyVq6v5wZDFwq+IJiBU3e3wxMZYJSQuKjmQah+iotc1lZleoYoksymDrrKAOhwhLx5xVYmji1U8OA1RHmHuMw9UBAl7vWTRSK3fzqmGxSTdTeTpN0GZb1BnPO1EKKbvJS9mN9jN85AvWkEY3VvpP94qvXFE1AuGL2U5pSAdW6n0Z4wM95aIKgJhKMIutiB+099QJf/afasgGK98NncDTWuA5HV4q6SZENYcimB4oDU/RVQgEdRHiBvlQBzRezf+wkghxC3Ncfsvtgw5O
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B924C74AF17F794BAA77285C93C9EFC6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f98fff-6926-43b6-f6e3-08d7847fdcb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 12:34:59.3319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYR3IguHrlotNSx9SQ9bnnmLRB18/SV8dJIjiyzjDOhfawb+4A60e74xOwdbHRDEFk4hPpaRe5c4IsRbWXzQbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9obiwNCg0KT24gMTIvMTkvMjAxOSAzOjM0IFBNLCBKb2huIEtlZXBpbmcgd3JvdGU6DQo+
IE9uIGNoaXBzIHdpdGggZmV3ZXIgRklGT3MgdGhhbiBlbmRwb2ludHMgKGZvciBleGFtcGxlIFJL
MzI4OCB3aGljaCBoYXMgOQ0KPiBlbmRwb2ludHMsIGJ1dCBvbmx5IDYgd2hpY2ggYXJlIGNhYmFi
bGUgb2YgaW5wdXQpLCB0aGUgRFBUWEZTSVpODQo+IHJlZ2lzdGVycyBhYm92ZSB0aGUgRklGTyBj
b3VudCBtYXkgcmV0dXJuIGludmFsaWQgdmFsdWVzLg0KPiANCg0KUkszMjg4IChyZXYuMi4yIE1h
ci4yMDE3KSBkYXRhYm9vayBzYXlzOg0KLSBTdXBwb3J0IHVwIHRvIDkgZGV2aWNlIG1vZGUgZW5k
cG9pbnRzIGluIGFkZGl0aW9uIHRvIGNvbnRyb2wgZW5kcG9pbnQgMA0KLSBTdXBwb3J0IHVwIHRv
IDYgZGV2aWNlIG1vZGUgSU4gZW5kcG9pbnRzIGluY2x1ZGluZyBjb250cm9sIGVuZHBvaW50IDAN
Ci0gRW5kcG9pbnRzIDEvMy81LzcgY2FuIGJlIHVzZWQgb25seSBhcyBkYXRhIElOIGVuZHBvaW50
DQotIEVuZHBvaW50cyAyLzQvNiBjYW4gYmUgdXNlZCBvbmx5IGFzIGRhdGEgT1VUIGVuZHBvaW50
DQotIEVuZHBvaW50cyA4LzkgY2FuIGJlIHVzZWQgYXMgZGF0YSBPVVQgYW5kIElOIGVuZHBvaW50
DQoNCjYgSU4gRVAncyAoaW5jbC5FUDApIG1lYW4gdGhhdCBUeEZJRk8gY291bnQgc2hvdWxkIGJl
IDUuIEZvciBFUDAgdXNpbmcgDQpOUFRYRklGTy4gT24gb3RoZXIgaGFuZCA2IEVQJ3MgMS8zLzUv
Ny84LzkgYXJlIElOIGVuZHBvaW50cy4NClNvbWV0aGluZyBub3QgY2xlYXIgdG8gbWUuIENvdWxk
IHlvdSBwbGVhc2UgcHJvdmlkZSBtZSB5b3VyIEhTT1RHIGNvcmUncyANCkdIV0NGRzEtNCByZWdp
c3RlcnMgdmFsdWVzLg0KQW5kL09yIHByb3ZpZGUgbWUgbmV3ZXIgZGF0YWJvb2suDQoNCk9uZSBt
b3JlIHN0dWZmLiBZb3UgZGlkbid0IHNlbmQgcGF0Y2ggc2VyaWVzIGNvdmVyIGxldHRlciAoW1BB
VENIIDAvMl0pIA0Kb3IgSSBkaWRuJ3QgcmVjZWl2ZWQgaXQ/DQoNClRoYW5rcywNCk1pbmFzDQoN
Cg0KPiBXaXRoIGxvZ2dpbmcgYWRkZWQgb24gc3RhcnR1cCwgSSBzZWU6DQo+IA0KPiAJZHdjMiBm
ZjU4MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD0xIHN6PTI1Ng0KPiAJZHdjMiBm
ZjU4MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD0yIHN6PTEyOA0KPiAJZHdjMiBm
ZjU4MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD0zIHN6PTEyOA0KPiAJZHdjMiBm
ZjU4MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD00IHN6PTY0DQo+IAlkd2MyIGZm
NTgwMDAwLnVzYjogZHdjMl9oc290Z19pbml0X2ZpZm86IGVwPTUgc3o9NjQNCj4gCWR3YzIgZmY1
ODAwMDAudXNiOiBkd2MyX2hzb3RnX2luaXRfZmlmbzogZXA9NiBzej0zMg0KPiAJZHdjMiBmZjU4
MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD03IHN6PTANCj4gCWR3YzIgZmY1ODAw
MDAudXNiOiBkd2MyX2hzb3RnX2luaXRfZmlmbzogZXA9OCBzej0wDQo+IAlkd2MyIGZmNTgwMDAw
LnVzYjogZHdjMl9oc290Z19pbml0X2ZpZm86IGVwPTkgc3o9MA0KPiAJZHdjMiBmZjU4MDAwMC51
c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD0xMCBzej0wDQo+IAlkd2MyIGZmNTgwMDAwLnVz
YjogZHdjMl9oc290Z19pbml0X2ZpZm86IGVwPTExIHN6PTANCj4gCWR3YzIgZmY1ODAwMDAudXNi
OiBkd2MyX2hzb3RnX2luaXRfZmlmbzogZXA9MTIgc3o9MA0KPiAJZHdjMiBmZjU4MDAwMC51c2I6
IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD0xMyBzej0wDQo+IAlkd2MyIGZmNTgwMDAwLnVzYjog
ZHdjMl9oc290Z19pbml0X2ZpZm86IGVwPTE0IHN6PTANCj4gCWR3YzIgZmY1ODAwMDAudXNiOiBk
d2MyX2hzb3RnX2luaXRfZmlmbzogZXA9MTUgc3o9MA0KPiANCj4gYnV0Og0KPiANCj4gCSMgY2F0
IC9zeXMva2VybmVsL2RlYnVnL2ZmNTgwMDAwLnVzYi9maWZvDQo+IAlOb24tcGVyaW9kaWMgRklG
T3M6DQo+IAlSWEZJRk86IFNpemUgMjc1DQo+IAlOUFRYRklGTzogU2l6ZSAxNiwgU3RhcnQgMHgw
MDAwMDExMw0KPiANCj4gCVBlcmlvZGljIFRYRklGT3M6DQo+IAkJRFBUWEZJRk8gMTogU2l6ZSAy
NTYsIFN0YXJ0IDB4MDAwMDAxMjMNCj4gCQlEUFRYRklGTyAyOiBTaXplIDEyOCwgU3RhcnQgMHgw
MDAwMDIyMw0KPiAJCURQVFhGSUZPIDM6IFNpemUgMTI4LCBTdGFydCAweDAwMDAwMmEzDQo+IAkJ
RFBUWEZJRk8gNDogU2l6ZSA2NCwgU3RhcnQgMHgwMDAwMDMyMw0KPiAJCURQVFhGSUZPIDU6IFNp
emUgNjQsIFN0YXJ0IDB4MDAwMDAzNjMNCj4gCQlEUFRYRklGTyA2OiBTaXplIDMyLCBTdGFydCAw
eDAwMDAwM2EzDQo+IAkJRFBUWEZJRk8gNzogU2l6ZSAwLCBTdGFydCAweDAwMDAwM2UzDQo+IAkJ
RFBUWEZJRk8gODogU2l6ZSAwLCBTdGFydCAweDAwMDAwM2EzDQo+IAkJRFBUWEZJRk8gOTogU2l6
ZSAyNTYsIFN0YXJ0IDB4MDAwMDAxMjMNCj4gDQo+IHNvIGl0IHNlZW1zIHRoYXQgRklGTyA5IGlz
IG1pcnJvcmluZyBGSUZPIDEuDQo+IA0KPiBGaXggdGhlIGFsbG9jYXRpb24gYnkgdXNpbmcgdGhl
IEZJRk8gY291bnQgaW5zdGVhZCBvZiB0aGUgZW5kcG9pbnQgY291bnQNCj4gd2hlbiBzZWxlY3Rp
bmcgYSBGSUZPIGZvciBhbiBlbmRwb2ludC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gS2Vl
cGluZyA8am9obkBtZXRhbmF0ZS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvZ2Fk
Z2V0LmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIGIv
ZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRleCA5MmU4ZGU5Y2I0NWMuLjkxMWI5NTBl
ZjI1ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC00MDU5LDExICs0MDU5LDEyIEBAIHN0YXRp
YyBpbnQgZHdjMl9oc290Z19lcF9lbmFibGUoc3RydWN0IHVzYl9lcCAqZXAsDQo+ICAgCSAqIGEg
dW5pcXVlIHR4LWZpZm8gZXZlbiBpZiBpdCBpcyBub24tcGVyaW9kaWMuDQo+ICAgCSAqLw0KPiAg
IAlpZiAoZGlyX2luICYmIGhzb3RnLT5kZWRpY2F0ZWRfZmlmb3MpIHsNCj4gKwkJdW5zaWduZWQg
Zmlmb19jb3VudCA9IGR3YzJfaHNvdGdfdHhfZmlmb19jb3VudChoc290Zyk7DQo+ICAgCQl1MzIg
Zmlmb19pbmRleCA9IDA7DQo+ICAgCQl1MzIgZmlmb19zaXplID0gVUlOVF9NQVg7DQo+ICAgDQo+
ICAgCQlzaXplID0gaHNfZXAtPmVwLm1heHBhY2tldCAqIGhzX2VwLT5tYzsNCj4gLQkJZm9yIChp
ID0gMTsgaSA8IGhzb3RnLT5udW1fb2ZfZXBzOyArK2kpIHsNCj4gKwkJZm9yIChpID0gMTsgaSA8
PSBmaWZvX2NvdW50OyArK2kpIHsNCj4gICAJCQlpZiAoaHNvdGctPmZpZm9fbWFwICYgKDEgPDwg
aSkpDQo+ICAgCQkJCWNvbnRpbnVlOw0KPiAgIAkJCXZhbCA9IGR3YzJfcmVhZGwoaHNvdGcsIERQ
VFhGU0laTihpKSk7DQo+IA0K
