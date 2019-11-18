Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FE0C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324D9222AB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="V2IuX7pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfKRSS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:18:56 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:34220 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfKRSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:18:55 -0500
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIIA4Pv006358;
        Mon, 18 Nov 2019 13:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=fmtd2iqBbFAO+k5+TNL8jMvexpF7b7aXX6LntGCOHZs=;
 b=V2IuX7pL+Dtqg5r/Gw4TqQJm7cYi7aGb5Im1xfZKevqQ87hSr8IyXfhfuE6X0KWiskUJ
 OPACDAHlhJp1n9mSad7rsrBVlsdZrXkF8TXZZEVoU4BpOR2LrzmF+4PGxO6uj6ooG0Ej
 sqriwTwGmBBINvE5TlPvgBoHPh8VTnwNG0qwqjQEP4kVNpYRKvyAuAseNs+WTvPwF7bC
 kIk7nz8nPvNWHJEkImDoq5Oom2jNtdnba8OZKdD3IV6LCn3pJE+c2GM+8zXhsa81NENG
 DkMMUC12pFw9y0whKkElR167UGqSc5MxaJRiEIISW+Wj9ddRRNojT0X992FTxjYPQsY4 dg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2wad5f05rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 13:18:54 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAII88Sw052981;
        Mon, 18 Nov 2019 13:18:53 -0500
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2wacmg0rva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 13:18:53 -0500
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1378781001"
From:   <Mario.Limonciello@dell.com>
To:     <gayatri.kammela@intel.com>, <andy.shevchenko@gmail.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <vishwanath.somayaji@intel.com>, <dvhart@infradead.org>,
        <linux-kernel@vger.kernel.org>, <charles.d.prestopine@intel.com>,
        <peterz@infradead.org>, <srinivas.pandruvada@intel.com>,
        <andriy.shevchenko@linux.intel.com>, <kan.liang@intel.com>,
        <david.e.box@intel.com>, <rajneesh.bhardwaj@intel.com>,
        <tony.luck@intel.com>
Subject: RE: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Thread-Topic: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Thread-Index: AQHVnf4HfWi4zwIc4UmHAQEsNxXTkKeRn7wA//+dHYA=
Date:   Mon, 18 Nov 2019 18:18:51 +0000
Message-ID: <9b880cb6585d4608814598517fe5d675@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
 <CAHp75Vfrd-BAZ7H_LuQfz32yaap1X3gEnqZ2-9EPQ+j_b0f93g@mail.gmail.com>
 <MN2PR11MB3711EDFC967C295689E109DEF24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB3711EDFC967C295689E109DEF24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_05:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180155
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBwbGF0Zm9ybS1kcml2ZXIteDg2
LW93bmVyQHZnZXIua2VybmVsLm9yZyA8cGxhdGZvcm0tZHJpdmVyLXg4Ni0NCj4gb3duZXJAdmdl
ci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgS2FtbWVsYSwgR2F5YXRyaQ0KPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDE4LCAyMDE5IDEyOjExIFBNDQo+IFRvOiBBbmR5IFNoZXZjaGVua28NCj4g
Q2M6IFBsYXRmb3JtIERyaXZlcjsgU29tYXlhamksIFZpc2h3YW5hdGg7IERhcnJlbiBIYXJ0OyBM
aW51eCBLZXJuZWwgTWFpbGluZw0KPiBMaXN0OyBQcmVzdG9waW5lLCBDaGFybGVzIEQ7IFBldGVy
IFppamxzdHJhOyBQYW5kcnV2YWRhLCBTcmluaXZhczsgQW5keQ0KPiBTaGV2Y2hlbmtvOyBMaWFu
ZywgS2FuOyBCb3gsIERhdmlkIEU7IEJoYXJkd2FqLCBSYWpuZWVzaDsgTHVjaywgVG9ueQ0KPiBT
dWJqZWN0OiBSRTogW1BBVENIIHYzIDAvN10geDg2L2ludGVsX3BtY19jb3JlOiBBZGQgVGlnZXIg
TGFrZSwgRWxraGFydCBMYWtlDQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gPiA+
IEFsbCB0aGUgaW5mb3JtYXRpb24gcmVnYXJkaW5nIHRoZSBQQ0ggSVBzIGFuZCBuYW1lcyBvZiBJ
UHMgd2lsbCBiZQ0KPiA+ID4gYXZhaWxhYmxlIGluIEludGVsJ3MgUGxhdGZvcm0gQ29udHJvbGxl
ciBIdWIgKFBDSCkgRXh0ZXJuYWwgRGVzaWduDQo+ID4gPiBTcGVjaWZpY2F0aW9uIChFRFMpIGRv
Y3VtZW50IGV4cGVjdGVkIHRvIGJlIHJlbGVhc2VkIGluIDIwMjAgYmVmb3JlDQo+ID4gPiBwcm9k
dWN0IGxhdW5jaC4NCj4gPg0KPiA+IFRoYW5rcywgdGhvdWdoIHlvdSBmb3Jnb3QgdG8gZml4IGFs
bCBwcmVmaXhlcyBpbiB0aGUgbWFpbHMuIFdlIGhhdmUNCj4gPiBwbGF0Zm9ybS94ODY6ICREUklW
RVJfTkFNRTogLi4uDQo+ID4NCj4gSGkgQW5keSEgU29ycnkgSSB0aGluayBJIG1pc3VuZGVyc3Rv
b2QgeW91ciBjb21tZW50IGxhc3QgdGltZS4gSnVzdCB0byBtYWtlDQo+IHN1cmUsIHRoZSBwcmVm
aXggc2hvdWxkIHRoZSBwYXR0ZXJuIGluIHRoaXMgY2FzZQ0KPiAicGxhdGZvcm0veDg2OiBpbnRl
bF9wbWNfY29yZTogIiBhbmQgc2hvdWxkIGJlIHNhbWUgZm9yIGFsbCB0aGUgcGF0Y2hlcyBpbiB0
aGUNCj4gc2VyaWVzIHJpZ2h0Pw0KPiANCj4gPiBBbHNvIGNvbnNpZGVyIE1hcmlvJ3MgY29tbWVu
dCAoSSBkaWRuJ3QgaGVhciBiYWNrIGZyb20geW91IG9uIGl0KS4NCj4gU29ycnkgYWJvdXQgdGhh
dC4gSSBhbSBwbGFubmluZyBvbiBzZW5kaW5nIGl0IGEgc2luZ2xlIHBhdGNoIGV4Y2x1ZGluZyBp
dCBmcm9tIHRoZQ0KPiBzZXJpZXMgc2luY2Ugd2UgcmVjZWl2ZWQgYSByZXF1ZXN0IGZyb20gRGVs
bC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSB0aGluayB0aGlzDQo+IHBhdGNoIHNob3VsZCBi
ZSBpbmNsdWRlZCBpbiB0aGUgc2VyaWVzLg0KDQpKdXN0IHRvIG1ha2UgaXQgY2xlYXIgdG8gdGhv
c2Ugb24gdGhlIGxpc3QgLSB0aGUgcmVxdWVzdCBmcm9tIERlbGwgd2FzIG9mZiBsaXN0IGFuZCBz
ZXBhcmF0ZWx5DQpmcm9tIG15IGNvbW1lbnQgaW4gYWRqdXN0aW5nIHRoZSBvcmRlcmluZy4gIEEg
Y29udmVuaWVudCBzaWRlIGVmZmVjdCBpcyB0aGF0IGl0IHdpbGwNCnRha2UgaW50byBjb25zaWRl
cmF0aW9uIG15IGNvbW1lbnQgdG9vIDopDQo=
