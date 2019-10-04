Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C3EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D8221D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="alyH3XLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389092AbfJDOWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:22:08 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:5362 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388270AbfJDOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:22:07 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94EJrBS000829;
        Fri, 4 Oct 2019 10:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=z6tKitNU8BBCheCk/Afn9TT4d4VeUpUcfmoKOg4dTcA=;
 b=alyH3XLk+NyqDbviY/nLkRHj/7SNeWpSAwRCJQN3ks7w0fEa4kxj5Z0AWSYLL0vXGFRE
 BuVAy54ywAvhG7u8zOyMiAZysm9n8TWwqyppGE5cGRk+uXBU8dJjfW4ScmmNntZtcSEO
 P0khi9WphgJS2Tjm8il1B46AiQVf1pd3MuHzM9eJWMdpz6yg7aXhm6NKi8tJb44Bxluw
 ac9OFfAyFgftlglBTnD8qDOFe9g2AZtfmbJ4BhVJ9v5Gv2q3ObkYsvi1t6/TeXNwd2Jl
 +XlEyT2fEjEMWJdMSLI9ecS48K7JcpD+nNbJiGW2rBMHV8HSpFR/YNyX2KcLSaJ9bztC 4w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2vdv95tw02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 10:22:05 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94EHvJW159279;
        Fri, 4 Oct 2019 10:22:04 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2vdbb4m8gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 10:22:04 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="468622187"
From:   <Mario.Limonciello@dell.com>
To:     <yehezkelshb@gmail.com>, <mika.westerberg@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Topic: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGAqiggAATYiCAAUbqgIAAF+AwgABczAD//7D1UIABYeAAgAAaodCAAXYEAIAAA6wAgAADboCAADI8gP//2PrggAAFUsA=
Date:   Fri, 4 Oct 2019 14:19:33 +0000
Message-ID: <7025a9ad0ba54f7381e1455088206aed@AUSX13MPC105.AMER.DELL.COM>
References: <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
 <20191002083913.GG2714@lahna.fi.intel.com>
 <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
 <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
 <20191003080028.GK2819@lahna.fi.intel.com>
 <06a04bff94494da99c5359a7fb645d19@AUSX13MPC105.AMER.DELL.COM>
 <20191004075426.GA2819@lahna.fi.intel.com>
 <CA+CmpXsMkwZhCegGYPYQo2GwN6ROwDYbY3RVZTEeN+FfZ-PbMQ@mail.gmail.com>
 <20191004081951.GD2819@lahna.fi.intel.com>
 <CA+CmpXvoro+m-NZLguMtDq_r_Og8LAFQgPGosvA+WsjMhi6m1Q@mail.gmail.com>
 <332849ed8714496587251b6319a11b0b@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <332849ed8714496587251b6319a11b0b@AUSX13MPC105.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-04T14:00:22.8568787Z;
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
 definitions=2019-10-04_07:2019-10-03,2019-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910040132
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910040132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8N
Cj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDQsIDIwMTkgOTowNiBBTQ0KPiBUbzogJ1llaGV6a2Vs
IEJlcm5hdCc7IE1pa2EgV2VzdGVyYmVyZw0KPiBDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9y
ZzsgQW5kcmVhcyBOb2V2ZXI7IE1pY2hhZWwgSmFtZXQ7IFJham1vaGFuIE1hbmk7DQo+IG5pY2hv
bGFzLmpvaG5zb24tb3BlbnNvdXJjZUBvdXRsb29rLmNvbS5hdTsgTHVrYXMgV3VubmVyOw0KPiBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgc3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVkdTsgQW50
aG9ueSBXb25nOyBMS01MDQo+IFN1YmplY3Q6IFJFOiBbUkZDIFBBVENIIDE3LzIyXSB0aHVuZGVy
Ym9sdDogQWRkIGluaXRpYWwgc3VwcG9ydCBmb3IgVVNCNA0KPiANCj4gPg0KPiA+IE9uIEZyaSwg
T2N0IDQsIDIwMTkgYXQgMTE6MTkgQU0gTWlrYSBXZXN0ZXJiZXJnDQo+ID4gPG1pa2Eud2VzdGVy
YmVyZ0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgT2N0IDA0
LCAyMDE5IGF0IDExOjA3OjM0QU0gKzAzMDAsIFllaGV6a2VsIEJlcm5hdCB3cm90ZToNCj4gPiA+
ID4gPiBBbHNvIGlmIHlvdSBjYW4gZ2V0IHRoZSBod192ZW5kb3JfaWQgYW5kIGh3X3Byb2R1Y3Rf
aWQgZnJvbSB0aGUga2VybmVsDQo+ID4gPiA+ID4gZG9lcyB0aGF0IG1lYW4geW91IGRvbid0IG5l
ZWQgdG8gZG8gdGhlIHR3byByZWFkcyBvciB5b3Ugc3RpbGwgbmVlZA0KPiA+ID4gPiA+IHRob3Nl
Pw0KPiA+ID4gPg0KPiA+ID4gPiBBcmUgdGhvc2UgdGhlIGNoaXAgdmVuZG9yIG9yIHRoZSBPRU0s
IGluIGNhc2UgdGhleSBhcmUgZGlmZmVyZW50Pw0KPiA+ID4NCj4gPiA+IFRob3NlIGFyZSB0aGUg
YWN0dWFsIFVTQjQgaGFyZHdhcmUgbWFrZXIgdmFsdWVzLCBkaXJlY3RseSBmcm9tDQo+ID4gPiBS
T1VURVJfQ1NfMCAocC4gMjg3IGluIHRoZSBVU0I0IHNwZWMpLiBUaGlzIGFsbW9zdCBjZXJ0YWlu
bHkgZGlmZmVyIGZyb20NCj4gPiA+IHRoZSBPRU0gdmFsdWVzIGZyb20gRFJPTSB3ZSBjdXJyZW50
bHkgZXhwb3NlLg0KPiA+DQo+ID4gTWFrZXMgc2Vuc2UgdG8gbWUuIFVzZXJzcGFjZSBjYW4gbGVh
cm4gdGhlIHJlbGV2YW50IElEcyB0aGF0IHRoZWlyIE5WTQ0KPiBmb3JtYXQNCj4gPiBpcw0KPiA+
IGtub3duLg0KPiA+DQo+ID4gPg0KPiA+ID4gPiBUaGlua2luZyBhYm91dCBpdCBhZ2FpbiwgSSdk
IGd1ZXNzIGl0IHNob3VsZG4ndCBtYXR0ZXIgbXVjaCwgaWYgdGhlIGNoaXAgaXMgZnJvbQ0KPiA+
ID4gPiBJbnRlbCwgdGhlIEZXIHN1cHBvcnRzIE5WTSB1cGdyYWRlLCBpc24ndCBpdD8NCj4gPiA+
DQo+ID4gPiBTbyB0aGUgYm90dG9tIGxpbmUgaXMgdGhhdCBpZiB0aGUga2VybmVsIHRoaW5rcyB0
aGUgcm91dGVyIHN1cHBvcnRzIE5WTQ0KPiA+ID4gdXBncmFkZSBpdCBleHBvc2VzIHRoZSBudm1f
YWN0aXZlL252bV9ub25fYWN0aXZlIGZpbGVzIGV0Yy4gSSB0aGluaw0KPiA+ID4gZnd1cGQgdXNl
cyB0aGlzIGluZm9ybWF0aW9uIHRvIGRpc3BsYXkgdXNlciB3aGV0aGVyIHRoZSBkZXZpY2UgY2Fu
IGJlDQo+ID4gPiB1cGdyYWRlZCBvciBub3QgKGZvciBleGFtcGxlIElDTCBjYW5ub3QgYXMgdGhl
IE5WTSBpcyBwYXJ0IG9mIEJJT1MpLg0KPiA+DQo+ID4gWWVzLCBmd3VwZCBhbHJlYWR5IHRha2Vz
IHRoaXMgaW50byBhY2NvdW50LCBidXQgdGhlIHF1ZXN0aW9uIGhlcmUgaXMgaG93IHRvDQo+ID4g
aGFuZGxlIGNhc2VzIHRoYXQgTlZNIGlzIGF2YWlsYWJsZSBidXQgdGhlIGZvcm1hdCBpc24ndCBr
bm93biB0bw0KPiA+IHVzZXJzcGFjZSAoeWV0KS4NCj4gDQo+IEV4YWN0bHkuDQo+IA0KPiA+DQo+
ID4gPg0KPiA+ID4gRXhwb3NpbmcgaHdfdmVuZG9yX2lkIGFuZCBod19wcm9kdWN0X2lkIG1heSBz
cGVlZCB1cCBmd3VwZCBiZWNhdXNlIGl0DQo+ID4gPiBkb2VzIG5vdCBuZWVkIHRvIGdvIG92ZXIg
dGhlIGFjdGl2ZSBOVk0gdG8gZmlndXJlIG91dCB3aGV0aGVyIHRoZSBuZXcNCj4gPiA+IGltYWdl
IGlzIGZvciB0aGUgY29ycmVjdCBjb250cm9sbGVyLg0KPiA+DQo+ID4gSXQncyBub3QgYWJvdXQg
ZmluZGluZyB0aGUgcmVsZXZhbnQgaW1hZ2UgZm9yIHVwZ3JhZGUgKHdoaWNoIG11c3QgYmUgc2Vh
cmNoZWQNCj4gPiBmb3IgYnkgbG9va2luZyBpbiB0aGUgRFJPTSB2ZW5kb3IvcHJvZHVjdCB2YWx1
ZXMpLCBidXQgYWJvdXQgdGhlIHF1ZXN0aW9uIGlmDQo+IHRoZQ0KPiA+IE5WTSBmb3JtYXQgaXMg
a25vd24gdG8gdXNlcnNwYWNlIGFuZCBza2lwIHRoZSBwYXJzaW5nIHdvcmsgaWYgaXQncyBhbnl3
YXkNCj4gZ29pbmcNCj4gPiB0byBmYWlsLg0KPiA+DQo+ID4gU28geWVzLCBJIHRoaW5rIGV4cG9z
aW5nIHZlbmRvciBJRCAoYW5kIG1heWJlIGFsc28gcHJvZHVjdCBJRCkgY2FuIGltcHJvdmUgdGhl
DQo+ID4gc2l0dWF0aW9uLg0KPiA+DQo+IA0KPiBDdXJyZW50bHkgYXQgcHJvYmUgdGltZSBldmVy
eXRoaW5nIGNvbWVzIGZyb20gdWRldiBleGNlcHQgZm9yIHRoZSBiaXQgaW5kaWNhdGluZw0KPiBy
dW5uaW5nIGluICJuYXRpdmUiIG1vZGUgb3Igbm90LiAgSnVzdCBlbm91Z2ggY2h1bmtzIG9mIHRo
ZSBOVk0gYXJlIHJlYWQgdG8NCj4gZGV0ZXJtaW5lDQo+IHRoYXQgKElFIG5vIHJlYWRpbmcgdXAg
dGhyb3VnaCBEUk9NIG9yIGp1bXBpbmcgYXJvdW5kKS4NCj4gDQo+IElmIENocmlzdGlhbidzIHBh
dGNoIHRvIGV4cG9ydCBnZW5lcmF0aW9uIGlzIGFjY2VwdGVkIEkgdGhpbmsgdGhhdCB3ZSBjb3Vs
ZCBtb3ZlDQo+IHRoYXQgY2hlY2sNCj4gdG8gb25seSByZWFkIC1uYXRpdmUgaWYgZ2VuZXJhdGlv
biA8IDMuDQo+IA0KDQpTb3JyeSBmb3IgdGhlIHR5cG87ICBnZW5lcmF0aW9uIDwgNC4NCg0KPiBB
bmQgaWYgeW91IGV4cG9ydCB0aGUgaHdfdmVuZG9yX2lkIGFuZCBod19wcm9kdWN0X2lkIGZpZWxk
cyB0aGVuIHRoYXQgbWVhbnMNCj4gVVNCNCBkZXZpY2VzDQo+IHdvdWxkIHJlcXVpcmUgbm8gcmVh
ZGluZyBmcm9tIE5WTSBhdCAicHJvYmUiIHNpbmNlIHdlIGRvbid0IGhhdmUgdG8gcmVhZCBhIC0N
Cj4gbmF0aXZlIGJpdC4NCj4gDQo+IFdlIHdvdWxkIHN0aWxsIG9mIGNvdXJzZSByZWFkIGFuZCBh
bmFseXplIHRoZSBOVk0gd2hlbiBpdCBjb21lcyB0aW1lIHRvIGZsYXNoIGENCj4gbmV3IGRldmlj
ZQ0KPiB0aG91Z2guDQo=
