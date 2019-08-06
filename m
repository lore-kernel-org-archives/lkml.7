Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F0CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A2120818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9QjYsJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbfHFOPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:15:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37786 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFOPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:15:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so62942787qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9AtvYU2xgoxOs2OEONfJSqtaxyOSpXmvUC2SyXZ4+ps=;
        b=m9QjYsJzYzzo/iy9iyElP8LFJ9SMn9cGEwiCJmsC6jNlyhN65Xj98OwmMB4SO8Unon
         9jVnusHCyWBCb1DDEw3O0NlOvubJSVnUxWvicXTSEFVluNUybD8iA2hgh/d+dIm4DmQJ
         1g0qhi5z3cSo4Tzv8zSYYXhSpW/XJJJ3GnkP83wXg2ev3J4TPxg4Wxe3S06di8Zd9Dru
         OKPs6MPQaR18QI9Jww8YBJlwywyTkiKJqSAgqn3vaeCqFg7RAkW1FwzCpFOs4UBXUpCh
         w+Om9lZq1XsrCwAlSCgYuEflxlVFgsRpqNTxBDdXiUxM2sTr5ALXphey5ZqBehAz708L
         DgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9AtvYU2xgoxOs2OEONfJSqtaxyOSpXmvUC2SyXZ4+ps=;
        b=G/QxLTe1kSSZeVs9jKeTqiyZNOlyvm1P7RLnMn0tE/4QM2Oi11MhISxAh2jpmPdtjS
         8bJBR+DG24Bc7smUzsJsB32ElI0UzqPaKg/If3KQW+Kr5UoTjjaKDCgLFQgiYGpPT3Xp
         niQROxbtwHa+a++NEvCxD24zU2is7BJKF4Kk+nzS0ENZk4X0tJHkBldJ2qV3/tVN4V8U
         rruAeI/drkLkUVEhyzPUOHImgc+JDvI/6F17+niKp9jB4g7SECy52G8rRMjPrlr1I0ca
         dqhzuWCZihuxyiz3jbUV2MgzEgrV9XfTV3XOgEuMz1H/lvrYxjtxr9a5JcTKTo4rrlNl
         uRsg==
X-Gm-Message-State: APjAAAWhjGxeidepFwVhY+PJm2svlzHSxePaPaOoRJOFA0v4ZLdgfBXZ
        xIWdr/kZv8BL8C22FX8dmAY7ga8A
X-Google-Smtp-Source: APXvYqwqLBbVnvevVEpri5oDehbzM8jw0xlRaG5GOrmEupq2dQXIllKUcDu9SSl/LPhBAVXObyOQMg==
X-Received: by 2002:a05:620a:710:: with SMTP id 16mr3326693qkc.382.1565100931572;
        Tue, 06 Aug 2019 07:15:31 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x206sm39820445qkb.127.2019.08.06.07.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 07:15:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 266D122050;
        Tue,  6 Aug 2019 10:15:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Aug 2019 10:15:29 -0400
X-ME-Sender: <xms:f4tJXb1luMls74UyiXxUp5X4Gx_fJ0tT079ngtOeq0dA1FtF64iZGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddutddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepge
    ehrdefvddruddvkedruddtleenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:f4tJXVmyOeJONud6STna3aaFBlXsdQPQVpVuRfIWDdhQK2nVZJwHhw>
    <xmx:f4tJXSUQekbz_85q0HlBB0jXUpTt3GZsIk-PKgdTeIDQC6M1kvn1Sg>
    <xmx:f4tJXbvaq9lqkXlTeQHy3b3oFD0hw-X8_Yf6xfo4HMsGL9athr5nFw>
    <xmx:gYtJXTEDnmZyvj72srK4LfgZaIfW_EYleP6S3l3HBU3v9N3Fss6gbNW7taA>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5281C8005B;
        Tue,  6 Aug 2019 10:15:27 -0400 (EDT)
Date:   Tue, 6 Aug 2019 22:15:23 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190806141523.GC972@tardis>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190805144318.GA972@tardis>
 <20190805145813.GB972@tardis>
 <20190805154328.GJ2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <20190805154328.GJ2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 05:43:28PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 05, 2019 at 10:58:13PM +0800, Boqun Feng wrote:
> > On Mon, Aug 05, 2019 at 10:43:18PM +0800, Boqun Feng wrote:
> > > On Mon, Aug 05, 2019 at 04:02:41PM +0200, Peter Zijlstra wrote:
> > > [...]
> > > > =20
> > > >  static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
> > > >  {
> > > > +	rwsem_release(&sem->dep_map, 1, _RET_IP_);
> > > > +
> > > >  	preempt_disable();
> > > >  	/*
> > > >  	 * Same as in percpu_down_read().
> > > >  	 */
> > > > -	if (likely(rcu_sync_is_idle(&sem->rss)))
> > > > +	if (likely(rcu_sync_is_idle(&sem->rss))) {
> > > >  		__this_cpu_dec(*sem->read_count);
> > > > -	else
> > > > -		__percpu_up_read(sem); /* Unconditional memory barrier */
> > > > -	preempt_enable();
> > > > +		preempt_enable();
> > > > +		return;
> > > > +	}
> > > > =20
> > > > -	rwsem_release(&sem->rw_sem.dep_map, 1, _RET_IP_);
> > >=20
> > > Missing a preempt_enable() here?
> > >=20
> >=20
> > Ah.. you modified the semantics of __percpu_up_read() to imply a
> > preempt_enable(), sorry for the noise...
>=20
> Yes indeed; I suppose I should've noted that in the Changlog. The reason
> is that waitqueues use spin_lock() which change into a sleepable lock on
> RT and thus cannot be used with preeption disabled. We also cannot
> (easily) switch to swait because we use both exclusive and !exclusive
> waits.

Thanks for the explanation. I was missing the point that the modfication
is mostly for RT, much clear now ;-)

Regards,
Boqun

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl1Ji3MACgkQSXnow7UH
+riAXAf/Qrwte7r5kR7uqoNuz+QiENJSrEGxIs5zR5ymKXqpqz6ayQEsh+U1q4Qm
7TyNIBAqr+vxDHz9JbUVglPGXfQLzXyDtAv8VrqxrtMWCu+ILUwWvBujh+jLt5RY
ss0a2p5wpcF15OU10ZgWv/p9cglcP6RoFJXtqLnCYWzvrZmk7r+ei7WrJ2qSt88b
lvCTy0qOIk50yVJxkOtdJNq4weVPP1OzsAnYDZY431pBbb2v2wMoC4e1atnkcLg5
C24pnoDA9qyYDqWSYWRhC6ST7YK2FkTKM8zZX3d7UcXz7AAKXWkdSNzrF8xVHYmY
xYfaGZwFC5c4ky/ZmV087LAioTxVig==
=5Ujv
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
