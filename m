Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B564C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169F320857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="koH5lBia";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EzbBVGpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDIURW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:17:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42314 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbfDIURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:17:22 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39K8nlg025768;
        Tue, 9 Apr 2019 13:16:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=A+HkaimL1cY1XqVJC4H7tI+7PnTFrQODJB415reeAr0=;
 b=koH5lBiaVg4fmPI8dF8a4SO28NldHivRkavvVdZvy5/N8lE8hz1w81H/RBLYA/XXqhNh
 nN5Zcf3f1HGy3d8lakdPcEmP2kSzVyruxc3c/phe44/ed3mkd71MQZ8oAZdO4Kd0bEl/
 qeO0ZTxoW4CneUGVLJFQIchTg8rtXJBFDbM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrvq41k23-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 13:16:48 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 13:16:46 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 13:16:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+HkaimL1cY1XqVJC4H7tI+7PnTFrQODJB415reeAr0=;
 b=EzbBVGpuI009i/jnNnjiCbGwnjnSSwSsESJBMPZqu8MEWiClScLQ1F4I+8JXhtWrKwBwdsoCa+CtiaCjQg3SJHInXCQsbaZDbLo4KguH/q1iSzdmwfkSAdmn2OCye2jdarkLYiDLEzGmNRQQkOqeTJmttDh7lgRHQOtB1vYKDv4=
Received: from CY4PR15MB1366.namprd15.prod.outlook.com (10.172.157.148) by
 CY4PR15MB1797.namprd15.prod.outlook.com (10.174.53.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 20:16:45 +0000
Received: from CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::cdcb:6db:7ea8:1477]) by CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::cdcb:6db:7ea8:1477%4]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 20:16:45 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Subject: Re: [PATCH v3 bpf-next 02/21] bpf: Sysctl hook
Thread-Topic: [PATCH v3 bpf-next 02/21] bpf: Sysctl hook
Thread-Index: AQHU6+beSSoHj5vo/0SsiAlx57fRwaY0EfIAgAA4igA=
Date:   Tue, 9 Apr 2019 20:16:45 +0000
Message-ID: <20190409201641.GA43779@rdna-mbp>
References: <cover.1554485409.git.rdna@fb.com>
 <fa56a873cb76394f49996fb0d191f8c434ac8885.1554485409.git.rdna@fb.com>
 <CAGXu5j+hW4NPihH+LmvCRxpNdHJDh=KD=k2FtFx51Ay8=vSdgA@mail.gmail.com>
In-Reply-To: <CAGXu5j+hW4NPihH+LmvCRxpNdHJDh=KD=k2FtFx51Ay8=vSdgA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1001CA0029.namprd10.prod.outlook.com
 (2603:10b6:301:2a::42) To CY4PR15MB1366.namprd15.prod.outlook.com
 (2603:10b6:903:f7::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:6328]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac796037-f7ee-480f-6f34-08d6bd28496e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR15MB1797;
x-ms-traffictypediagnostic: CY4PR15MB1797:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR15MB17978F6DB0DF332228F0BB66A82D0@CY4PR15MB1797.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(316002)(6306002)(478600001)(6916009)(6512007)(54906003)(46003)(186003)(6116002)(6246003)(966005)(446003)(486006)(6486002)(9686003)(2906002)(53936002)(33656002)(99286004)(11346002)(5660300002)(476003)(1076003)(68736007)(4326008)(52116002)(25786009)(8936002)(229853002)(76176011)(305945005)(33716001)(97736004)(106356001)(86362001)(105586002)(7736002)(6436002)(71190400001)(6506007)(386003)(256004)(102836004)(14444005)(53546011)(14454004)(81166006)(8676002)(7416002)(81156014)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1797;H:CY4PR15MB1366.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2lYpQ6lS7xuAqT/lAfPoJG/b2/ujcFmGXvDF/Y9xLDmpvkEvIceneFtk2IIrQxcfIvSRtXHnczB5V3C1TRSsOqIKfxgGwSeP80kmJOc3XN75hk5HMDz1gSj5mAxJ/8YD+Sm4Ol+DioJwJzLmQhpJAn+gaY7Qs3nR87lDJNsF+DkjbAUlaCdEMKpLq6/Bp6Tpb79qWJSdpejfhqIefOifnxRmeiY3VvF+uV50CFbdqUkk9XLR9maiBLECr3FpcnavEtwcHUussF2UX5Y1pymxgOQZjfAV5fuKYf6AyrWx96H82Hzw2C3T2L9uhBT2ERzf08MS4q4IeOVnLRlb5sBazbC+dLkwZavb6/1xk5RotxUfRpuG1JHc3d96uinvwUw1gcLDA7t5h2PLwZWmyHsW7w/gxVr0t/Hm9qbqjrH7ip8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71A3D1F0EB590F46A036EC14D645BC17@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac796037-f7ee-480f-6f34-08d6bd28496e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 20:16:45.4555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1797
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+IFtUdWUsIDIwMTktMDQtMDkgMDk6NTQg
LTA3MDBdOg0KPiBPbiBGcmksIEFwciA1LCAyMDE5IGF0IDEyOjM2IFBNIEFuZHJleSBJZ25hdG92
IDxyZG5hQGZiLmNvbT4gd3JvdGU6DQo+ID4gQ29udGFpbmVyaXplZCBhcHBsaWNhdGlvbnMgbWF5
IHJ1biBhcyByb290IGFuZCBpdCBtYXkgY3JlYXRlIHByb2JsZW1zDQo+ID4gZm9yIHdob2xlIGhv
c3QuIFNwZWNpZmljYWxseSBzdWNoIGFwcGxpY2F0aW9ucyBtYXkgY2hhbmdlIGEgc3lzY3RsIGFu
ZA0KPiA+IGFmZmVjdCBhcHBsaWNhdGlvbnMgaW4gb3RoZXIgY29udGFpbmVycy4NCj4gPg0KPiA+
IEZ1cnRoZXJtb3JlIGluIGV4aXN0aW5nIGluZnJhc3RydWN0dXJlIGl0IG1heSBub3QgYmUgcG9z
c2libGUgdG8ganVzdA0KPiA+IGNvbXBsZXRlbHkgZGlzYWJsZSB3cml0aW5nIHRvIHN5c2N0bCwg
aW5zdGVhZCBzdWNoIGEgcHJvY2VzcyBzaG91bGQgYmUNCj4gPiBncmFkdWFsIHdpdGggYWJpbGl0
eSB0byBsb2cgd2hhdCBzeXNjdGwgYXJlIGJlaW5nIGNoYW5nZWQgYnkgYQ0KPiA+IGNvbnRhaW5l
ciwgaW52ZXN0aWdhdGUsIGxpbWl0IHRoZSBzZXQgb2Ygd3JpdGFibGUgc3lzY3RsIHRvIGN1cnJl
bnRseQ0KPiA+IHVzZWQgb25lcyAoc28gdGhhdCBuZXcgb25lcyBjYW4gbm90IGJlIGNoYW5nZWQp
IGFuZCBldmVudHVhbGx5IHJlZHVjZQ0KPiA+IHRoaXMgc2V0IHRvIHplcm8uDQo+IA0KPiBBY3R1
YWwtcm9vdC1pbi1hLWNvbnRhaW5lciBpcyBwcmV0dHkgcG93ZXJmdWwuIFdoYXQgYWJvdXQgbW9k
dWxlDQo+IGxvYWRpbmcsIG9yIC9kZXYgZmlsZXM/IEluc3RlYWQgb2Ygc3lzY3RsLXNwZWNpZmlj
IGhvb2tzLCB3aGF0IGFib3V0DQo+IFZGUyBob29rcywgd2hpY2ggd291bGQgYmUgYWJsZSB0byBj
b3ZlciBhbGwgZmlsZS1iYXNlZCBBUElzLiBUaGlzIGlzDQo+IHdoYXQsIGZvciBleGFtcGxlLCBM
YW5kbG9jayB3YXMgd29ya2luZyBvbiBkb2luZyAoYWxzbyB3aXRoIGVCUEYpLg0KDQpUaGlzIHN5
c2N0bCBob29rIGRvZXNuJ3QgdHJ5IHRvIHNvbHZlIGFsbCBwb3NzaWJsZSBwcm9ibGVtcyB0aGF0
DQpyb290LWluLWEtY29udGFpbmVyIG1heSBpbXBvc2UsIGJ1dCByYXRoZXIgZm9jdXNlcyBvbiBv
bmUgc3BlY2lmaWMNCnByb2JsZW0uDQoNCkdlbmVyaWMgQlBGIGhvb2tzIGluIFZGUyBjYW4gYmUg
YSBnb29kIGlkZWEgYW5kIGluIGZhY3QgdGhlcmUgd2FzIGEgdHJ5DQp0byBhZGQgQlBGIGhvb2sg
Zm9yIGZpbGVfb3BlbiBbMV0sIGJ1dCBhcHBhcmVudGx5IGl0IG5lZWRzIG1vcmUgd29yay4NCg0K
RmxleGliaWxpdHkgb2YgZ2VuZXJpYyBob29rcyBoYXMgaXRzIGRpc2FkdmFudGFnZXMgdGhvdWdo
IHdoZW4gaXQgY29tZXMNCnRvIG1ha2luZyB3aGF0IHRoaXMgc3lzY3RsLWZvY3VzZWQgaG9vayBk
b2VzLiBFLmcuIHdpdGggc3lzY3RsIGhvb2sNCmFkbWluaXN0cmF0b3Igc2hvdWxkbid0IGNhcmUg
YWJvdXQgc3lzX29wZW4sIHN5c19yZWFkLCBzeXNfd3JpdGUNCnNlcGFyYXRlbHkgaWYgdGhleSB3
YW50IHRvIGltcGxlbWVudCBwb2xpY2llcyAob3IganVzdCB0cmFjaW5nKSBiYXNlZCBvbg0Kc3lz
Y3RsIG5hbWUgLyB2YWx1ZSBmb3IgY2dyb3VwLCBidXQgY2FuIGhhdmUganVzdCBvbmUgQlBGIHBy
b2dyYW0NCmluc3RlYWQgdGhhdCBoYXMgYWxsIG5lY2Vzc2FyeSBjb250ZXh0IHRvIG1ha2UgZGVj
aXNpb25zLg0KDQpBbHNvIGFjY2Vzc2VzIHRvIHN5c2N0bCBpcyB1c3VhbGx5IGp1c3QgYSB2ZXJ5
IHNtYWxsIHBhcnQgb2YgYWxsIGNhbGxzDQp0byBzeXNfb3Blbi9zeXNfcmVhZC9zeXNfd3JpdGUg
b24gYSBzeXN0ZW0sIG91dHNpZGUgb2YgZmFzdC1wYXRoIChlLmcuDQpub2JvZHkgc2hvdWxkIGNh
cmUgaWYgd3JpdGUgdG8gc3lzY3RsIGlzIGEgYml0IHNsb3dlciksIGFuZCBjYWxsaW5nIEJQRg0K
aG9vayBmb3IgZXZlcnkgc3lzX29wZW4vc3lzX3JlYWQvc3lzX3dyaXRlIHdoZW4gYWRtaW5pc3Ry
YXRvciB3YW50cyB0bw0KbGltaXQganVzdCBzeXNjdGwgY2hhbmdlcyBjYW4gYmUgdG9vIGV4cGVu
c2l2ZS4NCg0KRnVydGhlcm1vcmUgc3lzY3RsIGZvY3VzZWQgaG9vayBhbGxvd3MgdG8gdGFpbG9y
IGl0cyBBUEkgdG8gc3lzY3RsIG5lZWRzDQphbmQgYXZvaWQgZXhwb3NpbmcgQVBJcyB0aGF0IG1h
a2Ugc2Vuc2Ugb25seSBmb3Igc3lzY3RsIHRvIGFsbA0KZmlsZS1iYXNlZCBhY2Nlc3NlcyBhbmQg
dmlzZSB2ZXJzYS4NCg0KWzFdIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy83Njc2MTUvDQoNCi0t
IA0KQW5kcmV5IElnbmF0b3YNCg==
