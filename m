Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3999C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65478217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pXh0wiQy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OUY9D9iD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfEVVzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:55:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47508 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730152AbfEVVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:55:35 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MLlbHM007426;
        Wed, 22 May 2019 14:55:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=oK8DBqvO5sF5UE1pBtd4QEe9HkfortRGFhmfTSEJ++U=;
 b=pXh0wiQyxqE4FYgN0BNM67bMqybtsAs/S5oxsIP5mXMHShDGWZGwTIo4CZzJ/uLw5jb9
 p5pGo9x7HEDdQFWunUUBJOVqvXRBKRpPIuOTQR+h5vOFgxaUffBejE4+VluIw6XiYMSH
 U+zTzoCS3F7nAYjjfz0MCzG7atmQThjNkZg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sn9bgsek2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 May 2019 14:55:12 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 22 May 2019 14:55:11 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 22 May 2019 14:55:11 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 22 May 2019 14:55:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK8DBqvO5sF5UE1pBtd4QEe9HkfortRGFhmfTSEJ++U=;
 b=OUY9D9iDm1EkAgqdFL31J3KLnL9ELSIkFhI9gyF1bMlFO6F6kCLCKhEzqCKIc9globoVNmGUWBf0+ktoTbZKRqRrHZ+sQkvy9RRQIQot+L4ZBbszGio8zBmDaiZf/dgLYSDWddlp7cHqmjOiWk4YVpJNa76IjvymXQtpoHkgIx8=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2328.namprd15.prod.outlook.com (52.135.197.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 21:55:09 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::140e:9c62:f2d3:7f27]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::140e:9c62:f2d3:7f27%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 21:55:09 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Kairui Song <kasong@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Thread-Topic: Getting empty callchain from perf_callchain_kernel()
Thread-Index: AQHVDEJXYtrotGS6bU+cxwR7BKWjbKZu8J8AgAAG+ICAAAFQgIAIgRyAgAA/cgA=
Date:   Wed, 22 May 2019 21:55:08 +0000
Message-ID: <c517f213-01d5-b95b-1a4c-5dddedd71419@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190522180749.qpwdlhkcitxiazco@treble>
In-Reply-To: <20190522180749.qpwdlhkcitxiazco@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0084.namprd15.prod.outlook.com
 (2603:10b6:101:20::28) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::6565]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7c44748-effc-4a75-616f-08d6df0027a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2328;
x-ms-traffictypediagnostic: BYAPR15MB2328:
x-microsoft-antispam-prvs: <BYAPR15MB232861DAA30D2860A8C68D9ED7000@BYAPR15MB2328.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(68736007)(31696002)(76176011)(229853002)(305945005)(8936002)(99286004)(2906002)(7736002)(186003)(5660300002)(6246003)(54906003)(86362001)(478600001)(52116002)(8676002)(102836004)(6116002)(31686004)(81166006)(110136005)(36756003)(81156014)(53936002)(14454004)(256004)(6436002)(66476007)(66446008)(64756008)(66556008)(71200400001)(71190400001)(73956011)(66946007)(6486002)(446003)(14444005)(6512007)(386003)(25786009)(476003)(6506007)(46003)(4326008)(11346002)(53546011)(2616005)(486006)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2328;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5mmoSUlMBvshFI4Y/aV9KiLUx6WSOkA1Eq6GXHNm3UMYO+1hYbOm6PwdJors5kSZMGhP4U9THfPIJeLm2Z1B/nReZxRNG8Pv4xaXGJjsmwXxd9zc7lX7nrXzNpiTbNKbwjaLKAtDHX1J1meLAoixchIVUNDmN517hG+vWD20UdMUpqwpykEt7NOaoz1zoozJJyBIh0flRd2wxIjKjXfGP9pOP3vDrbUIPIc5gb60ywa3miL+VLDPZCAXbsE4DWndOXKC5btottmHRVZywN8mJwUNh8fqVsjzIW1gMBy/wEIU4iRHivD1oLKFdYoWXisywg+G1YhWvrYKaOFs2FFYtwvaPQ4CJvlEPKyPCAVv7iJH0ZvhlEve1x066cK/WJ5X2E2YkW/jTIuoT+5KGFfYX5U9tbPYW4C7e4wU60VMm+k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B2B63453986C40A89E703314A62141@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c44748-effc-4a75-616f-08d6df0027a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 21:55:08.8684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMi8xOSAxMTowNyBBTSwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+IE9uIEZyaSwgTWF5
IDE3LCAyMDE5IGF0IDA0OjE1OjM5UE0gKzA4MDAsIEthaXJ1aSBTb25nIHdyb3RlOg0KPj4gT24g
RnJpLCBNYXkgMTcsIDIwMTkgYXQgNDoxMSBQTSBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+IHdyb3RlOg0KPj4+DQo+Pj4gT24gRnJpLCBNYXkgMTcsIDIwMTkgYXQgMDk6NDY6
MDBBTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4+IE9uIFRodSwgTWF5IDE2LCAy
MDE5IGF0IDExOjUxOjU1UE0gKzAwMDAsIFNvbmcgTGl1IHdyb3RlOg0KPj4+Pj4gSGksDQo+Pj4+
Pg0KPj4+Pj4gV2UgZm91bmQgYSBmYWlsdXJlIHdpdGggc2VsZnRlc3RzL2JwZi90ZXN0c19wcm9n
IGluIHRlc3Rfc3RhY2t0cmFjZV9tYXAgKG9uIGJwZi9tYXN0ZXINCj4+Pj4+IGJyYW5jaCkuDQo+
Pj4+Pg0KPj4+Pj4gQWZ0ZXIgZGlnZ2luZyBpbnRvIHRoZSBjb2RlLCB3ZSBmb3VuZCB0aGF0IHBl
cmZfY2FsbGNoYWluX2tlcm5lbCgpIGlzIGdpdmluZyBlbXB0eQ0KPj4+Pj4gY2FsbGNoYWluIGZv
ciB0cmFjZXBvaW50IHNjaGVkL3NjaGVkX3N3aXRjaC4gQW5kIGl0IHNlZW1zIHJlbGF0ZWQgdG8g
Y29tbWl0DQo+Pj4+Pg0KPj4+Pj4gZDE1ZDM1Njg4N2U3NzBjNWYyZGNmOTYzYjUyYzdjYjUxMGM5
ZTQyZA0KPj4+Pj4gKCJwZXJmL3g4NjogTWFrZSBwZXJmIGNhbGxjaGFpbnMgd29yayB3aXRob3V0
IENPTkZJR19GUkFNRV9QT0lOVEVSIikNCj4+Pj4+DQo+Pj4+PiBCZWZvcmUgdGhpcyBjb21taXQs
IHBlcmZfY2FsbGNoYWluX2tlcm5lbCgpIHJldHVybnMgY2FsbGNoYWluIHdpdGggcmVncy0+aXAu
IFdpdGgNCj4+Pj4+IHRoaXMgY29tbWl0LCByZWdzLT5pcCBpcyBub3Qgc2VudCBmb3IgIXBlcmZf
aHdfcmVncyhyZWdzKSBjYXNlLg0KPj4+Pg0KPj4+PiBTbyB3aGlsZSBJIHRoaW5rIHRoZSBiZWxv
dyBpcyBpbmRlZWQgcmlnaHQ7IHdlIHNob3VsZCBzdG9yZSByZWdzLT5pcA0KPj4+PiByZWdhcmRs
ZXNzIG9mIHRoZSB1bndpbmQgcGF0aCBjaG9zZW4sIEkgc3RpbGwgdGhpbmsgdGhlcmUncyBzb21l
dGhpbmcNCj4+Pj4gZmlzaHkgaWYgdGhpcyByZXN1bHRzIGluIGp1c3QgdGhlIDEgZW50cnkuDQo+
Pj4+DQo+Pj4+IFRoZSBzY2hlZC9zY2hlZF9zd2l0Y2ggZXZlbnQgcmVhbGx5IHNob3VsZCBoYXZl
IGEgbm9uLXRyaXZpYWwgc3RhY2suDQo+Pj4+DQo+Pj4+IExldCBtZSBzZWUgaWYgSSBjYW4gcmVw
cm9kdWNlIHdpdGgganVzdCBwZXJmLg0KPj4+DQo+Pj4gJCBwZXJmIHJlY29yZCAtZyAtZSAic2No
ZWQ6c2NoZWRfc3dpdGNoIiAtLSBtYWtlIGNsZWFuDQo+Pj4gJCBwZXJmIHJlcG9ydCAtRA0KPj4+
DQo+Pj4gMTIgOTA0MDcxNzU5NDY3IDB4MTc5MCBbMHhkMF06IFBFUkZfUkVDT1JEX1NBTVBMRShJ
UCwgMHgxKTogNzIzNi83MjM2OiAweGZmZmZmZmZmODFjMjk1NjIgcGVyaW9kOiAxIGFkZHI6IDAN
Cj4+PiAuLi4gRlAgY2hhaW46IG5yOjEwDQo+Pj4gLi4uLi4gIDA6IGZmZmZmZmZmZmZmZmZmODAN
Cj4+PiAuLi4uLiAgMTogZmZmZmZmZmY4MWMyOTU2Mg0KPj4+IC4uLi4uICAyOiBmZmZmZmZmZjgx
YzI5OTMzDQo+Pj4gLi4uLi4gIDM6IGZmZmZmZmZmODExMWY2ODgNCj4+PiAuLi4uLiAgNDogZmZm
ZmZmZmY4MTEyMGI5ZA0KPj4+IC4uLi4uICA1OiBmZmZmZmZmZjgxMTIwY2U1DQo+Pj4gLi4uLi4g
IDY6IGZmZmZmZmZmODEwMDI1NGENCj4+PiAuLi4uLiAgNzogZmZmZmZmZmY4MWUwMDA3ZA0KPj4+
IC4uLi4uICA4OiBmZmZmZmZmZmZmZmZmZTAwDQo+Pj4gLi4uLi4gIDk6IDAwMDA3ZjliNmNkOTY4
MmENCj4+PiAuLi4gdGhyZWFkOiBzaDo3MjM2DQo+Pj4gLi4uLi4uIGRzbzogL2xpYi9tb2R1bGVz
LzUuMS4wLTEyMTc3LWc0MWJiYjkxMjk3NjcvYnVpbGQvdm1saW51eA0KPj4+DQo+Pj4NCj4+PiBJ
T1csIGl0IHNlZW1zIHRvICd3b3JrJy4NCj4+Pg0KPj4NCj4+IEhpLCBJIHRoaW5rIHRoZSBhY3R1
YWwgcHJvYmxlbSBpcyB0aGF0IGJwZl9nZXRfc3RhY2tpZF90cCAoYW5kIG1heWJlDQo+PiBzb21l
IG90aGVyIGJmcCBmdW5jdGlvbnMpIGlzIG5vdyBicm9rZW4sIG9yLCBzdHJhdGluZyBhbiB1bndp
bmQNCj4+IGRpcmVjdGx5IGluc2lkZSBhIGJwZiBwcm9ncmFtIHdpbGwgZW5kIHVwIHN0cmFuZ2Vs
eS4gSXQgaGF2ZSBmb2xsb3dpbmcNCj4+IGtlcm5lbCBtZXNzYWdlOg0KPj4NCj4+IFdBUk5JTkc6
IGtlcm5lbCBzdGFjayBmcmFtZSBwb2ludGVyIGF0IDAwMDAwMDAwNzBjYWQwN2MgaW4NCj4+IHRl
c3RfcHJvZ3M6MTI0MiBoYXMgYmFkIHZhbHVlIDAwMDAwMDAwZmZkNDQ5N2UNCj4+DQo+PiBBbmQg
aW4gdGhlIGRlYnVnIG1lc3NhZ2U6DQo+Pg0KPj4gWyAgMTYwLjQ2MDI4N10gMDAwMDAwMDA2ZTEx
NzE3NTogZmZmZmZmZmZhYTIzYTBlOA0KPj4gKGdldF9wZXJmX2NhbGxjaGFpbisweDE0OC8weDI4
MCkNCj4+IFsgIDE2MC40NjAyODddIDAwMDAwMDAwMDJlODcxNWY6IDAwMDAwMDAwMDBjNmJiYTAg
KDB4YzZiYmEwKQ0KPj4gWyAgMTYwLjQ2MDI4OF0gMDAwMDAwMDBiM2QwNzc1ODogZmZmZjljZTNm
OTc5MDAwMCAoMHhmZmZmOWNlM2Y5NzkwMDAwKQ0KPj4gWyAgMTYwLjQ2MDI4OV0gMDAwMDAwMDA1
NWM5NzgzNjogZmZmZjljZTNmOTc5MDAwMCAoMHhmZmZmOWNlM2Y5NzkwMDAwKQ0KPj4gWyAgMTYw
LjQ2MDI4OV0gMDAwMDAwMDA3Y2JiMTQwYTogMDAwMDAwMDEwMDAwMDA3ZiAoMHgxMDAwMDAwN2Yp
DQo+PiBbICAxNjAuNDYwMjkwXSAwMDAwMDAwMDdkYzYyYWM5OiAwMDAwMDAwMDAwMDAwMDAwIC4u
Lg0KPj4gWyAgMTYwLjQ2MDI5MF0gMDAwMDAwMDA2YjQxZTM0NjogMWM3ZGEwMWNkNzBjNDAwMCAo
MHgxYzdkYTAxY2Q3MGM0MDAwKQ0KPj4gWyAgMTYwLjQ2MDI5MV0gMDAwMDAwMDBmMjNkMTgyNjog
ZmZmZmQ4OWNmZmMzYWU4MCAoMHhmZmZmZDg5Y2ZmYzNhZTgwKQ0KPj4gWyAgMTYwLjQ2MDI5Ml0g
MDAwMDAwMDBmOWExNjAxNzogMDAwMDAwMDAwMDAwMDA3ZiAoMHg3ZikNCj4+IFsgIDE2MC40NjAy
OTJdIDAwMDAwMDAwYThlNjJkNDQ6IDAwMDAwMDAwMDAwMDAwMDAgLi4uDQo+PiBbICAxNjAuNDYw
MjkzXSAwMDAwMDAwMGNiYzgzYzk3OiBmZmZmYjg5ZDAwZDhkMDAwICgweGZmZmZiODlkMDBkOGQw
MDApDQo+PiBbICAxNjAuNDYwMjkzXSAwMDAwMDAwMDkyODQyNTIyOiAwMDAwMDAwMDAwMDAwMDdm
ICgweDdmKQ0KPj4gWyAgMTYwLjQ2MDI5NF0gMDAwMDAwMDBkYWZiZWM4OTogZmZmZmI4OWQwMGM2
YmM1MCAoMHhmZmZmYjg5ZDAwYzZiYzUwKQ0KPj4gWyAgMTYwLjQ2MDI5Nl0gMDAwMDAwMDAwNzc3
ZTRjZjogZmZmZmZmZmZhYTIyNWQ5NyAoYnBmX2dldF9zdGFja2lkKzB4NzcvMHg0NzApDQo+PiBb
ICAxNjAuNDYwMjk2XSAwMDAwMDAwMDk5NDJlYTE2OiAwMDAwMDAwMDAwMDAwMDAwIC4uLg0KPj4g
WyAgMTYwLjQ2MDI5N10gMDAwMDAwMDBhMDgwMDZiMTogMDAwMDAwMDAwMDAwMDAwMSAoMHgxKQ0K
Pj4gWyAgMTYwLjQ2MDI5OF0gMDAwMDAwMDA5ZjAzYjQzODogZmZmZmI4OWQwMGM2YmMzMCAoMHhm
ZmZmYjg5ZDAwYzZiYzMwKQ0KPj4gWyAgMTYwLjQ2MDI5OV0gMDAwMDAwMDA2Y2FmOGIzMjogZmZm
ZmZmZmZhYTA3NGZlOCAoX19kb19wYWdlX2ZhdWx0KzB4NTgvMHg5MCkNCj4+IFsgIDE2MC40NjAz
MDBdIDAwMDAwMDAwM2ExM2Q3MDI6IDAwMDAwMDAwMDAwMDAwMDAgLi4uDQo+PiBbICAxNjAuNDYw
MzAwXSAwMDAwMDAwMGUyZTI0OTZkOiBmZmZmOWNlMzAwMDAwMDAwICgweGZmZmY5Y2UzMDAwMDAw
MDApDQo+PiBbICAxNjAuNDYwMzAxXSAwMDAwMDAwMDhlZTZiN2MyOiBmZmZmZDg5Y2ZmYzNhZTgw
ICgweGZmZmZkODljZmZjM2FlODApDQo+PiBbICAxNjAuNDYwMzAxXSAwMDAwMDAwMGE4Y2Y2ZDU1
OiAwMDAwMDAwMDAwMDAwMDAwIC4uLg0KPj4gWyAgMTYwLjQ2MDMwMl0gMDAwMDAwMDA1OTA3ODA3
NjogZmZmZmQ4OWNmZmMzYWU4MCAoMHhmZmZmZDg5Y2ZmYzNhZTgwKQ0KPj4gWyAgMTYwLjQ2MDMw
M10gMDAwMDAwMDBjNmFhYzczOTogZmZmZjljZTNmMWUxOGViMCAoMHhmZmZmOWNlM2YxZTE4ZWIw
KQ0KPj4gWyAgMTYwLjQ2MDMwM10gMDAwMDAwMDBhMzlhZmY5MjogZmZmZmI4OWQwMGM2YmM2MCAo
MHhmZmZmYjg5ZDAwYzZiYzYwKQ0KPj4gWyAgMTYwLjQ2MDMwNV0gMDAwMDAwMDA5NzQ5OGJmMjog
ZmZmZmZmZmZhYTFmNDc5MSAoYnBmX2dldF9zdGFja2lkX3RwKzB4MTEvMHgyMCkNCj4+IFsgIDE2
MC40NjAzMDZdIDAwMDAwMDAwNjk5MmRlMWU6IGZmZmZiODlkMDBjNmJjNzggKDB4ZmZmZmI4OWQw
MGM2YmM3OCkNCj4+IFsgIDE2MC40NjAzMDddIDAwMDAwMDAwZGFjZDBjZTU6IGZmZmZmZmZmYzA0
MDU2NzYgKDB4ZmZmZmZmZmZjMDQwNTY3NikNCj4+IFsgIDE2MC40NjAzMDddIDAwMDAwMDAwYTgx
ZjI3MTQ6IDAwMDAwMDAwMDAwMDAwMDAgLi4uDQo+Pg0KPj4gIyBOb3RlIGhlcmUgaXMgdGhlIGlu
dmFsaWQgZnJhbWUgcG9pbnRlcg0KPj4gWyAgMTYwLjQ2MDMwOF0gMDAwMDAwMDA3MGNhZDA3Yzog
ZmZmZmI4OWQwMGExZDAwMCAoMHhmZmZmYjg5ZDAwYTFkMDAwKQ0KPj4gWyAgMTYwLjQ2MDMwOF0g
MDAwMDAwMDBmOGYxOTRlNDogMDAwMDAwMDAwMDAwMDAwMSAoMHgxKQ0KPj4gWyAgMTYwLjQ2MDMw
OV0gMDAwMDAwMDAyMTM0ZjQyYTogZmZmZmQ4OWNmZmMzYWU4MCAoMHhmZmZmZDg5Y2ZmYzNhZTgw
KQ0KPj4gWyAgMTYwLjQ2MDMxMF0gMDAwMDAwMDBmOTM0NTg4OTogZmZmZjljZTNmMWUxOGViMCAo
MHhmZmZmOWNlM2YxZTE4ZWIwKQ0KPj4gWyAgMTYwLjQ2MDMxMF0gMDAwMDAwMDA4YWQyMmE0Mjog
MDAwMDAwMDAwMDAwMDAwMCAuLi4NCj4+IFsgIDE2MC40NjAzMTFdIDAwMDAwMDAwNzM4MDgxNzM6
IGZmZmZiODlkMDBjNmJjZTAgKDB4ZmZmZmI4OWQwMGM2YmNlMCkNCj4+IFsgIDE2MC40NjAzMTJd
IDAwMDAwMDAwYzllZmZmZjQ6IGZmZmZmZmZmYWExZjQ4ZDEgKHRyYWNlX2NhbGxfYnBmKzB4ODEv
MHgxMDApDQo+PiBbICAxNjAuNDYwMzEzXSAwMDAwMDAwMGM1ZDhlYmQxOiBmZmZmYjg5ZDAwYzZi
Y2MwICgweGZmZmZiODlkMDBjNmJjYzApDQo+PiBbICAxNjAuNDYwMzE1XSAwMDAwMDAwMGJjZTBi
MDcyOiBmZmZmZmZmZmFiNjUxYmUwDQo+PiAoZXZlbnRfc2NoZWRfbWlncmF0ZV90YXNrKzB4YTAv
MHhhMCkNCj4+IFsgIDE2MC40NjAzMTZdIDAwMDAwMDAwMzU1Y2YzMTk6IDAwMDAwMDAwMDAwMDAw
MDAgLi4uDQo+PiBbICAxNjAuNDYwMzE2XSAwMDAwMDAwMDNiNjdmMmFkOiBmZmZmZDg5Y2ZmYzNh
ZTgwICgweGZmZmZkODljZmZjM2FlODApDQo+PiBbICAxNjAuNDYwMzE2XSAwMDAwMDAwMDlhNzdl
MjBiOiBmZmZmOWNlM2ZiYTI1MDAwICgweGZmZmY5Y2UzZmJhMjUwMDApDQo+PiBbICAxNjAuNDYw
MzE3XSAwMDAwMDAwMDMyY2Y3Mzc2OiAwMDAwMDAwMDAwMDAwMDAxICgweDEpDQo+PiBbICAxNjAu
NDYwMzE3XSAwMDAwMDAwMDAwNTFkYjc0OiBmZmZmYjg5ZDAwYzZiZDIwICgweGZmZmZiODlkMDBj
NmJkMjApDQo+PiBbICAxNjAuNDYwMzE4XSAwMDAwMDAwMDQwZWIzYmY3OiBmZmZmZmZmZmFhMjJi
ZTgxDQo+PiAocGVyZl90cmFjZV9ydW5fYnBmX3N1Ym1pdCsweDQxLzB4YjApDQo+IA0KPiBJcyB0
aGVyZSBhbiBlYXN5IHdheSB0byByZWNyZWF0ZSB0aGlzPw0KPiANCg0KVGhlIGZhaWx1cmUgSSBj
YXJlIGFib3V0IGNhbiBiZSByZXByb2R1Y2VkIHdpdGg6DQoNCmNkIHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZg0KbWFrZQ0KLi90ZXN0X3Byb2dzDQp0ZXN0X3N0YWNrdHJhY2VfbWFwOkZBSUw6
Y29tcGFyZV9tYXBfa2V5cyBzdGFja2lkX2htYXAgdnMuIHN0YWNrbWFwIGVyciANCi0xIGVycm5v
IDINCg0K
