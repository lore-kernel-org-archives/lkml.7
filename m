Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB4C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89522184E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="KprtMxnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfGQAD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:03:26 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:19046 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728699AbfGQAD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:03:26 -0400
X-Greylist: delayed 1695 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 20:03:24 EDT
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6GMbY8G005262;
        Tue, 16 Jul 2019 18:34:14 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0b-00010702.pphosted.com with ESMTP id 2ts0cd3v49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Jul 2019 18:34:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAGQv87Dx4Ud/TGryXvggybSN5yBeYusBrUqlX8pYmceCE/kAEIT+3cfZ/suhnc77J7FDFzOgjyYSo6BIDsCB8ldhgE5fvWazFq1Tz7f0XdnsviEeIZOE6FzjtiO3ueRQhpi4b95NKM2Klj/w1WM9cHH0Uf8s7q1nvvt53bQk/G6DtzwNshQazAZAMH81kveeI0SJgTWGj8KocmYpj57twmJ/Wzx6Sw+UNsPKQRvV9eX5pYn6x6OYDhdhVQIjRTnNFoQ2VvuVS1WKc+oGff2fq0oOyOl8S8c2L6hVfCH2KTSIWgWWczixsK3I940cJCrPuO5TnWSDQ5acU5iiZiLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACKA5QUMgMdi9bEg3iKpoIBw867sr9JynpVCEAzBrHs=;
 b=Jm8XtaDJHpJCynXBEkmOEakgfVjnj6P03hx0+Qw2zHPUoOZoW2c5/33SF8eDAQHYVjl+UdzVNs0U1Y5hAf6h7GPzQfOmQoyD/UIQKW09gp1p2/Qp/TiAy506at3phCvHv7EfldluytkW9WpiBIu1uAhe+cNspH2xtGulMpKlL3Z6F5/ZQrUG38I/gkIvXmcJKG2y7GW4HpA9Lh1DRsJa/B9Ts1lhLM0cOfxNmBS2KNYySEZ91nJBnwnzgSpNtGmG+8KZGmn4weHbk9a50XiDkyBu9SjTs4FI2TM0waBYBFQ6Csu/pBYi+5YzWFtjsosbA/UVbD0TDnyrGPUYV8axaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ni.com;dmarc=pass action=none header.from=ni.com;dkim=pass
 header.d=ni.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACKA5QUMgMdi9bEg3iKpoIBw867sr9JynpVCEAzBrHs=;
 b=KprtMxnbWxgEKBup0iD+26VkMqSFaEgwNBOnGfbqe3UQ5yRDQDRllssmE4aDkFYnboSqxuil8LPZJq8kW06LnwBu/olMkEbj/8L9htchGnD2AC2WijkeRimWMtkQtBcfql6IsTYCkzwW7nONs1FTUfqmjU6Ji/2iOAD4+2XBZ/E=
Received: from CY4PR04MB1174.namprd04.prod.outlook.com (10.173.193.141) by
 CY4PR04MB0391.namprd04.prod.outlook.com (10.173.195.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 23:34:11 +0000
Received: from CY4PR04MB1174.namprd04.prod.outlook.com
 ([fe80::3965:b673:6fe2:ec65]) by CY4PR04MB1174.namprd04.prod.outlook.com
 ([fe80::3965:b673:6fe2:ec65%11]) with mapi id 15.20.2073.012; Tue, 16 Jul
 2019 23:34:11 +0000
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia.cartwright@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
Thread-Topic: [patch 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
Thread-Index: AQHVPCxqjN1gTw20x0CHnz8f0oe2E6bN5ZQA
Date:   Tue, 16 Jul 2019 23:34:11 +0000
Message-ID: <87tvblr1u7.fsf@ni.com>
References: <20190715150402.798499167@linutronix.de>
 <20190715150601.205143057@linutronix.de>
In-Reply-To: <20190715150601.205143057@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0046.prod.exchangelabs.com (2603:10b6:800::14) To
 CY4PR04MB1174.namprd04.prod.outlook.com (2603:10b6:903:bb::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e148b2d-19c5-4851-5d9d-08d70a461afe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR04MB0391;
x-ms-traffictypediagnostic: CY4PR04MB0391:
x-microsoft-antispam-prvs: <CY4PR04MB0391625C1136820E8C6BFCCFFECE0@CY4PR04MB0391.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(86362001)(256004)(5640700003)(6916009)(6486002)(486006)(478600001)(2906002)(3846002)(6116002)(36756003)(25786009)(6246003)(4326008)(71200400001)(476003)(229853002)(66476007)(71190400001)(81156014)(2351001)(5660300002)(76176011)(6506007)(316002)(44832011)(8676002)(11346002)(386003)(52116002)(2616005)(446003)(26005)(102836004)(54906003)(7736002)(305945005)(2501003)(68736007)(186003)(8936002)(7416002)(99286004)(66066001)(66446008)(6512007)(6436002)(53936002)(81166006)(66556008)(66946007)(14454004)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0391;H:CY4PR04MB1174.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hti5y4FSAnckhHxTlcKjcrmB+pMPRvj8MTOZP1wR/r/zMDu2aDqmz1dnWP1yCZ2u92THpWCBrjkA7ZQh+1X6uSDzB+XhPznU0cbTozViJiAHQypG/f81M5mfcps0hM6KBzrWKGsKsn7fQF3GxUb9G0pSOGHRNZ2punyM97XftlDliO59iqfHrg/pw/t9lk9A+dUpNLpsHXMp54iFQHOHj27v+IAszyvOPPKwT2pd3AZf+M7xV5DjSmdMgwzW0qKXFYaMpBCPg/B3pI6YrKjRZAjNhTcAna25ic5tURQBESxEHpKXRWVNjOneK/k13cSrscl/IiyTodadgpQntJauMS2mt50XxjPR+2gb2XECxzCpdE2ILEAMHpBIJzstOBtR174fMg3JRFnGznSWMGkvQqPpxjQJUhuK0oOoZ9X/aAI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e148b2d-19c5-4851-5d9d-08d70a461afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 23:34:11.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gratian.crisan@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0391
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-16_06:2019-07-16,2019-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 clxscore=1011 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 suspectscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1904300001 definitions=main-1907160261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner writes:

> Add a new entry to the preemption menu which enables the real-time suppor=
t
> for the kernel. The choice is only enabled when an architecture supports
> it.
>
> It selects PREEMPT as the RT features depend on it. To achieve that the
> existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT as
> well.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

+1 from National Instruments. We have a vested interest in preempt_rt
and we're committed in helping support, maintain, and test it. Glad to
see this happening.

Acked-by: Gratian Crisan <gratian.crisan@ni.com>

Thanks,
    Gratian

> ---
>  arch/Kconfig           |    3 +++
>  kernel/Kconfig.preempt |   25 +++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -809,6 +809,9 @@ config ARCH_NO_COHERENT_DMA_MMAP
>  config ARCH_NO_PREEMPT
>  	bool
>
> +config ARCH_SUPPORTS_RT
> +	bool
> +
>  config CPU_NO_EFFICIENT_FFS
>  	def_bool n
>
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -35,10 +35,10 @@ config PREEMPT_VOLUNTARY
>
>  	  Select this if you are building a kernel for a desktop system.
>
> -config PREEMPT
> +config PREEMPT_LL
>  	bool "Preemptible Kernel (Low-Latency Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> -	select PREEMPT_COUNT
> +	select PREEMPT
>  	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>  	help
>  	  This option reduces the latency of the kernel by making
> @@ -55,7 +55,28 @@ config PREEMPT
>  	  embedded system with latency requirements in the milliseconds
>  	  range.
>
> +config PREEMPT_RT
> +	bool "Fully Preemptible Kernel (Real-Time)"
> +	depends on EXPERT && ARCH_SUPPORTS_RT
> +	select PREEMPT
> +	help
> +	  This option turns the kernel into a real-time kernel by replacing
> +	  various locking primitives (spinlocks, rwlocks, etc) with
> +	  preemptible priority-inheritance aware variants, enforcing
> +	  interrupt threading and introducing mechanisms to break up long
> +	  non-preemtible sections. This makes the kernel, except for very
> +	  low level and critical code pathes (entry code, scheduler, low
> +	  level interrupt handling) fully preemtible and brings most
> +	  execution contexts under scheduler control.
> +
> +	  Select this if you are building a kernel for systems which
> +	  require real-time guarantees.
> +
>  endchoice
>
>  config PREEMPT_COUNT
>         bool
> +
> +config PREEMPT
> +       bool
> +       select PREEMPT_COUNT
