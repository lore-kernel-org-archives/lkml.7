Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5689FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35842166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RHES6ZLb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="kDqw/JeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfEQWXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:23:44 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:42466 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbfEQWXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:23:43 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 182C8C00DF;
        Fri, 17 May 2019 22:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558131812; bh=BYWfYHCGDXoKNdrxmjJOY01P58Cl6L/FqwgRGlJb6XE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RHES6ZLbx2z/h+HLrEKFQONq3ojzWFq8OlBA8XLoZq5+IM9DfIWomWx2vKUxgay6R
         AYp8LyNM7S1C3ip4nnxy6fMNOe8b8KTo9piDJT0U2lW3+hcgPOashYfxK2VKZgahRg
         ftctRxLoSxq1Yb5ywuR4ecScwXNh/zoZEBrhKz1QQpVl7EYEpSIJ5WIBvjCN10zghz
         5g3fkMGdk5c4xMAlwjWN9zywuk9HGj+0uLb0bPma/91dUhU/NHP3eD2siPtTe0ad6l
         9fyfPy7gQp8VcQnHlc6nC57TgWyk9mjPsDf4DSLLtZh+xCQzKjctpghPem/5keBldD
         VtKnP2VNJ+Y6w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3FD38A007F;
        Fri, 17 May 2019 22:23:42 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 May 2019 15:23:42 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 17 May 2019 15:23:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYWfYHCGDXoKNdrxmjJOY01P58Cl6L/FqwgRGlJb6XE=;
 b=kDqw/JeXcEHBYWX9U6sIaEbWw5xKfdKAOUPFM3OR+QL/ORsq/UjzEOxzOYKH1hImw2MfkDPWY121zq4Qdj0IX1fIgSwmXcSygjJiOfpERCzmW0yElIyYu0eAqMimlwrgeosLRCWxkQ40Kq6Nu2xamFwPg/DNOtrFUV7rYyT/C+k=
Received: from MWHPR12MB1632.namprd12.prod.outlook.com (10.172.56.21) by
 MWHPR12MB1789.namprd12.prod.outlook.com (10.175.55.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 22:23:40 +0000
Received: from MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6]) by MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6%2]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 22:23:40 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "paltsev@snyopsys.com" <paltsev@snyopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma access
 permission code
Thread-Topic: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma
 access permission code
Thread-Index: AQHVCrV7sukeR9XiU0qv5Rc2AMUmg6Zv6JSA
Date:   Fri, 17 May 2019 22:23:40 +0000
Message-ID: <1558131743.2682.33.camel@synopsys.com>
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
         <1557880176-24964-5-git-send-email-vgupta@synopsys.com>
         <1558027448.2682.11.camel@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA2307501A2517B16@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2517B16@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [5.18.205.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed7d8e9d-994c-4332-7031-08d6db165057
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR12MB1789;
x-ms-traffictypediagnostic: MWHPR12MB1789:
x-microsoft-antispam-prvs: <MWHPR12MB17892F96AC45E35CF0A3EB0FDE0B0@MWHPR12MB1789.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39850400004)(136003)(199004)(189003)(256004)(478600001)(6512007)(6246003)(71446004)(2906002)(446003)(229853002)(81156014)(25786009)(5660300002)(103116003)(4326008)(76176011)(6862004)(14454004)(6486002)(305945005)(7736002)(8676002)(99286004)(8936002)(102836004)(6436002)(6506007)(53546011)(11346002)(476003)(2616005)(66066001)(81166006)(86362001)(316002)(54906003)(66556008)(6636002)(68736007)(53936002)(64756008)(71200400001)(36756003)(3846002)(6116002)(66476007)(91956017)(37006003)(186003)(26005)(66446008)(73956011)(71190400001)(76116006)(66946007)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR12MB1789;H:MWHPR12MB1632.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rIqhhHc0BAydrvHlRqoGpSf5rkC5OaSmEzKjaQw9vK19Q/zVWkwDZwVkqNcC2IaB+nPVIw+2XPpZCcdPMI/YsOtA5x0qqUVZsIQh6ewjuPc4n1TLQQo0x+kHx6/TbSUZ/M/r06MVRXtsATnpN3JUDowNLGmoGerf3v8O4NL5V6VMEG0YR+fYRHpqkSw/ffxG+QNQSHvOV6LZNTYAG34UarTYWTyyupIg6IqwW11r7OuO2f7BlzHXfpcSeK7ZQeDfFRP6h3CV29Y9R2t+J2YRJXma76KN+/bcOdjsn/xA65s1y0lE8fMvWS3liUe1qZe3/lYYhgnuyaJWQxPpFXQub8qz83r5Uo3MD8b4CCNnR9czNNm9itbZvMYJ+DQ94shNajqHTvu4cp2Z+Zxx1LUelb543T3QI+yz2aWZZDiX2YU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED5BCD6560531E4FAC7578F40C955653@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7d8e9d-994c-4332-7031-08d6db165057
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 22:23:40.1443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1789
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SG1tbSwNCg0Kc28gbG9hZCB0aGUgYm9vbCB2YXJpYWJsZSBmcm9tIG1lbW9yeSBpcyBjb252ZXJ0
ZWQgdG8gc3VjaCBhc20gY29kZToNCg0KLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0t
LS0tLS0gDQpsZGIJcjIsW3NvbWVfYm9vbF9hZGRyZXNzXQ0KZXh0Yl9zCXIyLHIyDQotLS0tLS0t
LS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpDb3VsZCB5b3UgcGxlYXNlIGRlc2Ny
aWJlIHRoYXQgdGhlIG1hZ2ljIGlzIGdvaW5nIG9uIHRoZXJlPw0KDQpUaGlzIGV4dGJfcyBpbnN0
cnVjdGlvbiBsb29rcyBjb21wbGV0ZWx5IHVzZWxlc3MgaGVyZSwgYWNjb3JkaW5nIG9uIHRoZSBM
REIgZGVzY3JpcHRpb24gZnJvbSBQUk06DQotLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0t
LS0tLS0tLQ0KTEQgTERIIExEVyBMREIgTEREOg0KVGhlIHNpemUgb2YgdGhlIHJlcXVlc3RlZCBk
YXRhIGlzIHNwZWNpZmllZCBieSB0aGUgZGF0YSBzaXplIGZpZWxkIDwueno+IGFuZCBieSBkZWZh
dWx0LCBkYXRhIGlzIHplcm8NCmV4dGVuZGVkIGZyb20gdGhlIG1vc3Qtc2lnbmlmaWNhbnQgYml0
IG9mIHRoZSBkYXRhIHRvIHRoZSBtb3N0LXNpZ25pZmljYW50IGJpdCBvZiB0aGUgZGVzdGluYXRp
b24NCnJlZ2lzdGVyLg0KLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0NCg0K
QW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCg0KT24gVGh1LCAyMDE5LTA1LTE2IGF0IDE3OjM3ICsw
MDAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+IE9uIDUvMTYvMTkgMTA6MjQgQU0sIEV1Z2VuaXkg
UGFsdHNldiB3cm90ZToNCj4gPiA+ICsgICAgdW5zaWduZWQgaW50IHdyaXRlID0gMCwgZXhlYyA9
IDAsIG1hc2s7DQo+ID4gDQo+ID4gUHJvYmFibHkgaXQncyBiZXR0ZXIgdG8gdXNlICdib29sJyB0
eXBlIGZvciAnd3JpdGUnIGFuZCAnZXhlYycgYXMgd2UgcmVhbGx5IHVzZSB0aGVtIGFzIGEgYm9v
bGVhbiB2YXJpYWJsZXMuDQo+IA0KPiBSaWdodCB0aG9zZSBhcmUgc2VtYW50aWNzLCBidXQgdGhl
IGdlbmVyYXRlZCBjb2RlIGZvciAiYm9vbCIgaXMgbm90IGlkZWFsIC0gZ2l2ZW4NCj4gaXQgaXMg
aW5oZXJlbnRseSBhICJjaGFyIiBpdCBpcyBwcm9tb3RlZCBmaXJzdCB0byBhbiBpbnQgd2l0aCBh
biBhZGRpdGlvbmFsIEVYVEINCj4gd2hpY2ggSSByZWFsbHkgZGlzbGlrZS4NCj4gR3Vlc3MgaXQg
aXMgbW9yZSBvZiBhIHN0eWxlIHRoaW5nLg0KPiANCj4gLVZpbmVldA0KLS0gDQogRXVnZW5peSBQ
YWx0c2V2
