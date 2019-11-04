Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866A3CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451FB20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="CcDZWdGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfKDPuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:50:00 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:60784 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728012AbfKDPt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:49:59 -0500
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4FkJL3011648
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 10:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lcT0TLQ+KHF8FTrslFNo6DclGX+F8I/fhOPp8j9/7dw=;
 b=CcDZWdGawu5dkOnTrspT+YyNhsTAtjXAJep0GdLP9V+odB/RHDCz3SM7eRUGoNbvmDnV
 0GpX/dy/YN660r7Dbv8QmTLQv9cicnRqEQbYYlvaiq3Bz8CVO0MNI7uvUJ9HDgxAY7mi
 9I1mFh020Dj4ix6VJI8+lcXAxqJoFOJeQZDBNN7dqjDYhVHZcyJBP7YfS0BDHyGJAEnn
 MFvNr7BWRuY0u/oeer06nfd7gfqc/V9eXFzEgquwkoWIhUYRy6o7gRt8v6N1hvJiRD9E
 QLr/Xa2B4CCP62E52W2wgJ50sCF9FLupXC/IUucypHWOY7oJaMt4ef41p7VtjTwmsieD qA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2w15178f9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:49:58 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4FmkBW059531
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 10:49:58 -0500
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2w14edq9mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:49:58 -0500
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="445097246"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <pmenzel@molgen.mpg.de>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <ck@xatom.net>,
        <linux-kernel@vger.kernel.org>, <anthony.wong@canonical.com>
Subject: RE: USB devices on Dell TB16 dock stop working after resuming
Thread-Topic: USB devices on Dell TB16 dock stop working after resuming
Thread-Index: AQHVkxGi4f0HmqPYOkmPAZlfRfFMhqd7dbiAgAAFewCAABDQAP//m/tg
Date:   Mon, 4 Nov 2019 15:49:55 +0000
Message-ID: <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
 <20191104142459.GC2552@lahna.fi.intel.com>
 <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com>
In-Reply-To: <20191104154446.GH2552@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-11-04T15:49:53.9303952Z;
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=987 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040155
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWthIFdlc3RlcmJlcmcgPG1p
a2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIg
NCwgMjAxOSA5OjQ1IEFNDQo+IFRvOiBQYXVsIE1lbnplbA0KPiBDYzogQW5kcmVhcyBOb2V2ZXI7
IE1pY2hhZWwgSmFtZXQ7IFllaGV6a2VsIEJlcm5hdDsgQ2hyaXN0aWFuIEtlbGxuZXI7IExpbnV4
DQo+IEtlcm5lbCBNYWlsaW5nIExpc3Q7IExpbW9uY2llbGxvLCBNYXJpbw0KPiBTdWJqZWN0OiBS
ZTogVVNCIGRldmljZXMgb24gRGVsbCBUQjE2IGRvY2sgc3RvcCB3b3JraW5nIGFmdGVyIHJlc3Vt
aW5nDQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gT24gTW9uLCBOb3YgMDQsIDIw
MTkgYXQgMDQ6NDQ6NDBQTSArMDIwMCwgTWlrYSBXZXN0ZXJiZXJnIHdyb3RlOg0KPiA+IE9uIE1v
biwgTm92IDA0LCAyMDE5IGF0IDA0OjI1OjAzUE0gKzAyMDAsIE1pa2EgV2VzdGVyYmVyZyB3cm90
ZToNCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgTm92IDA0LCAyMDE5IGF0IDAyOjEz
OjEzUE0gKzAxMDAsIFBhdWwgTWVuemVsIHdyb3RlOg0KPiA+ID4gPiBEZWFyIExpbnV4IGZvbGtz
LA0KPiA+ID4gPg0KPiA+ID4gPiBPbiB0aGUgRGVsbCBYUFMgMTMgOTM4MCB3aXRoIERlYmlhbiBT
aWQvdW5zdGFibGUgd2l0aCBMaW51eCA1LjMuNw0KPiA+ID4gPiBzdXNwZW5kaW5nIHRoZSBzeXN0
ZW0sIGFuZCByZXN1bWluZyB3aXRoIERlbGzigJlzIFRodW5kZXJib2x0IFRCMTYNCj4gPiA+ID4g
ZG9jayBjb25uZWN0ZWQsIHRoZSBVU0IgaW5wdXQgZGV2aWNlcywga2V5Ym9hcmQgYW5kIG1vdXNl
LA0KPiA+ID4gPiBjb25uZWN0ZWQgdG8gdGhlIFRCMTYgc3RvcCB3b3JraW5nLiBUaGV5IHdvcmsg
Zm9yIGEgZmV3IHNlY29uZHMNCj4gPiA+ID4gKG1vdXNlIGN1cnNvciBjYW4gYmUgbW92ZWQpLCBi
dXQgdGhlbiBzdG9wIHdvcmtpbmcuIFRoZSBsYXB0b3ANCj4gPiA+ID4ga2V5Ym9hcmQgYW5kIHRv
dWNocGFkIHN0aWxsIHdvcmtzIGZpbmUuIEFsbCBmaXJtd2FyZSBpcyB1cC10by1kYXRlDQo+ID4g
PiA+IGFjY29yZGluZyB0byBgZnd1cGRtZ3JgLg0KPiA+ID4NCj4gPiA+IFdoYXQgYXJlIHRoZSBl
eGFjdCBzdGVwcyB0byByZXByb2R1Y2U/IEp1c3QgImVjaG8gbWVtID4NCj4gPiA+IC9zeXMvcG93
ZXIvc3RhdGUiIGFuZCB0aGVuIHJlc3VtZSBieSBwcmVzc2luZyBwb3dlciBidXR0b24/DQo+ID4N
Cj4gPiBJIHRyaWVkIHY1LjQtcmM2IG9uIG15IDkzODAgd2l0aCBUQjE2IGRvY2sgY29ubmVjdGVk
IGFuZCBkaWQgYSBjb3VwbGUgb2YNCj4gPiBzdXNwZW5kL3Jlc3VtZSBjeWNsZXMgKHRvIHMyaWRs
ZSkgYnV0IEkgZG9uJ3Qgc2VlIGFueSBpc3N1ZXMuDQo+ID4NCj4gPiBJIG1heSBoYXZlIG9sZGVy
L2RpZmZlcmVudCBmaXJtd2FyZSB0aGFuIHlvdSwgdGhvdWdoLg0KPiANCj4gVXBncmFkZWQgQklP
UyB0byAxLjguMCBhbmQgVEJUIE5WTSB0byB2NDQgYnV0IHN0aWxsIGNhbid0IHJlcHJvZHVjZSB0
aGlzDQo+IG9uIG15IHN5c3RlbSA6Lw0KDQpMb29wIEFudGhvbnkuICBBbnRob255IGNhbiB5b3Ug
c2VlIGlmIHlvdSBndXlzIHJlcHJvIHRoaXMgYXQgYWxsIHRvbz8NCg0KQXMgYSBwb3RlbnRpYWwg
cG9pbnQgb2YgY29tcGFyaXNvbiBhbmQgc29tZXRpbWVzIHBhaW4gYXJlYSwgSSdtIHdvbmRlcmlu
ZyBpZg0Kc29tZXRoaW5nIGluIHVzZXJsYW5kIGlzIHBva2luZyBwb3dlciBzdGF0ZXMgZm9yIFBh
dWwgbGVhZGluZyB0byB0aGlzLg0KDQpQYXVsIHdoYXQgc29ydCBvZiBwb3dlciBtYW5hZ2VtZW50
IHBvbGljaWVzIGFyZSB5b3UgdXNpbmcgb24geW91ciBtYWNoaW5lPyANCkFueXRoaW5nIGxpa2U6
DQoqIHBvd2VydG9wICAtLWF1dG8tdHVuZSwgDQoqIFRMUA0KKiBzeXN0ZW1kID4gMjQzIChjb250
YWlucyBzb21lIHN0dWZmIGZvciBhdXRvbWF0aWMgc3VzcGVuZCkNCg0K
