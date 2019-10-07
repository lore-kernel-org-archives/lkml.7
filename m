Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D4DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8B72190F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s6Hym7Y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfJGMZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:25:32 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:10311
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfJGMZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:25:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNCXI+5LmhSLZdLZU/gMzv4O03mhYXsf4f5q0E3EICqT2BkaBLKRplmupeEP5DKmuaYxGx3+W0XjSZnO9gYV50l2HF/E1q/zb0bzPeakkXHuQNMia2YZRt9VBMret1B2m4w36OAvHYIA1HMvUGVsugPEiQHIr78CB5s5a3TWbgjMHEZwuX2Q9bGltyjNUdlEYxbpP7H5Sk41IFLGGTZva0aHkslOvNR5e06thXwyy9ZSBMjyc+Mit4zNLlGWEriBdEWySmuRYmuqSAswuP8uvbh4QcLTT0SxJ21y8FCzzQG2TjZ5RVmsDeTWqQs3oO6X/ThRoXPtYV7Sm5TITY5Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQsX/dZQT8Em8A8UcWnLzJOkY+RwJKV/Xv0hpV5JaME=;
 b=j2LjqogcK9I79N0n8bHKXJVupydI9epd17U5rFBJIfBlR06KRG4hrC/uIoSzVPr2YcNx07pMXgsQkeAC3W5ArbbHRTpKM0evtOLOkXR4kVG7n3ZGWV9WX2B+D0dyj8ODnWsU223JmBTB0R7Ih8fIC+R0oAHGknPRsy7mhialFGoV9ZYrmJMS2gpOt/hV99Yrf2juSpGGO4fMDFuTxZWFa84gyt7dZMynbi3qcwBiBWc1HX5mGju+XfWl5ornPWgjANnqSYktfcKB1lnIVtzsjfXitlq0hfCURbMJ27uZZ+7b4LaOo0hmEvr6KFvmhraiNE6YEeGqFHmTbbEexMICEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQsX/dZQT8Em8A8UcWnLzJOkY+RwJKV/Xv0hpV5JaME=;
 b=s6Hym7Y5mJQzYqBrWp3r2p56XE3DR7Lnob3mV7hpyoz7b35uJ4Lw7v0GQY7rlZilwkWRJO2KbFNpAfIX/TGZsce+/pCR9Lgri+qJFPKy5cyKH1t8WanaJAHKOt2YwfJ/MPLPZENj3RKhTx7P/yEVWeFkM1dG+yT3dCcJHdPIMpY=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 12:24:48 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36%7]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 12:24:48 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Eddy Petrisor <eddy.petrisor@nxp.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB board
Thread-Topic: [PATCH v4 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB board
Thread-Index: AQHVfQo1Eh0SeVFXnUWJbDaudlmLUA==
Date:   Mon, 7 Oct 2019 12:24:48 +0000
Message-ID: <VI1PR0402MB28639D7B0AB94EBC8DE6464FDF9B0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
 <20190905115803.19565-2-stefan-gabriel.mirea@nxp.com>
 <20191006015942.GK7150@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baf654e8-5ece-47a4-7aff-08d74b215875
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB3485:|VI1PR0402MB3485:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB34850E1AF93E7174167CBB38DF9B0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(26005)(6116002)(25786009)(76116006)(66946007)(66574012)(33656002)(91956017)(71190400001)(71200400001)(66446008)(66066001)(66476007)(66556008)(64756008)(6506007)(99286004)(7416002)(6916009)(3846002)(53546011)(7696005)(76176011)(86362001)(102836004)(81166006)(81156014)(8676002)(8936002)(486006)(446003)(476003)(7736002)(966005)(2906002)(186003)(14454004)(305945005)(74316002)(316002)(52536014)(54906003)(14444005)(478600001)(5660300002)(9686003)(6306002)(6436002)(256004)(55016002)(4326008)(6246003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3485;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfugnJ/QOrupEec0QRq+RlNZWjW72p7O8OjwsJ2kz8QxqUqQRO45e6d9O84G92hzCVipMCZWaXSGVkCwVY5w6BPIdK5Vf3fCFCKXqrHcm8OV307bfKyxp3kMn6CNqDuwgmONd19a9efcPEu2yJV5xFPjxWGxAS4nuqohLsMlcMP2YKBD4SPkwHl5Liq+SqKJynBb5jYPbcA0kDyVcf2OJ2MWP3399EIafR1qD8O+QXawh9bMVv1lZDeoQHXx59ZYqKpwEWRVmez026m1PD7e1BasG/fLzzI2pVXEAkJ3NNb3nR+aFUqs1v/9NajmWz7NzrnobCicFtwn7nhCn+dx94MGwTtOukfrorR8+3En9VhIgeDwiIxctg3WMTo1vx9a7eqrBnOmqvOofDRsiQH7LUanA/YzzXG+pOBcJg7Ym/ZCRiKuH7SWeFDgdKjK6KHeLNrWOZizYGRTclIRgceGYQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf654e8-5ece-47a4-7aff-08d74b215875
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 12:24:48.5393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6rSmB185eW6nFWfIyDgx9mIq/Eb8XKd2xHH1CpAp2QkIVZMiB8I6Squs/23v13MXIMlln813qISb1oszrexhygqkcT1ts1CuWbOji1KtgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNi8yMDE5IDU6MDAgQU0sIFNoYXduIEd1byB3cm90ZToKPiBPbiBUaHUsIFNlcCAwNSwg
MjAxOSBhdCAxMTo1ODozMkFNICswMDAwLCBTdGVmYW4tZ2FicmllbCBNaXJlYSB3cm90ZToKPj4g
RnJvbTogRWRkeSBQZXRyaciZb3IgPGVkZHkucGV0cmlzb3JAbnhwLmNvbT4KPj4KPj4gQWRkIGVu
dHJ5IGZvciB0aGUgTlhQIFMzMlYyMzQgQ3VzdG9tZXIgRXZhbHVhdGlvbiBCb2FyZCB0byB0aGUg
Ym9hcmQvU29DCj4+IGJpbmRpbmdzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBFZGR5IFBldHJpyJlv
ciA8ZWRkeS5wZXRyaXNvckBueHAuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4tR2Ficmll
bCBNaXJlYSA8c3RlZmFuLWdhYnJpZWwubWlyZWFAbnhwLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Cj4gCj4gSSdtIGFib3V0IHRvIGFwcGx5IHRoZSBw
YXRjaGVzLCBidXQgZm91bmQgdGhlIG1lc3NhZ2VzIGFyZSB1c2luZyBiYXNlNjQKPiBDb250ZW50
LVRyYW5zZmVyLUVuY29kaW5nLCB3aGljaCBpcyBkaWZmaWN1bHQgZm9yIG1lIHRvIGFwcGx5IHBh
dGNoCj4gZnJvbS4gIFBsZWFzZSBmaXggaXQgYW5kIHJlc2VuZC4KPiAKPiBTaGF3bgoKSGVsbG8g
U2hhd24sCgpJIHdpbGwgZml4IHRoaXMgaXMgdGhlIG5leHQgdmVyc2lvbi4gUGxlYXNlIG5vdGUg
dGhhdCB0aGlzIG1pZ2h0IHRha2UgYQp3aGlsZSwgYXMgdGhlIHByb2JsZW0gaXMgY2F1c2VkIGJ5
IG91ciBFeGNoYW5nZSBzZXJ2ZXIgYW5kIEkgbmVlZCB0bwpyZWNlaXZlIGFjY2VzcyB0byBhbm90
aGVyIFNNVFAgc2VydmVyLiBVbmZvcnR1bmF0ZWx5LCB0aGlzIGNhbm5vdCBiZQp3b3JrZWQgYXJv
dW5kIHdpdGggdGhlICctLXRyYW5zZmVyLWVuY29kaW5nJyBvcHRpb24gb2YgJ2dpdCBzZW5kLWVt
YWlsJwpmb3IgdGhpcyBwYXJ0aWN1bGFyIHBhdGNoLgoKQWxzbywgcGxlYXNlIG5vdGUgdGhhdCB0
aGVyZSBpcyBhbHNvIGEgNXRoIHZlcnNpb24gb2YgdGhpcyBzZXJpZXNbMV0sCnN1Ym1pdHRlZCBv
biAyIE9jdG9iZXIgKHRoZXJlIGFyZSBubyBzaWduaWZpY2FudCBjaGFuZ2VzIHRob3VnaDsgdGhl
CnBhdGNoZXMgd2VyZSBqdXN0IHJlYmFzZWQpLiBZb3Ugd2VyZSBub3QgaW5jbHVkZWQgaW4gdGhl
IHJlY2lwaWVudHMgbGlzdApiZWNhdXNlIHRoZSAnYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLSonIHBhdHRlcm4gaW4gdGhlIHNlY3Rpb24KJ0FSTS9GUkVFU0NBTEUgTEFZRVJTQ0FQ
RSBBUk0gQVJDSElURUNUVVJFJyBvZiB0aGUgTUFJTlRBSU5FUlMgZmlsZSBubwpsb25nZXIgbWF0
Y2hlcyB0aGUgZHRzL2R0c2kgZmlsZSBuYW1lcywgZm9sbG93aW5nIHRoZSBwcmVmaXggcmVtb3Zh
bCB5b3UKc3VnZ2VzdGVkLiBUaGVyZWZvcmUsIGdldF9tYWludGFpbmVyLnBsIGRpZCBub3Qgc2hv
dyB5b3UgYXMgYSBtYWludGFpbmVyCmFueW1vcmUuIEkgd2lsbCBhZGQgeW91IHRvIHRoZSBuZXh0
IHZlcnNpb24uCgpSZWdhcmRzLApTdGVmYW4KClsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAx
OS8xMC8yLzMyMAo=
