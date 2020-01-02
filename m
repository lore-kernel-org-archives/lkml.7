Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B2AC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E840C20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rdW5FCjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgABIu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:50:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58184 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgABIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:50:57 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0028mjoQ007721;
        Thu, 2 Jan 2020 09:50:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=LRdbeTk9U+whaEXucHpmJKJIXLSTzy8TN4eCF8nKnlk=;
 b=rdW5FCjvJZp4jjB8Zq169+SO5I2yDOHHeVn9ffeFn0qfFuJbIkdLiqX37tZHl1losuIT
 K8xlccRILYvzn4OG7G7rjKj9+f8hSg0OvrEcF/fTaT4mLeehR26aGdvHRfq2WZEALEka
 d/WbwqX9C1YmDYto0kEaZ4KI7p68kBKNvvoZIvPXOTGaR3ggaYNWtAiYZVsjuZngvvv/
 uDH/MdR8jQjnoIRHltOPNuJH+7E76GyPeoZUIHGL/4PCFQ93dw7Dag2CC92UTRR4OQdu
 iYX04ChjY3jCq4AXgjpEU3puzFoNxPJvBMGcTjJHvhaez7pErnf08R9ypcmjMgTQr563 Ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2x5wd6a4bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 09:50:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 897E8100034;
        Thu,  2 Jan 2020 09:50:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 666FF21ED5A;
        Thu,  2 Jan 2020 09:50:40 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Jan
 2020 09:50:39 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 2 Jan 2020 09:50:39 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: Remove unneeded "snps,dwc2" from
 hsotg node
Thread-Topic: [PATCH v2 2/2] ARM: dts: exynos: Remove unneeded "snps,dwc2"
 from hsotg node
Thread-Index: AQHVtlgQQnPVTv47G0+aNYZYg4bX66fS0MUAgARFMYA=
Date:   Thu, 2 Jan 2020 08:50:39 +0000
Message-ID: <bbc7e34c-75c2-dfe0-70f3-0685e8e54fed@st.com>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
 <20191219103536.25485-3-benjamin.gaignard@st.com> <20191230153758.GB4918@pi3>
In-Reply-To: <20191230153758.GB4918@pi3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <189E2F8963AD1C41B89EA1A9DC82B15E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_02:2019-12-30,2020-01-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8zMC8xOSA0OjM3IFBNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiBU
aHUsIERlYyAxOSwgMjAxOSBhdCAxMTozNTozNkFNICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3
cm90ZToNCj4+IFJlbW92ZSAic25wcyxkd2MyIiBmcm9tIGhzb3RnQDEyNDgwMDAwIG5vZGUgY29t
cGF0aWJsZSBsaXN0IGJlY2F1c2UNCj4+ICJzYW1zdW5nLHMzYzY0MDAtaHNvdGciIHNob3VsZCBi
ZSBlbm91Z2guDQo+IFRoZSBtb3JlIGRldGFpbGVkIGNvbXBhdGlibGUgaXMgYWxtb3N0IGFsd2F5
cyAiZW5vdWdoIi4gU29tZSBvdGhlciBub2Rlcw0KPiBhbHNvIGhhdmUgZGV0YWlsZWQrZ2VuZXJp
YyBjb21wYXRpYmxlLiBJbiB0aGlzIGNhc2UgdGhlcmUgaXMgYSBkcml2ZXINCj4gbWF0Y2hpbmcg
InNucHMsZHdjMiIgc28gd2h5IHJlbW92aW5nIGl0Pw0KDQpGaXJzdCBiZWNhdXNlLCB1bmxpa2Ug
dGhlIG90aGVycyBkd2MyIGRldmljZXMsIHRoaXMgY29tcGF0aWJsZSB3YXNuJ3QgDQpkZXNjcmli
ZSBpbiB0aGUgYmluZGluZ3MgZmlsZQ0KDQpzbyBJIGhhZCB0byBpbnZlc3RpZ2F0ZWQgaG93IGl0
IHNob3VsZCB3b3JrIGFuZCwgb24gc2Ftc3VuZyBEVCBmaWxlcywgDQpvbmx5ICJzYW1zdW5nLHMz
YzY0MDAtaHNvdGciLg0KDQogRnJvbSBkcml2ZXIgY29kZSBwb2ludCBvZiB2aWV3IHRoYXQgc2Vl
bXMgY29oZXJlbnQgKHdlIGRvIHRoZSBzYW1lIGZvciANCnN0bTMyKS4NCg0KV2l0aCB0aGF0IGlu
IG1pbmQgSSBoYXZlIGRlY2lkZWQgdG8gcmVtb3ZlICJzbnBzLGR3YzIiIGZyb20gZXh5bm9zIERU
IA0KZmlsZSByYXRoZXIgdGhhbiBhZGQgaXQgZXZlcnl3aGVyZSBlbHNlLg0KDQpCZW5qYW1pbg0K
DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBC
ZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPj4gLS0tDQo+PiAg
IGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRzaSB8IDIgKy0NCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4
eW5vczMyNTAuZHRzaQ0KPj4gaW5kZXggYjAxNmIwYjY4MzA2Li5kNDg2NjI2OWY0ZWUgMTAwNjQ0
DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9leHlub3MzMjUwLmR0c2kNCj4+ICsrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRzaQ0KPj4gQEAgLTM2Miw3ICszNjIsNyBAQA0K
Pj4gICAJCX07DQo+PiAgIA0KPj4gICAJCWhzb3RnOiBoc290Z0AxMjQ4MDAwMCB7DQo+PiAtCQkJ
Y29tcGF0aWJsZSA9ICJzYW1zdW5nLHMzYzY0MDAtaHNvdGciLCAic25wcyxkd2MyIjsNCj4+ICsJ
CQljb21wYXRpYmxlID0gInNhbXN1bmcsczNjNjQwMC1oc290ZyI7DQo+PiAgIAkJCXJlZyA9IDww
eDEyNDgwMDAwIDB4MjAwMDA+Ow0KPj4gICAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTQxIElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gICAJCQljbG9ja3MgPSA8JmNtdSBDTEtfVVNCT1RHPjsN
Cj4+IC0tIA0KPj4gMi4xNS4wDQo+Pg==
