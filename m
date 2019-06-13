Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A164C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E4B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PFI9OSYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392407AbfFMQcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:32:42 -0400
Received: from mail-eopbgr770098.outbound.protection.outlook.com ([40.107.77.98]:63727
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731233AbfFMQc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqOIr+DSkIIy+uFVsXO0USSLytrlP4YOD+TipL7+p9o=;
 b=PFI9OSYQ6PRC8WzoojPAShomHNwaJWZn1unomtprnuITF01RMJgbwiteq3W/aVuVQzU+e9uCLJVNsIxjFGH3dTVLtjriOX6bVFRJWaIh4+gFMUqZjSki8YcUGYp51gLuM79vkNHalMB+QvCagi/J4Ca5XfqtqGtXTpgB/S8ra1w=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1520.namprd22.prod.outlook.com (10.174.170.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 16:32:25 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40%2]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 16:32:25 +0000
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
Subject: Re: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic()
 and mips.
Thread-Topic: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic()
 and mips.
Thread-Index: AQHVIe8QIwfDQMV0Kk6fv8//v7CYs6aZx0gA
Date:   Thu, 13 Jun 2019 16:32:24 +0000
Message-ID: <20190613163222.zqisgcqzibofmkd7@pburton-laptop>
References: <20190613134317.734881240@infradead.org>
In-Reply-To: <20190613134317.734881240@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::21) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18530860-9f8b-4bdb-b1cf-08d6f01cb753
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1520;
x-ms-traffictypediagnostic: MWHPR2201MB1520:
x-microsoft-antispam-prvs: <MWHPR2201MB1520CD9535978ED9DFCB9644C1EF0@MWHPR2201MB1520.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(366004)(396003)(376002)(39850400004)(199004)(189003)(478600001)(6916009)(558084003)(1076003)(66066001)(42882007)(6436002)(229853002)(68736007)(6486002)(99286004)(9686003)(6512007)(14454004)(476003)(305945005)(44832011)(54906003)(7416002)(11346002)(7736002)(58126008)(446003)(486006)(8936002)(102836004)(33716001)(186003)(4326008)(26005)(5660300002)(25786009)(81166006)(8676002)(81156014)(53936002)(6246003)(52116002)(76176011)(71200400001)(71190400001)(73956011)(66946007)(256004)(66476007)(66556008)(64756008)(66446008)(3846002)(6116002)(386003)(6506007)(316002)(2906002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1520;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xva+Ol54ksx/D/PVX1Cn9+uEXOBOSBBTcjFttnlppS48hETgktldDeSss9jApJYl/FyYNp2QfS13mMVNuTujZZZ11BRCMv9kaUbZlnHH0q/eBpa2mL+U72fsjgayq3UiKX+NKTVigPlEJa60kVXRW01qPuEbh5nGvJ007Okh/3UJtS7zHrf04jeHaIq32WmyxJopjfKLeMNT0czAvGJjO8s0UDJg0lsMfpdUqvRrIu7v+JOw2b7TarIBEc/mzwdQRfYB2Bed7WhMRxcOtGs04oY6eRm+YxZkLU2nO88Y6ASyREMWueyts+M128SMwi1jIwPf5E5MoWSj6eUIJwOcv/iEj7mmBlWIZyngALuQEQT0TdkWHaVp0KhQi4UbpE/QWasUI8j1lpxdFmm0ZDXxi3SM+GhXt1/SpdwljqjZkn0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <374F03734895F54DA53D980E3B65D5AC@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18530860-9f8b-4bdb-b1cf-08d6f01cb753
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 16:32:24.9273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Jun 13, 2019 at 03:43:17PM +0200, Peter Zijlstra wrote:
> Paul, how do you want to route the MIPS bits?

Thanks for following up on these issues. I'd be happy to take the MIPS
patches through the mips-fixes branch - do you have a preference?

Paul
