Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E256C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8CD222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfDSSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:21 -0400
Received: from mx.socionext.com ([202.248.49.38]:31247 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbfDSSVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:43 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Apr 2019 17:59:54 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id E24C218028E;
        Fri, 19 Apr 2019 17:59:54 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Fri, 19 Apr 2019 17:59:54 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Fri, 19 Apr 2019 17:59:54 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Fri, 19 Apr 2019 17:59:54 +0900
From:   <yamada.masahiro@socionext.com>
To:     <sergey.senozhatsky.work@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <sergey.senozhatsky@gmail.com>
Subject: RE: [next] kbuild: use $(srctree) instead of KBUILD_SRC to check
 out-of-tree build
Thread-Topic: [next] kbuild: use $(srctree) instead of KBUILD_SRC to check
 out-of-tree build
Thread-Index: AQHU9oqaBkqafxKYBk6eibRvw8CxlaZDLaAQ
Date:   Fri, 19 Apr 2019 08:59:53 +0000
Message-ID: <43c5127830dd44e0817c2aa1906fe515@SOC-EX01V.e01.socionext.com>
References: <20190419083339.GA8504@jagdpanzerIV>
In-Reply-To: <20190419083339.GA8504@jagdpanzerIV>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY190117
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2V5LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlcmdl
eSBTZW5vemhhdHNreSBbbWFpbHRvOnNlcmdleS5zZW5vemhhdHNreS53b3JrQGdtYWlsLmNvbV0N
Cj4gU2VudDogRnJpZGF5LCBBcHJpbCAxOSwgMjAxOSA1OjM0IFBNDQo+IFRvOiBZYW1hZGEsIE1h
c2FoaXJvL+WxseeUsCDnnJ/lvJggPHlhbWFkYS5tYXNhaGlyb0Bzb2Npb25leHQuY29tPg0KPiBD
YzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2VyZ2V5IFNlbm96aGF0c2t5DQo+IDxz
ZXJnZXkuc2Vub3poYXRza3lAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbbmV4dF0ga2J1aWxkOiB1
c2UgJChzcmN0cmVlKSBpbnN0ZWFkIG9mIEtCVUlMRF9TUkMgdG8gY2hlY2sNCj4gb3V0LW9mLXRy
ZWUgYnVpbGQNCj4gDQo+IEhlbGxvIE1hc2FoaXJvLA0KPiANCj4gSXQgc2VlbXMgdGhhdCBjb21t
aXQgYTlhNDljMmFkOWI5YjggKGxpbnV4LW5leHQpIGJyZWFrcyAuL3NjcmlwdHMvdGFncy5zaA0K
PiBvbiBteSBzeXN0ZW0uIEl0IHNjYW5zLCBiYXNpY2FsbHksIG15IGVudGlyZSBkcml2ZSBub3cg
KGluY2x1ZGluZyB0aGUNCj4gcm9vdCBwYXJ0aXRpb24pOg0KPiANCj4gJCAuL3NjcmlwdHMvdGFn
cy5zaCB0YWdzDQoNCg0KSSBkaWQgbm90IGtub3cgdGhpcyBzY3JpcHQgaXMgcnVuIGRpcmVjdGx5
DQpiZWNhdXNlIEkgZXhwZWN0ZWQgcGVvcGxlIHdlcmUgdXNpbmcgJ21ha2UgdGFncycuDQoNCkl0
IGlzIGVhc3kgdG8gZml4LCB0aG91Z2guDQoNCg0KZGlmZiAtLWdpdCBhL3NjcmlwdHMvdGFncy5z
aCBiL3NjcmlwdHMvdGFncy5zaA0KaW5kZXggNmE1NTE4MDVkYjUyLi43MGUxNGM2N2JkZTcgMTAw
NzU1DQotLS0gYS9zY3JpcHRzL3RhZ3Muc2gNCisrKyBiL3NjcmlwdHMvdGFncy5zaA0KQEAgLTE5
LDcgKzE5LDcgQEAgaWdub3JlPSIkaWdub3JlICggLW5hbWUgKi5tb2QuYyApIC1wcnVuZSAtbyIN
CiAjIERvIG5vdCB1c2UgZnVsbCBwYXRoIGlmIHdlIGRvIG5vdCB1c2UgTz0uLiBidWlsZHMNCiAj
IFVzZSBtYWtlIE89LiB7dGFnc3xjc2NvcGV9DQogIyB0byBmb3JjZSBmdWxsIHBhdGhzIGZvciBh
IG5vbi1PPSBidWlsZA0KLWlmIFsgIiR7c3JjdHJlZX0iID0gIi4iIF07IHRoZW4NCitpZiBbICIk
e3NyY3RyZWV9IiA9ICIuIiAtbyAteiAiJHtzcmN0cmVlfSIgXTsgdGhlbg0KICAgICAgICB0cmVl
PQ0KIGVsc2UNCiAgICAgICAgdHJlZT0ke3NyY3RyZWV9Lw0KDQoNCg0KPiBmaW5kOiDigJgvYXJj
aC8qLltjaFNdL+KAmTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiBmaW5kOiDigJgvaW5j
bHVkZeKAmTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiBmaW5kOiDigJgvYm9vdC9sb3N0
K2ZvdW5k4oCZOiBQZXJtaXNzaW9uIGRlbmllZA0KPiBmaW5kOiDigJgvZXRjL3BhY21hbi5kL2du
dXBnL29wZW5wZ3AtcmV2b2NzLmTigJk6IFBlcm1pc3Npb24gZGVuaWVkDQo+IGZpbmQ6IOKAmC9l
dGMvcGFjbWFuLmQvZ251cGcvcHJpdmF0ZS1rZXlzLXYxLmTigJk6IFBlcm1pc3Npb24gZGVuaWVk
DQo+IGZpbmQ6IOKAmC9ldGMvcGFjbWFuLmQvZ251cGcvY3Jscy5k4oCZOiBQZXJtaXNzaW9uIGRl
bmllZA0KPiBmaW5kOiDigJgvZXRjL3BvbGtpdC0xL3J1bGVzLmTigJk6IFBlcm1pc3Npb24gZGVu
aWVkDQo+IGZpbmQ6IOKAmC9ldGMvc3Vkb2Vycy5k4oCZOiBQZXJtaXNzaW9uIGRlbmllZA0KPiBm
aW5kOiDigJgvZXRjL2F1ZGlzcC9wbHVnaW5zLmTigJk6IFBlcm1pc3Npb24gZGVuaWVkDQo+IGZp
bmQ6IOKAmC9ob21lL2xvc3QrZm91bmTigJk6IFBlcm1pc3Npb24gZGVuaWVkDQo+IGZpbmQ6IOKA
mC9ob21lL3Nr4oCZOiBQZXJtaXNzaW9uIGRlbmllZA0KPiBmaW5kOiDigJgvbG9zdCtmb3VuZOKA
mTogUGVybWlzc2lvbiBkZW5pZWQNCj4gY3RhZ3M6IFdhcm5pbmc6IC0tZXh0cmEgb3B0aW9uIGlz
IG9ic29sZXRlOyB1c2UgLS1leHRyYXMgaW5zdGVhZA0KPiBbLi5dDQo+IA0KPiANCj4gV2l0aCBy
ZXZlcnRlZCBhOWE0OWMyYWQ5YjliOCB0YWdzIHNjYW5zIGtlcm5lbCBzb3VyY2UgdHJlZSBvbmx5
DQo+IA0KPiAuL3NjcmlwdHMvdGFncy5zaCB0YWdzDQo+IGZpbmQ6IOKAmGFyY2gvKi5bY2hTXS/i
gJk6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gY3RhZ3M6IFdhcm5pbmc6IC0tZXh0cmEg
b3B0aW9uIGlzIG9ic29sZXRlOyB1c2UgLS1leHRyYXMgaW5zdGVhZA0KPiBbLi5dDQo+IA0KPiAJ
LXNzDQo=
