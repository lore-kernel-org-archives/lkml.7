Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC5EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656C206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfDDJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:24:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28818 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728556AbfDDJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:24:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x349Laqm032263;
        Thu, 4 Apr 2019 11:23:54 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgev9gjh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 04 Apr 2019 11:23:54 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11EF331;
        Thu,  4 Apr 2019 09:23:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A9C4516B5;
        Thu,  4 Apr 2019 09:23:49 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 4 Apr
 2019 11:23:49 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Thu, 4 Apr 2019 11:23:49 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Baruch Siach" <baruch@tkos.co.il>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        "Nancy Yuen" <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Wan ZongShun" <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Shawn Guo" <shawnguo@kernel.org>
Subject: Re: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
Thread-Topic: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
Thread-Index: AQHU6YaQ1KOIBZerNE+dqbJe8VePSKYrm5qA
Date:   Thu, 4 Apr 2019 09:23:49 +0000
Message-ID: <8283ed6e-baf6-280f-d2dd-9ab96493dfb7@st.com>
References: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4A643161002444D8DC09072EE7B2966@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KT24gNC8yLzE5IDk6MDEgUE0sIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+IFVzZSBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UgdG8gcmVkdWNlIHNvdXJjZSBjb2RlIHNpemUsDQo+
IGltcHJvdmUgcmVhZGFiaWxpdHksIGFuZCByZWR1Y2UgdGhlIGxpa2VseWhvb2Qgb2YgYnVncy4N
Cj4gDQo+IFRoZSBjb252ZXJzaW9uIHdhcyBkb25lIGF1dG9tYXRpY2FsbHkgd2l0aCBjb2NjaW5l
bGxlIHVzaW5nIHRoZQ0KPiBmb2xsb3dpbmcgc2VtYW50aWMgcGF0Y2guDQo+IA0KPiBAckANCj4g
aWRlbnRpZmllciByZXMsIHBkZXY7DQo+IGV4cHJlc3Npb24gYTsNCj4gZXhwcmVzc2lvbiBpbmRl
eDsNCj4gZXhwcmVzc2lvbiBlOw0KPiBAQA0KPiANCj4gPCsuLi4NCj4gLSByZXMgPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIGluZGV4KTsNCj4gLSBhID0gZGV2
bV9pb3JlbWFwX3Jlc291cmNlKGUsIHJlcyk7DQo+ICsgYSA9IGRldm1fcGxhdGZvcm1faW9yZW1h
cF9yZXNvdXJjZShwZGV2LCBpbmRleCk7DQo+IC4uLis+DQo+IA0KPiBAZGVwZW5kcyBvbiByQA0K
PiBpZGVudGlmaWVyIHIucmVzOw0KPiBAQA0KPiAtIHN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAg
IC4uLiB3aGVuICE9IHJlcw0KPiANCj4gQEANCj4gaWRlbnRpZmllciByZXMsIHBkZXY7DQo+IGV4
cHJlc3Npb24gaW5kZXg7DQo+IGV4cHJlc3Npb24gYTsNCj4gQEANCj4gLSBzdHJ1Y3QgcmVzb3Vy
Y2UgKnJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgaW5k
ZXgpOw0KPiAtIGEgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCj4g
KyBhID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIGluZGV4KTsNCj4gDQo+
IENjOiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogTmljb2xhcyBGZXJyZSA8
bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPiBDYzogQWxleGFuZHJlIEJlbGxvbmkgPGFs
ZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KPiBDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5m
YWluZWxsaUBnbWFpbC5jb20+DQo+IENjOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxp
bmFyby5vcmc+DQo+IENjOiBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0a29zLmNvLmlsPg0KPiBDYzog
S2VndWFuZyBaaGFuZyA8a2VndWFuZy56aGFuZ0BnbWFpbC5jb20+DQo+IENjOiBWbGFkaW1pciBa
YXBvbHNraXkgPHZ6QG1sZWlhLmNvbT4NCj4gQ2M6IEtldmluIEhpbG1hbiA8a2hpbG1hbkBiYXls
aWJyZS5jb20+DQo+IENjOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29t
Pg0KPiBDYzogQXZpIEZpc2htYW4gPGF2aWZpc2htYW43MEBnbWFpbC5jb20+DQo+IENjOiBOYW5j
eSBZdWVuIDx5dWVubkBnb29nbGUuY29tPg0KPiBDYzogQnJlbmRhbiBIaWdnaW5zIDxicmVuZGFu
aGlnZ2luc0Bnb29nbGUuY29tPg0KPiBDYzogV2FuIFpvbmdTaHVuIDxtY3Vvcy5jb21AZ21haWwu
Y29tPg0KPiBDYzogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gQ2M6
IFN5bHZhaW4gTGVtaWV1eCA8c2xlbWlldXgudHljb0BnbWFpbC5jb20+DQo+IENjOiBLdWtqaW4g
S2ltIDxrZ2VuZUBrZXJuZWwub3JnPg0KPiBDYzogQmFycnkgU29uZyA8YmFvaHVhQGtlcm5lbC5v
cmc+DQo+IENjOiBPcnNvbiBaaGFpIDxvcnNvbnpoYWlAZ21haWwuY29tPg0KPiBDYzogUGF0cmlj
ZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0KPiBDYzogTWF4aW1lIENvcXVlbGlu
IDxtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tPg0KPiBDYzogTWF4aW1lIFJpcGFyZCA8bWF4aW1l
LnJpcGFyZEBib290bGluLmNvbT4NCj4gQ2M6IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz4N
Cj4gQ2M6IE1hcmMgR29uemFsZXogPG1hcmMudy5nb256YWxlekBmcmVlLmZyPg0KPiBDYzogVGhp
ZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4NCj4gQ2M6IFNoYXduIEd1byA8
c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogR3VlbnRlciBSb2VjayA8bGlu
dXhAcm9lY2stdXMubmV0Pg0KPiAtLS0NCg0KPiAgZHJpdmVycy93YXRjaGRvZy9zdF9scGNfd2R0
LmMgICAgIHwgNCArLS0tDQoNCkZvciBzdF9scGNfd2R0DQoNCkFja2VkLWJ5OiBQYXRyaWNlIENo
b3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw==
