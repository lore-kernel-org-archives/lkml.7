Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BBEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EADC20854
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgFajdyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfH0XxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:53:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37950 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfH0XxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:53:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id u190so832174qkh.5;
        Tue, 27 Aug 2019 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62Da4VoiWrfMznig2bpZ/BzyHOak3Fv+Hl76QRWvvrw=;
        b=QgFajdyOlwo7Sww75zaQ9xj8gLTKCSmVmf1qxDOHiLm5wZnv2lqBdMbnO6rEk7Q+ft
         bKy6vh4uo5vRpOS+1NCtIWihyyw651Aurs/GErYH41DzW9HIHFwYHMONhXruZGi//IIF
         fSb/phKHzFRfd/WTRGtzoBg5DjliZ0s5IKw4gy2Q+2BAHCr5ful82wgSEydxkiJpM3Z5
         CdsflsVMAhOETyW2H0S7k8fTmZYmrrDeRTEa1MF2Edr2rMHtP4YW1kIVNSx2B/XQSXeI
         CAxcIuomc8sfMj4ujaaXi8ZseVYuYDK3KCTnzDuc7a92r3B+l64IJw7prrjMTqeICOPU
         tGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62Da4VoiWrfMznig2bpZ/BzyHOak3Fv+Hl76QRWvvrw=;
        b=J30rYJHFrmxwNZM1w7cJZoJ2C6OXWWDadR4f4ZvhXnhnhdDT1OyzerZx7CbDLpX2zd
         srtrN/CAublWVwr3I0lHyd0eTa1sRPmbc/1wIBjMRFAMOn0/3mNNLRRyF40MeLHdP9j6
         Ntp+AIKU1pUBuawV+xMK9q0GufbUHQlcz0yWdundXMnAoOkA23Yug9h5tKSLulqd2AkF
         QtXF3HqWYmMNCtp1fkC2VcCI/sXGQp7UtrDMh0ZZgX5oNXEk6YBSKXeWSGBMcPSlENg2
         uEqyBKHHE6Mt65TBl85sOtPJp4SQx9VvNP2U8G9yP6oXL94i4yWVFwl6h7417qTccRSb
         rASg==
X-Gm-Message-State: APjAAAW6OvxzC+XPO2bDT1CqsGEpNsbxdx8CtxAH+6Ys7VwIsKWhHd4u
        GbQwUNEz+7WlSk1voeEUIJI=
X-Google-Smtp-Source: APXvYqyWMD4DmPS8F9zRPWw5c+G9/7g/ABg7gIVxS4xHMXn495wvUhO9Sg/dMoJzJLeenjKF7Ofp1A==
X-Received: by 2002:a05:620a:6c3:: with SMTP id 3mr1258457qky.379.1566949980949;
        Tue, 27 Aug 2019 16:53:00 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q62sm475969qkb.69.2019.08.27.16.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 16:52:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2DA2F21E44;
        Tue, 27 Aug 2019 19:52:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Aug 2019 19:52:59 -0400
X-ME-Sender: <xms:WcJlXfSO8JHx3_BktiZaZ5KtujS5lvO7XJPUSaCk9E3vchvbO-nNJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepge
    ehrdefvddruddvkedruddtleenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:WcJlXWAfy7Mf8XXr2Cg8UXPs1NhgUqmp8ewymkzdeuexs2xXpwWfcQ>
    <xmx:WcJlXWg7wBDO5UOaeD1GMS-0T_Pmv2Hxlk-bAD6nsEhkAWUduCpZVw>
    <xmx:WcJlXXOxYf8zehK0dSIGiQaXHrzbY3VQrvaheF7MMe1ge8vbLCoZVA>
    <xmx:W8JlXdkFXHoRJTHitDY7v7MhOcxv5lcEB62qECiMy8Mvvtf7so8c4ifNjXo>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id D489D80064;
        Tue, 27 Aug 2019 19:52:56 -0400 (EDT)
Date:   Wed, 28 Aug 2019 07:52:53 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 2/5] rcu/tree: Add multiple in-flight batches of
 kfree_rcu work
Message-ID: <20190827235253.GB30253@tardis>
References: <5d657e35.1c69fb81.54250.01de@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <5d657e35.1c69fb81.54250.01de@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Tue, Aug 27, 2019 at 03:01:56PM -0400, Joel Fernandes (Google) wrote:
> During testing, it was observed that amount of memory consumed due
> kfree_rcu() batching is 300-400MB. Previously we had only a single
> head_free pointer pointing to the list of rcu_head(s) that are to be
> freed after a grace period. Until this list is drained, we cannot queue
> any more objects on it since such objects may not be ready to be
> reclaimed when the worker thread eventually gets to drainin g the
> head_free list.
>=20
> We can do better by maintaining multiple lists as done by this patch.
> Testing shows that memory consumption came down by around 100-150MB with
> just adding another list. Adding more than 1 additional list did not
> show any improvement.
>=20
> Suggested-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 64 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 19 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4f7c3096d786..9b9ae4db1c2d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2688,28 +2688,38 @@ EXPORT_SYMBOL_GPL(call_rcu);
> =20
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (HZ / 50)
> +#define KFREE_N_BATCHES 2
> +
> +struct kfree_rcu_work {
> +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> +	 * is done after a grace period.
> +	 */
> +	struct rcu_work rcu_work;
> +
> +	/* The list of objects that have now left ->head and are queued for
> +	 * freeing after a grace period.
> +	 */
> +	struct rcu_head *head_free;
> +
> +	struct kfree_rcu_cpu *krcp;
> +};
> +static DEFINE_PER_CPU(__typeof__(struct kfree_rcu_work)[KFREE_N_BATCHES]=
, krw);
> =20

Why not

	static DEFINE_PER_CPU(struct kfree_rcu_work[KFREE_N_BATCHES], krw);

here? Am I missing something?

Further, given "struct kfree_rcu_cpu" is only for defining percpu
variables, how about orginazing the data structure like:

	struct kfree_rcu_cpu {
		...
		struct kfree_rcu_work krws[KFREE_N_BATCHES];
		...
	}

This could save one pointer in kfree_rcu_cpu, and I think it provides
better cache locality for accessing _cpu and _work on the same cpu.

Thoughts?

Regards,
Boqun


>  /*
>   * Maximum number of kfree(s) to batch, if this limit is hit then the ba=
tch of
>   * kfree(s) is queued for freeing after a grace period, right away.
>   */
>  struct kfree_rcu_cpu {
> -	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> -	 * is done after a grace period.
> -	 */
> -	struct rcu_work rcu_work;
> =20
>  	/* The list of objects being queued in a batch but are not yet
>  	 * scheduled to be freed.
>  	 */
>  	struct rcu_head *head;
> =20
> -	/* The list of objects that have now left ->head and are queued for
> -	 * freeing after a grace period.
> -	 */
> -	struct rcu_head *head_free;
> +	/* Pointer to the per-cpu array of kfree_rcu_work structures */
> +	struct kfree_rcu_work *krwp;
> =20
> -	/* Protect concurrent access to this structure. */
> +	/* Protect concurrent access to this structure and kfree_rcu_work. */
>  	spinlock_t lock;
> =20
>  	/* The delayed work that flushes ->head to ->head_free incase ->head
> @@ -2730,12 +2740,14 @@ static void kfree_rcu_work(struct work_struct *wo=
rk)
>  {
>  	unsigned long flags;
>  	struct rcu_head *head, *next;
> -	struct kfree_rcu_cpu *krcp =3D container_of(to_rcu_work(work),
> -					struct kfree_rcu_cpu, rcu_work);
> +	struct kfree_rcu_work *krwp =3D container_of(to_rcu_work(work),
> +					struct kfree_rcu_work, rcu_work);
> +	struct kfree_rcu_cpu *krcp;
> +
> +	krcp =3D krwp->krcp;
> =20
>  	spin_lock_irqsave(&krcp->lock, flags);
> -	head =3D krcp->head_free;
> -	krcp->head_free =3D NULL;
> +	head =3D xchg(&krwp->head_free, NULL);
>  	spin_unlock_irqrestore(&krcp->lock, flags);
> =20
>  	/*
> @@ -2758,19 +2770,28 @@ static void kfree_rcu_work(struct work_struct *wo=
rk)
>   */
>  static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  {
> +	int i =3D 0;
> +	struct kfree_rcu_work *krwp =3D NULL;
> +
>  	lockdep_assert_held(&krcp->lock);
> +	while (i < KFREE_N_BATCHES) {
> +		if (!krcp->krwp[i].head_free) {
> +			krwp =3D &(krcp->krwp[i]);
> +			break;
> +		}
> +		i++;
> +	}
> =20
> -	/* If a previous RCU batch work is already in progress, we cannot queue
> +	/* If both RCU batches are already in progress, we cannot queue
>  	 * another one, just refuse the optimization and it will be retried
>  	 * again in KFREE_DRAIN_JIFFIES time.
>  	 */
> -	if (krcp->head_free)
> +	if (!krwp)
>  		return false;
> =20
> -	krcp->head_free =3D krcp->head;
> -	krcp->head =3D NULL;
> -	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
> -	queue_rcu_work(system_wq, &krcp->rcu_work);
> +	krwp->head_free =3D xchg(&krcp->head, NULL);
> +	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
> +	queue_rcu_work(system_wq, &krwp->rcu_work);
> =20
>  	return true;
>  }
> @@ -3736,8 +3757,13 @@ static void __init kfree_rcu_batch_init(void)
> =20
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp =3D per_cpu_ptr(&krc, cpu);
> +		struct kfree_rcu_work *krwp =3D &(per_cpu(krw, cpu)[0]);
> +		int i =3D KFREE_N_BATCHES;
> =20
>  		spin_lock_init(&krcp->lock);
> +		krcp->krwp =3D krwp;
> +		while (i--)
> +			krwp[i].krcp =3D krcp;
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  	}
>  }
> --=20
> 2.23.0.187.g17f5b7556c-goog
>=20

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl1lwk8ACgkQSXnow7UH
+rhalQf8DhiJrpTUoJOh4AwsvFgbpjnsVsc0ctc/kZnfs+6XpFzsip5W3R98SxrB
grZbztfpEuQPWzfp2MUYi8IwvMSlpIHcPnmIFG053ci3z69Ia6cr8OifncYRrxN0
4Fh9FUIElfclYtmehI58Bk+deDAnwsNpbsQU66K/BxmVfnSI3D1Ao7WrgO+Ho8ki
cNUGmI1CaPMuQLL9mFYFdTAyZzZZnO+ksjPUV0Q77nnWLuCdo48o2yn39E7LiVnT
3DjFLKxxm2caOQ9a4hOoKnsSNWhaaa5nJi1x6ai+7eR8txBmdXn+ge0eI2zjMt5v
bIEf82XoWz6t0X29DOhSONb+Kzz5sw==
=Jm0/
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
