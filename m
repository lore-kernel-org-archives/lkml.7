Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A9C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D1120B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="IxDi35Yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfFZH6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:58:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23470 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbfFZH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:58:20 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5Q7w3Ed023476;
        Wed, 26 Jun 2019 03:58:03 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2058.outbound.protection.outlook.com [104.47.40.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tc42b02p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 03:58:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=RAzNP7PTlsLUKOdgT26JhMMlHKQYix3fuJJ0K4cGkEf+y2/nfYVZXaN8qUAhknhLhymABf+nkiVQlpcWA6gV4VhXfmgyZSnYu8IcWtYkVUG2DnASBS4TMfu4qL+s0c2ELPecUdImHdXopHoxHf6PavugZhjOYxeuhOFEtJroxB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzhOGi6LYnwVAKkG5AdeX1oItNxcE6WTwBaEyLnTqLk=;
 b=ikssmAKhGyIiyRRW/EmvhIl5ro1nDwsOkzkYxVvSxMzAExSmtO6mC8GOOsOJfvg+0Bs48G4orb4AbrBszzaL4FeWiNtELxIB9FITkCYC6vM+iXGCAPV2d09m/uEzEH4u12vjKbclAN2csgiw8MdGLX4leq7JQyeLkoPklN48bFQ=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=linux.intel.com
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzhOGi6LYnwVAKkG5AdeX1oItNxcE6WTwBaEyLnTqLk=;
 b=IxDi35Yl9xXPFeNexoqsgFGCb2SA+KjC7y8sQmOKCktYVVUG2CtNSV3CivL34c+suZ0C70nNIohQioEukImdQbD8XS4oD2yKcJu31d/hipcLjV3nvwYsAILRl4lsldrNrPGpv3pxZWexy/5SGr/wDqnhM+qOi3qqzsW+sXV0Zg0=
Received: from DM6PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:100::26)
 by CY4PR03MB3128.namprd03.prod.outlook.com (2603:10b6:910:53::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 07:58:01 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR03CA0049.outlook.office365.com
 (2603:10b6:5:100::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 07:58:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Wed, 26 Jun 2019 07:58:00 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5Q7vxmI016211
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 26 Jun 2019 00:57:59 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Wed, 26 Jun 2019 03:57:59 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH][V4] lib: fix __sysfs_match_string() helper when n != -1
Thread-Topic: [PATCH][V4] lib: fix __sysfs_match_string() helper when n != -1
Thread-Index: AQHVK1YW63Q55qL7rEmy/pVv0EXHt6asoA4AgABooYCAAM1oAA==
Date:   Wed, 26 Jun 2019 07:57:59 +0000
Message-ID: <6cc402d735eef4859332c1d4dcfd6ae8d2cda068.camel@analog.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
         <20190625130104.29904-1-alexandru.ardelean@analog.com>
         <20190625132812.GB9224@smile.fi.intel.com>
         <20190625124241.8b963a256ebaa056d489bb15@linux-foundation.org>
In-Reply-To: <20190625124241.8b963a256ebaa056d489bb15@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B0AD4ED19D87F4A8E8C08569C14C222@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(55674003)(189003)(199004)(54534003)(476003)(446003)(126002)(102836004)(110136005)(50466002)(54906003)(8936002)(8676002)(5660300002)(478600001)(26005)(36756003)(356004)(11346002)(436003)(246002)(6306002)(118296001)(86362001)(486006)(426003)(14454004)(70586007)(2616005)(70206006)(47776003)(186003)(316002)(6246003)(14444005)(966005)(7696005)(2906002)(3846002)(2501003)(106002)(76176011)(23676004)(6116002)(2486003)(4326008)(7636002)(7736002)(305945005)(229853002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3128;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa2cc7d-6d10-4e92-6677-08d6fa0c02ab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY4PR03MB3128;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3128:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <CY4PR03MB3128E246E03FCF40984CFB7CF9E20@CY4PR03MB3128.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qt8VhapzLl7ApgV1Zxlx7Jb4B9UplEVaf3QmCyTNqdv3vVWL5WT+D4ylsB9pirokS2gXooTUHc3VbYu123GHMpQ1v31pL1iTp7vj+sCoI+kA6m3T9XWtFUz2tV0Nl3+HEVJ77aF7+9gLQ9WzUmSTOdT/cfibABQY0kuZPVNDqeTeD5WwUxYyNoTdAJGPE5xPjgRTfXNa+s4C3K/4J8W5wRtiGygS2/MAwTW5a3SlI+7gRbTgkxOwqIofIC38z8BB1FyJcQV0SC1+nYKRPGNAFhXEheg4ndFqUz/mp2AGGtS+g8rwB3bK/M2dGFkw+fEILNTVdJibB6VkwnMfzviGwjuiheuqp+xjHorBLLej8Epo/4aEl21A7ryxnHRPlQeJxhT8AD6iJCoqtAkYS9H6w6zG7i4N2n9QkqqYUXvFzGg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 07:58:00.5838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa2cc7d-6d10-4e92-6677-08d6fa0c02ab
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3128
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTI1IGF0IDEyOjQyIC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gVHVlLCAyNSBKdW4gMjAxOSAxNjoyODoxMiArMDMw
MCBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IE9uIFR1ZSwgSnVuIDI1LCAyMDE5IGF0IDA0OjAxOjA0UE0gKzAzMDAsIEFs
ZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4gPiA+IFRoZSBkb2N1bWVudGF0aW9uIHRoZSBgX19z
eXNmc19tYXRjaF9zdHJpbmcoKWAgaGVscGVyIG1lbnRpb25zIHRoYXQgYG5gDQo+ID4gPiAodGhl
IHNpemUgb2YgdGhlIGdpdmVuIGFycmF5KSBzaG91bGQgYmU6DQo+ID4gPiAgKiBAbjogbnVtYmVy
IG9mIHN0cmluZ3MgaW4gdGhlIGFycmF5IG9yIC0xIGZvciBOVUxMIHRlcm1pbmF0ZWQgYXJyYXlz
DQo+ID4gPiANCj4gPiA+IFRoZSBiZWhhdmlvciBvZiB0aGUgZnVuY3Rpb24gaXMgZGlmZmVyZW50
LCBpbiB0aGUgc2Vuc2UgdGhhdCBpdCBleGl0cyBvbg0KPiA+ID4gdGhlIGZpcnN0IE5VTEwgZWxl
bWVudCBpbiB0aGUgYXJyYXkuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUg
YmVoYXZpb3IsIHRvIGV4aXQgdGhlIGxvb3Agd2hlbiBhIE5VTEwgZWxlbWVudCBpcw0KPiA+ID4g
Zm91bmQsIGFuZCB0aGUgc2l6ZSBvZiB0aGUgYXJyYXkgaXMgcHJvdmlkZWQgYXMgLTEuDQo+ID4g
PiANCj4gPiA+IEFsbCBjdXJyZW50IHVzZXJzIG9mIF9fc3lzZnNfbWF0Y2hfc3RyaW5nKCkgJiBz
eXNmc19tYXRjaF9zdHJpbmcoKSBwcm92aWRlDQo+ID4gPiBjb250aWd1b3VzIGFycmF5cyBvZiBz
dHJpbmdzLCBzbyB0aGlzIGJlaGF2aW9yIGNoYW5nZSBkb2Vzbid0IGluZmx1ZW5jZQ0KPiA+ID4g
YW55dGhpbmcgKGF0IHRoaXMgcG9pbnQgaW4gdGltZSkuDQo+ID4gPiANCj4gPiA+IFRoaXMgYmVo
YXZpb3IgY2hhbmdlIGFsbG93cyBmb3IgYW4gYXJyYXkgb2Ygc3RyaW5ncyB0byBoYXZlIE5VTEwg
ZWxlbWVudHMNCj4gPiA+IHdpdGhpbiB0aGUgYXJyYXksIHdoaWNoIHdpbGwgYmUgaWdub3JlZC4g
VGhpcyBpcyBwYXJ0aWN1bGFybHkgdXNlZnVsIHdoZW4NCj4gPiA+IGNyZWF0aW5nIG1hcHBpbmcg
b2Ygc3RyaW5ncyBhbmQgaW50ZWdlcnMgKGFzIGJpdGZpZWxkcyBvciBvdGhlciBIVw0KPiA+ID4g
ZGVzY3JpcHRpb24pLg0KPiA+IA0KPiA+IFNpbmNlIGl0IGRvZXMgbm90aGluZyBmb3IgY3VycmVu
dCB1c2VycyBhbmQgY29tZXMgd2l0aG91dCBhbiBleGFtcGxlLA0KPiA+IGl0J3MgaGFyZCB0byBq
dXN0aWZ5IHRoZSBuZWVkLg0KPiANCj4gUHJlc3VtYWJseSAic3BsaXQgdGhpcyBwYXRjaCBhd2F5
IGZyb20gc2VyaWVzIiBtZWFucyB0aGVyZSdzIHNvbWUgY29kZQ0KPiB3aGljaCB1c2VzIHRoaXMu
ICBBIHJlZmVyZW5jZSB0byB0aGlzIGluIHRoZSBjaGFuZ2Vsb2cgd291bGQgYmUgZ29vZC4NCj4g
DQo+ID4gVGhlIGNvZGUgaXRzZWxmIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBTdXJlLiAgQnV0
IHRoZSBrZXJuZWxkb2MgZGVzY3JpcHRpb24gb2YgX19zeXNmc19tYXRjaF9zdHJpbmcoKSBjb3Vs
ZCBkbw0KPiB3aXRoIGFuIHVwZGF0ZS4NCj4gDQoNCkFwb2xvZ2llcyBmb3IgYW55IGNsdW1zaW5l
c3MgaGVyZSBbZnJvbSBteSBzaWRlXS4NCg0KVGhlIHNlcmllcyB0cmllZCB0byBoYW5kbGUgYSBj
aGFuZ2UgZm9yIHN1cHBvcnRpbmcgZ2FwcyBpbiBJSU8gZW51bXMuDQpQYXJ0aWN1bGFybHkgdGhp
cyBwYXRjaDoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA5MzUwMDMvDQoN
ClRoZXNlIGVudW1zIHVzZSBfX3N5c2ZzX21hdGNoX3N0cmluZygpIHRvIG1hdGNoIHN0cmluZ3Mg
dG8gZW51bS9pbnQgdmFsdWVzLg0KDQpUaGVyZSB3ZXJlIDMgdmVyc2lvbnM6DQpodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtaWlvL2xpc3QvP3Nlcmllcz0xMDg0ODEg
IFtWMV0NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1paW8vbGlz
dC8/c2VyaWVzPTEwODYwMyAgW1YyXQ0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LWlpby9saXN0Lz9zZXJpZXM9MTE1MjAxICBbVjNdDQoNClRoZSBsYXN0IHNlcmll
cyBbVjNdIGhhcyBhbiB1bnJlc29sdmVkIGRpc2N1c3Npb24gYWJvdXQgaG93IHRvIGhhbmRsZSBn
YXBzIGluIElJTyBlbnVtcy4NClRoaXMgd2lsbCBiZSByZXNvbHZlZCBhdCBhIGxhdGVyIHBvaW50
IGluIHRpbWUuDQoNCkluIHRoZSBtZWFudGltZSwgSSB0aG91Z2h0IEknZCBzdWdnZXN0IHRoaXMg
Y2hhbmdlIG9uIGl0J3Mgb3duLCBtb3N0bHkgZHVlIHRvIHRoZSBrZXJuZWxkb2Mgbm90IGJlaW5n
IGFjY3VyYXRlLg0KDQpJJ20gZmluZSB3aXRoIGJvdGggZml4aW5nIHRoZSBrZXJuZWxkb2Mgb3Ig
Zml4aW5nIHRoZSBjb2RlLg0KV2Ugd2lsbCBzdGlsbCBoYXZlIHRvIHJlc29sdmUgdGhlIGRpc2N1
c3Npb24gaW4gSUlPIGFib3V0IGhvdyB0byBoYW5kbGUgdGhvc2UgZ2FwcGVkIGVudW1zLg0KDQo+
IA0K
