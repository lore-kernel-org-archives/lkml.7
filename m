Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31155C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ACF204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Tdcdoko4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390676AbfHBIB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:01:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55868 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728268AbfHBIB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:01:56 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x727l47J024706;
        Fri, 2 Aug 2019 10:01:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=80WZ1+E55pChQRiPbqt3WX05FkkFhBCqjh5SB5ZS5fU=;
 b=Tdcdoko4/Ul2MgZc8VNexIOx7Y7AdHu0tU6ZmZO1RCcaDlQ4Mm6S8BAXI/d0Bf4w/x5L
 PAtYTxeQa+6OXF+NzoIZ0+eVWgGSasfPZguOPE3Rnl8yMPv2XXu7Q3aI37WdCCklP8by
 IXuDY+jcWMyaFmqJmTXT9GOzAjAexdHNR+CLIEChJXig3RgwC5XozwV61XbIyhVM7q0t
 cbah+wX39NhXVPHhzInc/ICWKjTihpL8QFcOrmXOF9tlSFh1SsaTJCTeP6KTOHhc7qYW
 qv9IcqYepZqae+BM6Ztto0C1didEPB6CzEXuGish6odXbSUZVoV/WDD+VVN/YvNLMrH3 Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u2jp4t4w2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 02 Aug 2019 10:01:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D1CA646;
        Fri,  2 Aug 2019 08:01:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACC2F207407;
        Fri,  2 Aug 2019 10:01:41 +0200 (CEST)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 2 Aug
 2019 10:01:41 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1473.003; Fri, 2 Aug 2019 10:01:41 +0200
From:   Yannick FERTRE <yannick.fertre@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Subject: Re: [PATCH] ARM: dts: stm32: add phy-dsi-supply property on
 stm32mp157c-ev1
Thread-Topic: [PATCH] ARM: dts: stm32: add phy-dsi-supply property on
 stm32mp157c-ev1
Thread-Index: AQHVRhn/pZrojeZIhUaYEdH8ko+CKKbnXDWAgAAHFwA=
Date:   Fri, 2 Aug 2019 08:01:40 +0000
Message-ID: <4e53ec28-0368-7ad8-1397-4d3d3172f02e@st.com>
References: <1564410548-20436-1-git-send-email-yannick.fertre@st.com>
 <346d04ad-17ed-40c8-f10a-b13a2ea79d92@st.com>
In-Reply-To: <346d04ad-17ed-40c8-f10a-b13a2ea79d92@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDDF93E406C16842AF9F6D3FE37A2808@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFueSB0aGFua3MgQWxleC4NCg0KT24gOC8yLzE5IDk6MzYgQU0sIEFsZXhhbmRyZSBUb3JndWUg
d3JvdGU6DQo+IEhpIFlhbm5pY2sNCj4NCj4gT24gNy8yOS8xOSA0OjI5IFBNLCBZYW5uaWNrIEZl
cnRyw6kgd3JvdGU6DQo+PiBUaGUgZHNpIHBoeXNpY2FsIGxheWVyIGlzIHBvd2VyZWQgYnkgdGhl
IDF2OCBwb3dlciBjb250cm9sbGVyIHN1cHBseS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5u
aWNrIEZlcnRyw6kgPHlhbm5pY2suZmVydHJlQHN0LmNvbT4NCj4+IC0tLQ0KPj4gwqAgYXJjaC9h
cm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MtZXYxLmR0cyB8IDEgKw0KPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L3N0bTMybXAxNTdjLWV2MS5kdHMgDQo+PiBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdj
LWV2MS5kdHMNCj4+IGluZGV4IGZlYjhmNzcuLjE5ZDY5ZDAgMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy1ldjEuZHRzDQo+PiArKysgYi9hcmNoL2FybS9ib290
L2R0cy9zdG0zMm1wMTU3Yy1ldjEuZHRzDQo+PiBAQCAtMTAxLDYgKzEwMSw3IEBADQo+PiDCoCAm
ZHNpIHsNCj4+IMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiDCoMKgwqDCoMKg
ICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gK8KgwqDCoCBwaHktZHNpLXN1cHBseSA9IDwmcmVnMTg+
Ow0KPj4gwqDCoMKgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+PiDCoCDCoMKgwqDCoMKgIHBvcnRz
IHsNCj4+DQo+DQo+IEFwcGxpZWQgb24gc3RtMzItbmV4dC4NCj4NCj4gVGhhbmtzLg0KPiBBbGV4
DQotLSANCllhbm5pY2sgRmVydHLDqSB8IFRJTkE6IDE2NiA3MTUyIHwgVGVsOiArMzMgMjQ0MDI3
MTUyIHwgTW9iaWxlOiArMzMgNjIwNjAwMjcwDQpNaWNyb2NvbnRyb2xsZXJzIGFuZCBEaWdpdGFs
IElDcyBHcm91cCB8IE1pY3JvY29udHJvbGxldXJzIERpdmlzaW9u
