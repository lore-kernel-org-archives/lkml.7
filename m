Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D54C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41662218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="onsAvQ3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfHTDuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:50:46 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:12416
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTDuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:50:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQL9S2IYEhS+TQXnVnrfBtWoJR643hv5QezJ3bFzrXSHgSPTSyPFwbZEbLVd7SnCqk4uQk9gEpTHTFuaZW+iRFEwBOqxOMNlTQDi/lFiHoHN9RKOGdSg6QnES+AlWNw3n8iq51609jLlQKwVRXoLp6uNkuQcGgzaReFtYwr0AoM99LyiS8jP44RizXTwXoLoXYeyhQS/xpI4uKgAW//mvYIf/6x83+P+onjrlwoS0hRcj6JhkKKM56bWNeZlYiGC/mFbhcxnWeXBPSTP5Sj9AorxcgP+w8nk5XFRbSYoI6Rsl1ek1q1R1PDxPU7LLIzZNVnxbQWvOujBSq8+ICgRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT/Bolt1eD0ad391f9vMuirjzeqsmwQro1oTVCG9zfY=;
 b=kQhg2vS+eB/mSExoWAied+dspAEbwk+zaVKrjlFarbyPxFuRvb0XRJwWHnBAyfH61PUALuo4J8czrUwvmuT/Md1nCOfdtEtUiRoGCLAWj/jS34d7i7fYAGhn5zS85Ma50JHYXXjQisMpXxzoXb+QTadp4pXM474A08fBG1oTcE+YowL4B+iTPhQH3rutw6eq0YzJK8LoQBcOhA9xuaWH7ycbhYDXpHB2PeHHz+eJT9wak1TC+JyQqQcaZaJ9BjFAetxul5rQpbtNRFGm0GkWl7Zjy3T+08mU9CbKbBk7DNloP49OUWQC5uyCsmMZa/gVfNkR8bQOLOmi32Y9aEXwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT/Bolt1eD0ad391f9vMuirjzeqsmwQro1oTVCG9zfY=;
 b=onsAvQ3KRrKEi2MBOuHHBUgIwjdLBoc1K8bFEZ4G8EiJtmEXQ42sawJuWZBZsIS8vtAxpID4JldKAjfhHBMPw2bUjhq1xEKqBJqdKoThJQ+G3KNm5PAGPVzXQPDaORV4ExLNQt8icMLI0FwNRtEs7yjvWWvtdFrK2mvSekpAhu8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4373.namprd03.prod.outlook.com (20.178.48.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 03:50:43 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 03:50:43 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3] arm64: KPROBES_ON_FTRACE
Thread-Topic: [PATCH v2 0/3] arm64: KPROBES_ON_FTRACE
Thread-Index: AQHVVwpwV+h0FsWU/0egxpRGPuo38A==
Date:   Tue, 20 Aug 2019 03:50:42 +0000
Message-ID: <20190820113928.1971900c@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::25) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cad8a21-29f0-4c17-7c10-08d7252192f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4373;
x-ms-traffictypediagnostic: BYAPR03MB4373:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR03MB437326A6D02449CD0656E687EDAB0@BYAPR03MB4373.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(316002)(6506007)(102836004)(966005)(25786009)(6486002)(8676002)(2501003)(486006)(476003)(71190400001)(71200400001)(305945005)(6116002)(3846002)(7736002)(186003)(1076003)(386003)(86362001)(26005)(7416002)(52116002)(110136005)(54906003)(81166006)(14454004)(6306002)(9686003)(5660300002)(66946007)(256004)(8936002)(66446008)(64756008)(81156014)(53936002)(66556008)(14444005)(99286004)(66476007)(66066001)(478600001)(4326008)(2906002)(50226002)(6512007)(6436002)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4373;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u01VlxGd3t6NF2hd4khno/EYL8S7gfo2ZKkqUdyJ9FTZgqXV0m4P7kksTgy3Zu2wSDull8R72aCzjzifZIf144x/UPHyDVMs8jggk94z1tOaNkhRnSwu7VkU01s38fxyP4jfoGfRHUQBmmomOcQhLTdJ8DnwC0J5do9ZoeH8mLsdgAXFkW2l2yrVhghqTxhkZbwj7eu+syyU/e70CI/sLtQOpc1TEP4rniGdYXJ9IGzbs+rscnINfpXRLAbJPYGXJlKndy+c+aAHHDAOEomqgA50JUS4xFm8JuEqC+8mpi8gUqcnDCdgYU7seVM1j9klfPbAwhai34+SI4dMhQ4YrW/9Z3Q9xsTk5eUfGlHxy+TJpQShggRarquazfMWaXUSBeQz5LoToMPzRZNStsXW4Lxonm4vHhrc7Hz0vh6CHo8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C886B6B54FCDA4BB1F6AAA1F63460EC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cad8a21-29f0-4c17-7c10-08d7252192f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 03:50:42.9645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAtQoR6natp2qXSa/Sos8p++x3QudfIBm9GyaBMe555grmEeW4PaAWP9OUWMAfz7GYbKBLR8T0rOFSDugxNGsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
eliminates the need for a trap, as well as the need to emulate or
single-step instructions.

Applied after arm64 FTRACE_WITH_REGS:
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-August/674404.ht=
ml

Changes since v1:
  - make the kprobes/x86: use instruction_pointer and instruction_pointer_s=
et
    as patch1
  - add Masami's ACK to patch1
  - add some description about KPROBES_ON_FTRACE and why we need it on
    arm64
  - correct the log before the patch
  - remove the consolidation patch, make it as TODO
  - only adjust kprobe's addr when KPROBE_FLAG_FTRACE is set
  - if KPROBES_ON_FTRACE, ftrace_call_adjust() the kprobe's addr before
    calling ftrace_location()
  - update the kprobes-on-ftrace/arch-support.txt in doc

Jisheng Zhang (3):
  kprobes/x86: use instruction_pointer and instruction_pointer_set
  kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
  arm64: implement KPROBES_ON_FTRACE

 .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/probes/Makefile             |  1 +
 arch/arm64/kernel/probes/ftrace.c             | 60 +++++++++++++++++++
 arch/x86/kernel/kprobes/ftrace.c              |  9 +--
 kernel/kprobes.c                              | 10 +++-
 6 files changed, 75 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/kernel/probes/ftrace.c

--=20
2.23.0.rc1

