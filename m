Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D265CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECB8217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="pElSTVIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfDWGjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:39:31 -0400
Received: from mail-eopbgr750070.outbound.protection.outlook.com ([40.107.75.70]:46469
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfDWGja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIlsA/kYl0XLELVDxV9pRgzdKNXxZkjx74fS+0LxKyA=;
 b=pElSTVItB8RqsRNZ6aNr31ImIHYwB05t4vGW4r90f0ld54QkKGsYtXzYeawsP9QDPQXNo4+qFLNpYlAncZrHp5XbOQRpWF/WkuaJHoKY32d2aVptoh+2n6hxItEscyPVYvhmWaZubGXOsWXNqN7rXclFi5C2Jh+KRz/GdWH8ujk=
Received: from MWHPR03CA0021.namprd03.prod.outlook.com (2603:10b6:300:117::31)
 by BN3PR03MB2257.namprd03.prod.outlook.com (2a01:111:e400:c5f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.18; Tue, 23 Apr
 2019 06:38:48 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR03CA0021.outlook.office365.com
 (2603:10b6:300:117::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.12 via Frontend
 Transport; Tue, 23 Apr 2019 06:38:47 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Tue, 23 Apr 2019 06:38:47 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x3N6ckK4028039
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Apr 2019 23:38:46 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 23 Apr 2019 02:38:46 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Thread-Topic: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Thread-Index: AQHU+OX/0R8yezHYP0WMOZzYo8YTnKZI76qAgACf+gA=
Date:   Tue, 23 Apr 2019 06:38:44 +0000
Message-ID: <86ea407aaa891e50a3bdaf2c3653636a365076ee.camel@analog.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
         <20190422210606.GA8805@kroah.com>
In-Reply-To: <20190422210606.GA8805@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D7D374C1CEFC24B94868A1D07E96469@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(189003)(199004)(436003)(106002)(446003)(11346002)(186003)(246002)(229853002)(8676002)(316002)(8936002)(476003)(2501003)(336012)(1730700003)(102836004)(47776003)(2351001)(54906003)(126002)(486006)(26005)(76176011)(3846002)(23676004)(86362001)(70586007)(478600001)(2616005)(426003)(2486003)(7696005)(6916009)(14454004)(5640700003)(4326008)(7636002)(6116002)(5660300002)(7736002)(70206006)(118296001)(50466002)(14444005)(6246003)(2906002)(356004)(305945005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2257;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea37b16-fa59-4c1e-1c5e-08d6c7b656f7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BN3PR03MB2257;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2257:
X-Microsoft-Antispam-PRVS: <BN3PR03MB2257274A50AAF369F3C18AD7F9230@BN3PR03MB2257.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0016DEFF96
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6CysNJbuzAGdQvSRtcf8VE3EKMPi9gapnv6nqDMElaZIdEKxche2hEvMdcJWgNu0GQB+MLDD9giwLdRg0DCkGGNXZdO2PnKVHTrhHplIiUwpQ+1pQwFoWY/5fJdx0udajwyXgXhKIuHMjzMFVFmYeLviOTUxRTkZfIsYsYwm1TmMGfq3HgszSfz2Qbnz13RMM9eJcLnGK6jNMQE/lzv/jJ7yIJ72+JQE6mqid+h05fn8NGhC1KD9HlLzWbBUpl7QQpsu1vFmeB5jW7qLaKvck3cy7343enZkPCjLbfqrTxLARAODE6Gu0aEmdqYxOFPK6mr5fRDJJ664dfVoQhLrE4LUJh5yT8IAjmWP7vSxeTey5BmsXYkPmfQU8hFk6B9B4VRhYmtRIZZcQB0ez/B5/rc9QHNGz86JwqYajn+QYOo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2019 06:38:47.3291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea37b16-fa59-4c1e-1c5e-08d6c7b656f7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTIyIGF0IDIzOjA2ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiANCj4g
DQo+IE9uIE1vbiwgQXByIDIyLCAyMDE5IGF0IDExOjMyOjU2QU0gKzAzMDAsIEFsZXhhbmRydSBB
cmRlbGVhbiB3cm90ZToNCj4gPiBUaGlzIGhlbHBlciBpcyBzaW1pbGFyIHRvIF9fc3lzZnNfbWF0
Y2hfc3RyaW5nKCkgd2l0aCB0aGUgZXhjZXB0aW9uDQo+ID4gdGhhdCBpdA0KPiA+IGlnbm9yZXMg
TlVMTCBlbGVtZW50cyB3aXRoaW4gdGhlIGFycmF5Lg0KPiANCj4gc3lzZnMgaXMgIm9uZSB2YWx1
ZSBwZXIgZmlsZSIsIHdoeSBhcmUgeW91IHRyeWluZyB0byB3cml0ZSBtdWx0aXBsZQ0KPiB0aGlu
Z3Mgb24gYSBzaW5nbGUgbGluZSB0byBhIHNpbmdsZSBzeXNmcyBmaWxlPw0KPiANCj4gSXMgSUlP
IHJlYWxseSB0aGF0IG1lc3N5PyAgOikNCj4gDQoNCkhtbSwgSSBkb24ndCB0aGluayBJIHVuZGVy
c3Rvb2QgdGhlIGNvbW1lbnQvcXVlc3Rpb24sIG9yIG1heWJlIEkgZGlkIG5vdA0KZm9ybXVsYXRl
IHRoZSBjb21tZW50IHByb3Blcmx5Lg0KDQpNYXliZSBKb25hdGhhbiBjYW4gcGl0Y2gtaW4gaGVy
ZSBpZiBJJ20gc2F5aW5nIHNvbWV0aGluZyB3cm9uZy4NCg0KU28sIGluIElJTyB0aGVyZSBpcyBg
c3RydWN0IGlpb19lbnVtYCB3aGljaCBpcyBlc3NlbnRpYWxseSBhIHN5c2ZzIHdyYXBwZXINCmZv
ciBleHBvc2luZyBhbiAiZW51bSIgdHlwZSB0byB1c2Vyc3BhY2UgdmlhIHN5c2ZzICh3aGljaCB0
YWtlcyBvbmx5IG9uZQ0KdmFsdWUpLiBUaGlzIGlpb19lbnVtIHR5cGUgaXMgYmFzaWNhbGx5IGEg
c3RyaW5nLXRvLWludCBtYXBwaW5nLg0KDQpTb21lIGV4YW1wbGUgaW4gQzoNCg0KZW51bSB7DQog
ICAgRU5VTTAsDQogICAgRU5VTTEsDQogICAgRU5VTTUgPSA1LA0KICAgIEVOVU02LA0KICAgIEVO
VU03DQp9Ow0KDQoNCi8qIE5vdGljZSB0aGUgZ2FwcyBpbiB0aGUgZWxlbWVudHMgKi8NCnN0YXRp
YyBjb25zdCBjaGFyICogY29uc3QgaXRlbV9zdHJpbmdzW10gPSB7DQogICAgICAgIFtFTlVNMF0g
PSAibW9kZTAiLA0KICAgICAgICBbRU5VTTFdID0gIm1vZGUxIiwNCiAgICAgICAgW0VOVU01XSA9
ICJtb2RlNSIsDQogICAgICAgIFtFTlVNNl0gPSAibW9kZTYiLCANCiAgICAgICAgW0VOVU03XSA9
ICJtb2RlNyIsDQp9Ow0KICAgICAgICAgICAgICAgICAgICAgICAgIA0Kc3RhdGljIGNvbnN0IHN0
cnVjdCBpaW9fZW51bSBpaW9fZW51bTEgPSB7DQogICAgICAgIC5pdGVtcyA9IGl0ZW1fc3RyaW5n
cywNCiAgICAgICAgLm51bV9pdGVtcyA9IEFSUkFZX1NJWkUoaXRlbV9zdHJpbmdzKSwNCiAgICAg
ICAgLnNldCA9IGlpb19lbnVtMV9zZXQsDQogICAgICAgIC5nZXQgPSBpaW9fZW51bTFfZ2V0LA0K
fTsNCg0KDQpUaGUgc2lnbmF0dXJlIG9mIHRoZSBpaW9fZW51bTFfc2V0IC8gaWlvX2VudW0xX2dl
dCBpcyBiZWxvdzoNCg0Kc3RhdGljIGludCBpaW9fZW51bTFfc2V0KHN0cnVjdCBpaW9fZGV2ICpp
bmRpb19kZXYsDQogICAgICAgIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFuLCB1bnNp
Z25lZCBpbnQgdmFsKTsNCg0Kc3RhdGljIGludCBpaW9fZW51bTFfZ2V0KHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYsDQogICAgICAgIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFuKQ0K
DQoNCklJTyBjb3JlIHJlc29sdmVzIHRoZSBzdHJpbmctdG8taW50IG1hcHBpbmcuDQpJdCB1c2Vz
IF9fc3lzZnNfbWF0Y2hfc3RyaW5nKCkgdG8gZG8gdGhhdCwgYnV0IGl0IHJlcXVpcmVzIHRoYXQg
dGhlIGxpc3Qgb2YNCnN0cmluZ3MgKGFuZCBDIGVudW1zKSBiZSBjb250aWd1b3VzLg0KVGhpcyBj
aGFuZ2UgW2FuZCBWMiBvZiB0aGlzIHBhdGNoXSBpbnRyb2R1Y2VzIGENCl9fc3lzZnNfbWF0Y2hf
c3RyaW5nX3dpdGhfZ2FwcygpIGhlbHBlciB0aGF0IGlnbm9yZXMgZ2FwcyAocmVwcmVzZW50ZWQg
YXMNCk5VTExzKS4NCg0KRm9yIHJlZmVyZW5jZSwgX19zeXNmc19tYXRjaF9zdHJpbmcoKSByZXR1
cm5zIC1FSU5WQUwgb24gdGhlIGZpcnN0IE5VTEwgaW4NCnRoZSBhcnJheSBvZiBzdHJpbmdzIChy
ZWdhcmRsZXNzIG9mIHRoZSBnaXZlbiBhcnJheSBzaXplKS4NCg0KX19zeXNmc19tYXRjaF9zdHJp
bmdfd2l0aF9nYXBzKCkgaXMgdHlwaWNhbGx5IGhlbHBmdWwgd2hlbiBDIGVudW1zIHJlZmVyIHRv
DQpiaXRmaWVsZHMsIG9yIGhhdmUgc29tZSBlcXVpdmFsZW5jZSBpbiBIVy4NCg0KVGhhbmtzDQpB
bGV4DQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
