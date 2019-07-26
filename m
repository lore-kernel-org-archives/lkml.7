Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC9BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A4722BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="OVKdE3ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfGZVRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:17:06 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:29546 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfGZVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:17:05 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QLGNal025177;
        Fri, 26 Jul 2019 16:16:26 -0500
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2055.outbound.protection.outlook.com [104.47.50.55])
        by mx0b-00010702.pphosted.com with ESMTP id 2tx62hcmc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 16:16:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsAqpcDSYA2ueq++23HUeAjaA4mweIJz8Kwsr+K1uYZI/1n5+gyg/3C88S6I2edQ/gpPrHXPFkanZ8H3qwsUeBTJKp3S7fiqFKW15api6Evvi00G9bqHapH4zdYbjS6ys8OBcZJ0V+klxZUIljqihY8q0QfHvzzsSgv8PBaaXWGDoJEuB4nh3l8gNdWY2oVkxdoEYu7jGfTgd/kelhO1/nLEailCeL43hLBVHzjiyF2/9mFN6cgD1/KMuEu1u0xMUuyGOG3uQxszhONq5KUOoMnoIP/4IcHmuv8GnwmkXON8TixrdTmQdtaBipn0VNeGJ0DUj0Bhmib/l0Y14/a4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A070JKW8+r+89JUjaZLE8EOuyw5M/cBWczpMXFZUDM=;
 b=ZBqS6Y0jaN6EONz9zcytawooY6dhR8e2IVrnbcnrbifWwYMrH5FXdnZr448Ban0KriEyyYmwxwhINrlS8MQuq8/r6EpF4Hnq7O5wzorCWLvTLrjtbanfMt5YkdRzI/F/7V6D3XWycY+p2zJgvVlMgurlIGDjT7QpIX8CSKhVtF+sUlJZWHXfwfgEs33Sy6nNHddTkcerJfU6OM0Bn3O8on1+vV/z6Nu0On4eR9VZUN21xAiQ2Top/HetxUnXIC285hT/TRFGLn2CzBSmACODceYEO2Sl3OP+aKP7b69kAbWJ2tFSbtXcv9uQM29UdYh46TybJTdqwmhDcNNFX8msEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ni.com;dmarc=pass action=none header.from=ni.com;dkim=pass
 header.d=ni.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A070JKW8+r+89JUjaZLE8EOuyw5M/cBWczpMXFZUDM=;
 b=OVKdE3ca6CSbo+JHe+IpA1rbK7+CQx4CEvWpJDAHuGP4lDjUYR0Y8mr7gzDM/Ww9xsUgKIMYwAHJKm6f28++ZNIrDaQ965a6HlP0gx/k4jDqS+iY+oHFvWBKN7VVLyyq2eJ8vTWHT1CKOVPcW7Q9Klyj2tzewy2X8sQA8ou1LuU=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB0917.namprd04.prod.outlook.com (10.174.234.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Fri, 26 Jul 2019 21:16:24 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c926:1efe:9535:239c]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c926:1efe:9535:239c%5]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 21:16:24 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 10/12] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
Thread-Topic: [patch 10/12] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
Thread-Index: AQHVQ/dh1HRGZLegj0qJPzGPIhhepA==
Date:   Fri, 26 Jul 2019 21:16:24 +0000
Message-ID: <20190726211623.GP29109@jcartwri.amer.corp.natinst.com>
References: <20190726183048.982726647@linutronix.de>
 <20190726185753.645792403@linutronix.de>
In-Reply-To: <20190726185753.645792403@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0018.namprd02.prod.outlook.com
 (2603:10b6:803:2b::28) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bedf2b6-8e01-4380-f7f8-08d7120e83b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR04MB0917;
x-ms-traffictypediagnostic: BN6PR04MB0917:
x-microsoft-antispam-prvs: <BN6PR04MB09171E8743CFF5F72B9D826DF4C00@BN6PR04MB0917.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(136003)(54534003)(189003)(199004)(6506007)(6436002)(386003)(9686003)(6246003)(6512007)(53936002)(102836004)(2906002)(7736002)(6916009)(4326008)(6116002)(66066001)(25786009)(7416002)(478600001)(186003)(14454004)(3846002)(76176011)(316002)(33656002)(54906003)(5660300002)(26005)(8936002)(1076003)(486006)(8676002)(66446008)(81166006)(66476007)(81156014)(229853002)(68736007)(66556008)(71190400001)(476003)(71200400001)(305945005)(446003)(66946007)(11346002)(99286004)(64756008)(6486002)(14444005)(256004)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0917;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FGbpLaAjFaqOBIQ3xqM7ee4E2HyNqLdqMOMoPox6K8QVHxslHONbYLJwnjvz/YBkXWqMb9ISypKDk2F37Vdcjw6geJG1xubgeci72ZBJLATrTb+qESFihdOopIkEyXOGe9HeMYVn+yr1HdbbDD1p0vv0khdbqh+6tZ3Jv39NYkTyEK2tPR+miyheSogsM7uzuUB9fmnYrzEJFNQ7k/SZHfOlhOj3sICjuRFfIFuT0ws+IwzukUFmUKoeb7nDPj9SHpJLogK5lG6WtaJdfXYrq0DxVAEmxo2CLz3fTqOE5leknOv3m1zEycKftXhHa5bJgR/LrbisIcbP0Pb6ljFK5EZYlC1mRQtJqzhwih4xX1SdnEdiwY5ojXqb/LvJj0MSPf/0VVfbyoFhbwU1VlgpADbxSlTdRJOmCHXXGDooEzM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD57C7F721190D4299F5A828FE50DFB2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bedf2b6-8e01-4380-f7f8-08d7120e83b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 21:16:24.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: julia.cartwright@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0917
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_15:2019-07-26,2019-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 clxscore=1011 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1907260241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:30:58PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> On PREEMPT_RT enabled kernels hrtimers which are not explicitely marked f=
or
> hard interrupt expiry mode are moved into soft interrupt context either f=
or
> latency reasons or because the hrtimer callback takes regular spinlocks o=
r
> invokes other functions which are not suitable for hard interrupt context
> on PREEMPT_RT.
>=20
> The hrtimer_sleeper callback is RT compatible in hard interrupt context,
> but there is a latency concern: Untrusted userspace can spawn many thread=
s
> which arm timers for the same expiry time on the same CPU. On expiry that
> causes a latency spike due to the wakeup of a gazillion threads.
>=20
> OTOH, priviledged real-time user space applications rely on the low laten=
cy
> of hard interrupt wakeups. These syscall related wakeups are all based on
> hrtimer sleepers.
>=20
> If the current task is in a real-time scheduling class, mark the mode for
> hard interrupt expiry.
>=20
> [ tglx: Split out of a larger combo patch. Added changelog ]
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/hrtimer.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1662,6 +1662,30 @@ static enum hrtimer_restart hrtimer_wake
>  static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
>  				   clockid_t clock_id, enum hrtimer_mode mode)
>  {
> +	/*
> +	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
> +	 * marked for hard interrupt expiry mode are moved into soft
> +	 * interrupt context either for latency reasons or because the
> +	 * hrtimer callback takes regular spinlocks or invokes other
> +	 * functions which are not suitable for hard interrupt context on
> +	 * PREEMPT_RT.
> +	 *
> +	 * The hrtimer_sleeper callback is RT compatible in hard interrupt
> +	 * context, but there is a latency concern: Untrusted userspace can
> +	 * spawn many threads which arm timers for the same expiry time on
> +	 * the same CPU. That causes a latency spike due to the wakeup of
> +	 * a gazillion threads.
> +	 *
> +	 * OTOH, priviledged real-time user space applications rely on the
> +	 * low latency of hard interrupt wakeups. If the current task is in
> +	 * a real-time scheduling class, mark the mode for hard interrupt
> +	 * expiry.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
> +			mode |=3D HRTIMER_MODE_HARD;

Because this ends up sampling the tasks' scheduling parameters only at
the time of enqueue, it doesn't take into consideration whether or not
the task maybe holding a PI lock and later be boosted if contended by an
RT thread.

Am I correct in assuming there is an induced inversion here in this
case, because the deferred wakeup mechanism isn't part of the PI chain?

If so, is this just to be an accepted limitation at this point?  Is the
intent to argue this away as bad RT application design? :)

   Julia
