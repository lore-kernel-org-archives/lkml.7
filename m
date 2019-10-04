Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B51C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42F320873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="onsEIeOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389023AbfJDOGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:06:14 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:7664 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388149AbfJDOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:06:14 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94DsqAs015188;
        Fri, 4 Oct 2019 10:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=3j2yaf8Eg1TtPF8R9JnfgCBrnf3lOeuaHg3pXeqJBMc=;
 b=onsEIeOEVkdAySgcTlt5O5V7lh+DDE9+gB4QTu+RdKrDoykf4IREysGOzJIHwGdrpnsB
 2c5QHciNpknuyUgtqqZsiF3m4o5Ogv8ZBUC60DGnHc798HYq62hTnfwWPiQ08OP9rBcB
 Rsxru3UkzKNNiAeixXf0j37UML+zRTwWGL88YMXvImDvPyvO7Wgp98cV6eP+OGmA1jOa
 hEkmfJHo5pQap7DHFegpQ+0xeg+D9ren4WIURmBOLZvi7/o/vBXbYKxdeafETlDc+xyZ
 XbPp61an4ZqfkXDqjXnrNlnhIYcmuVgyo/Hz24HypauLzg1STKS2QkR66/7RTrkwfCuZ bA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2pf622f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 10:06:13 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94DrA6D100810;
        Fri, 4 Oct 2019 10:06:12 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2vdbb4m0aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 10:06:12 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1306196770"
From:   <Mario.Limonciello@dell.com>
To:     <yehezkelshb@gmail.com>, <mika.westerberg@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Topic: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGAqiggAATYiCAAUbqgIAAF+AwgABczAD//7D1UIABYeAAgAAaodCAAXYEAIAAA6wAgAADboCAADI8gP//2Prg
Date:   Fri, 4 Oct 2019 14:05:46 +0000
Message-ID: <332849ed8714496587251b6319a11b0b@AUSX13MPC105.AMER.DELL.COM>
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
In-Reply-To: <CA+CmpXvoro+m-NZLguMtDq_r_Og8LAFQgPGosvA+WsjMhi6m1Q@mail.gmail.com>
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
 malwarescore=0 mlxlogscore=771 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910040130
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=886 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910040130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gRnJpLCBPY3QgNCwgMjAxOSBhdCAxMToxOSBBTSBNaWthIFdlc3RlcmJlcmcNCj4g
PG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJp
LCBPY3QgMDQsIDIwMTkgYXQgMTE6MDc6MzRBTSArMDMwMCwgWWVoZXprZWwgQmVybmF0IHdyb3Rl
Og0KPiA+ID4gPiBBbHNvIGlmIHlvdSBjYW4gZ2V0IHRoZSBod192ZW5kb3JfaWQgYW5kIGh3X3By
b2R1Y3RfaWQgZnJvbSB0aGUga2VybmVsDQo+ID4gPiA+IGRvZXMgdGhhdCBtZWFuIHlvdSBkb24n
dCBuZWVkIHRvIGRvIHRoZSB0d28gcmVhZHMgb3IgeW91IHN0aWxsIG5lZWQNCj4gPiA+ID4gdGhv
c2U/DQo+ID4gPg0KPiA+ID4gQXJlIHRob3NlIHRoZSBjaGlwIHZlbmRvciBvciB0aGUgT0VNLCBp
biBjYXNlIHRoZXkgYXJlIGRpZmZlcmVudD8NCj4gPg0KPiA+IFRob3NlIGFyZSB0aGUgYWN0dWFs
IFVTQjQgaGFyZHdhcmUgbWFrZXIgdmFsdWVzLCBkaXJlY3RseSBmcm9tDQo+ID4gUk9VVEVSX0NT
XzAgKHAuIDI4NyBpbiB0aGUgVVNCNCBzcGVjKS4gVGhpcyBhbG1vc3QgY2VydGFpbmx5IGRpZmZl
ciBmcm9tDQo+ID4gdGhlIE9FTSB2YWx1ZXMgZnJvbSBEUk9NIHdlIGN1cnJlbnRseSBleHBvc2Uu
DQo+IA0KPiBNYWtlcyBzZW5zZSB0byBtZS4gVXNlcnNwYWNlIGNhbiBsZWFybiB0aGUgcmVsZXZh
bnQgSURzIHRoYXQgdGhlaXIgTlZNIGZvcm1hdA0KPiBpcw0KPiBrbm93bi4NCj4gDQo+ID4NCj4g
PiA+IFRoaW5raW5nIGFib3V0IGl0IGFnYWluLCBJJ2QgZ3Vlc3MgaXQgc2hvdWxkbid0IG1hdHRl
ciBtdWNoLCBpZiB0aGUgY2hpcCBpcyBmcm9tDQo+ID4gPiBJbnRlbCwgdGhlIEZXIHN1cHBvcnRz
IE5WTSB1cGdyYWRlLCBpc24ndCBpdD8NCj4gPg0KPiA+IFNvIHRoZSBib3R0b20gbGluZSBpcyB0
aGF0IGlmIHRoZSBrZXJuZWwgdGhpbmtzIHRoZSByb3V0ZXIgc3VwcG9ydHMgTlZNDQo+ID4gdXBn
cmFkZSBpdCBleHBvc2VzIHRoZSBudm1fYWN0aXZlL252bV9ub25fYWN0aXZlIGZpbGVzIGV0Yy4g
SSB0aGluaw0KPiA+IGZ3dXBkIHVzZXMgdGhpcyBpbmZvcm1hdGlvbiB0byBkaXNwbGF5IHVzZXIg
d2hldGhlciB0aGUgZGV2aWNlIGNhbiBiZQ0KPiA+IHVwZ3JhZGVkIG9yIG5vdCAoZm9yIGV4YW1w
bGUgSUNMIGNhbm5vdCBhcyB0aGUgTlZNIGlzIHBhcnQgb2YgQklPUykuDQo+IA0KPiBZZXMsIGZ3
dXBkIGFscmVhZHkgdGFrZXMgdGhpcyBpbnRvIGFjY291bnQsIGJ1dCB0aGUgcXVlc3Rpb24gaGVy
ZSBpcyBob3cgdG8NCj4gaGFuZGxlIGNhc2VzIHRoYXQgTlZNIGlzIGF2YWlsYWJsZSBidXQgdGhl
IGZvcm1hdCBpc24ndCBrbm93biB0bw0KPiB1c2Vyc3BhY2UgKHlldCkuDQoNCkV4YWN0bHkuDQoN
Cj4gDQo+ID4NCj4gPiBFeHBvc2luZyBod192ZW5kb3JfaWQgYW5kIGh3X3Byb2R1Y3RfaWQgbWF5
IHNwZWVkIHVwIGZ3dXBkIGJlY2F1c2UgaXQNCj4gPiBkb2VzIG5vdCBuZWVkIHRvIGdvIG92ZXIg
dGhlIGFjdGl2ZSBOVk0gdG8gZmlndXJlIG91dCB3aGV0aGVyIHRoZSBuZXcNCj4gPiBpbWFnZSBp
cyBmb3IgdGhlIGNvcnJlY3QgY29udHJvbGxlci4NCj4gDQo+IEl0J3Mgbm90IGFib3V0IGZpbmRp
bmcgdGhlIHJlbGV2YW50IGltYWdlIGZvciB1cGdyYWRlICh3aGljaCBtdXN0IGJlIHNlYXJjaGVk
DQo+IGZvciBieSBsb29raW5nIGluIHRoZSBEUk9NIHZlbmRvci9wcm9kdWN0IHZhbHVlcyksIGJ1
dCBhYm91dCB0aGUgcXVlc3Rpb24gaWYgdGhlDQo+IE5WTSBmb3JtYXQgaXMga25vd24gdG8gdXNl
cnNwYWNlIGFuZCBza2lwIHRoZSBwYXJzaW5nIHdvcmsgaWYgaXQncyBhbnl3YXkgZ29pbmcNCj4g
dG8gZmFpbC4NCj4gDQo+IFNvIHllcywgSSB0aGluayBleHBvc2luZyB2ZW5kb3IgSUQgKGFuZCBt
YXliZSBhbHNvIHByb2R1Y3QgSUQpIGNhbiBpbXByb3ZlIHRoZQ0KPiBzaXR1YXRpb24uDQo+IA0K
DQpDdXJyZW50bHkgYXQgcHJvYmUgdGltZSBldmVyeXRoaW5nIGNvbWVzIGZyb20gdWRldiBleGNl
cHQgZm9yIHRoZSBiaXQgaW5kaWNhdGluZw0KcnVubmluZyBpbiAibmF0aXZlIiBtb2RlIG9yIG5v
dC4gIEp1c3QgZW5vdWdoIGNodW5rcyBvZiB0aGUgTlZNIGFyZSByZWFkIHRvIGRldGVybWluZQ0K
dGhhdCAoSUUgbm8gcmVhZGluZyB1cCB0aHJvdWdoIERST00gb3IganVtcGluZyBhcm91bmQpLg0K
DQpJZiBDaHJpc3RpYW4ncyBwYXRjaCB0byBleHBvcnQgZ2VuZXJhdGlvbiBpcyBhY2NlcHRlZCBJ
IHRoaW5rIHRoYXQgd2UgY291bGQgbW92ZSB0aGF0IGNoZWNrDQp0byBvbmx5IHJlYWQgLW5hdGl2
ZSBpZiBnZW5lcmF0aW9uIDwgMy4NCg0KQW5kIGlmIHlvdSBleHBvcnQgdGhlIGh3X3ZlbmRvcl9p
ZCBhbmQgaHdfcHJvZHVjdF9pZCBmaWVsZHMgdGhlbiB0aGF0IG1lYW5zIFVTQjQgZGV2aWNlcw0K
d291bGQgcmVxdWlyZSBubyByZWFkaW5nIGZyb20gTlZNIGF0ICJwcm9iZSIgc2luY2Ugd2UgZG9u
J3QgaGF2ZSB0byByZWFkIGEgLW5hdGl2ZSBiaXQuDQoNCldlIHdvdWxkIHN0aWxsIG9mIGNvdXJz
ZSByZWFkIGFuZCBhbmFseXplIHRoZSBOVk0gd2hlbiBpdCBjb21lcyB0aW1lIHRvIGZsYXNoIGEg
bmV3IGRldmljZQ0KdGhvdWdoLg0K
