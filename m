Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8013BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE5B24673
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P3gvsSAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLOVDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 16:03:15 -0500
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:6065
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfLOVDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 16:03:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLo7RdkA8qM4G3af2EKlm7YRS4IER9wL5VmR806ljobotmYtkwciKMmQH3Za7Zduj11nCihjZ3/eW5J/VZVcy0cJmRnJ78FL3NOg4Rps3+UMMIotm6F5Huqfuqz3W2N0HeGBkVhMhvkQoihOos/fzGOHrUutiSmaqX6jHgApm5q0+0dfc0tFE4Cmis896pFN01BtJ0OAABPP35ghXyi7wmunFw5wh3Jt+zttM6v0BYzXqB+wKK3LaeMXlmRIdOJX6y3iIpH++++Vkav/2zt1PS57Z7i/BKy01pQRgQBQNi1fmWQ9k9nOiVP5xGqUipa3ImQ3Q4MSjX0Hmrxc+NbvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpnp3Q9iLYUJr6YGjoRILJKY92KBhv7iJAk/zebVGZw=;
 b=aKA/SEP19JIJmsJ693LEnDobjjctaYjj+0YDHoHOhLSbXZaa+W3Fp7T/ArGGbv5dtqFg2zHnce04fTNGZmFm4KBpKYJ2JffHs15K+B/PvuMs+t1pauSa7cBVUIdK70wZFCjco17EA/fHgd2nJpF2zYND3o0O2fRoRwn87xBR9IxfLa968iET+tREuUsWQl7n/m3wkIAih+ioPN5Jy/lu2kpoMHMgpJ6RueD0A8g/iPdMhJXT8Yt0JtJSY4ol/ojW6cdw9w3HS7PKLaGCaOpuO4G2fKGu+ktt8Kb+vtp2LglSMEELWyPoOK0uEhNHRsaW/gsf/iWyGE2BFB14bBw9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpnp3Q9iLYUJr6YGjoRILJKY92KBhv7iJAk/zebVGZw=;
 b=P3gvsSAcK212bA5PB/3mI/3gfcAYkrF9gxRNpA9urTX4DXMQgz8MwLqqVTbygpDLafFvGiP+5PJqw51wCfGkYI4ySodyYY0aaTd+B2teiZR29LIMRFTWtFnZTdwtFVmLvbiPAwr+7i+DbfUUktZtbvGcM3dpzUlrhJr+ntw7vhs=
Received: from PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) by
 PU1P153MB0121.APCP153.PROD.OUTLOOK.COM (10.170.188.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.4; Sun, 15 Dec 2019 21:02:26 +0000
Received: from PU1P153MB0155.APCP153.PROD.OUTLOOK.COM
 ([fe80::8887:e87d:a635:b5b1]) by PU1P153MB0155.APCP153.PROD.OUTLOOK.COM
 ([fe80::8887:e87d:a635:b5b1%5]) with mapi id 15.20.2559.012; Sun, 15 Dec 2019
 21:02:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Dexuan-Linux Cui <dexuan.linux@gmail.com>, Qian Cai <cai@lca.pw>,
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
Thread-Index: AQHVs4UjfkfCY1SyTUaF01bpD1XVcKe7qDEggAAFIwCAAAEtEA==
Date:   Sun, 15 Dec 2019 21:02:25 +0000
Message-ID: <PU1P153MB01557F1D44CCA23A8DA880F5BF560@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
References: <20191213224646.GH2889@paulmck-ThinkPad-P72>
 <CAA6354A-C747-4BE0-8EDC-C06E3C1D7D08@lca.pw>
 <20191214064048.GI2889@paulmck-ThinkPad-P72>
 <CAA42JLbBFkpYHXRVvyveYO76DnbkE3gyRW-=qmBGZcJTAiB6Uw@mail.gmail.com>
 <20191215202023.GM2889@paulmck-ThinkPad-P72>
 <HK0P153MB01485AF4FC857C8D26F4F471BF560@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <20191215205656.GO2889@paulmck-ThinkPad-P72>
In-Reply-To: <20191215205656.GO2889@paulmck-ThinkPad-P72>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-15T21:02:23.4593657Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e3de4d9-5815-48d5-a55b-fc2f39efff66;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:55d1:ce55:1295:858c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89141007-38b6-4715-e961-08d781a216a8
x-ms-traffictypediagnostic: PU1P153MB0121:|PU1P153MB0121:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB012110CA43232B11047E69C6BF560@PU1P153MB0121.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(136003)(366004)(346002)(199004)(189003)(7696005)(4326008)(54906003)(81166006)(81156014)(8990500004)(53546011)(8676002)(107886003)(316002)(33656002)(186003)(6506007)(8936002)(478600001)(6916009)(10290500003)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(71200400001)(86362001)(9686003)(55016002)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0121;H:PU1P153MB0155.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GcusqxJ4YRFGo5xUtIOmeWa8/nr+gJVBhzyUXnfiSjMMMGo7jtMFENb2xqetA9RK7uB6FUzdas5JhGIwbIGj9UNa8BbNgIoCTSoiXNfnaQf+GLApfyhhbWhOJ0rB2B+3a7mXlhG2ORfe68eJKSWNDd5jNCd3CGToWBrS7q0JxyHNXL8FtA3W+br7iUAspn/lF2CDLDchc8uIEBhQW3Y9+NUzELJholEeierW2G2d24U9VbFL/Saa3o2+m8DHRZ/TWpLfqBYWDcWfanKVpvwFa+g+UcNdGKpNVUYls0A1mjjybS4XpBaFBsKLUJcPjc4NlI7GV1FtgNmjbmDUy+UpLj6ThKlBI9GsvMPzIyxFPHNHxlJTGI0MEC+eQe5CYsN8OQjQ9HOiJ/9iUY9avowDBsdPwua7TC53CcuKlbXbEemTSWSR6oyjqU+8uo/UGEa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89141007-38b6-4715-e961-08d781a216a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 21:02:25.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mv6aLyqGeLo+Q+qoOy3bAiz2/0/TrzuWeKyVgKL8FhtEque77pRNyaCrH2NRKM6MlPW8B82ojv2M6zTc02Pk4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Sunday, December 15, 2019 12:57 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Dexuan-Linux Cui <dexuan.linux@gmail.com>; Qian Cai <cai@lca.pw>; Joe=
l
> Fernandes (Google) <joel@joelfernandes.org>; Tejun Heo <tj@kernel.org>;
> Josh Triplett <josh@joshtriplett.org>; Steven Rostedt <rostedt@goodmis.or=
g>;
> rcu@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.=
org>;
> Lili Deng <Lili.Deng@microsoft.com>; Baihua Lu <Baihua.Lu@microsoft.com>
> Subject: Re: "rcu: React to callback overload by aggressively seeking qui=
escent
> states" hangs on boot
>=20
> On Sun, Dec 15, 2019 at 08:40:40PM +0000, Dexuan Cui wrote:
> > > From: Paul E. McKenney <paulmck@kernel.org>
> > > Sent: Sunday, December 15, 2019 12:20 PM
> > >
> > > This is consistent with what I saw in Qian Cai's report, FYI.  So I
> > > am very interested in learning whether the first patch in my reply [1=
]
> > > helps you.
> > > 							Thanx, Paul
> >
> > Hi Paul, yes, your first patch (the below) can fix the hang issue:
> >
> > commit e8d6182b015bdd8221164477f4ab1c307bd2fbe9
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Sun Dec 15 10:59:06 2019 -0800
> >
> >     squash! rcu: React to callback overload by aggressively seeking
> quiescent states
>=20
> Thank you!  May I add your Tested-by?
>=20
 							Thanx, Paul

Tested-by: Dexuan Cui <decui@microsoft.com>
