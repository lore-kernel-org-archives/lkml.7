Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ECECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E09A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="EmmuJyAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfKDQSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:18:10 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:49490 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbfKDQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:18:09 -0500
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4GFj2l005966
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 11:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=dzF+MKVxx/oeg7V0ABEFsgeIyDMDVjT1wG45pKwNXMo=;
 b=EmmuJyAXswuqKHLifoDBqSSJFlJ5y7zmGgP8GH6jRJwQ3jsACrwtXIk7cvq5HH38aIpQ
 bbbdA4BIKzIssP6BUn1ZD/cgb3+30kVJY6vD2gFliqD+OulJXcaUdo+BV416lJTl6Yeo
 0nyvrAImetF2nFZ9iWY/NIS0pCF6qvfOHv7RotX99zrsQlY+QV2g4+uKsKQlAmdk82LD
 IoCuNia0NBv1LZp7dEctC2wWlwYtclMJqvt5ly+3lAWCoXTyiPfRuZ8nvdHGEjI31uVw
 PV/W37h00ci7I/QPHh+EmUgh6xDtBzEmzPbIq2/ITsDiDCiSuBk5Dp8hmZMisrknlNvM 1g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2w12vw118r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:18:08 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4GDHqT001363
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 11:18:07 -0500
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2w13nu88ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:18:07 -0500
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="445108044"
From:   <Mario.Limonciello@dell.com>
To:     <pmenzel@molgen.mpg.de>, <mika.westerberg@linux.intel.com>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <ck@xatom.net>,
        <linux-kernel@vger.kernel.org>, <anthony.wong@canonical.com>
Subject: RE: USB devices on Dell TB16 dock stop working after resuming
Thread-Topic: USB devices on Dell TB16 dock stop working after resuming
Thread-Index: AQHVkxGi4f0HmqPYOkmPAZlfRfFMhqd7dbiAgAAFewCAABDQAP//m/tggABrZQD//5u+MA==
Date:   Mon, 4 Nov 2019 16:17:15 +0000
Message-ID: <fef12597547e475cb240a0bb6c1c2ed7@AUSX13MPC105.AMER.DELL.COM>
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
 <20191104142459.GC2552@lahna.fi.intel.com>
 <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
In-Reply-To: <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-11-04T16:17:14.4068448Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911040159
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911040160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnpl
bEBtb2xnZW4ubXBnLmRlPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDQsIDIwMTkgMTA6MTEg
QU0NCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbzsgTWlrYSBXZXN0ZXJiZXJnDQo+IENjOiBBbmRy
ZWFzIE5vZXZlcjsgTWljaGFlbCBKYW1ldDsgWWVoZXprZWwgQmVybmF0OyBDaHJpc3RpYW4gS2Vs
bG5lcjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFudGhvbnkgV29uZw0KPiBT
dWJqZWN0OiBSZTogVVNCIGRldmljZXMgb24gRGVsbCBUQjE2IGRvY2sgc3RvcCB3b3JraW5nIGFm
dGVyIHJlc3VtaW5nDQo+IA0KPiBEZWFyIE1pa2EsIGRlYXIgTWFyaW8sDQo+IA0KPiANCj4gT24g
MjAxOS0xMS0wNCAxNjo0OSwgTWFyaW8uTGltb25jaWVsbG9AZGVsbC5jb20gd3JvdGU6DQo+IA0K
PiA+PiBGcm9tOiBNaWthIFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5j
b20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAxOSA5OjQ1IEFNDQo+IA0KPiA+
PiBPbiBNb24sIE5vdiAwNCwgMjAxOSBhdCAwNDo0NDo0MFBNICswMjAwLCBNaWthIFdlc3RlcmJl
cmcgd3JvdGU6DQo+ID4+PiBPbiBNb24sIE5vdiAwNCwgMjAxOSBhdCAwNDoyNTowM1BNICswMjAw
LCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6DQo+IA0KPiA+Pj4+IE9uIE1vbiwgTm92IDA0LCAyMDE5
IGF0IDAyOjEzOjEzUE0gKzAxMDAsIFBhdWwgTWVuemVsIHdyb3RlOg0KPiANCj4gPj4+Pj4gT24g
dGhlIERlbGwgWFBTIDEzIDkzODAgd2l0aCBEZWJpYW4gU2lkL3Vuc3RhYmxlIHdpdGggTGludXgg
NS4zLjcNCj4gPj4+Pj4gc3VzcGVuZGluZyB0aGUgc3lzdGVtLCBhbmQgcmVzdW1pbmcgd2l0aCBE
ZWxs4oCZcyBUaHVuZGVyYm9sdCBUQjE2DQo+ID4+Pj4+IGRvY2sgY29ubmVjdGVkLCB0aGUgVVNC
IGlucHV0IGRldmljZXMsIGtleWJvYXJkIGFuZCBtb3VzZSwNCj4gPj4+Pj4gY29ubmVjdGVkIHRv
IHRoZSBUQjE2IHN0b3Agd29ya2luZy4gVGhleSB3b3JrIGZvciBhIGZldyBzZWNvbmRzDQo+ID4+
Pj4+IChtb3VzZSBjdXJzb3IgY2FuIGJlIG1vdmVkKSwgYnV0IHRoZW4gc3RvcCB3b3JraW5nLiBU
aGUgbGFwdG9wDQo+ID4+Pj4+IGtleWJvYXJkIGFuZCB0b3VjaHBhZCBzdGlsbCB3b3JrcyBmaW5l
LiBBbGwgZmlybXdhcmUgaXMgdXAtdG8tZGF0ZQ0KPiA+Pj4+PiBhY2NvcmRpbmcgdG8gYGZ3dXBk
bWdyYC4NCj4gPj4+Pg0KPiA+Pj4+IFdoYXQgYXJlIHRoZSBleGFjdCBzdGVwcyB0byByZXByb2R1
Y2U/IEp1c3QgImVjaG8gbWVtID4NCj4gPj4+PiAvc3lzL3Bvd2VyL3N0YXRlIiBhbmQgdGhlbiBy
ZXN1bWUgYnkgcHJlc3NpbmcgcG93ZXIgYnV0dG9uPw0KPiANCj4gR05PTUUgU2hlbGwgMy4zNC4x
K2dpdDIwMTkxMDI0LTEgaXMgdXNlZCwgYW5kIHRoZSB1c2VyIGp1c3QgY2xvc2VzIHRoZQ0KPiBk
aXNwbGF5LiBTbyBtb3JlIHRoYW4gYGVjaG8gbWVtID4gL3N5cy9wb3dlci9zdGF0ZWAgaXMgZG9u
ZS4gV2hhdA0KPiBkaXN0cmlidXRpb24gZG8geW91IHVzZT8NCg0KSSBndWVzcyB0aGlzIGlzIHRo
ZW4gdXNpbmcgc3lzdGVtY3RsJ3Mgc2xlZXAgY29tbWFuZCBhbmQgYW55dGhpbmcgaXQgZG9lcyBh
cyBhDQpyZXN1bHQ/DQoNCklJUkMgdGhhdCBoYXMgc3VwcG9ydCBmb3IgZG9pbmcgZXh0cmEgc3R1
ZmYgaWYgeW91IHdhbnQgdG8gdmlhIHNjcmlwdHMuDQpBbnkgZXh0cmEgc2NyaXB0cyB5b3UndmUg
cHV0IGluIHBsYWNlPyAgT3IgeW91ciBkaXN0cm8gaXMgcnVubmluZz8NCg0KPiANCj4gPj4+IEkg
dHJpZWQgdjUuNC1yYzYgb24gbXkgOTM4MCB3aXRoIFRCMTYgZG9jayBjb25uZWN0ZWQgYW5kIGRp
ZCBhIGNvdXBsZSBvZg0KPiA+Pj4gc3VzcGVuZC9yZXN1bWUgY3ljbGVzICh0byBzMmlkbGUpIGJ1
dCBJIGRvbid0IHNlZSBhbnkgaXNzdWVzLg0KPiA+Pj4NCj4gPj4+IEkgbWF5IGhhdmUgb2xkZXIv
ZGlmZmVyZW50IGZpcm13YXJlIHRoYW4geW91LCB0aG91Z2guDQo+ID4+DQo+ID4+IFVwZ3JhZGVk
IEJJT1MgdG8gMS44LjAgYW5kIFRCVCBOVk0gdG8gdjQ0IGJ1dCBzdGlsbCBjYW4ndCByZXByb2R1
Y2UgdGhpcw0KPiA+PiBvbiBteSBzeXN0ZW0gOi8NCj4gDQo+IFRoZSB1c2VyIHJlcG9ydGVkIHRo
ZSBpc3N1ZSB3aXRoIHRoZSBwcmV2aW91cyBmaXJtd2FyZXMgMS54IGFuZCBUQlQgTlZNIHY0MC4N
Cj4gVXBkYXRpbmcgdG8gdGhlIHJlY2VudCB2ZXJzaW9uIChJIGdvdCB0aGUgbG9ncyB3aXRoKSBk
aWQgbm90IGZpeCB0aGUgaXNzdWUuDQo+IA0KPiA+IExvb3AgQW50aG9ueS4gIEFudGhvbnkgY2Fu
IHlvdSBzZWUgaWYgeW91IGd1eXMgcmVwcm8gdGhpcyBhdCBhbGwgdG9vPw0KPiA+DQo+ID4gQXMg
YSBwb3RlbnRpYWwgcG9pbnQgb2YgY29tcGFyaXNvbiBhbmQgc29tZXRpbWVzIHBhaW4gYXJlYSwg
SSdtIHdvbmRlcmluZyBpZg0KPiA+IHNvbWV0aGluZyBpbiB1c2VybGFuZCBpcyBwb2tpbmcgcG93
ZXIgc3RhdGVzIGZvciBQYXVsIGxlYWRpbmcgdG8gdGhpcy4NCj4gPg0KPiA+IFBhdWwgd2hhdCBz
b3J0IG9mIHBvd2VyIG1hbmFnZW1lbnQgcG9saWNpZXMgYXJlIHlvdSB1c2luZyBvbiB5b3VyIG1h
Y2hpbmU/DQo+ID4gQW55dGhpbmcgbGlrZToNCj4gPiAqIHBvd2VydG9wICAtLWF1dG8tdHVuZSwN
Cj4gPiAqIFRMUA0KPiA+ICogc3lzdGVtZCA+IDI0MyAoY29udGFpbnMgc29tZSBzdHVmZiBmb3Ig
YXV0b21hdGljIHN1c3BlbmQpDQo+IA0KPiBJ4oCZbGwgY2hlY2sgd2l0aCB0aGUgdXNlciBhZ2Fp
biwgYnV0IHRvIG15IGtub3dsZWRnZSBub3RoaW5nIGZyb20gdGhlIGxpc3QgaXMNCj4gdXNlZCBv
biB0aGUgZGV2aWNlLg0KPiANCg0KVGhvc2UgYXJlIGp1c3QgaWxsdXN0cmF0aXZlIGV4YW1wbGVz
LCBhbnl0aGluZyBlbHNlIHRoYXQgeW91J3JlIGRvaW5nIGFib3ZlIGFuZCBiZXlvbmQNCiJzdG9j
ayIgRGViaWFuIHVuc3RhYmxlIHdvdWxkIGJlIHVzZWZ1bCB0byBub3RlIHRvbyBpbiB0aGlzIGFy
ZWEuDQo=
