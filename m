Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B49CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A217A20862
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfKARjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:39:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbfKARjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:39:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42A70B31C;
        Fri,  1 Nov 2019 17:39:38 +0000 (UTC)
Date:   Fri, 1 Nov 2019 18:39:36 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/numa: advanced per-cgroup numa statistic
Message-ID: <20191101173936.GB16165@blackbody.suse.cz>
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <682ed1d4-abf1-92f6-851f-567ff9b9a841@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <682ed1d4-abf1-92f6-851f-567ff9b9a841@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Yun.

On Tue, Oct 29, 2019 at 03:57:20PM +0800, =E7=8E=8B=E8=B4=87 <yun.wang@linu=
x.alibaba.com> wrote:
> +static void update_numa_statistics(struct cfs_rq *cfs_rq)
> +{
> +	int idx;
> +	unsigned long remote =3D current->numa_faults_locality[3];
> +	unsigned long local =3D current->numa_faults_locality[4];
> +
> +	cfs_rq->nstat.jiffies++;
This statistics effectively doubles what
kernel/sched/cpuacct.c:cpuacct_charge() does (measuring per-cpu time).
Hence it seems redundant.

> +
> +	if (!remote && !local)
> +		return;
> +
> +	idx =3D (NR_NL_INTERVAL - 1) * local / (remote + local);
> +	cfs_rq->nstat.locality[idx]++;
IIUC, the mechanism numa_faults_locality values, this statistics only
estimates the access locality based on NUMA balancing samples, i.e.
there exists more precise source of that information.

All in all, I'd concur to Mel's suggestion of external measurement.

Michal

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl28bdQACgkQia1+riC5
qSiRFw//R5yv0tgBXXcfvqhHwDcn/waKeDP2e/3VKcsH/TfbcFdp+4Eeg7kCP0K0
gPcTtP14kcPeErMHO71TrQLsI5BxdBY1wxgCNiy6NeEplBNGCqcMuz8y6bXC4Fng
19xxbh4OQcyvIIbbU+zYzIBHmL3I0cwznk5pgNQSde1mfThRj1AcYjvLAR/c1RIQ
WfpcYJS6SGWA+VrgX1SEC4X3Fz7tDBb6cES3TFAN8+L75FCfO8qffd2xyTz73FYH
cDZrqErKbb1h5RoS08cOltw9F1M9KCr6sMHxosAlvvEX97fqTUsflN/RgnRWy3Vo
vqUraPlbN5XmTxDNUqN+SOuC6yfj9SvBdd2ya4BcO7tcgCF98VgdZuj2zHAWC+nf
UtKgfEHXOnMKGxJs8R5l+XULVx10ul9b6EszPtp5Ipruk8haXhNhy/xM2EDHLxph
bYxlzTomuvXYYCKVu8hmwXTGPRUnI5LnLBrCE37q7XcQGNyeEIy5qt/hoR0zwdJK
r/kBqFC4QaL7BWjO02YH1I9EfcZGU75tnGFjGIobMb15MAt4+q2bLe1J/ptlTiUl
qcJdMP0Kc3I9y1f5rbi0FAj12VbgzTTSYzPoCSfzOHFvam+sXnXLPVdEusEa3dM5
wBzqvHo5+Rn+sSAGZRXpyNN94tnGZiLM3Xm89TeyUNDIdyRBRD4=
=PaRy
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
