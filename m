Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B63C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6772240E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ip7iVblj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKSUAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:00:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22960 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbfKSUAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:00:00 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJJgDbS021254;
        Tue, 19 Nov 2019 20:59:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=cVy/bt4cw6kZCF28y2TA2VipfYUSKT4PaUvUMRbKWsA=;
 b=ip7iVbljgd/rVZRvnC8lU4dcPugz3zv+zCB5LIjUCcequSIdCl1+QkxIIb3I3JzujPQz
 9HX2neSSoTno6okF4BASO8TpaEADC0ghzhXOFLAC0HGCFda6GdUqfFE7sT6kbxulBBJ7
 tVoKmd6F5TJm/j9IbBNHLKsPzPIglqFc8l6qNm6JYiS1SpPKAmPUxdf9sGjfO5NRB2Ln
 8Jeh07ivdTmUEbOl+LP/9l7YE766GZewDuv0VyxlrOeumaVDHGFJhMPBVYWXnLNJSM6+
 2KSFQ/3LUxdnfEo1z2gdXhmY8W8WjMr3j7J23guujVTgsB05nXPFoNIqlrH7kc8uTu4o +Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9up1knu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 20:59:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED68010002A;
        Tue, 19 Nov 2019 20:59:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4BFE2B94EE;
        Tue, 19 Nov 2019 20:59:45 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Nov
 2019 20:59:45 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 19 Nov 2019 20:59:45 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     "Souza, Jose" <jose.souza@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/crtc-helper: drm_connector_get_single_encoder
 prototype is missing
Thread-Topic: [PATCH] drm/crtc-helper: drm_connector_get_single_encoder
 prototype is missing
Thread-Index: AQHVntkBzHviK+RvC0uNrMl+exNxkaeSxriAgAASmAA=
Date:   Tue, 19 Nov 2019 19:59:44 +0000
Message-ID: <6ad4ff49-240b-a665-d229-20e177fa6b2f@st.com>
References: <20191119125805.4266-1-benjamin.gaignard@st.com>
 <f6f32b4d8d8e271953f887c50793f9d64d48e7b3.camel@intel.com>
In-Reply-To: <f6f32b4d8d8e271953f887c50793f9d64d48e7b3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2E1B40B3CB9EF47BBF9C0BEAC8264D5@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS8xOS8xOSA3OjUzIFBNLCBTb3V6YSwgSm9zZSB3cm90ZToNCj4gT24gVHVlLCAyMDE5
LTExLTE5IGF0IDEzOjU4ICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4+IEluY2x1
ZGUgZHJtX2NydGNfaGVscGVyX2ludGVybmFsLmggdG8gcHJvdmlkZQ0KPj4gZHJtX2Nvbm5lY3Rv
cl9nZXRfc2luZ2xlX2VuY29kZXINCj4+IHByb3RvdHlwZS4NCj4+DQo+PiBGaXhlczogYTkyNDYy
ZDZiZjQ5MyAoImRybS9jb25uZWN0b3I6IFNoYXJlIHdpdGggbm9uLWF0b21pYyBkcml2ZXJzDQo+
PiB0aGUgZnVuY3Rpb24gdG8gZ2V0IHRoZSBzaW5nbGUgZW5jb2RlciIpDQo+IGRybV9jb25uZWN0
b3JfZ2V0X3NpbmdsZV9lbmNvZGVyKCkgaXMgaW1wbGVtZW50ZWQgYmVmb3JlIHRoZSB1c2UgaW4N
Cj4gdGhpcyBmaWxlIHNvIGl0IGlzIG5vdCBicm9rZW4sIG5vIG5lZWQgb2YgYSBmaXhlcyB0YWcu
DQo+DQo+IFJldmlld2VkLWJ5OiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNvdXphQGlu
dGVsLmNvbT4NCg0KSSB3aWxsIHJlbW92ZSBmaXhlIHRhZyBiZWZvcmUgcHVzaCBpdC4NCg0KVGhh
bmtzLA0KDQpCZW5qYW1pbg0KDQo+DQo+PiBDYzogSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8am9z
ZS5zb3V6YUBpbnRlbC5jb20+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gR2FpZ25h
cmQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vZHJtX2NydGNfaGVscGVyLmMgfCAyICsrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9jcnRjX2hl
bHBlci5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fY3J0Y19oZWxwZXIuYw0KPj4gaW5kZXgg
NDk5YjA1YWFjY2ZjLi45M2E0ZWVjNDI5ZTggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vZHJtX2NydGNfaGVscGVyLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fY3J0Y19o
ZWxwZXIuYw0KPj4gQEAgLTQ4LDYgKzQ4LDggQEANCj4+ICAgI2luY2x1ZGUgPGRybS9kcm1fcHJp
bnQuaD4NCj4+ICAgI2luY2x1ZGUgPGRybS9kcm1fdmJsYW5rLmg+DQo+PiAgIA0KPj4gKyNpbmNs
dWRlICJkcm1fY3J0Y19oZWxwZXJfaW50ZXJuYWwuaCINCj4+ICsNCj4+ICAgLyoqDQo+PiAgICAq
IERPQzogb3ZlcnZpZXcNCj4+ICAgICo=
