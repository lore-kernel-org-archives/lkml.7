Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A3EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A50E206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ImSv3KTs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="NEHzlD/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNUMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:12:39 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:48608 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbfKNUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:12:38 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F3EEBC04C9;
        Thu, 14 Nov 2019 20:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573762356; bh=9YtbGWlhrjecsGYrx3DdzZRC0wXbsG4LgQv0XmXRlDw=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=ImSv3KTsLK7fpUjvYPJchb4TXHYEvOvqa2Dd2lYmWK9VR3LLSiItLK1Pob4NAwq1F
         WxKcUXqm7Z+kOr8URR+q8Ca8g9nLee+IAcBYVKNbog9Ut6Nwp4TEzhzL2PwVXuhdiN
         uNEyw4uPAUJf/7dWm6655H2E6Kz68bhwr7BZ2T1p5qu0ep8EyAjaz2V4BaElz4dinc
         FeGL1+W2gCONSCsXj263AQejDPc57CqxWWeSr1fMyGNwGjqYNq0tt570+h402nGoV0
         /BmUrZpJrmqX8tjL5oMrFnP9sCvyrlhNy97/XqdwWet58Ba5ICLCgy9Oxk4WK8StPr
         kvzMlySqCp0WQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 933CEA0079;
        Thu, 14 Nov 2019 20:12:34 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Nov 2019 12:12:32 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 14 Nov 2019 12:12:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgQYD7ddkwp6fEPVC8pYSRt895VLywQhNTs01odjhN/QehWISdKn+8TlPUFqBOdPIm8LRxBnb5blOfXyAsnqbRMse5OPEN7KWT7HW4sOlaH0dSYOqaS7Hz2gb4vK9H1Z+Gbr8cbsFRR69F0yX5XcEI8w3TAibr3KEw6tKp6IngW+940t6+lL+Ty33rmcUI+tndyfBBGYUo9CLvNMmk7BgKLgA21BDjYW1fCAcQgKyQiB0YP/f1zJbC9Rv2nwYM6U5S3cZBidDAE0b/ZdGvWI0bB9E1xGp5M6B6tV+kLrJYCYxNEzAFE78RCAz1J+XmJI0SI1dnz7l2fpWQ+WrqjRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YtbGWlhrjecsGYrx3DdzZRC0wXbsG4LgQv0XmXRlDw=;
 b=AeODpqXDHx3TLwnlBVJ45Idlc0cuKwsXIYRYkDFmPsBJiKeit2xCznmOSlltPbjjF6i7H7CrykPZ8oeWTvkqP/ywMVllly9p5ayiM2aJOBOcquAyB4s5irH9QsU6es392Mc80PHePYO7HFfJobvIXjGJNnpomuclnJRYUC6zsznNk8jcR5+NCqRHNBb/f+hln22JV7lfs9zR0PCd9ZvhV45bNLnHbaR/2bKaEdc439lB4UUPmHaFOdpXHAjme6b71xArSfFTSrxnJbTg0W5LQQyfQNCmki+YO0nqw/5g6/F1UDIqr6Bkpzg+oOMP7asWXjfY55qNrMmHvjxDdkL3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YtbGWlhrjecsGYrx3DdzZRC0wXbsG4LgQv0XmXRlDw=;
 b=NEHzlD/NOwBKfT6jd1fgceqE1Aj3Lfs/uPEhG0EamNlhwdshQ5YWA2Nr+A2KpBcR3Vnh3Cip7fKQ4t7JAbRmlhA6VB+l4C0gKuAhMXOzejGnSR8pcfl1hM+TkZddmQKRs/B0CnJJVsbvHZpsngG3SkwTDCTV8h03JTmDCQgRSpo=
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com (10.172.78.22) by
 CY4PR1201MB0021.namprd12.prod.outlook.com (10.172.77.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 20:11:57 +0000
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3]) by CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3%4]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 20:11:57 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Thread-Index: AQHVmKSAwOKFEHeaw0mottJUNN0pEqeIevUAgABCiACAAII+gIAAPESAgAEc0ACAAIVuAA==
Date:   Thu, 14 Nov 2019 20:11:56 +0000
Message-ID: <6d4b87c8-5aca-18cb-81db-a8d2fd4bd86e@synopsys.com>
References: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
 <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
 <20191114121422.qtvyom6nytzwoy2e@pengutronix.de>
In-Reply-To: <20191114121422.qtvyom6nytzwoy2e@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50f5afbe-f3a6-4f22-2f43-08d7693ee677
x-ms-traffictypediagnostic: CY4PR1201MB0021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0021E4D82A86643F178357B6AA710@CY4PR1201MB0021.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(39860400002)(346002)(189003)(199004)(99286004)(66556008)(446003)(316002)(64756008)(8936002)(5660300002)(76176011)(66446008)(86362001)(11346002)(6512007)(6486002)(66476007)(81166006)(81156014)(76116006)(6506007)(8676002)(91956017)(25786009)(66946007)(2906002)(71190400001)(71200400001)(186003)(31686004)(478600001)(14454004)(14444005)(256004)(6436002)(110136005)(7736002)(305945005)(2616005)(229853002)(26005)(2201001)(2171002)(102836004)(31696002)(6116002)(476003)(3846002)(2501003)(66066001)(6246003)(36756003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0021;H:CY4PR1201MB0037.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bV/LAL8ym2TKFWbn+SsayQrWYnTT1EN5pLmXBLX0baU9pnxB187SSlCXahH4UTLpMH5JUpngHuc55VhtdvxBoSIX9darzbsLdH2Vq9oui+TKryXobX/BIAdTlwLZwO6zRxQnl5as2bzKzU1ouQXQ7zgoX0I6vp5WebxLJ7PL4HS+7Nnp7gyWm00mHVCQVd0KaFFdWat8gl8xNsDbZAx8QnZUEAKHQ/X0f2sxmLiq1hnfrA2UmtaaoLQh4dcP3T49h+m2GC9fVAkJOa17KO6gHKZpZnghOogqk3gvWhTcX3SoKPvpV4wQebR36ZnOzXRHP0lGeTmM6JKkT8DMzgzbmBUgkuKjPxGiHl9WuivuUpPgzpO5IL63qFfpsPGr2ex2kuSET/GS8twpjE8HUkOI66FuipAcKSwo7E65VmDdXrDRkG7nz0g0X3tCWj6AhHt
Content-Type: text/plain; charset="utf-8"
Content-ID: <980C3DF329E7224E9A6972C604E65FD0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f5afbe-f3a6-4f22-2f43-08d7693ee677
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 20:11:56.9934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1W27ulyDbjDisFjmyeAmwz/NhVVSSiKiGsfhwnbgQO7QvK6bdyTrca/N/ibieWXltJTRZPOm9SUbP0Uo2VB4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0021
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWljaGFlbCBPbGJyaWNoIHdyb3RlOg0KPiBPbiBXZWQsIE5vdiAxMywgMjAxOSBhdCAwNzoxNDo1
OVBNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBBbGFuIFN0ZXJuIHdyb3RlOg0KPj4+
IE9uIFdlZCwgMTMgTm92IDIwMTksIE1pY2hhZWwgT2xicmljaCB3cm90ZToNCj4+Pj4gT24gV2Vk
LCBOb3YgMTMsIDIwMTkgYXQgMDM6NTU6MDFBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
Pj4+Pj4gTWljaGFlbCBPbGJyaWNoIHdyb3RlOg0KPj4+Pj4+IEN1cnJlbnRseSwgbW9zdCBnYWRn
ZXQgZHJpdmVycyBoYW5kbGUgaXNvYyB0cmFuc2ZlcnMgb24gYSBiZXN0IGVmZm9ydA0KPj4+Pj4+
IGJhc2VzOiBJZiB0aGUgcmVxdWVzdCBxdWV1ZSBydW5zIGVtcHR5LCB0aGVuIHRoZXJlIHdpbGwg
c2ltcGx5IGJlIGdhcHMgaW4NCj4+Pj4+PiB0aGUgaXNvYyBkYXRhIHN0cmVhbS4NCj4+Pj4+Pg0K
Pj4+Pj4+IFRoZSBVVkMgZ2FkZ2V0IGRlcGVuZHMgb24gdGhpcyBiZWhhdmlvdXIuIEl0IHNpbXBs
eSBwcm92aWRlcyBuZXcgcmVxdWVzdHMNCj4+Pj4+PiB3aGVuIHZpZGVvIGZyYW1lcyBhcmUgYXZh
aWxhYmxlIGFuZCBhc3N1bWVzIHRoYXQgdGhleSBhcmUgc2VudCBhcyBzb29uIGFzDQo+Pj4+Pj4g
cG9zc2libGUuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgZHdjMyBnYWRnZXQgY3VycmVudGx5IHdvcmtz
IGRpZmZlcmVudGx5OiBJdCBhc3N1bWVzIHRoYXQgdGhlcmUgaXMgYQ0KPj4+Pj4+IGNvbnRpZ3Vv
dXMgc3RyZWFtIG9mIHJlcXVlc3RzIHdpdGhvdXQgYW55IGdhcHMuIElmIGEgcmVxdWVzdCBpcyB0
b28gbGF0ZSwNCj4+Pj4+PiB0aGVuIGl0IGlzIGRyb3BwZWQgYnkgdGhlIGhhcmR3YXJlLg0KPj4+
Pj4+IEZvciB0aGUgVVZDIGdhZGdldCB0aGlzIG1lYW5zIHRoYXQgYSBsaXZlIHN0cmVhbSBzdG9w
cyBhZnRlciB0aGUgZmlyc3QNCj4+Pj4+PiBmcmFtZSBiZWNhdXNlIGFsbCBmb2xsb3dpbmcgcmVx
dWVzdHMgYXJlIGxhdGUuDQo+Pj4+PiBDYW4geW91IGV4cGxhaW4gbGl0dGxlIG1vcmUgaG93IFVW
QyBnYWRnZXQgZmFpbHM/DQo+Pj4+PiBkd2MzIGNvbnRyb2xsZXIgZXhwZWN0cyBhIHN0ZWFkeSBz
dHJlYW0gb2YgZGF0YSBvdGhlcndpc2UgaXQgd2lsbCByZXN1bHQNCj4+Pj4+IGluIG1pc3NlZF9p
c29jIHN0YXR1cywgYW5kIGl0IHNob3VsZCBiZSBmaW5lIGFzIGxvbmcgYXMgbmV3IHJlcXVlc3Rz
IGFyZQ0KPj4+Pj4gcXVldWVkLiBUaGUgY29udHJvbGxlciBkb2Vzbid0IGp1c3QgZHJvcCB0aGUg
cmVxdWVzdCB1bmxlc3MgdGhlcmUncyBzb21lDQo+Pj4+PiBvdGhlciBmYWlsdXJlLg0KPj4+PiBV
VkMgKHdpdGggYSBsaXZlIHN0cmVhbSkgZG9lcyBub3QgZmlsbCB0aGUgY29tcGxldGUgYmFuZHdp
ZHRoIG9mIGFuDQo+Pj4+IGlzb2Nocm9ub3VzIGVuZHBvaW50LiBMZXQncyBhc3N1bWUgZm9yIHRo
ZSBleGFtcGxlIHRoYXQgb25lIHZpZGVvIGZyYW1lDQo+Pj4+IGZpbGxzIDMgcmVxdWVzdHMuIEJl
Y2F1c2UgaXQgaXMgYSBsaXZlIHN0cmVhbSwgdGhlcmUgd2lsbCBiZSBhIGdhcCBiZXR3ZWVuDQo+
Pj4+IHZpZGVvIGZyYW1lcy4gVGhpcyBpcyB1bmF2b2lkYWJsZSwgZXNwZWNpYWxseSBmb3IgY29t
cHJlc3NlZCB2aWRlby4gU28gdGhlDQo+Pj4+IFVWQyBnYWRnZXQgd2lsbCBoYXZlIHJlcXVlc3Rz
IGZvciB0aGUgZnJhbWUgbnVtYmVycyAxIDIgMyA1IDYgNyA5IDEwIDExIDEzIDE0DQo+Pj4+IDE1
IGFuZCBzbyBvbi4NCj4+Pj4gVGhlIGR3YzMgaGFyZHdhcmUgdHJpZXMgdG8gc2VuZCB0aG9zZSB3
aXRoIGZyYW1lIG51bWJlcnMgMSAyIDMgNCA1IDYgNyA4IDkNCj4+Pj4gMTAgMTEgMTIuIFNvIGV4
Y2VwdCBmb3IgdGhlIGZpc3QgZmV3IHJlcXVlc3RzLCBhbGwgYXJlIGxhdGUgYW5kIHJlc3VsdCBp
biBhDQo+Pj4+IG1pc3NlZF9pc29jLiBJIHRyaWVkIHRvIGp1c3QgaWdub3JlIHRoZSBtaXNzZWRf
aXNvYyBidXQgdGhhdCBkaWQgbm90IHdvcmsNCj4+Pj4gZm9yIG1lLiBJIG9ubHkgcmVjZWl2ZWQg
dGhlIGZpcnN0IGZyYW1lIGF0IHRoZSBvdGhlciBlbmQuDQo+Pj4+IE1heWJlIEkgbWlzc2luZyBz
b21ldGhpbmcgaGVyZSwgaSBkb24ndCBoYXZlIGFjY2VzcyB0byB0aGUgaGFyZHdhcmUNCj4+Pj4g
ZG9jdW1lbnRhdGlvbiwgc28gSSBjYW4gb25seSBndWVzcyBmcm9tIHRoZSBleGlzdGluZyBkcml2
ZXIuDQo+PiBUaGUgcmVhc29uIEkgYXNrZWQgaXMgYmVjYXVzZSB5b3VyIHBhdGNoIGRvZXNuJ3Qg
c2VlbSB0byBhZGRyZXNzIHRoZQ0KPj4gYWN0dWFsIGlzc3VlLg0KPj4NCj4+IEZvciB0aGUgMiBj
aGVja3MgeW91IGRvIGhlcmUNCj4+IDEuIFRoZXJlIGFyZSBjdXJyZW50bHkgbm8gcmVxdWVzdHMg
cXVldWVkIGluIHRoZSBoYXJkd2FyZQ0KPj4gMi4gVGhlIGN1cnJlbnQgZnJhbWUgbnVtYmVyIHBy
b3ZpZGVkIGJ5IERTVFMgZG9lcyBub3QgbWF0Y2ggdGhlIGZyYW1lDQo+PiAgIMKgwqDCoCBudW1i
ZXIgcmV0dXJuZWQgYnkgdGhlIGxhc3QgdHJhbnNmZXIuDQo+Pg0KPj4gRm9yICMxLCBpdCdzIGFs
cmVhZHkgZG9uZSBpbiB0aGUgZHdjMyBkcml2ZXIuIChjaGVjaw0KPj4gZHdjM19nYWRnZXRfZW5k
cG9pbnRfdHJhbnNmZXJfaW5fcHJvZ3Jlc3MoKSkNCj4gQnV0IHRoYXQncyBvbmx5IGFmdGVyIGEg
aXNvY19taXNzZWQgb2NjdXJyZWQuIFdoYXQgZXhhY3RseSBkb2VzIHRoYXQgbWVhbj8NCj4gV2Fz
IHRoZSByZXF1ZXN0IHRyYW5zZmVycmVkIG9yIG5vdD8gTXkgdGVzdHMgc3VnZ2VzdCB0aGF0IGl0
IHdhcyBub3QNCj4gdHJhbnNmZXJyZWQsIHNvIEkgd2FudGVkIHRvIGNhdGNoIHRoaXMgYmVmb3Jl
IGl0IGhhcHBlbnMuDQoNCk1pc3NlZF9pc29jIHN0YXR1cyBtZWFucyB0aGF0IHRoZSBjb250cm9s
bGVyIGRpZCBub3QgbW92ZSBhbGwgdGhlIGRhdGEgDQppbiBhbiBpbnRlcnZhbC4NCg0KPg0KPj4g
Rm9yICMyLCBpdCdzIHVubGlrZWx5IHRoYXQgRFNUUyBjdXJyZW50IGZyYW1lIG51bWJlciB3aWxs
IG1hdGNoIHdpdGggdGhlDQo+PiBYZmVyTm90UmVhZHkncyBmcmFtZSBudW1iZXIuIFNvIHRoaXMg
Y2hlY2sgZG9lc24ndCBtZWFuIG11Y2guDQo+IFRoZSBmcmFtZSBudW1iZXIgaXMgYWxzbyB1cGRh
dGVkIGZvciBlYWNoICJUcmFuc2ZlciBJbiBQcm9ncmVzcyIgaW50ZXJydXB0Lg0KPiBJZiB0aGV5
IG1hdGNoLCB0aGVuIHRoZXJlIGEgbmV3IHJlcXVlc3QgY2FuIHN0aWxsIGJlIHF1ZXVlZCBzdWNj
ZXNzZnVsbHkuDQo+IFdpdGhvdXQgdGhpcyBJIGdvdCB1bm5lY2Vzc2FyeSBzdG9wL3N0YXJ0IHRy
YW5zZmVycyBpbiB0aGUgbWlkZGxlIG9mIGENCj4gdmlkZW8gZnJhbWUuIEJ1dCBtYXliZSBzb21l
dGhpbmcgZWxzZSB3YXMgd3JvbmcgaGVyZS4gSSdkIG5lZWQgdG8gcmVjaGVjay4NCg0KVGhlIHJl
YXNvbiB0aGV5IG1heSBub3QgbWF0Y2ggaXMgMSkgdGhlIGZyYW1lX251bWJlciBpcyBvbmx5IHVw
ZGF0ZWQgDQphZnRlciB0aGUgc29mdHdhcmUgaGFuZGxlcyB0aGUgWGZlckluUHJvZ3Jlc3MgaW50
ZXJydXB0LiBEZXBlbmRzIG9uIA0Kc3lzdGVtIGxhdGVuY3ksIHRoYXQgdmFsdWUgbWF5IG5vdCBi
ZSB1cGRhdGVkIGF0IHRoZSB0aW1lIHRoYXQgd2UgY2hlY2sgDQp0aGUgZnJhbWVfbnVtYmVyLg0K
MikgVGhpcyBjaGVjayBkb2Vzbid0IHdvcmsgaWYgdGhlIHNlcnZpY2UgaW50ZXJ2YWwgaXMgZ3Jl
YXRlciB0aGFuIDEgDQp1ZnJhbWUuIFRoYXQgaXMsIGl0IGRvZXNuJ3QgaGF2ZSB0byBtYXRjaCBl
eGFjdGx5IHRoZSB0aW1lIHRvIGJlIA0KY29uc2lkZXIgbm90IGxhdGUuIFRob3VnaCwgdGhlIHNl
Y29uZCByZWFzb24gY2FuIGVhc2lseSBiZSBmaXhlZC4NCg0KDQo+DQo+PiBTbyBJJ20gc3RpbGwg
d29uZGVyaW5nIGhvdyBkb2VzIHRoaXMgcGF0Y2ggaGVscCByZXNvbHZlIHlvdXIgaXNzdWUuDQo+
IFdpdGggdGhpcyBwYXRjaCwgdGhlIHRyYW5zZmVyIGlzIHJlc3RhcnRlZCBmb3IgZXZlcnkgdmlk
ZW8gZnJhbWUuDQo+IE90aGVyd2lzZSwgSSBqdXN0IGdldCBhIGxvdCBvZiBpc29jX21pc3NlZCBh
bmQgaWdub3JpbmcgdGhvc2UgZGlkIG5vdCBoZWxwLg0KPiBObyB2YWxpZCBkYXRhIGFycml2ZWQg
YWZ0ZXIgdGhlIGZpcnN0IHZpZGVvIGZyYW1lLg0KPg0KPj4+IEhvdyBhYm91dCBjaGFuZ2luZyB0
aGUgZ2FkZ2V0IGRyaXZlciBpbnN0ZWFkPyAgRm9yIGZyYW1lcyB3aGVyZSB0aGUgVVZDDQo+Pj4g
Z2FkZ2V0IGtub3dzIG5vIHZpZGVvIGZyYW1lIGRhdGEgaXMgYXZhaWxhYmxlIChudW1iZXJzIDQs
IDgsIDEyLCBhbmQgc28NCj4+PiBvbiBpbiB0aGUgZXhhbXBsZSBhYm92ZSksIHF1ZXVlIGEgemVy
by1sZW5ndGggcmVxdWVzdC4gIFRoZW4gdGhlcmUNCj4+PiB3b24ndCBiZSBhbnkgZ2FwcyBpbiB0
aGUgaXNvY2hyb25vdXMgcGFja2V0IHN0cmVhbS4NCj4+IFdoYXQgQWxhbiBzdWdnZXN0cyBtYXkg
d29yay4gSGF2ZSB5b3UgdHJpZWQgdGhpcz8NCj4gWWVzIGFuZCBpdCB3b3JrcyBpbiBnZW5lcmFs
LiBUaGVyZSBhcmUgaG93ZXZlciBzb21lIHByb2JsZW1zIHdpdGggdGhhdA0KPiBhcHByb2FjaCB0
aGF0IEkgd2FudCB0byBhdm9pZDoNCj4NCj4gMS4gSXQgYWRkcyBleHRyYSBvdmVyaGVhZCB0byBo
YW5kbGUgdGhlIGV4dHJhIHplcm8tbGVuZ3RoIHJlcXVlc3QuDQo+IEVzcGVjaWFsbHkgZm9yIGVu
Y29kZWQgdmlkZW8gdGhlIGF2YWlsYWJsZSBiYW5kd2lkdGggY2FuIGJlIHF1aXRlIGEgYml0DQo+
IGxhcmdlciB0aGF0IHdoYXQgaXMgYWN0dWFsbHkgdXNlZC4gSSB3YW50IHRvIGF2b2lkIHRoYXQu
DQo+DQo+IDIuIFRoZSBVVkMgZ2FkZ2V0IGN1cnJlbnRseSBkb2VzIG5vIGtub3cgaG93IG1hbnkg
emVyby1sZW5ndGggcmVxdWVzdCBtdXN0DQo+IGFkZGVkLiBTbyBpdCBuZWVkcyBmaWxsIGFsbCBh
dmFpbGFibGUgcmVxdWVzdCB1bnRpbCBhIG5ldyB2aWRlbyBmcmFtZQ0KPiBhcnJpdmVzLiBXaXRo
IHRoZSBjdXJyZW50IDQgcmVxdWVzdHMgdGhhdCBpcyBub3QgYSBwcm9ibGVtIHJpZ2h0IG5vdy4g
QnV0DQo+IHRoYXQgZG9lcyBub3Qgc2NhbGUgZm9yIFVTQjMgYmFuZHdpZHRocy4gU28gb25lIHRo
aW5nIHRoYXQgSSB3YW50IHRvIGRvIGlzDQo+IHRvIHF1ZXVlIG1hbnkgcmVxdWVzdHMgYnV0IG9u
bHkgZW5hYmxlIHRoZSBpbnRlcnJ1cHQgZm9yIGEgZmV3IG9mIHRoYW4uDQo+ICBGcm9tIHdoYXQg
SSBjYW4gdGVsbCBmcm9tIHRoZSBjb2RlLCB0aGUgZ2FkZ2V0IGZyYW1ld29yayBhbmQgdGhlIGR3
YzMNCj4gZHJpdmVyIHNob3VsZCBhbHJlYWR5IHN1cHBvcnQgdGhpcy4NCj4gVGhpcyB3aWxsIHJl
c3VsdCBpbiBleHRyYSBsYXRlbmN5LiBUaGVyZSBpcyBwcm9iYWJseSBhbiBhY2NlcHRhYmxlDQo+
IHRyYWRlLW9mZiB3aXRoIGFuIGFjY2VwdGFibGUgaW50ZXJydXB0IGxvYWQgYW5kIGxhdGVuY3ku
IEJ1dCBJIHdvdWxkIGxpa2UNCj4gdG8gYXZvaWQgdGhhdCBpZiBwb3NzaWJsZS4NCj4NCj4gUmVn
YXJkcywNCj4gTWljaGFlbA0KDQoNCkkgdGhpbmsgSSB1bmRlcnN0YW5kIHRoZSBwcm9ibGVtIHlv
dSdyZSB0cnlpbmcgdG8gc29sdmUgbm93Lg0KDQpUaGUgZHdjMyBkcml2ZXIgZG9lcyBub3Qga25v
dyB0aGF0IHRoZXJlJ3MgYSBnYXAgdW50aWwgYWZ0ZXIgYSBuZXcgDQpyZXF1ZXN0IHdhcyBxdWV1
ZWQsIHdoaWNoIHRoZW4gaXQgd2lsbCBzZW5kIGFuIEVORF9UUkFOU0ZFUiBjb21tYW5kIGFuZCAN
CmRlcXVldWUgYWxsIHRoZSByZXF1ZXN0cyB0byByZXN0YXJ0IHRoZSB0cmFuc2ZlciBkdWUgdG8g
bWlzc2VkX2lzb2MuDQpXZSBkbyB0aGlzIGJlY2F1c2UgdGhlIGR3YzMgZHJpdmVyIGRvZXMgbm90
IGtub3cgd2hldGhlciB0aGUgbmV3IHJlcXVlc3QgDQppcyBhY3R1YWxseSBzdGFsZSBkYXRhLCBh
bmQgd2Ugc2hvdWxkIG5vdCBjaGFuZ2UgdGhpcyBiZWhhdmlvci4NCg0KTm93LCB3aXRoIFVWQywg
aXQgbmVlZHMgdG8gY29tbXVuaWNhdGUgdG8gdGhlIGR3YzMgZHJpdmVyIHRoYXQgdGhlcmUgDQp3
aWxsIGJlIGEgZ2FwIGFmdGVyIGEgY2VydGFpbiByZXF1ZXN0IChhbmQgdGhhdCB0aGUgZGV2aWNl
IGlzIGV4cGVjdGluZyANCnRvIHNlbmQgMC1sZW5ndGggZGF0YSkuIFRoaXMgaXMgbm90IGEgbm9y
bWFsIG9wZXJhdGlvbiBmb3IgaXNvYyANCnRyYW5zZmVyLiBZb3UgbWF5IG5lZWQgdG8gaW50cm9k
dWNlIGEgbmV3IHdheSBmb3IgdGhlIGZ1bmN0aW9uIGRyaXZlciB0byANCmRvIHRoYXQsIHBvc3Np
Ymx5IGEgbmV3IGZpZWxkIGluIHVzYl9yZXF1ZXN0IHN0cnVjdHVyZSB0byBpbmRpY2F0ZSB0aGF0
LiANCkhvd2V2ZXIsIHRoaXMgc2VlbXMgYSBsaXR0bGUgYXdrd2FyZC4gTWF5YmUgb3RoZXJzIGNh
biBjb21tZW50IG9uIHRoaXMuDQoNCkJSLA0KVGhpbmgNCg==
