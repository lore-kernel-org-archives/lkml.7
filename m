Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D1F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="gytqcggA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCFOMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:12:34 -0500
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:32784
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfCFOMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOAE6Ls+a5sdGutyv0VeGhRXGKPWVNQescvXfS1EP0U=;
 b=gytqcggAmXrwE/jtVQayXO6WkJpKAMFHms8x43HUWmvmVkS/lNI6G4ocTk499EUNKOAWX5fiq8Mycle2XgbyAY6ffmDuBhDJANqrda0/dhVNsRxrFyVDckBfiAr6nQUfW9T1PVhdz3seo0EUlGcVdLYVQxJyptERX1fkYVQzZ04=
Received: from MN2PR01CA0021.prod.exchangelabs.com (2603:10b6:208:10c::34) by
 SN6PR01MB3999.prod.exchangelabs.com (2603:10b6:805:28::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 14:11:50 +0000
Received: from CO1NAM03FT057.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::206) by MN2PR01CA0021.outlook.office365.com
 (2603:10b6:208:10c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.18 via Frontend
 Transport; Wed, 6 Mar 2019 14:11:49 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT057.mail.protection.outlook.com (10.152.81.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.13 via Frontend Transport; Wed, 6 Mar 2019 14:11:48 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x26EBivb030324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Mar 2019 09:11:45 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 62D3A7A3F4B; Wed,  6 Mar 2019 09:11:44 -0500 (EST)
Date:   Wed, 6 Mar 2019 09:11:44 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: a.out coredumping: fix or delete?
Message-ID: <20190306141144.GD7930@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic>
 <20190305122218.GD13380@bombadil.infradead.org>
 <alpine.DEB.2.21.1903061323030.1646@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903061323030.1646@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(199004)(189003)(46406003)(6266002)(4326008)(75432002)(93886005)(11346002)(786003)(316002)(33656002)(42186006)(16586007)(58126008)(50466002)(36756003)(126002)(476003)(2616005)(14444005)(106466001)(52956003)(229853002)(103686004)(336012)(446003)(186003)(86362001)(90966002)(97756001)(88552002)(356004)(6916009)(2906002)(54906003)(36906005)(486006)(76176011)(47776003)(5660300002)(8936002)(305945005)(8676002)(246002)(26005)(106002)(478600001)(26826003)(4744005)(6246003)(23726003)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR01MB3999;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea1ce3e-c4ca-411a-e7cc-08d6a23dac9e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR01MB3999;
X-MS-TrafficTypeDiagnostic: SN6PR01MB3999:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB3999;20:/gM583Lsw8U2fvvj9auluwreKk6WBXsGCXHpEyGQ7QQWXZWotqnGp02HJ4dSfU6DZ8CxyTbb7A9s2T8AErGVtAwd3ZdBKsUGvU3Jig1Pbw0XB7QdP5GRCiZvtr4RagfuOSXPCg5n7+huJMp5+7RZ4ZT89FLRT2TRB1uYiiv8PfwDha2HZDSzVdlg7FzIbBHGL8Sp6vTJO+zs2tKVVBuf/xt9gtAZRQ4NWt8vdiiQx9LMh+N7IDLgQk2FFcMwVZXazcgZiELbnFpT6cgyQZzRlUChwerS++Waejj2Ujm80+IwMBk7I3bqqtoPd6DehALwm4SGJM7T+GGWsSQUS+Nd1M7KwhxYb4djjzdunLq0s1P1m7NDJ8ruNjnzaC90R3Ocp0TXLhc0gLiP4WCPfNkrCgCO06+i13rteOtZKwDgHNXT/YFDcWLYwPgS/vpeyGULoyEDasQZnbj1iEC9UXhZXltil99Si7xmNuDcOD1m9YgNPfnx4kbfitJlbmmU3M1rOF7kA4iZrSJVVdTjPeiNbBeirDDTCp9EUfLR9ILVJn2UAkRh0TSYT+RAOd+h5uhOyN0cePnosdrreAlChSyLE6gqkSpwfvDolJ1sgj7Iyig=
X-Microsoft-Antispam-PRVS: <SN6PR01MB3999A85100C2089D04DDE8FFB5730@SN6PR01MB3999.prod.exchangelabs.com>
X-Forefront-PRVS: 0968D37274
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR01MB3999;23:D9JUEckVKv2D6uJ3niKJOyX5OldbtIKvUp3goC3QK?=
 =?us-ascii?Q?//AB6rgr9VXjPLhADlJls2e/vNQv/Nte88TwCzFZTASClxZGTtF3Z/uX82p6?=
 =?us-ascii?Q?9ybGHt9vGqFJraBvpTclZw5CaJHCNo1bRznUNosAGl8DFisUftZMQ6Hpx7FJ?=
 =?us-ascii?Q?FmWYpKRE2C3abh5uW2/CWBuMTtz7xJKXNwQpK1FEqu26Qf0f60QifxhOR1zO?=
 =?us-ascii?Q?ARlF85jV2zm0cYSxwOiPJYV7Mwi+Wz6jP5L521ICUMrCaRU0FPUUVqloq0A6?=
 =?us-ascii?Q?yunflxMxc4ZfJSTlcPEsq6pL0jBAa0o7Kb9wSyjctj2fJOTWd0eY6TWJhzOE?=
 =?us-ascii?Q?Beuuv034XT9Y0p4TQZtPfU42fSqabjOdhStTBAQ5rzWCor5+oDyR65u1+GAX?=
 =?us-ascii?Q?6n8P9TC+iJ/6B8e66nvyEl50bOCs+p0dHmAr3CI62QgoqZpI58JDRNjC0T86?=
 =?us-ascii?Q?1C5CpqYVh+pjIgt+Lv/2vDCwBpsYPDBmTmV3zqxv8sSKWgZYEfoFpgCeZjEE?=
 =?us-ascii?Q?2gwPdxENCM3K7s0lAFqc9KpeCboAEFXt6wNE2UxBykYT/fObCVPTdpggkjln?=
 =?us-ascii?Q?dD7ckTDA6mYKsNAsMbPawPqD1lNYewVQo0m1za/pKPE2clp7k0jvgQJEfqe+?=
 =?us-ascii?Q?gmatPqnFZIeWQkvomvM46B6kK94GWJ10KlLucx+2Ei3OnX+kkeAblr2gON/D?=
 =?us-ascii?Q?gOPInqKnjm1l7aTiNLR1UEoPnvSOJE/kSAkoRtr1LnkPR+7SlFLHAjsxtbgf?=
 =?us-ascii?Q?PhQIPv7Diqo2/N7zgWi3oGYbaahwt7d80bUwbGi6jaFmDtK2SKHG8VpGqpo8?=
 =?us-ascii?Q?wv+GJIJupWVsEgQZ5uZP28jMulIAdJPyv/lXrPwRTGz1lx97kiWnovlc0vXI?=
 =?us-ascii?Q?0lv3q6aDt9ln6B6ZYFxeUs2isQeOyfdW2CQWmj4tAUOiPPwKKC8qPIVh4Izu?=
 =?us-ascii?Q?0tl8rHb4AqxRlF10FGHE8pSzpu2d4avqzueWcuwY1uwZMurMX6//7P1Pcwa0?=
 =?us-ascii?Q?2XC3pKemUNwiaEd/kzt/Zh1h98enfdFVTwvvxbww8y8+4JDMSkcCkKQD/bdv?=
 =?us-ascii?Q?AXoJSMPx1W6GQvypYCHwHb41tgXbMq4Lt9U5IYbUE9Z9rNr3nOVAgztGpFtT?=
 =?us-ascii?Q?MlQON/QtFQZu4Q0MmjFSODugJuA6BaL4Qt4rj69dTZ4XGUgS6IBopXRyvb8Q?=
 =?us-ascii?Q?PQ41QZ2bEoHmBYk/POcIDnRy/FtExaO9P1g0kAEYTuWsqah6HBO+TviRaehb?=
 =?us-ascii?Q?J1X5SAhW0DOfPtIy8Yy+Zs0ouAmZaf903z1yWEt?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: B4BfAJ38t7v9MiRO8uVONfU0qP54zQsuGi2zmKHsVt53uJ8BbJ5Z1I5Sk472HUm4dTjhScd7YMcxFmblFna04wS18rmHF+mbJbS0hBVCW//A9jHER8x28xcxcnKWKDfUp8e8PqGAYATY93M3TrTBKVwmkFXn6NkJtFodvK/gKOQcUP5IusB0JBg6r10D5yhQOPI1nT7mtXllHdFQ8rwPibxN1GMuxt3zf8iL+PrhsH2yUhDDax6WiwcRURvJKCkVPsEIlI4V1yWeCHngVfTh7WPmLLyQ/b521Zh1APSe0b1W+RB7/kq59B/YalULCkLVX9SvHZGjCqAPT01BQIGT+pCIf0cm28MpTYt7q+sPTzGXnx5jfsbYJSFSu+LN/Ty8zFUzW2ruhp6s5zeX76miaTehoIh8sD3DhbR28fSztvA=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2019 14:11:48.5268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea1ce3e-c4ca-411a-e7cc-08d6a23dac9e
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB3999
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 01:25:17PM +0100, Thomas Gleixner wrote:
> > It's been 25 years since Linux added support for ELF.  Can we just
> > delete the a.out support entirely now?  According to the Linux-ELF HOWTO,
> > support was added in 1.1.52 (August 1994).  It's pretty much necromancy
> > at this point.
> 
> The Kernel-Necrophilia cult members might disagree. :)
> 
> But yes, good riddance.

Doesn't Minix 1.0 use a.out?  It *is* cool to be able to binaries from
run dead operating systems.  :-)

						- Ted
