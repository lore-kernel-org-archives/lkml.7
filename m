Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D212AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847AE20878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="CG/9BVKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfKTRGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:06:43 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:43228 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728040AbfKTRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:06:43 -0500
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKGwnhV023443
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=H1B6VurNKQ1k1lUlsiR8CsBBa9d6UTufUw8tDcWc934=;
 b=CG/9BVKj0Wv6nxcWSr1t6TyrarY3/46o61Eb0YgC5bmW6btVX/+eDOUW7FhsyNbaVgjN
 u+UucFhkpaE+W3ew3h4h0iwWzoRyQXkVbqHlJUnbNBV43kwhx0OGbh1yxVCFtEBJaXDB
 2SfY6MCg0ApXOIwXOlifhE6uYJ+ir9MoB/CZDWKEnLonoc1y0z/BhkfiXnz39OF0/XHw
 DB6LxmQq2iVUVdP7Yd03NAKFp3Ppw3QiUaimDYIB4VzPCSieiLTC7lYjs5Qs4hp0trh2
 yMzd80OANv2ZYAplslZg78PN8X9TKJr4ku4uaSrKnzp6IaxlTF+eWX1mUMZB0FFrfsw7 xQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2wad50aqpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:06:42 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKH2YEJ152419
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:06:41 -0500
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 2wcefn38nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:06:41 -0500
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="885188116"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <pmenzel@molgen.mpg.de>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>, <ck@xatom.net>,
        <linux-kernel@vger.kernel.org>, <anthony.wong@canonical.com>
Subject: RE: USB devices on Dell TB16 dock stop working after resuming
Thread-Topic: USB devices on Dell TB16 dock stop working after resuming
Thread-Index: AQHVkxGi4f0HmqPYOkmPAZlfRfFMhqd7dbiAgAAFewCAABDQAP//m/tggABrZQCAAALDgIAXnKiAgAEsYAD//9QgQIAAeCqA//+3CCA=
Date:   Wed, 20 Nov 2019 17:06:39 +0000
Message-ID: <90daf5669f064057b3d0da5fc110b3a4@AUSX13MPC105.AMER.DELL.COM>
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
In-Reply-To: <20191120152351.GJ11621@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-11-20T17:06:38.3463573Z;
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
 clxscore=1015 mlxlogscore=685 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200145
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=795 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gWWVhaCBpdCBtaWdodCBiZSB1c2VmdWwgdG8gZW51bWVyYXRlIGFsbCB0aGUgQklPUyBz
ZXR0aW5ncyB0aGF0IGFyZSBzZWxlY3RlZA0KPiA+IHJlbGF0ZWQgdG8gVGh1bmRlcmJvbHQuICBT
b21lIG9mIHRoZW0gYXJlIGEgYml0IGNvbmZ1c2luZy4NCj4gDQo+IEJUVywgSSBwbGF5ZWQgYSBi
aXQgd2l0aCA5MzgwIGFuZCBpdCBsb29rcyBsaWtlIHRoZXJlIGlzIG5vIG9wdGlvbiB0bw0KPiBl
bmFibGUgUHJlYm9vdCBBQ0wgd2hpY2ggbWVhbnMgdGhhdCBpZiB5b3UgaGF2ZSBUQlQgc2VjdXJp
dHkgZW5hYmxlZA0KPiAodXNlciBvciBzZWN1cmUpIHRoZSBEb2NrIFBDSWUgc2lkZSBpcyBub3Qg
ZnVuY3Rpb25hbCBkdXJpbmcgYm9vdCwgb25seQ0KPiBvbmNlIHRoZSBPUyBoYXMgYm9vdGVkIHVw
LiBUaGF0J3MgZmluZSB1bmxlc3MgeW91IHdhbnQgdG8gZW50ZXIgQklPUw0KPiBtZW51IGZyb20g
dGhlIGtleWJvYXJkIHlvdSBoYXZlIGNvbm5lY3RlZCB0byB0aGUgVEIxNiBkb2NrIChwcm9iYWJs
eSBub3QNCj4gdG9vIGNvbW1vbiB1c2UgY2FzZSBhbnl3YXkpLg0KDQpFaD8gIE9uIDkzODAgaW4g
ZnJvbnQgb2YgbWU6DQpTeXN0ZW0gQ29uZmlndXJhdGlvbiAtPiBUaHVuZGVyYm9sdCAoVE0pIEFk
YXB0ZXIgQ29uZmlndXJhdGlvbg0KDQpUaGVyZSBpcyBhIGNoZWNrYm94IGZvciAiRW5hYmxlIFRo
dW5kZXJib2x0IChhbmQgUENJZSBiZWhpbmQgVEJUKSBQcmUtYm9vdA0KbW9kdWxlcyIuICBJdCdz
IG5vdCBjaGVja2VkIGJ5IGRlZmF1bHQsIGJ1dCB0aGF0IHNob3VsZCB0dXJuIG9uIHByZS1ib290
IEFDTA0Kc3R1ZmYuICBUaGF0J3MgdGhlIHRoaW5nIHRoYXQgUGF1bCBwcm9iYWJseSBuZWVkcyBj
aGVja2VkIHRvby4NCg0KQnV0IEkgbWVhbiB0aGlzIGlzIGdlbmVyYWxseSBhbiB1bnNhZmUgKGJ1
dCBjb252ZW5pZW50KSBvcHRpb24sIGl0IG1lYW5zIHRoYXQgeW91DQp0aHJvdyBvdXQgc2VjdXJp
dHkgcHJlLWJvb3QsIGFuZCBhbGwgc29tZW9uZSBuZWVkcyB0byBkbyBpcyB0dXJuIG9mZiB5b3Vy
IG1hY2hpbmUsDQpwbHVnIGluIGEgbWFsaWNpb3VzIGRldmljZSwgdHVybiBpdCBvbiBhbmQgdGhl
biB0aGV5IGhhdmUgbWFsaWNpb3VzIGRldmljZSBhbGwgdGhlIHdheQ0KaW50byBPUy4NCg0KDQo=
