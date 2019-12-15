Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B81AC2D0CA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B52320700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CYpKUfPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfLOUUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:20:03 -0500
Received: from mail-eopbgr1300114.outbound.protection.outlook.com ([40.107.130.114]:31809
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfLOUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:20:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K63P1Gy08IcegoRxIjSBNZx9t8/klXgQYnGNf/XrySyVhamAF3RYASF2JjiZSURr0EoRNNq7ibf3G0rQyRUImOtDBE5eqSv03hFC+YCiSoCxGOSiy9FujtNrTpod4pNl5c7wX3xqp0MvYLl3kUxnGM+hpgC5SGgpc/uccAmApLYxjLFM9UBaFVlcd66R9GMfVuARNr+3Ukp1+AGZIO/AGxxnlMxvTi+U02WCaAFf4OMsVh5CFUs8velL3AWnoHKwT++4kqBzvsU4o73qiWwnwXjscDLkoySnummZ3sh0AD4kRQ0101lk6mOJtk0jEFxHXHlVJHmyuFIgcAYRahTdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXiIA5JmXi6DgMQoR2jU7gCkJLH/EK+nyX8zFXqI3zk=;
 b=Frd+KXSCN2rbZLZifFyknseS/K8y1UCbN7gwl38P3kDotPaACAKmp1V+A7tUjG0ePkvDcnQp/xzFmks619HzldEz+F1N/YS23yIaI6rhEOlp2KehBJ8hJ91028TJTc6BpDLB+xhl9zkYeN3Eh83EQv/y8G/1xrP+rf4UCxohL4zdb38rtk/RnQ/XtphQChaOkH/E3w6ySb5NIz3q8WkdCaTb6v4/j1YT1s+5zysETUdxZ2yMoofZ6gv6QWMWuYu0ck399y51akak+0kcMGomo4xbCFur02nCaB0Ki4ROe90g2VaeZEb1MFHCrdY7leWTNyx8UuEcS/HT6VYZCmVWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXiIA5JmXi6DgMQoR2jU7gCkJLH/EK+nyX8zFXqI3zk=;
 b=CYpKUfPQSxnGj7mXMUmFzCGL2qjx2xw4P41EjI6DzE/tbkciLvHu7UFGCWSjvfTZIhEz1oG3JGkZ/hYqd0+gtGH+a/E5Is4Yo19JRV9kEx5zHt5L3TDHNC8eoN0oW9ooM2Hh595sOLO1jbGvG7ASMBM2CVornxwK41uNTOepy54=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.8; Sun, 15 Dec 2019 20:19:56 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::a5bb:f459:f4f2:1b94]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::a5bb:f459:f4f2:1b94%7]) with mapi id 15.20.2559.012; Sun, 15 Dec 2019
 20:19:55 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Qian Cai <cai@lca.pw>, Dexuan-Linux Cui <dexuan.linux@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lili Deng <Lili.Deng@microsoft.com>,
        Baihua Lu <Baihua.Lu@microsoft.com>
Subject: RE: "rcu: React to callback overload by aggressively seeking
 quiescent states" hangs on boot
Thread-Topic: "rcu: React to callback overload by aggressively seeking
 quiescent states" hangs on boot
Thread-Index: AQHVs4Fb1xlEUoCb6U6Du/8oqLqJJae7omqw
Date:   Sun, 15 Dec 2019 20:19:55 +0000
Message-ID: <HK0P153MB0148B34EECB0A1A982B25732BF560@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <BCD69C9E-4E61-405F-A514-36096E0F34F4@lca.pw>
In-Reply-To: <BCD69C9E-4E61-405F-A514-36096E0F34F4@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-15T20:19:53.9196049Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eaf7a87d-02fa-4daa-9371-fb5a9e549873;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:2040:6c9c:f479:9e9d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1ace6eb-3dff-4bdb-0248-08d7819c26ad
x-ms-traffictypediagnostic: HK0P153MB0273:|HK0P153MB0273:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0273ADFFE1E255DE876208B4BF560@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(2906002)(316002)(54906003)(66446008)(66556008)(8990500004)(86362001)(4326008)(7696005)(52536014)(66476007)(8936002)(53546011)(478600001)(81156014)(81166006)(110136005)(6506007)(33656002)(107886003)(4744005)(8676002)(71200400001)(10290500003)(55016002)(76116006)(966005)(5660300002)(186003)(9686003)(64756008)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0273;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rIodSaqXo1vvNmz+dwXDGWhz3bappowUJ1x+nQNTAXjY6LmbfMWPGcCuke4bk3K4P7SGU3afrf+MJ4EdYqf3wLHfrQY7BS2GHczUCeGbRLW0qPyV+7sFcJeV1Bd6jFY3PGBhNtKk/t0qgKZu+G7AZ/J+6U3FIAkQsZKjYZETBYD34lwltK8wicCJBxcyd0HQ1ExPGk1shjEAvTLzVkEeucKrf4q8lNlOoo6vdWLwW1QwA8P7c0yxGcMSHGhuejB1WWh6/VYXPd4/LI45ahZP00+Vfx7x4ZLd87uFA7iC4xhd9P3F0/i4kJUVpPSIUHui2RpfnWzr39aGyp4A7+2oGvtVJvRkj5aXQPsxe2w//QnwNTCLSaHyEDeTNRVHsOoO8/rc35n7ZSnQqK0XVdBNGuXoj2u1WgAul9g28c1jbicD7VpYNYi7uC7NFS/N0icNuQ7NbjEA5ml7lHmEOJNTLAm9v/L7ylAqNINrd8bbi0g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ace6eb-3dff-4bdb-0248-08d7819c26ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 20:19:55.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdoypkR/2rjqodAGE99Z8HBOPoatglhYP5yNZbysMKSVIxdr5xN6el30119/PjOTWEuAYnoC5cDjhxVkcXCq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0273
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBRaWFuIENhaSA8Y2FpQGxjYS5wdz4NCj4gU2VudDogU3VuZGF5LCBEZWNlbWJlciAx
NSwgMjAxOSAxMTo1NCBBTQ0KPiBTdWJqZWN0OiBSZTogInJjdTogUmVhY3QgdG8gY2FsbGJhY2sg
b3ZlcmxvYWQgYnkgYWdncmVzc2l2ZWx5IHNlZWtpbmcNCj4gcXVpZXNjZW50IHN0YXRlcyIgaGFu
Z3Mgb24gYm9vdA0KPg0KPg0KPiBPbiBEZWMgMTUsIDIwMTksIGF0IDI6MTggUE0sIERleHVhbi1M
aW51eCBDdWkgPG1haWx0bzpkZXh1YW4ubGludXhAZ21haWwuY29tPiB3cm90ZToNCj4gV2UncmUg
c2VlaW5nIHRoZSBzYW1lIGhhbmcgaXNzdWUgd2l0aCBhIHJlY2VudCBMaW51eCBuZXh0LTIwMTkx
MjEzDQo+IGtlcm5lbC4gIElmIHdlIHJldmVydCB0aGUgc2FtZSBjb21taXQgODIxNTBjYjUzZGNi
ICgicmN1OiBSZWFjdCB0bw0KPiBjYWxsYmFjayBvdmVybG9hZCBieSBhZ2dyZXNzaXZlbHkgc2Vl
a2luZyBxdWllc2NlbnQgc3RhdGVz4oCdKSwgdGhlDQo+IGlzc3VlIHdpbGwgZ28gYXdheS4NCj4N
Cj4gRG9lcyB0aGlzIHBhdGNoIHdvcmsgZm9yIHlvdT8NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcmN1LzIwMTkxMjE1MDY1MjQyLjcxNTUtMS1jYWlAbGNhLnB3LyNyDQoNClllcywgIHRoaXMg
Y2FuIHdvcmsgZm9yIG1lLiBUaGFua3MhDQo=
