Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DFDC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CB4216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="MKoAph3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfEHTiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:38:55 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:40262 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbfEHTiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:38:54 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48JaHXk020910
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 15:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=RG3fYOhlX+j9LA9OuPSHT6FI9k57l6698BnyP71APwc=;
 b=MKoAph3EjoHUwsyWYD4fJqgB+udMdAcfqhPWhGpFWmGxWMSyDoHb+HlLojtToY5/+4fG
 YyfjV/Gy47ejczf7P3nc1WrDlIIvOfkn8XvC+ynpgHATVg59qZRA9evqhRP/6dTxN++V
 hb6WCWDmky9ejH8M22fYyk7g2xVALaH9WW/8ww5J9y9ngadiAulkU0f4VGMpFhLFSEu6
 vIFjEapw099/STEXzDQVsWK3rY1ztnX5p7noD2k+3yx4MY4gpgjmgvx0c6O2qY3sqUVQ
 +N6rWOs6pH8MZb2jb663+MTXGwdhfT4fh4qDiI2rNsL+ldP8z3SZnfZDn2ffdELQKVV8 sQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2sb5mwep7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:38:53 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48JWw0E005417
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 15:38:53 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2sc32828x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:38:53 -0400
X-LoopCount0: from 10.166.132.130
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1233281014"
From:   <Mario.Limonciello@dell.com>
To:     <kai.heng.feng@canonical.com>, <kbusch@kernel.org>
CC:     <keith.busch@intel.com>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Topic: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Index: AQHVBdBS/xizqbOjGUOY5SKUREVH6KZh7T4AgAAD4gD//6zksA==
Date:   Wed, 8 May 2019 19:38:50 +0000
Message-ID: <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
In-Reply-To: <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=979 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080119
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905080119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWku
aGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDgsIDIwMTkg
MjozMCBQTQ0KPiBUbzogS2VpdGggQnVzY2gNCj4gQ2M6IEtlaXRoIEJ1c2NoOyBheGJvZUBmYi5j
b207IGhjaEBsc3QuZGU7IHNhZ2lAZ3JpbWJlcmcubWU7IGxpbnV4LQ0KPiBudm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpbW9uY2llbGxvLCBN
YXJpbw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBudm1lLXBjaTogVXNlIG5vbi1vcGVyYXRpb25h
bCBwb3dlciBzdGF0ZSBpbnN0ZWFkIG9mIEQzIG9uDQo+IFN1c3BlbmQtdG8tSWRsZQ0KPiANCj4g
DQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4gDQo+IGF0IDAzOjE2LCBLZWl0aCBCdXNjaCA8a2J1c2No
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gPiBPbiBUaHUsIE1heSAwOSwgMjAxOSBhdCAwMjo1
OTo1NUFNICswODAwLCBLYWktSGVuZyBGZW5nIHdyb3RlOg0KPiA+PiArc3RhdGljIGludCBudm1l
X2RvX3Jlc3VtZV9mcm9tX2lkbGUoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4+ICt7DQo+ID4+
ICsJc3RydWN0IG52bWVfZGV2ICpuZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+PiAr
CWludCByZXN1bHQ7DQo+ID4+ICsNCj4gPj4gKwlwZGV2LT5kZXZfZmxhZ3MgJj0gflBDSV9ERVZf
RkxBR1NfTk9fRDM7DQo+ID4+ICsJbmRldi0+Y3RybC5zdXNwZW5kX3RvX2lkbGUgPSBmYWxzZTsN
Cj4gPj4gKw0KPiA+PiArCXJlc3VsdCA9IHBjaV9hbGxvY19pcnFfdmVjdG9ycyhwZGV2LCAxLCAx
LCBQQ0lfSVJRX0FMTF9UWVBFUyk7DQo+ID4+ICsJaWYgKHJlc3VsdCA8IDApDQo+ID4+ICsJCWdv
dG8gb3V0Ow0KPiA+PiArDQo+ID4+ICsJcmVzdWx0ID0gbnZtZV9wY2lfY29uZmlndXJlX2FkbWlu
X3F1ZXVlKG5kZXYpOw0KPiA+PiArCWlmIChyZXN1bHQpDQo+ID4+ICsJCWdvdG8gb3V0Ow0KPiA+
PiArDQo+ID4+ICsJcmVzdWx0ID0gbnZtZV9hbGxvY19hZG1pbl90YWdzKG5kZXYpOw0KPiA+PiAr
CWlmIChyZXN1bHQpDQo+ID4+ICsJCWdvdG8gb3V0Ow0KPiA+PiArDQo+ID4+ICsJbmRldi0+Y3Ry
bC5tYXhfaHdfc2VjdG9ycyA9IE5WTUVfTUFYX0tCX1NaIDw8IDE7DQo+ID4+ICsJbmRldi0+Y3Ry
bC5tYXhfc2VnbWVudHMgPSBOVk1FX01BWF9TRUdTOw0KPiA+PiArCW11dGV4X3VubG9jaygmbmRl
di0+c2h1dGRvd25fbG9jayk7DQo+ID4NCj4gPiBUaGlzIGxvY2sgd2FzIG5ldmVyIGxvY2tlZC4N
Cj4gDQo+IFllYSwgd2lsbCBmaXggdGhpcy4NCj4gDQo+ID4NCj4gPiBCdXQgSSB0aGluayB0aGVz
ZSBzcGVjaWFsIHN1c3BlbmQvcmVzdW1lIHJvdXRpbmVzIGFyZSB0b28gc2ltaWxhciB0byB0aGUN
Cj4gPiBleGlzdGluZyBvbmVzLCB0aGV5IHNob3VsZCBqdXN0IGluY29ycG9yYXRlIHRoaXMgZmVh
dHVyZSBpZiB3ZSBuZWVkIHRvDQo+ID4gZG8gdGhpcy4NCj4gDQo+IFRoYXTigJlzIG15IG9yaWdp
bmFsIGRpcmVjdGlvbiwgYnV0IHRoaXMgcmVxdWlyZXMgYSBuZXcgYm9vbCB0bw0KPiBudm1lX2Rl
dl9kaXNhYmxlKCksIHNvIGl0IGJlY29tZXMNCj4gc3RhdGljIHZvaWQgbnZtZV9kZXZfZGlzYWJs
ZShzdHJ1Y3QgbnZtZV9kZXYgKmRldiwgYm9vbCBzaHV0ZG93biwgYm9vbA0KPiBzdXNwZW5kX3Rv
X2lkbGUpDQo+IA0KPiBBbmQgaXQgc3RhcnRzIHRvIGdldCBtZXNzeS4NCj4gDQoNClRoZSBleGlz
dGluZyByb3V0aW5lcyBoYXZlIGFuIGltcGxpZWQgYXNzdW1wdGlvbiB0aGF0IGZpcm13YXJlIHdp
bGwgY29tZSBzd2luZ2luZw0Kd2l0aCBhIGhhbW1lciB0byBjb250cm9sIHRoZSByYWlscyB0aGUg
U1NEIHNpdHMgb24uDQpXaXRoIFMySSBldmVyeXRoaW5nIG5lZWRzIHRvIGNvbWUgZnJvbSB0aGUg
ZHJpdmVyIHNpZGUgYW5kIGl0IHJlYWxseSBpcyBhDQpkaWZmZXJlbnQgcGFyYWRpZ20uDQo=
