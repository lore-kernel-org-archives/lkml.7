Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B67C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA04720851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="JwLa4Ncs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfHSLak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:30:40 -0400
Received: from mail-eopbgr740085.outbound.protection.outlook.com ([40.107.74.85]:47949
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfHSLak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:30:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK1FlxswQ8kAezrBj6bPAxCtGv8Pau8rl5LZHY0+AgtzK4/KMRtYBz1cAd6n2xMZW47RnmtLTk6lQwLQm7+RHMBhZXRHY+sr4h/VuM2coV3KC9lcs4AlQhZz+aExWbLkilcXJ/71qu1aVKPoH5OHD2GxeNYFwZBux6gwXMFc/kWMCOpbEJMZKUby1huoUxrMLzlAWLyAQ/tRGrZdv4+garD6js9+dencuyGOs8Ypyc4ROSlyhkHkgzHYYBFM35RboJ6l7GUIVwDZfeb2eTFX+QU0TGntkXtXAegTgguUwJXue//MIGWWDqxPnfyNpA4YrspDz98ZobAh/tOyTN35DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk3BS6QT18njK+oH/RHzZBrxjctEw656amqPTTStWNU=;
 b=aDd5XFkgX1+zlUUlbRTa7ERXEpXshPuHimTZmBoituspCIrriKPtWD6KB4lZQ4I0DYfAoiOfTFNKe8PmU3N0ydPI2T4tv3KjAaGzrZiHXEsX6aXeu+iZe/68kIXdVtoZ1jMdrBOXaa70vPIEDnEbIS2AYeL03dJonola2CDF7SFnf+KjNSCcBQTPeHdeiVCibeqL69WHJ1qzDwSmyW1OutBSuqIB66V5DJlXgdPmpG8pBCnUoHHb8SlaqyoiQWM+NI4V6gcNQ45nNTvaJfkhKjOY89NU7KPhmJqck08FDkirtiqvzupTY3iDp1FpfMi28ZK/hYjIHBOZNpWM7my4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk3BS6QT18njK+oH/RHzZBrxjctEw656amqPTTStWNU=;
 b=JwLa4Ncs7zcZPCM8duU5e2NJrJQwrdLpww+yLremy6Me0bnMBQ8XD5HkIcGyq3NSZMs7M0P6fEbPRrx0meHx+BpbXnNK9+wssEYzLNlxWQ0RqpeoNZWxZ9biK5yFvItHeT3wcGVdrgQ80xI6Z0Xe2WudCHsegLzyWYFrpXg3jxs=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3528.namprd03.prod.outlook.com (52.135.213.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 11:30:38 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 11:30:38 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH 1/3] ftrace: introdue ftrace_call_init
Thread-Topic: [PATCH 1/3] ftrace: introdue ftrace_call_init
Thread-Index: AQHVVoEOXDxpF53mfUS1paE9VVhs/acCUvOA
Date:   Mon, 19 Aug 2019 11:30:38 +0000
Message-ID: <20190819191935.406afa82@xhacker.debian>
References: <20190819191530.0f47b9b1@xhacker.debian>
        <20190819191622.57050fdf@xhacker.debian>
In-Reply-To: <20190819191622.57050fdf@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:405:1::31) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ec7748a-793d-4439-f6a9-08d72498a8a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3528;
x-ms-traffictypediagnostic: BYAPR03MB3528:
x-microsoft-antispam-prvs: <BYAPR03MB3528D04ABE0120AA0AF74DA3EDA80@BYAPR03MB3528.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(5660300002)(8936002)(50226002)(86362001)(81156014)(81166006)(71200400001)(71190400001)(6246003)(25786009)(486006)(476003)(8676002)(11346002)(14444005)(446003)(66446008)(64756008)(66556008)(66476007)(66946007)(1076003)(6512007)(66066001)(9686003)(26005)(6486002)(305945005)(99286004)(186003)(102836004)(2906002)(52116002)(54906003)(53936002)(3846002)(6116002)(316002)(256004)(4326008)(76176011)(14454004)(6506007)(386003)(229853002)(6436002)(7736002)(478600001)(110136005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3528;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DzRKUIpXEwFD3zBeSAQuVylhA14Ra67fkmQRyQzX9eutUsKossE6u05xv1Q3OMDkTBMCoS4Jd9XS9uA02VxIg5gv05XGIvJtKYmeqlf55I4B+uQMABaYrCK1rYB4IWxQNmIA2q1aBxoQ5dKo/cYIIk0Ki/3cvjpWzCQ4qwMhPFtUlhIhih6b2SAfEj3NPH2heAMrFekU3Pl/n0A9hUHmPuWNS3dETMvdkpI/4GwYx9/47fYPaeAzIJhMqdUVFqcb/kyMIhjsCDXA4ctoY71e8nhvS6e+7WWVnuYUVEIwIz8oEqs1rmhmlRquiozSYOOs36zDVfdM6PDLBKDg2X/1SPYsBtydwcaQC0lJ8q3n7R35gKt+StI6kkdo7qOEdQmQ0IloxsUEWMWTgroLj+H45JVEwjn6wOVmwJsQ4rBJAho=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <484B046BDB32D94E82E2E55F18ADAD69@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec7748a-793d-4439-f6a9-08d72498a8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 11:30:38.2203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzcoMmtaceTM9j3Rkqexoz4YVletoSn3d9Q3kgI73VlmjTlfRBwbTSlIj3jLsb1rGD8T4nCvpQVGrWPCRd7qeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 19:16:22 +0800 Jisheng Zhang wrote:

> On some arch, the FTRACE_WITH_REGS is implemented with gcc's
>  -fpatchable-function-entry (=3D2), gcc adds 2 NOPs at the beginning
> of each function, so this makes the MCOUNT_ADDR useless. In ftrace
> common framework, MCOUNT_ADDR is mostly used to "init" the nop, so
> let's introcude ftrace_call_init().
>=20
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  include/linux/ftrace.h | 1 +
>  kernel/trace/ftrace.c  | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 8a8cb3c401b2..8175ffb671f0 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -458,6 +458,7 @@ extern void ftrace_regs_caller(void);
>  extern void ftrace_call(void);
>  extern void ftrace_regs_call(void);
>  extern void mcount_call(void);
> +extern int ftrace_call_init(struct module *mod, struct dyn_ftrace *rec);
> =20
>  void ftrace_modify_all_code(int command);
> =20
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index eca34503f178..9df5a66a6811 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2500,7 +2500,11 @@ ftrace_code_disable(struct module *mod, struct dyn=
_ftrace *rec)
>  	if (unlikely(ftrace_disabled))
>  		return 0;
> =20
> +#ifdef MCOUNT_ADDR
>  	ret =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +#else
> +	ret =3D ftrace_call_init(mod, rec);
> +#endif

If we want to remove MCOUNT_ADDR from all arch, I could cook patches for
this.
