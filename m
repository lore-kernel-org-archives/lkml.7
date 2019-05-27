Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A9C28CBF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D8521707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hEev7QfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE0AxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 20:53:08 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39897 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfE0AxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 20:53:08 -0400
Received: by mail-ua1-f65.google.com with SMTP id 79so5848155uav.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 17:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tetwU88W86xd3qxoZ4slgsmGudl9PUA8gEHz0OF4TME=;
        b=hEev7QfZZUGXyw3NxaWZVFf+1xoSorD06IO4vPTOSC/rSxUDfzzO6z77wfFN5b2XF3
         RBckklc56POGWQds3IczXrU8xX/E5T4kUWWJbUY+TowRc7TvxokVLsNOBlA/iipFBnj8
         IyowAIPdvWQD4XJews4Jey7Dtzkm5lXp0ulrGfqhYPL5aablLe/3LlXypHct6OUSbdqB
         oyPZDoVVXuijnDRoAbm+yINbFRXqWUtIjzQYzK5G1CSZB5Ogw8PnqWYM9o1KX/ZxhXYl
         Yk21G7sUFFIWCnKrAvDwnCzefM/R509T1XX9+iksPzh0C3Lu4XgnG2Tf7ZOpT/NIuED5
         lacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tetwU88W86xd3qxoZ4slgsmGudl9PUA8gEHz0OF4TME=;
        b=VgcPZBNZnQO7vaXF3V8PN5Ux8+0Jxo0CgOGoILrER96FpX90PGrOdOzXn92DHPWwIQ
         MmN3GstK5/TKDROJD0UB2rMTmMEaiedXSFU13+bDKr4qVqIp/mwCAvyaETEC76b8lh4p
         7O2dYkytu4FagI24haQqChuJhPcxQVX3v4CUJC246IgxBdXcd6ys4OTsQVAsV1bdubiN
         Gww7xfnpg62tJPV2pTagzlAXVhOtiSfZEWxQtZmzfjdleeUeZAT5auJB2Jv7kTK354xh
         raw6C3mTSXij1BHr62Q+UYx0K14FUZjS7IA0NiIWkbLezbPXdPILnUL8rVflKpTw/6ir
         k1pQ==
X-Gm-Message-State: APjAAAXf4dRm/blWL7hYHByzpSZJuSc2M7OKKYyUmVUqBC4Lit6ZCicw
        EWtKNrXCI+IjiHelW1hwrnXNiA==
X-Google-Smtp-Source: APXvYqxS1nDjxxH4SjdNP4Y+hJboWueG45AfdStI+kR1/71Wchq20yTMS9ARprHKlh1d5kmoIHGaiA==
X-Received: by 2002:a9f:2246:: with SMTP id 64mr17320085uad.47.1558918387214;
        Sun, 26 May 2019 17:53:07 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k13sm3345233uae.8.2019.05.26.17.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 17:53:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] sched/fair: fix variable "done" set but not used
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <0dd5f59e-bd7e-69d8-e3e8-dbc73820b110@arm.com>
Date:   Sun, 26 May 2019 20:53:05 -0400
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw>
References: <20190525161821.1025-1-cai@lca.pw>
 <0dd5f59e-bd7e-69d8-e3e8-dbc73820b110@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2019, at 7:56 PM, Valentin Schneider =
<valentin.schneider@arm.com> wrote:
>=20
> Hi,
>=20
> On 25/05/2019 17:18, Qian Cai wrote:
>> The commit f643ea220701 ("sched/nohz: Stop NOHZ stats when decayed")
>> introduced a compilation warning if CONFIG_NO_HZ_COMMON=3Dn,
>>=20
>> kernel/sched/fair.c: In function 'update_blocked_averages':
>> kernel/sched/fair.c:7750:7: warning: variable 'done' set but not used
>> [-Wunused-but-set-variable]
>>=20
>=20
> For some reason I can't get this warning to fire on my end (arm64 =
defconfig
> + all the NO_HZ stuff set to nope + GCC 8.1). However I do think there =
are
> things we could improve here.

I like your approach more if it works. The warning can be reproduced by =
compiling with W=3D1.

> cfs_rq_has_blocked() is only used here and in a CONFIG_NO_HZ_COMMON =
block
> within the !CONFIG_FAIR_GROUP_SCHED update_blocked_averages(). Same =
goes for
> others_have_blocked(), so maybe these two should only be defined for
> CONFIG_NO_HZ_COMMON, so we get an obvious splat when they end up in
> !CONFIG_NO_HZ_COMMON paths.=20
>=20
> Otherwise we can have them defined as straight up false, in which case =
we
> may be able to save ourselves some inline ifdeffery with something =
like the
> following. It's barely compile-tested, but the objdump seems okay.
>=20
> ----->8-----
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f35930f5e528..d3d6a36316f9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7695,6 +7695,7 @@ static void attach_tasks(struct lb_env *env)
> 	rq_unlock(env->dst_rq, &rf);
> }
>=20
> +#ifdef CONFIG_NO_HZ_COMMON
> static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
> {
> 	if (cfs_rq->avg.load_avg)
> @@ -7705,7 +7706,11 @@ static inline bool cfs_rq_has_blocked(struct =
cfs_rq *cfs_rq)
>=20
> 	return false;
> }
> +#else
> +static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return =
false; }
> +#endif
>=20
> +#ifdef CONFIG_NO_HZ_COMMON
> static inline bool others_have_blocked(struct rq *rq)
> {
> 	if (READ_ONCE(rq->avg_rt.util_avg))
> @@ -7721,6 +7726,9 @@ static inline bool others_have_blocked(struct rq =
*rq)
>=20
> 	return false;
> }
> +#else
> +static inline bool others_have_blocked(struct rq *rq) { return false; =
}
> +#endif
>=20
> #ifdef CONFIG_FAIR_GROUP_SCHED
>=20
> @@ -7741,6 +7749,18 @@ static inline bool cfs_rq_is_decayed(struct =
cfs_rq *cfs_rq)
> 	return true;
> }
>=20
> +#ifdef CONFIG_NO_HZ_COMMON
> +static inline void update_blocked_load_status(struct rq *rq, bool =
has_blocked)
> +{
> +	rq->last_blocked_load_update_tick =3D jiffies;
> +
> +	if (!has_blocked)
> +		rq->has_blocked_load =3D 0;
> +}
> +#else
> +static inline void update_blocked_load_status(struct rq *rq, bool =
has_blocked) {}
> +#endif
> +
> static void update_blocked_averages(int cpu)
> {
> 	struct rq *rq =3D cpu_rq(cpu);
> @@ -7787,11 +7807,7 @@ static void update_blocked_averages(int cpu)
> 	if (others_have_blocked(rq))
> 		done =3D false;
>=20
> -#ifdef CONFIG_NO_HZ_COMMON
> -	rq->last_blocked_load_update_tick =3D jiffies;
> -	if (done)
> -		rq->has_blocked_load =3D 0;
> -#endif
> +	update_blocked_load_status(rq, !done);
> 	rq_unlock_irqrestore(rq, &rf);
> }
>=20
> -----8<-----
> [...]

