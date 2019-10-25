Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3F8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A99B20867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fpitMjVT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="izn9q9ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392917AbfJYFaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 01:30:39 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:38828 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392384AbfJYFai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:30:38 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 491C8C04D9;
        Fri, 25 Oct 2019 05:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571981436; bh=w9YNDAZdHJ+lnoBukS9U1beFiRuAEhgRyt2+jqtNg2g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fpitMjVTpKDiumsKWEHcbophlhN1+0F/GdMY+JIbAy03gQhBFUO3N2Bcvq6xN70vW
         rYSrylITIjOc2DOGii+Wuw3NX5XA69RiTX61ple38xbqddTctIdd0myYBiHrBYhVvt
         vxZKSDX2RkgkxcERBenJWb4OnurR2GgMSaKTIpXPUu0dA8ZF8H0nkz9Kja8SfB5pk5
         JxwUKy4hKT+XUnsqXBY58pnPTKxTgb20vssWJSXAmA22m+PP4nI5KrSH2xgYqMKjq0
         Z4VXjQSz7orN94tJYb009T3elx3bHECQKv40JG5+sGbE54YvZgfKGRFe02DKgDVklv
         whYxLQEY5RIJg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7EBE1A0079;
        Fri, 25 Oct 2019 05:30:35 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Oct 2019 22:29:49 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 24 Oct 2019 22:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/eQh8KJO3S6Hy7Ig1LoUKabb3wuKHTE3b+59Ke6+QbxNSoucNlP8u+NPYJDwenuH5neNDnF5NTjrNFqBL/BxDFHxSh1s1inFMYiTkEyXmdcLBQAx1ES8BesdFuaiRdfNfjyAyo/0UocgHLeAOs8aEX994MF/nbrDctLN0jUAz2iopWIVXT2JN2HlPyk8kS88LjQ12IjaH+EDdYAKFUi90WZSwFJ7HP8H77Yws0ddN/o6Ojx1SahcH4e922opqX1xdkPIGoOEA7GH5O852+EU2dm79H8Ijhw/fSCk9o6q+bAiT5psexzYn8Gxavo6TI0nyvroNdEXRxscOSdip6a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9YNDAZdHJ+lnoBukS9U1beFiRuAEhgRyt2+jqtNg2g=;
 b=C3VRA2/Kn3BlGedd2gMMMESv7pQbL4DHQPuQg5sfj9dyKoq9dvEAxq/OGtMYtE96R+IuBfRhOydsmmiN34skfWZvKo5V+bBVsUjpJvde8JeHiUmcPLyv9vUDuVSZUN1k2mIR8x73Tz7Y6kCyzYlN2e0dQOTrqgt0JTVyh549R/pDwqeVqMgNV1KqBz9uKz5/JWYx+xOJb/knysy5rEr5rYwdqFm/5ruIC9p29+295layuqVz1qfUU6AGmIOMXKt8nBsfvEI4xt0PJNMxxKk3wbl8qoG3m9K+dVp1R7egxAnk+Gc/RLeoySuEGxzL3nwT5JL/XisF8sZnPypQLhmVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9YNDAZdHJ+lnoBukS9U1beFiRuAEhgRyt2+jqtNg2g=;
 b=izn9q9veMwBemMpuJIeFrCT0q4WPYPYCTd44c3AXD+fBy4Z+SQC0zq6UOzWqMHpStyG02q+UynReQHVRW2VezqkZaPriRCAPtMi5gzMoWsrxnjQl5iJMsobPV060mjuejF2OVHrTL57nXwK+SMVbCbNIfJak/b4u2GguhHBPRYo=
Received: from MN2PR12MB4093.namprd12.prod.outlook.com (52.135.51.203) by
 MN2PR12MB3150.namprd12.prod.outlook.com (20.178.241.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 05:30:18 +0000
Received: from MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::85e4:7eb9:af8d:8a9]) by MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::85e4:7eb9:af8d:8a9%3]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 05:30:18 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Bin Liu <b-liu@ti.com>, Jiri Kosina <trivial@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH trivial] usb: Spelling s/enpoint/endpoint/
Thread-Topic: [PATCH trivial] usb: Spelling s/enpoint/endpoint/
Thread-Index: AQHVin/SMejy29PKK0advY8hwcY1/adq1ZGA
Date:   Fri, 25 Oct 2019 05:30:18 +0000
Message-ID: <aa4cfba1-45de-a646-adde-3eedc8c2341e@synopsys.com>
References: <20191024152833.30698-1-geert+renesas@glider.be>
In-Reply-To: <20191024152833.30698-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [2.18.65.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61e7bc0a-37a8-4591-49f2-08d7590c6c33
x-ms-traffictypediagnostic: MN2PR12MB3150:
x-microsoft-antispam-prvs: <MN2PR12MB31506476BF3D3E1494D9468DA7650@MN2PR12MB3150.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(2616005)(76116006)(2906002)(4326008)(26005)(8936002)(316002)(14444005)(81156014)(110136005)(256004)(8676002)(66476007)(66946007)(64756008)(91956017)(31696002)(476003)(58126008)(478600001)(66556008)(65956001)(65806001)(66446008)(102836004)(54906003)(11346002)(14454004)(36756003)(186003)(53546011)(486006)(6116002)(3846002)(71200400001)(71190400001)(25786009)(5660300002)(81166006)(229853002)(99286004)(6512007)(31686004)(6436002)(66066001)(6486002)(86362001)(7736002)(6246003)(76176011)(446003)(305945005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB3150;H:MN2PR12MB4093.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjeyoBUwW7y/+tTZlNundP4HbCD+CDSvk8XXC3mO9ojmsluUtj8m0yXUvmh8Y2aVlC65oLcqNr3qLeb7Oq0J38ix3DZSR4lcmfctIfW9Y5Zg3xalZ7L7jS676m+L5HaGseSpmCWpNASa4OOL4ClOb4BNwn+AtDecB6Pf9VjQNAYNFSS/L9c/gve9cNDOahtqwYwxuWGttorn8t8LIYoUL1DE/H3MXFQLTHoTlVGeZRwQUuysujnY6DKjl0GivZO4YLst8nweco2O/yPenB+3if3pOvTQ1CRK7fe2aBV9B004yFIJf6dTIX5i7h1NHxtFt5SqH//WuSPGji0pJ99HAqBVsyyFCt5D8HaFpIfD05aDj/70R4dfjUNT0Mas6xiqK1Nu7rsiZPsvtzKjE5fRqmCpE1UR9POtvj4fs6TEe2cx2s/OsX8xo3t1DmemtcOC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <69ED6765E5239746AD05322D69345781@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e7bc0a-37a8-4591-49f2-08d7590c6c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 05:30:18.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bY3f2KcQKWfhqm5CnURwu6tEffQAaWPWWBoNUmLzRlCQFpOcIuB3V9INFH5zYIJzkDONQ7duzt5eDXOLLvVXRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI0LzIwMTkgNzoyOCBQTSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBG
aXggbWlzc3BlbGxpbmdzIG9mICJlbmRwb2ludCIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KDQpBY2tlZC1ieTogTWlu
YXMgSGFydXR5dW55YW4gPGhtaW5hc0BzeW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVy
cy91c2IvZHdjMi9jb3JlLmggICAgICAgICAgICAgfCAyICstDQo+ICAgZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9mc2xfcWVfdWRjLmggfCA0ICsrLS0NCj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L212X3UzZC5oICAgICB8IDIgKy0NCj4gICBkcml2ZXJzL3VzYi9tdXNiL211c2JfZ2FkZ2V0LmMg
ICAgICB8IDIgKy0NCj4gICA0IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuaCBiL2Ry
aXZlcnMvdXNiL2R3YzIvY29yZS5oDQo+IGluZGV4IGQwOGQwNzBhMGZiNmY1OTguLjk2OGUwM2I4
OWQwNGQ1ZDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvY29yZS5oDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzIvY29yZS5oDQo+IEBAIC0xMzQsNyArMTM0LDcgQEAgc3RydWN0IGR3
YzJfaHNvdGdfcmVxOw0KPiAgICAqIEB0YXJnZXRfZnJhbWU6IFRhcmdldGVkIGZyYW1lIG51bSB0
byBzZXR1cCBuZXh0IElTT0MgdHJhbnNmZXINCj4gICAgKiBAZnJhbWVfb3ZlcnJ1bjogSW5kaWNh
dGVzIFNPRiBudW1iZXIgb3ZlcnJ1biBpbiBEU1RTDQo+ICAgICoNCj4gLSAqIFRoaXMgaXMgdGhl
IGRyaXZlcidzIHN0YXRlIGZvciBlYWNoIHJlZ2lzdGVyZWQgZW5wb2ludCwgYWxsb3dpbmcgaXQN
Cj4gKyAqIFRoaXMgaXMgdGhlIGRyaXZlcidzIHN0YXRlIGZvciBlYWNoIHJlZ2lzdGVyZWQgZW5k
cG9pbnQsIGFsbG93aW5nIGl0DQo+ICAgICogdG8ga2VlcCB0cmFjayBvZiB0cmFuc2FjdGlvbnMg
dGhhdCBuZWVkIGRvaW5nLiBFYWNoIGVuZHBvaW50IGhhcyBhDQo+ICAgICogbG9jayB0byBwcm90
ZWN0IHRoZSBzdGF0ZSwgdG8gdHJ5IGFuZCBhdm9pZCB1c2luZyBhbiBvdmVyYWxsIGxvY2sNCj4g
ICAgKiBmb3IgdGhlIGhvc3QgY29udHJvbGxlciBhcyBtdWNoIGFzIHBvc3NpYmxlLg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9mc2xfcWVfdWRjLmggYi9kcml2ZXJzL3Vz
Yi9nYWRnZXQvdWRjL2ZzbF9xZV91ZGMuaA0KPiBpbmRleCAyYzUzN2E5MDRlZTczOTUwLi41M2Nh
MGZmN2MyY2JkNDhjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2ZzbF9x
ZV91ZGMuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2ZzbF9xZV91ZGMuaA0KPiBA
QCAtMzMzLDggKzMzMyw4IEBAIHN0cnVjdCBxZV91ZGMgew0KPiAgIAl1MzIgcmVzdW1lX3N0YXRl
OyAgICAgICAvKiBVU0Igc3RhdGUgdG8gcmVzdW1lKi8NCj4gICAJdTMyIHVzYl9zdGF0ZTsgICAg
ICAgICAgLyogVVNCIGN1cnJlbnQgc3RhdGUgKi8NCj4gICAJdTMyIHVzYl9uZXh0X3N0YXRlOyAg
ICAgLyogVVNCIG5leHQgc3RhdGUgKi8NCj4gLQl1MzIgZXAwX3N0YXRlOyAgICAgICAgICAvKiBF
bnBvaW50IHplcm8gc3RhdGUgKi8NCj4gLQl1MzIgZXAwX2RpcjsgICAgICAgICAgICAvKiBFbnBv
aW50IHplcm8gZGlyZWN0aW9uOiBjYW4gYmUNCj4gKwl1MzIgZXAwX3N0YXRlOyAgICAgICAgICAv
KiBFbmRwb2ludCB6ZXJvIHN0YXRlICovDQo+ICsJdTMyIGVwMF9kaXI7ICAgICAgICAgICAgLyog
RW5kcG9pbnQgemVybyBkaXJlY3Rpb246IGNhbiBiZQ0KPiAgIAkJCQlVU0JfRElSX0lOIG9yIFVT
Ql9ESVJfT1VUKi8NCj4gICAJdTMyIHVzYl9zb2ZfY291bnQ7ICAgICAgLyogU09GIGNvdW50ICov
DQo+ICAgCXUzMiBlcnJvcnM7ICAgICAgICAgICAgIC8qIFVTQiBFUlJPUnMgY291bnQgKi8NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvbXZfdTNkLmggYi9kcml2ZXJzL3Vz
Yi9nYWRnZXQvdWRjL212X3UzZC5oDQo+IGluZGV4IDk4MjYyNWI3MTk3YTBkOWMuLjY2Yjg0Zjc5
MmY2NDZiYjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvbXZfdTNkLmgN
Cj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9tdl91M2QuaA0KPiBAQCAtMTM4LDcgKzEz
OCw3IEBAIHN0cnVjdCBtdl91M2Rfb3BfcmVncyB7DQo+ICAgCXUzMglkb29yYmVsbDsJLyogZG9v
cmJlbGwgcmVnaXN0ZXIgKi8NCj4gICB9Ow0KPiAgIA0KPiAtLyogY29udHJvbCBlbnBvaW50IGVu
YWJsZSByZWdpc3RlcnMgKi8NCj4gKy8qIGNvbnRyb2wgZW5kcG9pbnQgZW5hYmxlIHJlZ2lzdGVy
cyAqLw0KPiAgIHN0cnVjdCBlcHhjciB7DQo+ICAgCXUzMgllcHhvdXRjcjA7CS8qIGVwIG91dCBj
b250cm9sIDAgcmVnaXN0ZXIgKi8NCj4gICAJdTMyCWVweG91dGNyMTsJLyogZXAgb3V0IGNvbnRy
b2wgMSByZWdpc3RlciAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXVzYi9tdXNiX2dh
ZGdldC5jIGIvZHJpdmVycy91c2IvbXVzYi9tdXNiX2dhZGdldC5jDQo+IGluZGV4IDJjYjMxZmMw
Y2Q2MDFlYjQuLmY2MmZmYWVkZTFhYmJhNDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL211
c2IvbXVzYl9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9tdXNiL211c2JfZ2FkZ2V0LmMN
Cj4gQEAgLTEzMTUsNyArMTMxNSw3IEBAIHN0YXRpYyBpbnQgbXVzYl9nYWRnZXRfZGVxdWV1ZShz
dHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXF1ZXN0KQ0KPiAgIH0NCj4g
ICANCj4gICAvKg0KPiAtICogU2V0IG9yIGNsZWFyIHRoZSBoYWx0IGJpdCBvZiBhbiBlbmRwb2lu
dC4gQSBoYWx0ZWQgZW5wb2ludCB3b24ndCB0eC9yeCBhbnkNCj4gKyAqIFNldCBvciBjbGVhciB0
aGUgaGFsdCBiaXQgb2YgYW4gZW5kcG9pbnQuIEEgaGFsdGVkIGVuZHBvaW50IHdvbid0IHR4L3J4
IGFueQ0KPiAgICAqIGRhdGEgYnV0IHdpbGwgcXVldWUgcmVxdWVzdHMuDQo+ICAgICoNCj4gICAg
KiBleHBvcnRlZCB0byBlcDAgY29kZQ0KPiANCg==
