Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B5C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424F2224B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="gZ1D0SZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfKTOPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:15:24 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:28574 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730565AbfKTOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:15:23 -0500
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKE4kV7001898
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=5PJiZghwnftwVQUE1ZGck5U/PWEgD9JydGOHnmbkruo=;
 b=gZ1D0SZXO+pZFujlwzkey7uHH3ZrvDQre8o0j5mJaANNNph3iz1V3x90W5vu9pSZuvfu
 mWWPczhtC24zTDS1t3rnjaU9K+LW7C2mhdk6VnwDVICL0ElxKPlMJXaD++zEgpV8Hocz
 x1zhidIT8XUybNVpxDrQE6a8UGqumzd5045B+kTOKxUkeBd0Njif/eZtTuEe2cocAjTa
 HffnnJA2t0BY3r6WrMgVamMR0y5Xk3bOYePju8K9JwvvkyYL7wO9ZNdlwcYghjTpQaQY
 rw7oSakg1im+AIEqgfpAInN2B2W72eyT7mdqBurcLwF8IEcRZeWb1zJJobnhBu0m/wz1 /A== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2waenr9geg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:15:22 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKEDm2J143109
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:15:21 -0500
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2wcp98f3m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:15:20 -0500
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="489905008"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <pmenzel@molgen.mpg.de>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <ck@xatom.net>,
        <linux-kernel@vger.kernel.org>, <anthony.wong@canonical.com>
Subject: RE: USB devices on Dell TB16 dock stop working after resuming
Thread-Topic: USB devices on Dell TB16 dock stop working after resuming
Thread-Index: AQHVkxGi4f0HmqPYOkmPAZlfRfFMhqd7dbiAgAAFewCAABDQAP//m/tggABrZQCAAALDgIAXnKiAgAEsYAD//9QgQA==
Date:   Wed, 20 Nov 2019 14:15:17 +0000
Message-ID: <ccfa5f1a1b5e475aa4ddcbed2297b9c4@AUSX13MPC105.AMER.DELL.COM>
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
 <20191104142459.GC2552@lahna.fi.intel.com>
 <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
 <20191120105048.GY11621@lahna.fi.intel.com>
In-Reply-To: <20191120105048.GY11621@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-11-20T14:15:15.4322146Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_04:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200128
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911200127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWthIFdlc3RlcmJlcmcgPG1p
a2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1i
ZXIgMjAsIDIwMTkgNDo1MSBBTQ0KPiBUbzogUGF1bCBNZW56ZWwNCj4gQ2M6IExpbW9uY2llbGxv
LCBNYXJpbzsgQW5kcmVhcyBOb2V2ZXI7IE1pY2hhZWwgSmFtZXQ7IFllaGV6a2VsIEJlcm5hdDsg
Q2hyaXN0aWFuDQo+IEtlbGxuZXI7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFudGhv
bnkgV29uZw0KPiBTdWJqZWN0OiBSZTogVVNCIGRldmljZXMgb24gRGVsbCBUQjE2IGRvY2sgc3Rv
cCB3b3JraW5nIGFmdGVyIHJlc3VtaW5nDQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiAN
Cj4gT24gVHVlLCBOb3YgMTksIDIwMTkgYXQgMDU6NTU6NDNQTSArMDEwMCwgUGF1bCBNZW56ZWwg
d3JvdGU6DQo+ID4gRGVhciBNaWthLA0KPiA+DQo+ID4NCj4gPiBPbiAyMDE5LTExLTA0IDE3OjIx
LCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6DQo+ID4gPiBPbiBNb24sIE5vdiAwNCwgMjAxOSBhdCAw
NToxMToxMFBNICswMTAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4gPg0KPiA+ID4+IE9uIDIwMTkt
MTEtMDQgMTY6NDksIE1hcmlvLkxpbW9uY2llbGxvQGRlbGwuY29tIHdyb3RlOg0KPiA+ID4+DQo+
ID4gPj4+PiBGcm9tOiBNaWthIFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRl
bC5jb20+DQo+ID4gPj4+PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDQsIDIwMTkgOTo0NSBBTQ0K
PiA+ID4+DQo+ID4gPj4+PiBPbiBNb24sIE5vdiAwNCwgMjAxOSBhdCAwNDo0NDo0MFBNICswMjAw
LCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6DQo+ID4gPj4+Pj4gT24gTW9uLCBOb3YgMDQsIDIwMTkg
YXQgMDQ6MjU6MDNQTSArMDIwMCwgTWlrYSBXZXN0ZXJiZXJnIHdyb3RlOg0KPiA+ID4+DQo+ID4g
Pj4+Pj4+IE9uIE1vbiwgTm92IDA0LCAyMDE5IGF0IDAyOjEzOjEzUE0gKzAxMDAsIFBhdWwgTWVu
emVsIHdyb3RlOg0KPiA+ID4+DQo+ID4gPj4+Pj4+PiBPbiB0aGUgRGVsbCBYUFMgMTMgOTM4MCB3
aXRoIERlYmlhbiBTaWQvdW5zdGFibGUgd2l0aCBMaW51eCA1LjMuNw0KPiA+ID4+Pj4+Pj4gc3Vz
cGVuZGluZyB0aGUgc3lzdGVtLCBhbmQgcmVzdW1pbmcgd2l0aCBEZWxs4oCZcyBUaHVuZGVyYm9s
dCBUQjE2DQo+ID4gPj4+Pj4+PiBkb2NrIGNvbm5lY3RlZCwgdGhlIFVTQiBpbnB1dCBkZXZpY2Vz
LCBrZXlib2FyZCBhbmQgbW91c2UsDQo+ID4gPj4+Pj4+PiBjb25uZWN0ZWQgdG8gdGhlIFRCMTYg
c3RvcCB3b3JraW5nLiBUaGV5IHdvcmsgZm9yIGEgZmV3IHNlY29uZHMNCj4gPiA+Pj4+Pj4+ICht
b3VzZSBjdXJzb3IgY2FuIGJlIG1vdmVkKSwgYnV0IHRoZW4gc3RvcCB3b3JraW5nLiBUaGUgbGFw
dG9wDQo+ID4gPj4+Pj4+PiBrZXlib2FyZCBhbmQgdG91Y2hwYWQgc3RpbGwgd29ya3MgZmluZS4g
QWxsIGZpcm13YXJlIGlzIHVwLXRvLWRhdGUNCj4gPiA+Pj4+Pj4+IGFjY29yZGluZyB0byBgZnd1
cGRtZ3JgLg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiBXaGF0IGFyZSB0aGUgZXhhY3Qgc3RlcHMg
dG8gcmVwcm9kdWNlPyBKdXN0ICJlY2hvIG1lbSA+DQo+ID4gPj4+Pj4+IC9zeXMvcG93ZXIvc3Rh
dGUiIGFuZCB0aGVuIHJlc3VtZSBieSBwcmVzc2luZyBwb3dlciBidXR0b24/DQo+ID4gPj4NCj4g
PiA+PiBHTk9NRSBTaGVsbCAzLjM0LjErZ2l0MjAxOTEwMjQtMSBpcyB1c2VkLCBhbmQgdGhlIHVz
ZXIganVzdCBjbG9zZXMgdGhlDQo+ID4gPj4gZGlzcGxheS4gU28gbW9yZSB0aGFuIGBlY2hvIG1l
bSA+IC9zeXMvcG93ZXIvc3RhdGVgIGlzIGRvbmUuIFdoYXQNCj4gPiA+PiBkaXN0cmlidXRpb24g
ZG8geW91IHVzZT8NCj4gPiA+DQo+ID4gPiBJIGhhdmUgYnVpbGRyb290IGJhc2VkICJkaXN0cm8i
IHNvIHRoZXJlIGlzIG5vIFVJIHJ1bm5pbmcuDQo+ID4NCj4gPiBIbW0sIHRoaXMgaXMgcXVpdGUg
ZGlmZmVyZW50IGZyb20gdGhlIOKAnG5vcm1hbOKAnSB1c2UtY2FzZSBvZiB0aGUgdGhlc2UgZGV2
aWNlcy4NCj4gPiBUaGF0IHdheSB5b3Ugd29u4oCZdCBoaXQgdGhlIGJ1Z3Mgb2YgdGhlIG5vcm1h
bCB1c2Vycy4gOy0pDQo+IA0KPiBXZWxsLCBJIGNhbiBpbnN0YWxsIHNvbWUgZGlzdHJvIHRvIHRo
YXQgdGhpbmcgYWxzbyA6KSBJIHN1cHBvc2UgRGViaWFuDQo+IDEwLjIgZG9lcyBoYXZlIHRoaXMg
aXNzdWUsIG5vPw0KPiANCj4gPiA+Pj4+PiBJIHRyaWVkIHY1LjQtcmM2IG9uIG15IDkzODAgd2l0
aCBUQjE2IGRvY2sgY29ubmVjdGVkIGFuZCBkaWQgYSBjb3VwbGUgb2YNCj4gPiA+Pj4+PiBzdXNw
ZW5kL3Jlc3VtZSBjeWNsZXMgKHRvIHMyaWRsZSkgYnV0IEkgZG9uJ3Qgc2VlIGFueSBpc3N1ZXMu
DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBJIG1heSBoYXZlIG9sZGVyL2RpZmZlcmVudCBmaXJtd2Fy
ZSB0aGFuIHlvdSwgdGhvdWdoLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFVwZ3JhZGVkIEJJT1MgdG8g
MS44LjAgYW5kIFRCVCBOVk0gdG8gdjQ0IGJ1dCBzdGlsbCBjYW4ndCByZXByb2R1Y2UgdGhpcw0K
PiA+ID4+Pj4gb24gbXkgc3lzdGVtIDovDQo+ID4gPj4NCj4gPiA+PiBUaGUgdXNlciByZXBvcnRl
ZCB0aGUgaXNzdWUgd2l0aCB0aGUgcHJldmlvdXMgZmlybXdhcmVzIDEueCBhbmQgVEJUIE5WTSB2
NDAuDQo+ID4gPj4gVXBkYXRpbmcgdG8gdGhlIHJlY2VudCB2ZXJzaW9uIChJIGdvdCB0aGUgbG9n
cyB3aXRoKSBkaWQgbm90IGZpeCB0aGUgaXNzdWUuDQo+ID4gPg0KPiA+ID4gSSBhbHNvIHRyaWVk
IHY0MCAodGhhdCB3YXMgb3JpZ2luYWxseSBvbiB0aGF0IHN5c3RlbSkgYnV0IEkgd2FzIG5vdCBh
YmxlDQo+ID4gPiB0byByZXByb2R1Y2UgaXQuDQo+ID4gPg0KPiA+ID4gRG8geW91IGtub3cgaWYg
dGhlIHVzZXIgY2hhbmdlZCBhbnkgQklPUyBzZXR0aW5ncz8NCj4gPg0KPiA+IFdlIGhhZCB0byBk
aXNhYmxlIHRoZSBUaHVuZGVyYm9sdCBzZWN1cml0eSBzZXR0aW5ncyBhcyBvdGhlcndpc2UgdGhl
IFVTQg0KPiA+IGRldmljZXMgd291bGRu4oCZdCB3b3JrIGF0IGNvbGQgYm9vdCBlaXRoZXIuDQo+
IA0KPiBUaGF0IGRvZXMgbm90IHNvdW5kIHJpZ2h0IGF0IGFsbC4gVGhlcmUgaXMgdGhlIHByZWJv
b3QgQUNMIHRoYXQgYWxsb3dzDQo+IHlvdSB0byB1c2UgVEJUIGRvY2sgYXJlYWR5IG9uIGJvb3Qu
IEJvbHQgdGFrZXMgY2FyZSBvZiB0aGlzLg0KDQpZZWFoIGl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBl
bnVtZXJhdGUgYWxsIHRoZSBCSU9TIHNldHRpbmdzIHRoYXQgYXJlIHNlbGVjdGVkDQpyZWxhdGVk
IHRvIFRodW5kZXJib2x0LiAgU29tZSBvZiB0aGVtIGFyZSBhIGJpdCBjb25mdXNpbmcuDQoNCj4g
DQo+IEFyZSB5b3UgdGFsa2luZyBhYm91dCBVU0IgZGV2aWNlcyBjb25uZWN0ZWQgdG8gdGhlIFRC
MTYgZG9jaz8NCj4gDQo+IEFsc28gYXJlIHlvdSBjb25uZWN0aW5nIHRoZSBUQjE2IGRvY2sgdG8g
dGhlIFRodW5kZXJib2x0IHBvcnRzIChsZWZ0DQo+IHNpZGUgb2YgdGhlIHN5c3RlbSBtYXJrZWQg
d2l0aCBzbWFsbCBsaWdodG5pbmcgbG9nbykgb3IgdG8gdGhlIG5vcm1hbA0KPiBUeXBlLUMgcG9y
dHMgKHJpZ2h0IHNpZGUpPw0KDQpJdCBkZWZpbml0ZWx5IHdvdWxkbid0IGZ1bmN0aW9uIGF0IGFs
bCBvbiB0aGUgcmlnaHQgc2lkZS4gIFRoZSBUQjE2IGRvY2sgYW5kDQpjYWJsZSBlYWNoIGNvbnRh
aW5zIEFscGluZSBSaWRnZSwgc28gaXQgd2lsbCBvbmx5IHdvcmsgd2l0aCBhIFRCVCBjb250cm9s
bGVyDQpvbiB0aGUgb3RoZXIgZW5kLg0KDQo+IA0KPiA+IFNvLCBJIGJ1aWx0IExpbnV4IDUuNC1y
YzggKGBtYWtlIGJpbmRlYi1wa2cgLWo4YCksIGJ1dCB1bmZvcnR1bmF0ZWx5IHRoZQ0KPiA+IGVy
cm9yIGlzIHN0aWxsIHRoZXJlLiBTb21ldGltZXMsIHJlLXBsdWdnaW5nIHRoZSBkb2NrIGhlbHBl
ZCwgYW5kIHNvbWV0aW1lcw0KPiA+IGl0IGRpZCBub3QuDQo+ID4NCj4gPiBQbGVhc2UgZmluZCB0
aGUgbG9ncyBhdHRhY2hlZC4gVGhlIHN0cmFuZ2UgdGhpbmcgaXMsIHRoZSBMaW51eCBrZXJuZWwg
ZGV0ZWN0cw0KPiA+IHRoZSBkZXZpY2VzIGFuZCBJIGRvIG5vdCBzZWUgYW55IGRpc2Nvbm5lY3Qg
ZXZlbnRzLiBCdXQsIGBsc3VzYmAgZG9lcyBub3QgbGlzdA0KPiA+IHRoZSBrZXlib2FyZCBhbmQg
dGhlIG1vdXNlLiBJcyB0aGF0IGV4cGVjdGVkLg0KPiANCj4gSSdtIGJpdCBjb25mdXNlZC4gQ2Fu
IHlvdSBkZXNjcmliZSB0aGUgZXhhY3Qgc3RlcHMgd2hhdCB5b3UgZG8gKHNvIEkgY2FuDQo+IHJl
cGxpY2F0ZSB0aGVtKS4NCj4gDQo+ID4gQWRkaXRpb25hbGx5LCBkZXNwaXRlIGBDT05GSUdfUENJ
X0RFQlVHYCBJIGRvIG5vdCBzZWUgbW9yZSBlbGFib3JhdGUNCj4gbWVzc2FnZXMuDQo+IA0KPiBJ
IHNlZSBvbmUgc3RyYW5nZSB0aGluZyBpbiB0aGF0IGxvZy4gVGhlIFRodW5kZXJib2x0IGRyaXZl
ciBkb2VzIG5vdA0KPiBzaG93IHRoZSBkZXZpY2UgYXQgYm9vdC4gWW91IHNob3VsZCBzZWUgc29t
ZXRoaW5nIGxpa2UgdGhpcyB3aGVuIHlvdQ0KPiBib290IHdpdGggdGhlIGRvY2sgY29ubmVjdGVk
Og0KPiANCj4gICB0aHVuZGVyYm9sdCAwLTM6IG5ldyBkZXZpY2UgZm91bmQsIHZlbmRvcj0weGQ0
IGRldmljZT0weGIwNTENCj4gICB0aHVuZGVyYm9sdCAwLTM6IERlbGwgRGVsbCBUaHVuZGVyYm9s
dCBDYWJsZQ0KPiAgIHRodW5kZXJib2x0IDAtMzAzOiBuZXcgZGV2aWNlIGZvdW5kLCB2ZW5kb3I9
MHhkNCBkZXZpY2U9MHhiMDU0DQo+ICAgdGh1bmRlcmJvbHQgMC0zMDM6IERlbGwgRGVsbCBUaHVu
ZGVyYm9sdCBEb2NrDQo+IA0KPiBJIG9ubHkgc2VlIHRob3NlIGFmdGVyIHlvdSBkaWQgc3VzcGVu
ZC9yZXN1bWUgY3ljbGUuDQo+IA0KPiA+IExhc3RseSwgY291bGQgdGhlIGRhZW1vbiBib2x0ZCBo
YXZlIGFueXRoaW5nIHRvIGRvIHdpdGggdGhpcz8NCj4gDQo+IEl0IGlzIHRoZSBvbmUgdGhhdCBh
dXRob3JpemVzIHRoZSBQQ0llIHR1bm5lbGluZyBzbyBkZWZpbml0ZWx5IGhhcw0KPiBzb21ldGhp
bmcgdG8gZG8gYnV0IGJlbG93Og0KPiANCj4gPg0KPiA+IGBgYA0KPiA+ICQgYm9sdGN0bCAtLXZl
cnNpb24NCj4gPiBib2x0IDAuOA0KPiA+ICQgYm9sdGN0bCBsaXN0DQo+ID4gIOKXjyBEZWxsIFRo
dW5kZXJib2x0IENhYmxlDQo+ID4gICAg4pSc4pSAIHR5cGU6ICAgICAgICAgIHBlcmlwaGVyYWwN
Cj4gPiAgICDilJzilIAgbmFtZTogICAgICAgICAgRGVsbCBUaHVuZGVyYm9sdCBDYWJsZQ0KPiA+
ICAgIOKUnOKUgCB2ZW5kb3I6ICAgICAgICBEZWxsDQo+ID4gICAg4pSc4pSAIHV1aWQ6ICAgICAg
ICAgIDAwODJiMDlkLTJmNWYtZDQwMC1mZmZmLWZmZmZmZmZmZmZmZg0KPiA+ICAgIOKUnOKUgCBz
dGF0dXM6ICAgICAgICBhdXRob3JpemVkDQo+IA0KPiBsb29rcyB3aGF0IGlzIGV4cGVjdGVkLg0K
