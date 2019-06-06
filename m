Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7EDC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93735206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fiBqVAL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfFFPs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:48:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37303 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729156AbfFFPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:48:26 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56FkhkV020575;
        Thu, 6 Jun 2019 17:48:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=gGCf28774irLLSKFXYWcYkPoYMFVE7Vt0PR7IMC2LZY=;
 b=fiBqVAL0EjZRJKzxblB62imKyCV/3cHFrVj4nR7fLs+a/s3NvoQw7ufiFo+9e11zwXEP
 u6e+P4AuuRwKzycKkiEs1eRtvV2hvnDVLIjFjmlLeN7lp3wPaNbh14hKEJpJsF4627sB
 XyDc6XL1YvPfTrxEfNpPPLlAS42B2MLCGdT5xuX91wA12Yh8HpnJTKOtk6H32aD2tlrh
 TjxuKeQUbGbUi0N3fAiNYbu0rjZmiMb8ITYZohDjGcc6ro1VlR4gRGGd21uV+pxj+7qX
 WW6n3WuKH84RFDTMDti12vRtU3vZf8YSObvVg6v82gm9spc07XTRLfh4zWYfwEPbozhO vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sxqxmv5ws-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Jun 2019 17:48:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7A9B31;
        Thu,  6 Jun 2019 15:48:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E6812B23;
        Thu,  6 Jun 2019 15:48:06 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Jun
 2019 17:48:06 +0200
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Thu, 6 Jun 2019 17:48:06 +0200
From:   Erwan LE RAY <erwan.leray@st.com>
To:     Borut Seljak <borut.seljak@t-2.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] serial: stm32: fix a recursive locking in
 stm32_config_rs485
Thread-Topic: [PATCH v3] serial: stm32: fix a recursive locking in
 stm32_config_rs485
Thread-Index: AQHVHFHrSWlGRhgeoU6uFgV0pT5nv6aOpEqA
Date:   Thu, 6 Jun 2019 15:48:06 +0000
Message-ID: <e0f8d4b2-a622-3758-473b-b78bd8949323@st.com>
References: <erwan.leray@st.com> <20190606101901.31151-1-borut.seljak@t-2.net>
In-Reply-To: <20190606101901.31151-1-borut.seljak@t-2.net>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7F0DC97BDB15B4E944187432787DEC1@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA2LzYvMTkgMTI6MTkgUE0sIEJvcnV0IFNlbGphayB3cm90ZToNCj4gUmVtb3ZlIHNwaW5f
bG9ja19pcnFzYXZlIGluIHN0bTMyX2NvbmZpZ19yczQ4NSwgaXQgY2F1c2UgcmVjdXJzaXZlIGxv
Y2tpbmcuDQo+IEFscmVhZHkgbG9ja2VkIGluIHVhcnRfc2V0X3JzNDg1X2NvbmZpZy4NCj4NCj4g
Zml4ZXM6IDFiY2RhMDlkMjkxMDgxICgic2VyaWFsOiBzdG0zMjogYWRkIHN1cHBvcnQgZm9yIFJT
NDg1IGhhcmR3YXJlIGNvbnRyb2wgbW9kZSIpDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJvcnV0IFNl
bGphayA8Ym9ydXQuc2VsamFrQHQtMi5uZXQ+DQoNCkhpIEJvcnV0LA0KDQpUaGFua3MgZm9yIHlv
dXIgcGF0Y2guDQoNCkFja2VkLWJ5OiBFcndhbiBMZSBSYXkgPGVyd2FuLmxlcmF5QHN0LmNvbT4N
Cg0KUGxlYXNlIGNvcnJlY3QgYSB0eXBvIGluIGNvbW1pdCBtZXNzYWdlOiAiRml4ZXMiIGluc3Rl
YWQgImZpeGVzIg0KDQpFcndhbi4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL3R0eS9zZXJpYWwvc3Rt
MzItdXNhcnQuYyB8IDMgLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jDQo+IGluZGV4IGU4ZDdhN2JiNDMzOS4uNWQwNzJl
YzYxMDcxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYw0K
PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYw0KPiBAQCAtMTA1LDkgKzEw
NSw3IEBAIHN0YXRpYyBpbnQgc3RtMzJfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBv
cnQsDQo+ICAgCXN0cnVjdCBzdG0zMl91c2FydF9jb25maWcgKmNmZyA9ICZzdG0zMl9wb3J0LT5p
bmZvLT5jZmc7DQo+ICAgCXUzMiB1c2FydGRpdiwgYmF1ZCwgY3IxLCBjcjM7DQo+ICAgCWJvb2wg
b3Zlcjg7DQo+IC0JdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gICANCj4gLQlzcGluX2xvY2tfaXJx
c2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOw0KPiAgIAlzdG0zMl9jbHJfYml0cyhwb3J0LCBvZnMt
PmNyMSwgQklUKGNmZy0+dWFydF9lbmFibGVfYml0KSk7DQo+ICAgDQo+ICAgCXBvcnQtPnJzNDg1
ID0gKnJzNDg1Y29uZjsNCj4gQEAgLTE0Nyw3ICsxNDUsNiBAQCBzdGF0aWMgaW50IHN0bTMyX2Nv
bmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LA0KPiAgIAl9DQo+ICAgDQo+ICAgCXN0
bTMyX3NldF9iaXRzKHBvcnQsIG9mcy0+Y3IxLCBCSVQoY2ZnLT51YXJ0X2VuYWJsZV9iaXQpKTsN
Cj4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwb3J0LT5sb2NrLCBmbGFncyk7DQo+ICAgDQo+
ICAgCXJldHVybiAwOw0KPiAgIH0=
