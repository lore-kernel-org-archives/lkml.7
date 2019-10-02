Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C4FC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42A421A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="u2peh/ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfJBQBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:01:01 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:4858 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727964AbfJBQBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:01:00 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92CQVWH011233;
        Wed, 2 Oct 2019 12:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=DDfOLBjbXub1hW1ubYvHVAD7KSICxmg8nsU9+MTOTYI=;
 b=u2peh/kaFgDf+WjVAq0EdS5JXVO/iOxcZKKhHoLsMQPhX0/4XgtnU5aAmOMDEU1ESvoj
 Dt8b+LPr09+dlH29Pt6I9a/lMeOA+9/ESOUUQbiyL8tk+VFRkZnP8dkxAqajJEvxyzRg
 05TBni1mEJB009uYJWA8Ce+ljKVIaMKBS78NjTiMKDFp3fRfvXXZ/0iv3xoODg7rDz9E
 jJNcPswwOSTaR7E2Qf6pG1Y9hGsTy6zlxFs2U1j4olTFLRe96V92NtQQoQzXVc4FYIpg
 TPqvx8UD2NLA9CETW3tVxs/cdXLEd9+e++kIiYnDk7lvxfD7cLRsEikoM8HDDqBWHt6M OA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2va3hd3qdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 12:00:59 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92Flt7s083619;
        Wed, 2 Oct 2019 12:00:58 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2va25g9nr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 12:00:57 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="404255656"
From:   <Mario.Limonciello@dell.com>
To:     <yehezkelshb@gmail.com>
CC:     <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>,
        <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Topic: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGAqiggAATYiCAAUbqgIAAF+AwgABczAD//7D1UA==
Date:   Wed, 2 Oct 2019 16:00:55 +0000
Message-ID: <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
 <20191002083913.GG2714@lahna.fi.intel.com>
 <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
In-Reply-To: <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-02T16:00:53.7765086Z;
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
 definitions=2019-10-02_07:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910020141
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909280083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZZWhlemtlbCBCZXJuYXQgPHll
aGV6a2Vsc2hiQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIsIDIwMTkg
MTA6MzcgQU0NCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbw0KPiBDYzogTWlrYSBXZXN0ZXJiZXJn
OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBBbmRyZWFzIE5vZXZlcjsgTWljaGFlbA0KPiBK
YW1ldDsgUmFqbW9oYW4gTWFuaTsgbmljaG9sYXMuam9obnNvbi1vcGVuc291cmNlQG91dGxvb2su
Y29tLmF1OyBMdWthcw0KPiBXdW5uZXI7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBzdGVy
bkByb3dsYW5kLmhhcnZhcmQuZWR1OyBBbnRob255DQo+IFdvbmc7IExLTUwNCj4gU3ViamVjdDog
UmU6IFtSRkMgUEFUQ0ggMTcvMjJdIHRodW5kZXJib2x0OiBBZGQgaW5pdGlhbCBzdXBwb3J0IGZv
ciBVU0I0DQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gT24gV2VkLCBPY3QgMiwg
MjAxOSBhdCA2OjA5IFBNIDxNYXJpby5MaW1vbmNpZWxsb0BkZWxsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBNaWthIFdlc3Rl
cmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+DQo+ID4gPiBTZW50OiBXZWRu
ZXNkYXksIE9jdG9iZXIgMiwgMjAxOSAzOjM5IEFNDQo+ID4gPiBUbzogTGltb25jaWVsbG8sIE1h
cmlvDQo+ID4gPiBDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgYW5kcmVhcy5ub2V2ZXJA
Z21haWwuY29tOw0KPiA+ID4gbWljaGFlbC5qYW1ldEBpbnRlbC5jb207IFllaGV6a2VsU2hCQGdt
YWlsLmNvbTsNCj4gcmFqbW9oYW4ubWFuaUBpbnRlbC5jb207DQo+ID4gPiBuaWNob2xhcy5qb2hu
c29uLW9wZW5zb3VyY2VAb3V0bG9vay5jb20uYXU7IGx1a2FzQHd1bm5lci5kZTsNCj4gPiA+IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Ow0KPiA+
ID4gYW50aG9ueS53b25nQGNhbm9uaWNhbC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDE3LzIyXSB0aHVuZGVyYm9sdDogQWRk
IGluaXRpYWwgc3VwcG9ydCBmb3IgVVNCNA0KPiA+ID4NCj4gPiA+DQo+ID4gPiBbRVhURVJOQUwg
RU1BSUxdDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBPY3QgMDEsIDIwMTkgYXQgMDY6MTQ6MjNQTSAr
MDAwMCwgTWFyaW8uTGltb25jaWVsbG9AZGVsbC5jb20NCj4gd3JvdGU6DQo+ID4gPiA+IE9uZSBt
b3JlIHRob3VnaHQ7IHdvdWxkIHlvdSBjb25zaWRlciBleHBvcnRpbmcgdG8gc3lzZnMgc3ctDQo+
ID4gPiA+Y29uZmlnLnZlbmRvcl9pZD8NCj4gPiA+ID4gTWF5YmUgYW4gYXR0cmlidXRlIHRoYXQg
aXMgc3dpdGNoX3ZlbmRvcj8NCj4gPiA+ID4NCj4gPiA+ID4gVXNlcmxhbmQgZnd1cGQgYWxzbyBk
b2VzIHZhbGlkYXRpb24gb24gdGhlIE5WTSBhbmQgd2lsbCBuZWVkIHRvIGZvbGxvdw0KPiB0aGlz
Lg0KPiA+ID4gPiBUaGUgc2FtZSBjaGVjayB3aWxsIGdvIGludG8gZnd1cGQgdG8gbWF0Y2ggdGhl
IHZlbmRvciBhbmQgbGFjayBvZg0KPiA+ID4gbnZtX25vbl9hY3RpdmUwDQo+ID4gPiA+IHRvIG1h
cmsgdGhlIGRldmljZSBhcyBub3QgdXBkYXRhYmxlLiAgV2hlbiB0aGUgY2hlY2tzIGluIHRoZSBr
ZXJuZWwgZ2V0DQo+ID4gPiByZWxheGVkLA0KPiA+ID4gPiBzb21lIE5WTSBwYXJzaW5nIHdpbGwg
aGF2ZSB0byBtYWtlIGl0IG92ZXIgdG8gZnd1cGQgdG9vIHRvIHJlbGF4IHRoZSBjaGVjaw0KPiBh
dA0KPiA+ID4gdGhhdCBwb2ludC4NCj4gPiA+DQo+ID4gPiBUaGUgb3JpZ2luYWwgaWRlYSB3YXMg
dGhhdCB0aGUga2VybmVsIGRvZXMgdGhlIGJhc2ljIHZhbGlkYXRpb24gYW5kDQo+ID4gPiB1c2Vy
c3BhY2UgdGhlbiBkb2VzIG1vcmUgY29tcGxleCBjaGVja3MuIEN1cnJlbnRseSB5b3UgY2FuIGNv
bXBhcmUgdGhlDQo+ID4gPiB0d28gTlZNIGltYWdlcyAoYWN0aXZlIG9uZSBhbmQgdGhlIG5ldykg
YW5kIGZpbmQgdGhhdCBpbmZvcm1hdGlvbiB0aGVyZS4NCj4gPiA+IEkgdGhpbmsgZnd1cGQgaXMg
ZG9pbmcganVzdCB0aGF0IGFscmVhZHkuIElzIHRoYXQgbm90IGVub3VnaD8NCj4gPg0KPiA+IEkg
Z3Vlc3MgZm9yIGZ3dXBkIHdlIGNhbiBkbyB0aGlzIHdpdGhvdXQgdGhlIGV4dHJhIGF0dHJpYnV0
ZToNCj4gPg0KPiA+IDEpIElmIG5vIE5WTSBmaWxlcyBvciBudm1fdmVyc2lvbjogbWVhbnMgdW5z
dXBwb3J0ZWQgdmVuZG9yIC1zaG93IHRoYXQNCj4gbWVzc2FnaW5nIHNvbWV3aGVyZS4NCj4gPiBU
aGlzIG1lYW5zIGtlcm5lbCBkb2Vzbid0IGtub3cgdGhlIHZlbmRvci4NCj4gPg0KPiA+IDIpIElm
IE5WTSBmaWxlIGFuZCBudm1fdmVyc2lvbjogbWVhbnMga2VybmVsIGtub3dzIGl0DQo+ID4gKmZ3
dXBkIGNoZWNrcyB0aGUgdmVuZG9yIG9mZnNldCBmb3IgaW50ZWwuDQo+ID4gLT4gaW50ZWw6IGdv
b2QsIHByb2NlZWQNCj4gPiAtPnNvbWV0aGluZyBlbHNlOiBmd3VwZCBuZWVkcyB0byBsZWFybiB0
aGUgZm9ybWF0IGZvciB0aGUgbmV3IHZlbmRvciwgc2hvdw0KPiBtZXNzYWdpbmcNCj4gPg0KPiA+
IFRoZXJlIGlzIHRoZSB1bmxpa2VseSBjYXNlIHRoYXQga2VybmVsIGtub3dzIG5ldyB2ZW5kb3Ig
Zm9ybWF0IGFuZCB2ZW5kb3INCj4gTlZNIGhhcHBlbmVkIHRvIGhhdmUNCj4gPiBzYW1lIHZhbHVl
IGFzIEludGVsIHZlbmRvciBJRCBpbiBzYW1lIGxvY2F0aW9uIG9mIEludGVsIE5WTSBidXQgYW5v
dGhlcg0KPiBtZWFuaW5nLg0KPiA+IEhvcGVmdWxseSB0aGF0IGRvZXNuJ3QgaGFwcGVuIDopDQo+
IA0KPiBJdCdzIG5vdCBldmVuICJzYW1lIGxvY2F0aW9uIC0gYW5vdGhlciBtZWFuaW5nIiwgdGhl
IHZlbmRvciBJRCBjb21lcyBmcm9tIHRoZQ0KPiBEUk9NIHNlY3Rpb24sIHNvIGl0IHRha2VzIGEg
ZmV3IGludGVybmFsIGp1bXBzIGluc2lkZSB0aGUgTlZNIHRvIGZpbmQgdGhlDQo+IGxvY2F0aW9u
LiBPbmUgb2YgdGhlICJwb2ludGVycyIgb3Igc2VjdGlvbiBoZWFkZXJzIHdpbGwgYmUgYnJva2Vu
IGZvciBzdXJlLg0KPiANCj4gQW5kIGFmdGVyIHRoaXMsIHdlIG5lZWQgdG8gZmluZCB0aGUgTlZN
IGluIExWRlMgYW5kIGl0IGhhcyB0byBwYXNzIHZhbGlkYXRpb24gaW4NCj4gYSBmZXcgb3RoZXIg
bG9jYXRpb25zLiBUaGUgY2hhbmNlcyBhcmUgc28gbG93IHRoYXQgSSdkIHRoaW5rIGl0IGlzbid0
IHdvcnRoDQo+IHdvcnJ5aW5nIGFib3V0IGl0Lg0KDQpBbmQgbm93IEkgcmVtZW1iZXIgd2h5IHRo
ZSBiYWNrIG9mIG15IG1pbmQgd2FzIGhhdmluZyB0aGlzIHRob3VnaHQgb2Ygd2FudGluZw0Kc3lz
ZnMgYXR0cmlidXRlIGluIHRoZSBmaXJzdCBwbGFjZS4gIFRoZSBtdWx0aXBsZSBqdW1wcyBtZWFu
cyB0aGF0IGEgbG90IG1vcmUgb2YgdGhlDQpOVk0gaGFzIHRvIGJlIGR1bXBlZCB0byBnZXQgdGhh
dCBkYXRhLCB3aGljaCBzbG93cyBkb3duIGZ3dXBkIHN0YXJ0dXAgc2lnbmlmaWNhbnRseS4NCkhv
d2V2ZXIgdGhlIGtlcm5lbCBoYXMgdGhpcyBpbmZvcm1hdGlvbiBoYW5keSBhbHJlYWR5IGZyb20g
dGh1bmRlcmJvbHQgaW5pdCBhbmQgY2FuDQplYXNpbHkgZXhwb3J0IGFuIGF0dHJpYnV0ZSB3aGlj
aCBjYW4gdGhlbiBjb21lIGZyb20gdWRldiB3aXRoIG5vIHN0YXJ0dXAgcGVuYWx0eS4NCg0KDQo=
