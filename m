Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B843F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GIHDRyAz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="D1lnHzNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCLTmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:42:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbfCLTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:42:03 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CJRRhS020070;
        Tue, 12 Mar 2019 12:41:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=k5dwIh0pXW/bPgm9wj0ITKSXz77/W94/t/zCqtaIyVA=;
 b=GIHDRyAzER0PiJ6mc5QrmeASmnPCK8et948vhXILrCSlHCGBJxgHoHo5svIhsQh+LapW
 JLhMFUxoShaEBVLv4P6vxdBBUBSLQemblD2YBaWDowzZ3K3GLrseOV7LG+f9ji6swRGW
 1x1gUZUl9/jE0lTINPQxkvTKvnYrTCPniEU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r6juug2k0-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Mar 2019 12:41:55 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 12:41:38 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 12:41:38 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Mar 2019 12:41:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5dwIh0pXW/bPgm9wj0ITKSXz77/W94/t/zCqtaIyVA=;
 b=D1lnHzNqy+MXo2280a8aC6Y4AwhfpJzRDrIqVHJN2hcapiVg0Tn62C+hnSkAVNOlW+zezhBsMEUBK+q21YgZ/aKvcwjATe6DezpMhN1NrQNWoK9nl7RzXT2RL65jbgF3oobw6zdGjf/L5GVxoTwdXRpJtq7xCZKIGAWyDplgTs0=
Received: from MWHPR15MB1264.namprd15.prod.outlook.com (10.175.3.14) by
 MWHPR15MB1311.namprd15.prod.outlook.com (10.175.3.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Tue, 12 Mar 2019 19:41:36 +0000
Received: from MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb]) by MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb%9]) with mapi id 15.20.1709.011; Tue, 12 Mar 2019
 19:41:36 +0000
From:   Calvin Owens <calvinowens@fb.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
Thread-Topic: [PATCH] tpm: Make timeout logic simpler and more robust
Thread-Index: AQHU2GXGLeYW3Qpbpky5KjnMPwFs0aYHJAWAgADPhQCAAB9hAIAAD9uAgABDnAA=
Date:   Tue, 12 Mar 2019 19:41:36 +0000
Message-ID: <20190312194130.GA5058@Haydn>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
 <1552350463.23859.8.camel@HansenPartnership.com>
 <20190312125028.GC9243@linux.intel.com>
 <1552401766.3083.3.camel@HansenPartnership.com>
 <20190312153931.GA9927@linux.intel.com>
In-Reply-To: <20190312153931.GA9927@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:301:3a::36) To MWHPR15MB1264.namprd15.prod.outlook.com
 (2603:10b6:320:24::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::ce7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee58eb31-ad11-4df7-bfdc-08d6a722bcd9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1311;
x-ms-traffictypediagnostic: MWHPR15MB1311:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1311;20:CeV0rlT67cwFERmIpL89lsxooKCpFGk2eX5EWmUb6ogPyuMCCMJgH/qa3nJhNBTzDxl2ux9MuLPiUc2saJULBtmmwR9l8Vg+LuSJhlCDUr8oLMAWbf7PVbHUq5XjoECDdq8IZFJK7IKyiH+CW70sayrwgbLCyaA3ZByoxunPRho=
x-microsoft-antispam-prvs: <MWHPR15MB13112E4584292DDF04B9C34ECE490@MWHPR15MB1311.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(366004)(396003)(39850400004)(136003)(376002)(189003)(199004)(316002)(33716001)(386003)(53936002)(97736004)(186003)(6246003)(76176011)(5660300002)(81156014)(102836004)(6506007)(93886005)(6916009)(81166006)(1076003)(8936002)(52116002)(14454004)(8676002)(99286004)(478600001)(106356001)(71200400001)(446003)(305945005)(7736002)(6436002)(105586002)(9686003)(54906003)(476003)(6512007)(11346002)(86362001)(46003)(4326008)(33656002)(71190400001)(229853002)(68736007)(6486002)(6116002)(25786009)(2906002)(256004)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1311;H:MWHPR15MB1264.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UnA3hUm8XTBDELx17a4GtxGKTQ3MUNgI6apG3pt0CVa1a2rvqa6ZVVzeyBss/N10vO4dOFFoUbXKtQr6JSrjJBQyHw8D3wHMZ88aSj4xzwYOwgs7bE/Kf+r/mMiAymvStORmQOT5QYchKtRVgg6xCQxDs1FfQL7+bbPuzznnZVt3XyFEHsS0gkPM8Y35AF1A3UvREYZml1lK4ZyPe4/l7BgG1Gj8aXJhSpUAWH2EPSNIOwp+Dn7fygPSO6DH+Nnhnp68nHkCgpj0dMb0gzv4GLJ8nbuEmufZ+nYDn4KNtU/tS/n0/BRkfAeaLCe1sUrH3+Zhbc1DyjqgDy9483xoVTlVwQK8kJK+8X+U2C/3N1vQOeCSbZTiPrDWSvuLf3SW+4wyHaajhQEGkhJ1ufaLRIgTCdrcJDMSLHq7QMszE3Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6C192D1BED14549857863A9859CC914@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee58eb31-ad11-4df7-bfdc-08d6a722bcd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 19:41:36.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1311
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlc2RheSAwMy8xMiBhdCAxNzozOSArMDIwMCwgSmFya2tvIFNha2tpbmVuIHdyb3RlOg0K
PiBPbiBUdWUsIE1hciAxMiwgMjAxOSBhdCAwNzo0Mjo0NkFNIC0wNzAwLCBKYW1lcyBCb3R0b21s
ZXkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTAzLTEyIGF0IDE0OjUwICswMjAwLCBKYXJra28g
U2Fra2luZW4gd3JvdGU6DQo+ID4gPiBPbiBNb24sIE1hciAxMSwgMjAxOSBhdCAwNToyNzo0M1BN
IC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjAxOS0wMy0x
MSBhdCAxNjo1NCAtMDcwMCwgQ2FsdmluIE93ZW5zIHdyb3RlOg0KPiA+ID4gPiA+IGUncmUgaGF2
aW5nIGxvdHMgb2YgcHJvYmxlbXMgd2l0aCBUUE0gY29tbWFuZHMgdGltaW5nIG91dCwgYW5kDQo+
ID4gPiA+ID4gd2UncmUgc2VlaW5nIHRoZXNlIHByb2JsZW1zIGFjcm9zcyBsb3RzIG9mIGRpZmZl
cmVudCBoYXJkd2FyZQ0KPiA+ID4gPiA+IChib3RoIHYxL3YyKS4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBJIGluc3RydW1lbnRlZCB0aGUgZHJpdmVyIHRvIGNvbGxlY3QgbGF0ZW5jeSBkYXRhLCBi
dXQgSSB3YXNuJ3QNCj4gPiA+ID4gPiBhYmxlIHRvIGZpbmQgYW55IHNwZWNpZmljIHRpbWVvdXQg
dG8gZml4OiBpdCBzZWVtcyBsaWtlIG1hbnkgb2YNCj4gPiA+ID4gPiB0aGVtIGFyZSB0b28gYWdn
cmVzc2l2ZS4gU28gSSB0cmllZCByZXBsYWNpbmcgYWxsIHRoZSB0aW1lb3V0DQo+ID4gPiA+ID4g
bG9naWMgd2l0aCBhIHNpbmdsZSB1bml2ZXJzYWwgbG9uZyB0aW1lb3V0LCBhbmQgZm91bmQgdGhh
dCBtYWtlcw0KPiA+ID4gPiA+IG91ciBUUE1zIDEwMCUgcmVsaWFibGUuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gR2l2ZW4gdGhhdCB0aGlzIHRpbWVvdXQgbG9naWMgaXMgdmVyeSBjb21wbGV4LCBw
cm9ibGVtYXRpYywgYW5kDQo+ID4gPiA+ID4gYXBwZWFycyB0byBzZXJ2ZSBubyByZWFsIHB1cnBv
c2UsIEkgcHJvcG9zZSBzaW1wbHkgZGVsZXRpbmcgYWxsDQo+ID4gPiA+ID4gb2YgaXQuDQo+ID4g
PiA+IA0KPiA+ID4gPiAibm8gcmVhbCBwdXJwb3NlIiBpcyBhIGJpdCBzdHJvbmcgZ2l2ZW4gdGhh
dCBhbGwgdGhlc2UgdGltZW91dHMgYXJlDQo+ID4gPiA+IHN0YW5kYXJkcyBtYW5kYXRlZC4gIFRo
ZSBwdXJwb3NlIHN0YXRlZCBieSB0aGUgc3RhbmRhcmRzIGlzIHRoYXQNCj4gPiA+ID4gdGhlcmUg
bmVlZHMgdG8gYmUgYSB3YXkgb2YgZGlmZmVyZW50aWF0aW5nIHRoZSBUUE0gY3Jhc2hlZCBmcm9t
IHRoZQ0KPiA+ID4gPiBUUE0gaXMgdGFraW5nIGEgdmVyeSBsb25nIHRpbWUgdG8gcmVzcG9uZC4g
IEZvciBhIG5vcm1hbGx5DQo+ID4gPiA+IGZ1bmN0aW9uaW5nIFRQTSBpdCBsb29rcyBjb21wbGV4
IGFuZCB1bm5lY2Vzc2FyeSwgYnV0IGZvciBhDQo+ID4gPiA+IG1hbGZ1bmN0aW9uaW5nIG9uZSBp
dCdzIGEgbGlmZXNhdmVyLg0KPiA+ID4gDQo+ID4gPiBTdGFuZGFyZHMgc2hvdWxkIGJlIG9ubHkg
Zm9sbG93ZWQgd2hlbiB0aGV5IG1ha2UgcHJhY3RpY2FsIHNlbnNlIGFuZA0KPiA+ID4gaWdub3Jl
ZCB3aGVuIG5vdC4gVGhlIHJhbmdlIGlzIG9ubHkgdXAgdG8gMnMgYW55d2F5Lg0KPiA+IA0KPiA+
IEkgZG9uJ3QgZGlzYWdyZWUgLi4uIGFuZCBJJ20gY2VydGFpbmx5IG5vdCBnb2luZyB0byBkZWZl
bmQgdGhlIFRDRw0KPiA+IGJlY2F1c2UgSSBkbyB0aGluayB0aGUgY29tcGxleGl0eSBvZiBzb21l
IG9mIGl0cyBzdGFuZGFyZHMgY29udHJpYnV0ZWQNCj4gPiB0byB0aGUgbGFjayBvZiB1c2Ugb2Yg
VFBNIDEuMi4NCj4gPiANCj4gPiBIb3dldmVyLCBJIGFtIHNheWluZyB3ZSBzaG91bGQgcm9vdCBj
YXVzZSB0aGlzIHByb2JsZW0gcmF0aGVyIHRoYW4gdGFrZQ0KPiA+IGEgYmxpbmQgc2hvdCBhdCB0
aGUgYXBwYXJlbnQgdGltZW91dCBjb21wbGV4aXR5LiAgTXkgdGltZW91dA0KPiA+IGluc3RhYmls
aXR5IGlzIGRlZmluaXRlbHkgcmVsYXRlZCB0byB0aGUgcG9sbGluZyBhZGp1c3RtZW50cywgc28g
aXQncw0KPiA+IG5vdCB1bnJlYXNvbmFibGUgdG8gdGhpbmsgRmFjZWJvb2tzIG1pZ2h0IGJlIGFz
IHdlbGwuDQo+IA0KPiBZZWFoLCByZWZlcnJpbmcgdG8gbXkgcmV2aWV3IGNvbW1lbnQsIEkgdGhp
bmsgdGhlIHZlcnkgZmlyc3QgdGhpbmcNCj4gdGhhdCBzaG91bGQgYmUgZG9uZSBpcyB0byBzcGxp
dCBwYXRjaCBpbnRvIHR3by4gVGhlbiB3ZSBjYW4gcHJvYmFibHkNCj4gZ2l2ZSBiZXR0ZXIgZmVl
ZGJhY2suDQoNCkFic29sdXRlbHksIHdpbGwgZG8uDQoNClRoYW5rcywNCkNhbHZpbg0KIA0KPiAv
SmFya2tvDQo=
