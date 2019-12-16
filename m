Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8025AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB8F206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ETVeOCVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfLPONC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:13:02 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38540 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfLPONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:13:01 -0500
Received: by mail-qv1-f65.google.com with SMTP id t6so2328749qvs.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mi7ftffFrqB3MIpnsGeNJ41kn2EGtdc3WEvbuGDojUA=;
        b=ETVeOCVsQIXPTANO0VbZSfJ6I3BzftLD/sO6uJZYJ1eoa1eHcI1CugMDBoCvaYEPkZ
         5FsGMuX5bO5Tuur0R1PRFTv00apn+5SQxIb5tkfnZzjlT7Ht5/cHztbpa1SinTrEVgaG
         B7gC7MCOPJZAIrl6G7nTnU2UPxZTn+rc8s8wKoSihEFQKfjXZE+ZANchaVTzzkN48cqF
         meTvQA9kB2RQqU7LjaoO/nG2M2gnP35RC15o85zb3bIuuw4ehv1hhbhR34jHhOc3QWmr
         DgdEuEfSotsu6aKyNHxoRB0m7aH+MIcD5jNzrfYlLw6vYsLeT6McUzp3RQBJ57fCP9vQ
         K3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mi7ftffFrqB3MIpnsGeNJ41kn2EGtdc3WEvbuGDojUA=;
        b=LXZIwhfVh27E0bIJcrJfSQFkXQll3jXeHqYFolp6nyhQSIaLtWksYbjL+S4l3023Fe
         TuxlHE0GNURO//7ib74HSKoLGOGpVDlq6q5iA7iordQePETeT4amnBVNB7sVuAj31gsA
         qv/dYhP9jNa3UdPH36BIJhlxiM7TxeQwqHF8GyPuz0Z1w0FFKzfxmd+1XDB9E7rxdhHn
         QqAX0yPjWcfdtimm2FdPV1BL/4FWmmomWpYtWkQtiOFpYXE2cXH9KuDV8AA1H2vS2uEZ
         4GY29JQBhOMWzDQYHyybQQjaCpUWHX9HrdCMHEZtUkpqzJ0O7gfQUzmrUPRrkXwgr8kq
         /nxw==
X-Gm-Message-State: APjAAAUkAWgvNUQC2eWj1tXg6MUmIMdqq0IESahX8WeoKyorGn96D25J
        +1PEW/iX4kzu6TSlGrZi4dphdA==
X-Google-Smtp-Source: APXvYqy30U1xUJPeEnRlbVlVmpesQ5tK8gBnBApYA59e/0ntyicHXPnbA9UeMOxAzwNzlGCZz6jVjA==
X-Received: by 2002:ad4:514e:: with SMTP id g14mr26937965qvq.196.1576505580506;
        Mon, 16 Dec 2019 06:13:00 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o7sm5978842qkd.119.2019.12.16.06.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:13:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] rcu: fix an infinite loop in rcu_gp_cleanup()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191215201646.GK2889@paulmck-ThinkPad-P72>
Date:   Mon, 16 Dec 2019 09:12:58 -0500
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, tj@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2AD3650-B814-48D1-89D0-BF2C56157DA1@lca.pw>
References: <20191215065242.7155-1-cai@lca.pw>
 <20191215201646.GK2889@paulmck-ThinkPad-P72>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 15, 2019, at 3:16 PM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Sun, Dec 15, 2019 at 01:52:42AM -0500, Qian Cai wrote:
>> The commit 82150cb53dcb ("rcu: React to callback overload by
>> aggressively seeking quiescent states") introduced an infinite loop
>> during boot here,
>>=20
>> // Reset overload indication for CPUs no longer overloaded
>> for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
>> 	rdp =3D per_cpu_ptr(&rcu_data, cpu);
>> 	check_cb_ovld_locked(rdp, rnp);
>> }
>>=20
>> because on an affected machine,
>>=20
>> rnp->cbovldmask =3D 0
>> rnp->grphi =3D 127
>> rnp->grplo =3D 0
>=20
> Your powerpc.config file from your first email shows:
>=20
> 	rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D128=

>=20
> So this should be the root rcu_node structure (as opposed to one of =
the
> eight leaf rcu_node structures, each of which should have the =
difference
> between rnp->grphi and rnp->grplo equal to 15).  And RCU should not be
> invoking for_each_leaf_node_cpu_mask() on this rcu_node structure.
>=20
>> It ends up with "cpu" is always 64 and never be able to get out of =
the
>> loop due to "cpu <=3D rnp->grphi". It is pointless to enter the loop =
when
>> the cpumask is 0 as there is no CPU would be able to match it.
>>=20
>> Fixes: 82150cb53dcb ("rcu: React to callback overload by aggressively =
seeking quiescent states")
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> kernel/rcu/rcu.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> index ab504fbc76ca..fb691ec86df4 100644
>> --- a/kernel/rcu/rcu.h
>> +++ b/kernel/rcu/rcu.h
>> @@ -363,7 +363,7 @@ static inline void rcu_init_levelspread(int =
*levelspread, const int *levelcnt)
>> 	((rnp)->grplo + find_next_bit(&(mask), BITS_PER_LONG, (cpu)))
>> #define for_each_leaf_node_cpu_mask(rnp, cpu, mask) \
>> 	for ((cpu) =3D rcu_find_next_bit((rnp), 0, (mask)); \
>> -	     (cpu) <=3D rnp->grphi; \
>> +	     (cpu) <=3D rnp->grphi && (mask); \
>> 	     (cpu) =3D rcu_find_next_bit((rnp), (cpu) + 1 - =
(rnp->grplo), (mask)))
>=20
> This change cannot be right, but has to be one of the better bug =
reports
> I have ever received, so thank you very much, greatly appreciated!!!
>=20
> So if I say the above change cannot be right, what change might work?
>=20
> Again, it would certainly be a bug to invoke =
for_each_leaf_node_cpu_mask()
> on anything but one of the leaf rcu_node structures, as you might =
guess
> from the name.  And as noted above, your dump of the rcu_node fields
> above looks like it is exactly that bug that happened.  So let's =
review
> the uses of this macro:
>=20
> kernel/rcu/tree.c:
>=20
> o	rcu_gp_cleanup() invokes for_each_leaf_node_cpu_mask() within a
> 	srcu_for_each_node_breadth_first() loop, which includes non-leaf
> 	rcu_node structures.  This is a bug!  Please see patch below.
>=20
> o	force_qs_rnp() is OK because for_each_leaf_node_cpu_mask() is
> 	invoked within a rcu_for_each_leaf_node() loop.
>=20
> kernel/rcu/tree_exp.h:
>=20
> o	rcu_report_exp_cpu_mult() invokes it on whatever rcu_node =
structure
> 	was passed in:
>=20
> 	o	sync_rcu_exp_select_node_cpus() also relies on its
> 		caller (via workqueues) to do the right thing.
>=20
> 		o	sync_rcu_exp_select_cpus() invokes
> 			sync_rcu_exp_select_node_cpus() from within a
> 			rcu_for_each_leaf_node() loop, so is OK.
>=20
> 		o	sync_rcu_exp_select_cpus() also invokes
> 			sync_rcu_exp_select_node_cpus() indirectly
> 			via workqueues, but also from within the same
> 			rcu_for_each_leaf_node() loop, so is OK.
>=20
> 	o	rcu_report_exp_rdp() invokes rcu_report_exp_cpu_mult()
> 		on the rcu_node structure corresponding to some
> 		specific CPU, which will always be a leaf rcu_node
> 		structure.
>=20
> Again, thank you very much for your testing and debugging efforts!
> I have queued the three (almost untested) patches below, the first of
> which I will fold into the buggy "rcu: React to callback overload by
> aggressively seeking quiescent states" patch, the second of which I =
will
> apply to prevent future bugs of this sort, even when running on small
> systems, and the third of which will allow me to easily run rcutorture
> tests on the larger systems that I have recently gained easy access =
to.
>=20
> And the big question...  Does the first patch clear up your hangs?  =
;-)
> Either way, please let me know!
>=20
> 							Thanx, Paul
>=20
> =
------------------------------------------------------------------------
>=20
> commit e8d6182b015bdd8221164477f4ab1c307bd2fbe9
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Sun Dec 15 10:59:06 2019 -0800
>=20
>    squash! rcu: React to callback overload by aggressively seeking =
quiescent states
>=20
>    [ paulmck: Fix bug located by Qian Cai. ]
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1d0935e..48fba22 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1760,10 +1760,11 @@ static void rcu_gp_cleanup(void)
> 		/* smp_mb() provided by prior unlock-lock pair. */
> 		needgp =3D rcu_future_gp_cleanup(rnp) || needgp;
> 		// Reset overload indication for CPUs no longer =
overloaded
> -		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
> -			rdp =3D per_cpu_ptr(&rcu_data, cpu);
> -			check_cb_ovld_locked(rdp, rnp);
> -		}
> +		if (rcu_is_leaf_node(rnp))
> +			for_each_leaf_node_cpu_mask(rnp, cpu, =
rnp->cbovldmask) {
> +				rdp =3D per_cpu_ptr(&rcu_data, cpu);
> +				check_cb_ovld_locked(rdp, rnp);
> +			}
> 		sq =3D rcu_nocb_gp_get(rnp);
> 		raw_spin_unlock_irq_rcu_node(rnp);
> 		rcu_nocb_gp_cleanup(sq);
>=20


This works fine.

Tested-by: Qian Cai <cai@lca.pw>

