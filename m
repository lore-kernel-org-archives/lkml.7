Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6FFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0577208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Rixn7JO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfDXVSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:18:08 -0400
Received: from mail-eopbgr700131.outbound.protection.outlook.com ([40.107.70.131]:57760
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfDXVSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FNHu7STlgRUsp2CHIOwFw8IunPHoKHttFHXSQTsUg0=;
 b=Rixn7JO0H0mTlQqqBFSJQlSGKn9EHPEmfX+CBorcRu8fvN+XDMfLgsuLreNR8o2W3plgOZ5+qU3J7092Zc3igIqSIjvk9YIffvZdg6Z7gVYwan/uROz7MxdQTmhWDWgvg5X4VOWeDhsvOt6enyswg1SC/qoLkn5SzrOl0C61Lcs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1117.namprd22.prod.outlook.com (10.174.169.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Wed, 24 Apr 2019 21:18:05 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:18:05 +0000
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
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>
Subject: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
Thread-Topic: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
Thread-Index: AQHU+pv2IxeIXeF+7U+aGuCeCnVQmKZL0SqA
Date:   Wed, 24 Apr 2019 21:18:04 +0000
Message-ID: <20190424211759.52xraajqwudc2fza@pburton-laptop>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
In-Reply-To: <20190424124421.636767843@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc895fc8-a46a-4d7d-56df-08d6c8fa56eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1117;
x-ms-traffictypediagnostic: MWHPR2201MB1117:
x-microsoft-antispam-prvs: <MWHPR2201MB1117D118F47D877930F6A62CC13C0@MWHPR2201MB1117.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39840400004)(376002)(136003)(396003)(366004)(52314003)(189003)(199004)(102836004)(6486002)(476003)(81156014)(2906002)(316002)(81166006)(8676002)(6436002)(26005)(446003)(6512007)(58126008)(4326008)(8936002)(68736007)(5660300002)(11346002)(9686003)(52116002)(6916009)(14454004)(386003)(6506007)(97736004)(66946007)(66446008)(64756008)(66556008)(66476007)(229853002)(73956011)(76176011)(478600001)(256004)(1076003)(14444005)(66066001)(186003)(42882007)(7416002)(305945005)(7736002)(33716001)(54906003)(99286004)(71190400001)(25786009)(71200400001)(44832011)(3846002)(6116002)(6246003)(486006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1117;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oRediic0OcGisYNJxM1m8clUOertP0F8UGQNbhcnKTjsSIfM0qmJFEzHKtumT1TnbxdVoiGPWHJaopadSPGplHweRtHvVPRTNUWpi5FrWQ6mjLbaWxsX6NxfZIsfKSFqa/k5o8ZluMQYeCn5oUAD2ljuNcdbBa0ZF1o4nnfePHjV59DHtSv4fs10e1skzJRlffxeiDHJ5ctO6D4C1yq6hlqEYutN7TKqLeyfvTk0w9xem8pZNkJvxqYQBnWzuoQKrNpM6hP+AJsQWsJpVxrg+6mqzsoXNX1YKO/GLo0mrZ+1DbALdOzcVVSX9qvUpbO2JRCoBvuLB8051mRj/s374GXcMcFYrUXQj9sePp29sLE1daPCzLb9q5xJEKJ6Kc6RJ6G/oqvpWzWoacCd1Aa0qMhYmlLuYpJCORjPIOVEu60=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDD116FC8C4C8A4F89887538B96636B8@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc895fc8-a46a-4d7d-56df-08d6c8fa56eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:18:04.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Apr 24, 2019 at 02:36:58PM +0200, Peter Zijlstra wrote:
> The comment describing the loongson_llsc_mb() reorder case doesn't
> make any sense what so ever. Instruction re-ordering is not an SMP
> artifact, but rather a CPU local phenomenon. This means that _every_
> LL/SC loop needs this barrier right in front to avoid the CPU from
> leaking a memop inside it.

Does it?

The Loongson bug being described here causes an sc to succeed
erroneously if certain loads or stores are executed between the ll &
associated sc, including speculatively. On a UP system there's no code
running on other cores to race with us & cause our sc to fail - ie. sc
should always succeed anyway, so if the bug hits & the sc succeeds
what's the big deal? It would have succeeded anyway. At least that's my
understanding based on discussions with Loongson engineers a while ago.

Having said that, if you have a strong preference for adding the barrier
in UP systems anyway then I don't really object. It's not like anyone's
likely to want to run a UP kernel on the affected systems, nevermind
care about a miniscule performance impact.

One possibility your change could benefit would be if someone ran Linux
on a subset of cores & some non-Linux code on other cores, in which case
there could be something to cause the sc to fail. I've no idea if that's
something these Loongson systems ever do though.

> For the branch speculation case; if futex_atomic_cmpxchg_inatomic()
> needs one at the bne branch target, then surely the normal
> __cmpxch_asmg() implementation does too. We cannot rely on the

s/cmpxch_asmg/cmpxchg_asm/

> barriers from cmpxchg() because cmpxchg_local() is implemented with
> the same macro, and branch prediction and speculation are, too, CPU
> local.

Similar story - cmpxchg_local() ought not have have CPUs racing for
access to the memory in question. Having said that I don't know the
details of when Loongson clears LLBit (ie. causes an sc to fail), so if
it does that on based upon access to memory at a larger granularity than
the 32b or 64b value being operated on then that could be a problem so
I'm pretty happy with adding these barriers.

Thanks,
    Paul
