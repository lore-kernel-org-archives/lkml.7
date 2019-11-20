Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A1DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFEB20715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="DEHv0d2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfKTRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:42:24 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:40422 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbfKTRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:42:24 -0500
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKHaSMC016928
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=FcWpCdyTsdKjkrhDjEDzm3Iz3GzkKyv0UiFMeaU9rnI=;
 b=DEHv0d2TNBzfij/bOjz57EeWOLYGZfhmqwy4DDQOJgtuVh7GcUNJK/jn7WsKWAe19esE
 P6XaHM68jeJaDSpMpIvmZw/ixbQsNvVT6PJcb3UAQ2IpZ2Y4R3ypHNNTTdqm7UQN2omG
 80ntM5zyzaeR0iHRqdsZeqVVRtl8W3AkGJw7WeqDxB972NNa0uGoou6JPzqI2yC0pzZr
 94i9RvfT7A3LspfiTrS7kBpe6eKbANS2wcLkVnArLUWHW6E/tzQoW4KN+mGoV5XllJos
 /5O6f/xuUwNV7ph9ATr7D1nnr44JhoPZ2dxTrN/SckOrdzTDYBIBjwcP8rlyJ8OwkOeR nA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2wadu1amgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:42:22 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKHXrMK014852
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:42:21 -0500
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2wcefn3tb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:42:21 -0500
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="403917177"
From:   <Mario.Limonciello@dell.com>
To:     <yehezkelshb@gmail.com>
CC:     <mika.westerberg@linux.intel.com>, <pmenzel@molgen.mpg.de>,
        <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <ck@xatom.net>, <linux-kernel@vger.kernel.org>,
        <anthony.wong@canonical.com>
Subject: RE: USB devices on Dell TB16 dock stop working after resuming
Thread-Topic: USB devices on Dell TB16 dock stop working after resuming
Thread-Index: AQHVkxGi4f0HmqPYOkmPAZlfRfFMhqd7dbiAgAAFewCAABDQAP//m/tggABrZQCAAALDgIAXnKiAgAEsYAD//9QgQIAAeCqA//+3CCAADRJdAAALxgIA
Date:   Wed, 20 Nov 2019 17:41:43 +0000
Message-ID: <291d19c96463462b911988d47b9a6a0d@AUSX13MPC105.AMER.DELL.COM>
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
 <20191104142459.GC2552@lahna.fi.intel.com>
 <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
 <20191120105048.GY11621@lahna.fi.intel.com>
 <ccfa5f1a1b5e475aa4ddcbed2297b9c4@AUSX13MPC105.AMER.DELL.COM>
 <20191120152351.GJ11621@lahna.fi.intel.com>
 <90daf5669f064057b3d0da5fc110b3a4@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXubOwsradq=ObUF-h6WBpRF3tDx9TqaUO8TeJDqvdeGPg@mail.gmail.com>
In-Reply-To: <CA+CmpXubOwsradq=ObUF-h6WBpRF3tDx9TqaUO8TeJDqvdeGPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-11-20T17:41:40.9193997Z;
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
 definitions=2019-11-20_05:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=642 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200148
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=752 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911200148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEJ1dCBJIG1lYW4gdGhpcyBpcyBnZW5lcmFsbHkgYW4gdW5zYWZlIChidXQgY29udmVuaWVu
dCkgb3B0aW9uLCBpdCBtZWFucyB0aGF0IHlvdQ0KPiA+IHRocm93IG91dCBzZWN1cml0eSBwcmUt
Ym9vdCwgYW5kIGFsbCBzb21lb25lIG5lZWRzIHRvIGRvIGlzIHR1cm4gb2ZmIHlvdXINCj4gbWFj
aGluZSwNCj4gPiBwbHVnIGluIGEgbWFsaWNpb3VzIGRldmljZSwgdHVybiBpdCBvbiBhbmQgdGhl
biB0aGV5IGhhdmUgbWFsaWNpb3VzIGRldmljZSBhbGwgdGhlDQo+IHdheQ0KPiA+IGludG8gT1Mu
DQo+IA0KPiBPbmx5IGlmIHRoZSBhdHRhY2tlciBmb3VuZCBob3cgdG8gZm9yZ2UgdGhlIGRldmlj
ZSBVVUlEIChhbmQga25ldyB3aGF0IFVVSURzDQo+IGFyZSBhbGxvd2VkKSwgaXNuJ3QgaXQ/IFVu
bGVzcyB5b3UgdGFrZSBpbnRvIGFjY291bnQgdGhpbmdzIGxpa2UNCj4gZXh0ZXJuYWwgR1BVIGJv
eCwNCj4gd2hlcmUgaXQncyBwcmV0dHkgZWFzeSB0byByZXBsYWNlIHRoZSBjYXJkIGluc3RhbGxl
ZCBpbnNpZGUgaXQuDQoNCk5vdGljZSwgSSBuZXZlciBzYWlkIGl0IHdhcyBlYXN5IDopDQoNCklu
IG9yZGVyIHRvIHR1cm4gdGhhdCBvbiBzb21ldGhpbmcgbGlrZSB0aGF0ICJnZW5lcmFsbHkiIHNh
ZmVseSB5b3UgbmVlZCB0byBoYXZlDQptaXRpZ2F0aW9ucyBsaWtlIHByZSBib290IERNQSBwcm90
ZWN0aW9uIGluIHBsYWNlLg0K
