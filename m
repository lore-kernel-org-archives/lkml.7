Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAB120674
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YwLmPanv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfDOIPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:15:35 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:57650 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOIPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:15:35 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 2732210C2A9C;
        Mon, 15 Apr 2019 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555316134; bh=YasZ8OghOGkU1OI8etqUYPfDbjmSfonfqmeP3HJW1VQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YwLmPanvgOj+eyg4kAJw8P+pGwXqzgU7ZLusiDYF+N5GHjhBshLWdvUdbPEVSVbxC
         AgrrAURakbsQBUJOap1tQyVDVOotXLI0rV3YUDKuzak5LMDYqiaroNQuWig/PAWCvJ
         0h53L4ogzua4E+R7Wcse5pbZxkqGlg4NefOSNjDM6LxPQ/tyOivLNla+VVhvzahSqi
         DGCvwmLld9fP8lHzypbIL/QxI2WsgcJiDylfM9/NIeR0OVUbPGDTY/3CmUqXnX4ldX
         X3Ubd5wSrPBrfBRS8vyTwii8kkEJY61W/3NkuTAtcx/vWu61/lAFizjpFtVgpKmEsb
         kVDH3WDWrXfFA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 50372A006A;
        Mon, 15 Apr 2019 08:15:31 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 15 Apr 2019 01:15:31 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 15 Apr 2019 10:15:30 +0200
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Jose Abreu <jose.abreu@synopsys.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        =?utf-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        =?utf-8?B?Q2hyaXN0b3BoIE3DvGxsbmVy?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: RE: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
Thread-Topic: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
Thread-Index: AQHU6Ld2BNOIyyJamEeC//pMtZni+6YnhciAgAADZICAAAGHgIAA920AgAAfNACAACI8cIAAipiAgAALMwCAALjx8IAAYG+AgAAFvgCAAASDgIAC4/OwgABi2ACAAAQmgIAAAsSAgAmYDQCAAM6qYIAAHUAAgASlj1A=
Date:   Mon, 15 Apr 2019 08:15:29 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B4586B2@DE02WEMBXB.internal.synopsys.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
        <1554305721.1328.0@gmail.com> <1554306954.1328.1@gmail.com>
        <c863f88a-65e2-4093-7cc1-f37e4443b871@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B44985F@DE02WEMBXB.internal.synopsys.com>
        <1554488052.1193.1@gmail.com> <85c1d945-d49b-3350-6ff4-a058c5a8c1d7@arm.com>
        <1554489537.1199.0@gmail.com> <1555016970.28872.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4566A9@DE02WEMBXB.internal.synopsys.com>
 <1555067632.1216.0@gmail.com>
In-Reply-To: <1555067632.1216.0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.107.19.176]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGVvbmlkYXMgUC4gUGFwYWRha29zIDxwYXBhZGFrb3NwYW5AZ21haWwuY29tPg0KRGF0
ZTogRnJpLCBBcHIgMTIsIDIwMTkgYXQgMTI6MTM6NTINCg0KPiANCj4gPiBDYW4geW91IHBsZWFz
ZSBzaGFyZSB0aGUgc3RhY2t0cmFjZSBoZXJlID8gSSBjYW4ndCBhY2Nlc3MgcGFzdGViaW4gDQo+
ID4gZHVlIHRvDQo+ID4gY29ycG9yYXRlIHBvbGljeS4NCj4gDQo+IFRoaXMgaGFwcGVucyBzZWNv
bmRzIGFmdGVyIEkgY2hhbmdlIHRoZSBNVFUuIEkgcmVtZW1iZXIgaXQgdXNlZCB0byANCj4gaGFw
cGVuIHdpdGggMTUwMCBhcyB3ZWxsLCBiZWZvcmUgdGhlIGdtYWMgdHdlYWtzLiBJdCBtYWtlcyBz
ZW5zZQ0KPg0KDQpOb3RpY2UgdGhhdCBpbmNvcnJlY3Qgc2V0dGluZ3Mgb2YgUEJMIGNhbiBjYXVz
ZSBRdWV1ZSB0aW1lb3V0LiBDYW4geW91IA0KdHJ5IHdpdGggUEJMID0gMHgxIGFuZCBuby1wYmwt
eDggYW5kIGxldCBtZSBrbm93IGlmIHRoZSB0aW1lb3V0IHN0aWxsIA0KaGFwcGVucz8NCiANCj4g
DQo+IFdoZW4geW91IHNheSBGSUZPIHNpemUsIGlzIHRoYXQgcmVsYXRlZCB0byB0aGUgdHgvcnhf
ZGVsYXk/DQoNCk5vLCBGSUZPIHNpemUgaXMgdGhlIFF1ZXVlIEZJRk8gc2l6ZSB0aGF0IHN0b3Jl
cyBwYWNrZXRzIGFmdGVyIERNQSANCmZldGNoZXMgdGhlbS4NCg0KVGhhbmtzLA0KSm9zZSBNaWd1
ZWwgQWJyZXUNCg==
