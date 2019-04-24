Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03A320656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qtbRQI3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfDXVYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:24:37 -0400
Received: from mail-eopbgr820137.outbound.protection.outlook.com ([40.107.82.137]:9696
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbfDXVYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rJZkIG0vGI79Fk1x/sLtDSTYaGuemwhNdNH06fxWvc=;
 b=qtbRQI3tTJpoGF/DrXmwYBvUhgLiTRsudOEw+isC0KwbCBkMtytFf29L0izGq2shmAFxVQVzHfZf3abfnstKsOh+8ANVqF9yEQZB/m4XGykMz36eGc2pbgRW1ap2JR66jR5jehNQYAzzkFh2j8LbGcHqKKCbRpanrgelkCSWGfM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1360.namprd22.prod.outlook.com (10.174.162.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Wed, 24 Apr 2019 21:24:32 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:24:32 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 4/5] mips/atomic: Fix smp_mb__{before,after}_atomic()
Thread-Topic: [RFC][PATCH 4/5] mips/atomic: Fix
 smp_mb__{before,after}_atomic()
Thread-Index: AQHU+pvw+cZO+u6L3EeyssGPr9Lw/6ZL0vSA
Date:   Wed, 24 Apr 2019 21:24:31 +0000
Message-ID: <20190424212422.bykvyho3jqw6jz6w@pburton-laptop>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.751367532@infradead.org>
In-Reply-To: <20190424124421.751367532@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2383fc4c-9445-44ef-5300-08d6c8fb3dbd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1360;
x-ms-traffictypediagnostic: MWHPR2201MB1360:
x-microsoft-antispam-prvs: <MWHPR2201MB136019317F69555867958237C13C0@MWHPR2201MB1360.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(136003)(39850400004)(376002)(366004)(396003)(346002)(199004)(189003)(486006)(7736002)(6246003)(8936002)(44832011)(229853002)(6486002)(14444005)(2906002)(66946007)(3846002)(66446008)(66556008)(66476007)(64756008)(6116002)(99286004)(7416002)(256004)(54906003)(386003)(6506007)(58126008)(52116002)(6916009)(68736007)(66066001)(4326008)(71190400001)(11346002)(6436002)(476003)(71200400001)(81166006)(81156014)(446003)(33716001)(305945005)(8676002)(316002)(1076003)(53936002)(76176011)(102836004)(5660300002)(4744005)(6512007)(9686003)(14454004)(25786009)(186003)(97736004)(26005)(73956011)(478600001)(42882007)(142933001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1360;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UoqYn4B06PbYeRzk55bZs7rCFqOpKGpA53bcLGdg+iASfGRWe/o3fex5i8/ktsSPSX5YalR+IR3zwh/6p5/3ljMTCZuxWHtBTSlc150eMgi4cU7Mty+YRKON1t17rlRGTe+mc+7oCLJTkMiZvVe+1g420fbgcdGBykQfiYIpZ7UOdlAKDPa9cyxXtlk7d+6pF6Pin2ANFYM68s8PqKjtSywlilyV/JR2zLCSE7q2Xvagr2+PSkeRGoGUO8nymr3wLSQZMOSrwnna+vWStyJTd7iPDGFItLcf7rayMM/OTUdC6e+s5/y9qlYQniNZ3AJcoT5T11+gghCldMBjOVunIIVAp/FIChJnuOISE1GoJ8+EHRZm8scDOG23hnIyuKQuoPoslT06E56AkijFB5IfXq31X+/Am0J70TxgfH1+T9Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0473ECA1AE84CE48B31E5AC8D71E5DB7@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2383fc4c-9445-44ef-5300-08d6c8fb3dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:24:31.9969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Apr 24, 2019 at 02:37:00PM +0200, Peter Zijlstra wrote:
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -230,9 +238,6 @@
>  #define nudge_writes() mb()
>  #endif
> =20
> -#define __smp_mb__before_atomic()	__smp_mb__before_llsc()
> -#define __smp_mb__after_atomic()	smp_llsc_mb()
> -
>  /*
>   * Some Loongson 3 CPUs have a bug wherein execution of a memory access =
(load,
>   * store or pref) in between an ll & sc can cause the sc instruction to

I think this bit should be part of patch 3, where you currently add a
second definition of these 2 macros.

Otherwise this one looks reasonable to me.

Thanks,
    Paul
