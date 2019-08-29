Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D547C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5798D22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="hGwbx72J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH2HGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:06:18 -0400
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:40001
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfH2HGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7rUgn8n9PLJ2RCxN+znGewLOFYelGJqKC4QQmGLhe3czE/8bLBA6YyuubeHFQ6w68wQGtT3/d8lg2o+fbowV6GnPYzwrlj+Q83f6giopUChI6BzCM+1grLrE3i+uzwcVLJ/VOK05Fau1cXbAvWyoWnSNlbzXlLojf2MEZ3BlnKfTB2Qyae1niHOV9MDExspe173tSHqgUMghKWyROuZOZ4K4MNgH5mC/sfEqdSVOzjnGUT7THHuT70HJ/d8tjPVVAiuDg6i0DtLDJa7Vp3tOZ1yMuDI+xJhNKfI1oS8VEcuOSkc6yvxliYeAjbhhVwB53nlj4ZSZo5tQDe8Pb0mLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhjqkoP+cfgrle1wujUhgUnrxijhKHag89STP5ESqIQ=;
 b=Vmd4x1JpRtmtRtNYZsKdG83dsrxIyLU1eHiMXdujmGJDle1Dsy/QgczfizZgS6TSWho/u9so8f2WGO/BYVKkqNNxhsmo5AbFysALV/YIKKr9gtrhaQ2wyf93YrWLr/IWMS7ol5bkLvGR+dwj7laNimgu0KKdZkildapq58l446pQq1bWFzXyodDYYN7iQke709tFbAnR+LJRDS6LjoS7bQ298lMJ/vczs3B03Q1/cenNUqofgr3xjuedRlu6g/939DtWcEgoghda2D3vT/SccroygMyp37tyhPNeodeG3KY3xWaRFAqGTOjGnNDDT73hf8zU8yej1NiOnCVUpFAjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhjqkoP+cfgrle1wujUhgUnrxijhKHag89STP5ESqIQ=;
 b=hGwbx72J8WJIPTYa7h7tghXAWQGA9Juhaq+sC3Qa7XNxxGk08OHnOYwjDx44om5QMWBqcviTCYn4TJa71mYNf/LS7X1FmYNVJC9B3BlvmQRWB6P8XDnf7Gk6njlcpvCpp3eSpWeNwDXsn0usOWOGj4lBOgUlYqE7/gpqsG/CdH0=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4615.namprd03.prod.outlook.com (20.179.90.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 07:06:14 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::391b:4d0f:a377:41c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::391b:4d0f:a377:41c%4]) with mapi id 15.20.2220.013; Thu, 29 Aug 2019
 07:06:14 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ARM: ftrace: remove mcount(),ftrace_caller_old() and
 ftrace_call_old()
Thread-Topic: [PATCH v3] ARM: ftrace: remove mcount(),ftrace_caller_old() and
 ftrace_call_old()
Thread-Index: AQHVWZ46Zhc7nRpNpE6gOQZveSAqyqcRuhEA
Date:   Thu, 29 Aug 2019 07:06:14 +0000
Message-ID: <20190829145450.0c0f79ee@xhacker.debian>
References: <20190823182239.20f9a656@xhacker.debian>
In-Reply-To: <20190823182239.20f9a656@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:404:ce::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 403d50d5-6e35-4b3b-79a2-08d72c4f615f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4615;
x-ms-traffictypediagnostic: BYAPR03MB4615:
x-microsoft-antispam-prvs: <BYAPR03MB4615B1C499880BA23612201AEDA20@BYAPR03MB4615.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(446003)(99286004)(66946007)(11346002)(476003)(66446008)(64756008)(66556008)(66476007)(66066001)(8936002)(81166006)(8676002)(486006)(81156014)(478600001)(316002)(50226002)(14454004)(71190400001)(102836004)(1076003)(305945005)(386003)(110136005)(6506007)(7736002)(256004)(5660300002)(86362001)(54906003)(53936002)(6246003)(71200400001)(52116002)(186003)(9686003)(6512007)(229853002)(26005)(3846002)(6486002)(6116002)(6436002)(76176011)(25786009)(4326008)(2906002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4615;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uqddwuvsiIzFbYBHiRNz0mbrYMh6TeEdy3ln2qS1X1uaMuW+3uw12k/E3/RABf/K5G6ll6WW13ShHMgPeegWtw6L5bccyA1zwdeFra3tWgZ5xSxE0eSSvwf4Qh6xjM+dmYgOc5ja/p11L/z6UbHWi9m5XiAYdrFBziZY2HQqUXKdvZFxcWL+kVpA2QlDfDE8fr2QjdgAFn7DdsWF7nODnT4YFONXIJK1hL7XOcKc7ISIa4A4j3IZ48dz3evhLfiP8syjjNXx7KXhldldNkB9O9Yt798BYDyakLzZx9wllrkzvVJw74AhCyAoRHQltGg27xFB/wbemaBhSJkiPtIn3tDYBDEsamX9VJbkaYOYN8lDnV71TJzc8qwDkjvatzEqOIOA1nSUihApFZbSsz/2xp+ds9fwjaNI3A5CStnAPU4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D637AF53FFE02A4399732A3695A09051@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403d50d5-6e35-4b3b-79a2-08d72c4f615f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 07:06:14.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f75y4odESQK25U9EN+ypGTMoAn/n3R1Qg+hLePVxnBU9W/D2OTtunPyQ6H3SvQ1Flt68H/XSDDkqdlbqf7oxQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, 23 Aug 2019 18:22:39 +0800 Jisheng Zhang wrote:

> Commit d3c61619568c ("ARM: 8788/1: ftrace: remove old mcount support")
> removed the old mcount support, but forget to remove these three
> declarations. This patch removes them.

May I put this patch into your patch system?

thanks

>=20
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>=20
> Changes since v2:
>   - really remove mcount() declaration too. I made a mistake when sending=
 out v2
>=20
> Changes since v1:
>   - remove mcount() declaration too
>=20
>  arch/arm/include/asm/ftrace.h | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.=
h
> index 18b0197f2384..48ec1d0337da 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -11,7 +11,6 @@
>  #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
> =20
>  #ifndef __ASSEMBLY__
> -extern void mcount(void);
>  extern void __gnu_mcount_nc(void);
> =20
>  #ifdef CONFIG_DYNAMIC_FTRACE
> @@ -23,9 +22,6 @@ static inline unsigned long ftrace_call_adjust(unsigned=
 long addr)
>  	/* With Thumb-2, the recorded addresses have the lsb set */
>  	return addr & ~1;
>  }
> -
> -extern void ftrace_caller_old(void);
> -extern void ftrace_call_old(void);
>  #endif
> =20
>  #endif

