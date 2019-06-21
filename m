Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12EDC48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CB02075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="f+Jx5nMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFUOBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:01:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44064 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFUOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:01:50 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LDuf6Q019584;
        Fri, 21 Jun 2019 16:01:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=ExRPSHAf2oaqoI/rvhpwZf2rtDMJg0QWAnnvxeZLPVI=;
 b=f+Jx5nMQp4ZRubCQ1iz1vgxfPg7ERoECkB6K/IN0XgRRT/rzSCYsGsuNV0haltz+9XcH
 7pfn75dECHZantSm1xIcyiRmj304+sDrc4Xbnf+AkVgjVDCU/AC6vVvmI+9Z+vvfz1U4
 Vct4KACAeBV/SiwjzYInOXtsLPVvnjG2JDO7ENsXOmLQeJFkW8nMFIS1FYPdLCHBRGAb
 59dzPvK4mrlqnbATvgSRS7wFLxY/QQgw/fVHwreLtGToEg6LXf6iDFY3rMduZL+7K6tN
 mMs+XrgYhVUzXUgY0TkJ5fI8o4m4SCqzHvlDfdVa2VF9LaaE9uNVv+xZAgWzz4Zr0XZ0 Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813qkj6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Jun 2019 16:01:34 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 61B093D;
        Fri, 21 Jun 2019 14:01:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F072E2B25;
        Fri, 21 Jun 2019 14:01:31 +0000 (GMT)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Jun
 2019 16:01:31 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1347.000; Fri, 21 Jun 2019 16:01:31 +0200
From:   Yannick FERTRE <yannick.fertre@st.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     Philippe CORNU <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "ML dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/stm: drv: fix suspend/resume
Thread-Topic: [PATCH 1/3] drm/stm: drv: fix suspend/resume
Thread-Index: AQHVJNzXIA8cZ3x1+kCqnLPAiEBAX6akq10AgAFdCYA=
Date:   Fri, 21 Jun 2019 14:01:31 +0000
Message-ID: <2c169739-febb-12a9-0fa1-d5da053ded67@st.com>
References: <1560755897-5002-1-git-send-email-yannick.fertre@st.com>
 <CACvgo50vSNCTTTKp9D_07tazOE9YkU-zKAsDywvWe6h0NgcEmQ@mail.gmail.com>
In-Reply-To: <CACvgo50vSNCTTTKp9D_07tazOE9YkU-zKAsDywvWe6h0NgcEmQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <662427F63BD55B4D8D5465D3980AEB62@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRW1pbCwNCg0KVGhlIG1zbSBkcml2ZXIgdGVzdHMgdGhlIHJldHVybiB2YWx1ZSAmIHNldCBz
dGF0ZSB0byBOVUxMIGlmIG5vIGVycm9yIGlzIA0KZGV0ZWN0ZWQuDQoNCnRoZSBsdGRjIGRyaXZl
ciB0ZXN0cyB0aGUgcmV0dXJuIHZhbHVlICYgZm9yY2UgdG8gc3VzcGVuZCBpZiBhbiBlcnJvciBp
cyANCmRldGVjdGVkLg0KDQpJdCdzIG5vdCBleGFjdGx5IHRoZSBzYW1lLg0KDQpCZXN0IHJlZ2Fy
ZHMNCg0KDQotLSANCllhbm5pY2sgRmVydHLDqSB8IFRJTkE6IDE2NiA3MTUyIHwgVGVsOiArMzMg
MjQ0MDI3MTUyIHwgTW9iaWxlOiArMzMgNjIwNjAwMjcwDQpNaWNyb2NvbnRyb2xsZXJzIGFuZCBE
aWdpdGFsIElDcyBHcm91cCB8IE1pY3JvY29udHJvbGxldXJzIERpdmlzaW9uDQoNCk9uIDYvMjAv
MTkgNzoxMiBQTSwgRW1pbCBWZWxpa292IHdyb3RlOg0KPiBIaSBZYW5uaWNrLA0KPg0KPiBPbiBN
b24sIDE3IEp1biAyMDE5IGF0IDA4OjE4LCBZYW5uaWNrIEZlcnRyw6kgPHlhbm5pY2suZmVydHJl
QHN0LmNvbT4gd3JvdGU6DQo+DQo+PiBAQCAtMTU1LDE1ICsxNTQsMTcgQEAgc3RhdGljIF9fbWF5
YmVfdW51c2VkIGludCBkcnZfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgICAgICAg
IHN0cnVjdCBsdGRjX2RldmljZSAqbGRldiA9IGRkZXYtPmRldl9wcml2YXRlOw0KPj4gICAgICAg
ICAgaW50IHJldDsNCj4+DQo+PiArICAgICAgIGlmIChXQVJOX09OKCFsZGV2LT5zdXNwZW5kX3N0
YXRlKSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsNCj4+ICsNCj4+ICAgICAg
ICAgIHBtX3J1bnRpbWVfZm9yY2VfcmVzdW1lKGRldik7DQo+PiAgICAgICAgICByZXQgPSBkcm1f
YXRvbWljX2hlbHBlcl9yZXN1bWUoZGRldiwgbGRldi0+c3VzcGVuZF9zdGF0ZSk7DQo+PiAtICAg
ICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgaWYgKHJldCkNCj4gSG1tIHRoZSBtc20gZHJpdmVy
IHVzZXMgIXJldCBoZXJlLiBTdXNwZWN0aW5nIHRoYXQgeW91IHdhbnQgdGhlIHNhbWUsDQo+IGFs
dGhvdWdoIEkgaGF2ZW4ndCBjaGVja2VkIGluIGRldGFpbC4NCj4NCj4gSFRIDQo+IC1FbWlsDQot
LSANCllhbm5pY2sgRmVydHLDqSB8IFRJTkE6IDE2NiA3MTUyIHwgVGVsOiArMzMgMjQ0MDI3MTUy
IHwgTW9iaWxlOiArMzMgNjIwNjAwMjcwDQpNaWNyb2NvbnRyb2xsZXJzIGFuZCBEaWdpdGFsIElD
cyBHcm91cCB8IE1pY3JvY29udHJvbGxldXJzIERpdmlzaW9u
