Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C157C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE4224679
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QyuPPJB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfLOUkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:40:49 -0500
Received: from mail-eopbgr1300110.outbound.protection.outlook.com ([40.107.130.110]:8467
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbfLOUks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:40:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB7Y3otf+i2bwm791KWFc8Nu4B43ikuM3JeqnFw2evvx4udEM4MXejujfWl8faHiyKTNpCPpa5wi6hjtoOE9lLm1f5dMzJ4e7wpCCY+m5CrGRZB49hpj1Opt/GY5hIWJKOqF+kjjkeyXCT/Z64qKg4XCboSOPImB9owzRdFz72QErJHgJGDHl+4CrZhHcStyJIhG5DNxLbm40xs+HXJ4PVrQVri8IOc+wDUj5z/iNzQNklxySJwbGB9/hgZtSaJ3DcrWGcp2UlyGpzUSnvmH98bO8t4vo7qhFQIeAe9ur/vK8oBgbyyOQKcQMZRQ8ay9Vae9jsYLcwc0GqdxvNZP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L62aoEzNYLLvWNRvozkDEtYI7Rdl0eB1vbTM6BHtac=;
 b=lWhgaW74PNmAbG6PvkV1ob7z4lFmTLyr00lC6rJdJVCV0zxaEz8UteG+PohEH7XK6+tzOQLDo0GLDfCG9TlUt/Sx6Wv+ScJ/4B1L6QekawQraBvpFT8/hfC7vEuBEGdzXzB7LsjZOlEk4PfPHc6QSdolNW3Y6+Zg8pZk/FshrLF/P7zkT+ZjozTA2CbqRasEvZYp0SHplrFsRD1dZwCXW3YHfhC7s9YEKxiV++frjnBeeQaC2eCRP59tFlRTYF5EO1i0b1ighyQ1g0CywMSyb2kQSWtBBUnWAHfkWbI8k9yTO8zuJMfe1fa2mmQ62kn1aja0GgqnWOJ+Qalj1ydHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L62aoEzNYLLvWNRvozkDEtYI7Rdl0eB1vbTM6BHtac=;
 b=QyuPPJB5pAwYk9dZIWODt4t49r5aQTqmttb8zOpxbbiN171iNEIsRDdA3tzotG3bcu0BepXAh5tHP19bnRm8BhuXr18vmIiz0ScQWFB0Va/0pPCWoIwFV+/dlMCRlDaSEawPnxi+JCQybHOCS8Yy9fvOawlqNG+iBUavXrO0lEM=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0146.APCP153.PROD.OUTLOOK.COM (52.133.156.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.7; Sun, 15 Dec 2019 20:40:40 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::a5bb:f459:f4f2:1b94]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::a5bb:f459:f4f2:1b94%7]) with mapi id 15.20.2559.012; Sun, 15 Dec 2019
 20:40:40 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>
CC:     Qian Cai <cai@lca.pw>,
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
Thread-Index: AQHVs4UjfkfCY1SyTUaF01bpD1XVcKe7qDEg
Date:   Sun, 15 Dec 2019 20:40:40 +0000
Message-ID: <HK0P153MB01485AF4FC857C8D26F4F471BF560@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <20191213224646.GH2889@paulmck-ThinkPad-P72>
 <CAA6354A-C747-4BE0-8EDC-C06E3C1D7D08@lca.pw>
 <20191214064048.GI2889@paulmck-ThinkPad-P72>
 <CAA42JLbBFkpYHXRVvyveYO76DnbkE3gyRW-=qmBGZcJTAiB6Uw@mail.gmail.com>
 <20191215202023.GM2889@paulmck-ThinkPad-P72>
In-Reply-To: <20191215202023.GM2889@paulmck-ThinkPad-P72>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-15T20:40:38.0391311Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ece93af8-9f75-48ae-93a8-bf999a421425;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:2040:6c9c:f479:9e9d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75f1546c-7f2c-4a1c-a13f-08d7819f0c96
x-ms-traffictypediagnostic: HK0P153MB0146:|HK0P153MB0146:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB014621BB531685E1FC90CD15BF560@HK0P153MB0146.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(10290500003)(8936002)(55016002)(6506007)(478600001)(81166006)(81156014)(8676002)(33656002)(52536014)(107886003)(110136005)(64756008)(66556008)(54906003)(66476007)(316002)(66946007)(66446008)(186003)(4744005)(4326008)(71200400001)(86362001)(76116006)(7696005)(2906002)(8990500004)(9686003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0146;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5swY3YCZ1jFda3TKvbYZA5v7/G+f0SI1KkjvNJf9M+2ckR56FBRt2b7uzZxmMauAip0d/wM3AH6EopKwdbqqDKRqdcbaSTgs0tPtxrq4wF8K3GSl9QVroSPMc82R7J7pSSPhZjqD5n7MOmOa9X1Ruzu7AKI6A6OKvUvMN3+QDPKlB/zWJGIrXNDYKwqIx2yOH/G+kQwuG2xwCkKR+Plt7qJgpbohWG8HAOUXmjc7qL8CMSCz3QEJvbkLTJSAJ0JiTvY2/J/vDOowWhEV4yaCRRHEX1T6hO331eXaHZ5ZWZfSbitXPNqlVSMzvKkUTkofcrHNHsVQdFyLVwAtpgUIttOgeQH7Wp11nzoM7DgWGdYgFB9La2qnF3Xkhku6KGvdtfcvxHq8ZIAVvf047LThMwzHuYD46PIOuwHM37+MrkT3OC35DV7KvSQjVRBUvWPg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f1546c-7f2c-4a1c-a13f-08d7819f0c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 20:40:40.2778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vIE/H29qkfKTd4eZkuaiQGSpAW0MvkUJdLHJlf4sIcqf4A3cb1peL8RgyovsX4mAiQ67PrjKuAjmkhOPT/arg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1
bmRheSwgRGVjZW1iZXIgMTUsIDIwMTkgMTI6MjAgUE0NCj4gDQo+IFRoaXMgaXMgY29uc2lzdGVu
dCB3aXRoIHdoYXQgSSBzYXcgaW4gUWlhbiBDYWkncyByZXBvcnQsIEZZSS4gIFNvIEkNCj4gYW0g
dmVyeSBpbnRlcmVzdGVkIGluIGxlYXJuaW5nIHdoZXRoZXIgdGhlIGZpcnN0IHBhdGNoIGluIG15
IHJlcGx5IFsxXQ0KPiBoZWxwcyB5b3UuDQo+IAkJCQkJCQlUaGFueCwgUGF1bA0KDQpIaSBQYXVs
LCB5ZXMsIHlvdXIgZmlyc3QgcGF0Y2ggKHRoZSBiZWxvdykgY2FuIGZpeCB0aGUgaGFuZyBpc3N1
ZToNCg0KY29tbWl0IGU4ZDYxODJiMDE1YmRkODIyMTE2NDQ3N2Y0YWIxYzMwN2JkMmZiZTkNCkF1
dGhvcjogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KRGF0ZTogICBTdW4g
RGVjIDE1IDEwOjU5OjA2IDIwMTkgLTA4MDANCg0KICAgIHNxdWFzaCEgcmN1OiBSZWFjdCB0byBj
YWxsYmFjayBvdmVybG9hZCBieSBhZ2dyZXNzaXZlbHkgc2Vla2luZyBxdWllc2NlbnQgc3RhdGVz
DQoNClRoYW5rcywNCi0tIERleHVhbg0K
