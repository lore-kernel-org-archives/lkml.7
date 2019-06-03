Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D0C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8639027DDE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="iBU5FywK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfFCI7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:59:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58528 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbfFCI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:59:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x538uY80031648;
        Mon, 3 Jun 2019 10:58:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=vhx7EIV6xeOk88gkHCWKERKEgt0npZQLR8heaw2xtlI=;
 b=iBU5FywKEi3ZkJQl6/SQMMRxLzzSRD/Eh7hyB26luQ4OXcKfxat0CRmyHsgGxNFeHFyR
 pPFuoebFRxQncEC1f4CkjkvA0k3KIbZgEoboD3qYiHorHGB6Ap7x0RcZGHhIa8SxoO3s
 M6dtdXjJdRr8/OushmrOIRehhAg1He4MtnXmdwk/pthOcqYOmrdLnwSnl29GnynCmNpW
 5BqPAh0ZY3zGXvt+qR7kU4qxAFh+3LhJhUJDZswAVXGaCXlOBuJa8HHKBgKE4bKoCuU3
 wyOjkBEQGr4W6zc4flWsYevXZKvWuTlId5XwuImAoWjaObg3gxWq6hsm6cawDYGjRxRH tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sundrsbtr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Jun 2019 10:58:54 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0DFDC3F;
        Mon,  3 Jun 2019 08:58:53 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D063F1645;
        Mon,  3 Jun 2019 08:58:52 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Jun
 2019 10:58:52 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 3 Jun 2019 10:58:52 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] usb: host: ehci-st: Remove set but not used
 variable 'ehci'
Thread-Topic: [PATCH -next] usb: host: ehci-st: Remove set but not used
 variable 'ehci'
Thread-Index: AQHVFVu5oOZw623mTkKrd0PNUsnGP6aJiNsA
Date:   Mon, 3 Jun 2019 08:58:52 +0000
Message-ID: <0c5c8b72-0242-bd9e-24d2-fb48bd5dbfe3@st.com>
References: <20190528134529.17612-1-yuehaibing@huawei.com>
In-Reply-To: <20190528134529.17612-1-yuehaibing@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8E577DA51A7EA43A8B47DF0E9F0A2D8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KT24gNS8yOC8xOSAzOjQ1IFBNLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBGaXhlcyBnY2Mg
Jy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL3VzYi9o
b3N0L2VoY2ktc3QuYzogSW4gZnVuY3Rpb24gc3RfZWhjaV9wbGF0Zm9ybV9wcm9iZToNCj4gZHJp
dmVycy91c2IvaG9zdC9laGNpLXN0LmM6MTU1OjE5OiB3YXJuaW5nOiB2YXJpYWJsZSBlaGNpIHNl
dCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+IA0KPiBJdCBpcyBu
ZXZlciB1c2VkLCBzbyBjYW4gYmUgcmVtb3ZlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhh
aWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9ob3N0
L2VoY2ktc3QuYyB8IDIgLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1zdC5jIGIvZHJpdmVycy91c2Iv
aG9zdC9laGNpLXN0LmMNCj4gaW5kZXggZGM0Mjk4MTA0N2M5Li5jY2I0ZTYxMTAwMWQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2hvc3QvZWhjaS1zdC5jDQo+IEBAIC0xNTIsNyArMTUyLDYgQEAgc3RhdGljIGludCBzdF9laGNp
X3BsYXRmb3JtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikNCj4gIAlzdHJ1Y3Qg
cmVzb3VyY2UgKnJlc19tZW07DQo+ICAJc3RydWN0IHVzYl9laGNpX3BkYXRhICpwZGF0YSA9ICZl
aGNpX3BsYXRmb3JtX2RlZmF1bHRzOw0KPiAgCXN0cnVjdCBzdF9laGNpX3BsYXRmb3JtX3ByaXYg
KnByaXY7DQo+IC0Jc3RydWN0IGVoY2lfaGNkICplaGNpOw0KPiAgCWludCBlcnIsIGlycSwgY2xr
ID0gMDsNCj4gIA0KPiAgCWlmICh1c2JfZGlzYWJsZWQoKSkNCj4gQEAgLTE3Nyw3ICsxNzYsNiBA
QCBzdGF0aWMgaW50IHN0X2VoY2lfcGxhdGZvcm1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqZGV2KQ0KPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKGRldiwgaGNkKTsNCj4gIAlkZXYtPmRl
di5wbGF0Zm9ybV9kYXRhID0gcGRhdGE7DQo+ICAJcHJpdiA9IGhjZF90b19laGNpX3ByaXYoaGNk
KTsNCj4gLQllaGNpID0gaGNkX3RvX2VoY2koaGNkKTsNCj4gIA0KPiAgCXByaXYtPnBoeSA9IGRl
dm1fcGh5X2dldCgmZGV2LT5kZXYsICJ1c2IiKTsNCj4gIAlpZiAoSVNfRVJSKHByaXYtPnBoeSkp
IHsNCj4gDQoNCg0KQWNrZWQtYnk6IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQHN0
LmNvbT4NCg0KVGhhbmtzDQoNClBhdHJpY2U=
