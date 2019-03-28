Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA325C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B02064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="e9IQL+46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfC1Smv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:42:51 -0400
Received: from mail-eopbgr780139.outbound.protection.outlook.com ([40.107.78.139]:62112
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfC1Smv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uzUQsUJ6tPn/o5/o02t6aqYJdl0ciWfrIXTTeXtZ7c=;
 b=e9IQL+46B4viC069cTtwor1FfwQ5mzB7lwlZ9M82TnTYNRHvtasAU+aL7H4CFyPlc47ekTcSYIYIubcozCa+kKCR3Y5dg95vzyZMStUNSIA1z4Iqhh6thhrJIMbBm7XZqIh5qIpMxLbLMXZkDS38JZuPMjb+EhZkcGHzB6nFcOU=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.214.23) by
 CY4PR2201MB1398.namprd22.prod.outlook.com (10.171.210.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 28 Mar 2019 18:42:48 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::3814:18cc:d558:6039]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::3814:18cc:d558:6039%11]) with mapi id 15.20.1730.019; Thu, 28 Mar
 2019 18:42:48 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH fixes] MIPS: perf: Fix build with CONFIG_CPU_BMIPS5000
 enabled
Thread-Topic: [PATCH fixes] MIPS: perf: Fix build with CONFIG_CPU_BMIPS5000
 enabled
Thread-Index: AQHU4/Xm66kUt/wyf0OS9JvhPam+e6YhZCYA
Date:   Thu, 28 Mar 2019 18:42:47 +0000
Message-ID: <20190328184245.43siejnjlvv6oyue@pburton-laptop>
References: <20190326170335.8031-1-f.fainelli@gmail.com>
In-Reply-To: <20190326170335.8031-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:40::37) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:6e::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a288a8e9-e621-4dbe-1852-08d6b3ad2c6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1398;
x-ms-traffictypediagnostic: CY4PR2201MB1398:
x-microsoft-antispam-prvs: <CY4PR2201MB1398279DF70780A607604D16C1590@CY4PR2201MB1398.namprd22.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(136003)(346002)(366004)(39840400004)(51444003)(199004)(189003)(6246003)(11346002)(46003)(102836004)(4326008)(446003)(386003)(6506007)(186003)(256004)(105586002)(53936002)(106356001)(42882007)(33716001)(9686003)(58126008)(81166006)(81156014)(316002)(76176011)(68736007)(97736004)(54906003)(8676002)(6512007)(44832011)(229853002)(71190400001)(1076003)(99286004)(7416002)(71200400001)(52116002)(8936002)(14454004)(6116002)(6486002)(478600001)(7736002)(5660300002)(25786009)(476003)(6436002)(2906002)(486006)(305945005)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1398;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CrNT15OXLmMi0+wYv+b9ttRaPKgYS1l8MeXsHrSSTreafCBZuEE6G6zGw8ZwGyyMO09AoqJR9RpPhPyX8KXfY+mKvF8i9pps3M6QIco2b6sEygDs0r1Z57wEdC2b+5R1xwj3XYjE1f/KxolnFCQRb8ea8JU9remNjC1rsdFuIEhcQIGLDtsgVTecSDM4/v3WSqfSmrHPJk5pwMDSEhOj1VXZLXIhozuuDcFYurZfsFg5In8fMclU1TQPpKX4Q9xR6wJ7FNdywYvzyXhA+BPPFbU7ANVi95jIqwSXIusw8u2/+gFABhgo9FjNK8H+Da/+6ZGaWbdSbAYcm7qpE/oOiQKHBSZFS7zT8JSfX4cPsXm82CaiXGCz7dq5UlAfa0UGdj2SXtAzHaVIYxqHcP2WxNHI1mfjfwcoK/uuljDrKB0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DD929C52977A14A86E2AA4F8A613023@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a288a8e9-e621-4dbe-1852-08d6b3ad2c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 18:42:47.8566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, Mar 26, 2019 at 10:03:34AM -0700, Florian Fainelli wrote:
> The 'event' variable may be unused in case only CONFIG_CPU_BMIPS5000
> being enabled:
>=20
> arch/mips/kernel/perf_event_mipsxx.c: In function 'mipsxx_pmu_enable_even=
t':
> arch/mips/kernel/perf_event_mipsxx.c:326:21: error: unused variable 'even=
t' [-Werror=3Dunused-variable]
>   struct perf_event *event =3D container_of(evt, struct perf_event, hw);
>                      ^~~~~

Ah - nice catch :)

Could we fix it by replacing the existing #ifdef with an

  if (IS_ENABLED(CONFIG_CPU_BMIPS5000)) {

instead? The same could be done for the CONFIG_MIPS_MT_SMP #ifdefs too.

I think that would leave us with more readable code.

Thanks,
    Paul

> Fixes: 84002c88599d ("MIPS: perf: Fix perf with MT counting other threads=
")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/kernel/perf_event_mipsxx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf=
_event_mipsxx.c
> index 413863508f6f..739b7ff9fdab 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -323,7 +323,9 @@ static int mipsxx_pmu_alloc_counter(struct cpu_hw_eve=
nts *cpuc,
> =20
>  static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
>  {
> +#ifndef CONFIG_CPU_BMIPS5000
>  	struct perf_event *event =3D container_of(evt, struct perf_event, hw);
> +#endif
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>  #ifdef CONFIG_MIPS_MT_SMP
>  	unsigned int range =3D evt->event_base >> 24;
> --=20
> 2.17.1
>=20
