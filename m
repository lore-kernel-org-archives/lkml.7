Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD437C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0815216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLpFZf38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfHEO6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:58:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40187 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHEO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:58:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so81175329qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OqojxpjT8qnkNNQEY0MJCR4RAfNG21cI0RBH2E+MqOY=;
        b=dLpFZf38pcnv0fujmz7fHOUj84ZWIoYkHJiH+RYcvXN5n2Wc0ne36Cy4Pacq31sz3d
         oQpqbAqMbxb9+5ANy+ZQdDnSgVcC2UrJjLnVIMkzkoGXWrm7lCEMCKrgbQxYkLRGimV6
         dBQJJ5icKc7ifapI+/4k7DWk+16G/CTvCXEGHh21eBfGe8UFeRlLrD5T789qx6oQgLOM
         DAobIZ31xUQfXvG9wXpG1mZ6N2g+NsPnDIW768oaFnPjepdoanb86/WZS2EIwa+arr1K
         6F3VT8u/6RFHCV8d/swx9jSd5f0Pd33aImuuybS/t1Zh9sSBm2j2u0BqwcPJV8i21Qe7
         Ut6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqojxpjT8qnkNNQEY0MJCR4RAfNG21cI0RBH2E+MqOY=;
        b=AcqcAfHLck9CLRBjQWlMWiUHwL3/Wn3Gm4d//YgDV9lSHik3MqajrNTiLc+T+L0sLE
         1WDKSr1HfwSlR5i1PbYkKgPkTEplSyy++aHdNGSfQji+Y9U+LAR3A6H/AzybRd4p5DaV
         ZXbSphdC+zFlfkOUNo4GC6+ZLP9DgU/gF61T9NzJqjyh3ZviDKThtWDntjSh8OKK+jg8
         kInhdYSgocm9jTqM6HF9eMTUcoGQGHBysl9Qi70RFz5BrkM/7KApHvuGy9a46ePSrMqz
         fFh79fDwAlvHuPOR5z5+/GuTFNuWIH/SBAdM+jjAppZaNCR5l+4qF+pl8MChDIwVwlTp
         S/tg==
X-Gm-Message-State: APjAAAXMAvfjVEmcYh4av3vEESKURPIRTkH4kel4smQjfIBWa+EOyy1A
        S+aLKMHseac0jveuXE+cjr4=
X-Google-Smtp-Source: APXvYqxHky/ooFP1FemEpPVPcOvSX5pdWo7zBjPdkJScBtKv1vxMIJ2RDafjd0qVUmnW/BqNUfyIIg==
X-Received: by 2002:a0c:b4ae:: with SMTP id c46mr110459396qve.230.1565017103321;
        Mon, 05 Aug 2019 07:58:23 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d12sm34271577qtj.50.2019.08.05.07.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 07:58:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C90A9200E3;
        Mon,  5 Aug 2019 10:58:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Aug 2019 10:58:21 -0400
X-ME-Sender: <xms:C0RIXVhzgJuizrl_tc07HLt_JbzRAvoh6tiWLpVZ5hY4cXoaZpzolg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddtjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepge
    ehrdefvddruddvkedruddtleenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:C0RIXW6-mOuhd4DmZoI7Jo_nm61eAdyIL_bEqu4RW-AA-Nru08GgDw>
    <xmx:C0RIXT0S8SF0cYPLKb3GaOk9Qw2klx81-mJhWdkn9trkIQi2Gi-Nmg>
    <xmx:C0RIXeiQdv_n5lNNc7HskyYkR4Oh-94A4aZZhbI2yxT6FRtwNidegQ>
    <xmx:DURIXenMblQedo6SKHija_2dS5ayQR03llt3vuyIou29FwFAQO-aqPdYtyw>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8245638008F;
        Mon,  5 Aug 2019 10:58:18 -0400 (EDT)
Date:   Mon, 5 Aug 2019 22:58:13 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190805145813.GB972@tardis>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190805144318.GA972@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <20190805144318.GA972@tardis>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 10:43:18PM +0800, Boqun Feng wrote:
> On Mon, Aug 05, 2019 at 04:02:41PM +0200, Peter Zijlstra wrote:
> [...]
> > =20
> >  static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
> >  {
> > +	rwsem_release(&sem->dep_map, 1, _RET_IP_);
> > +
> >  	preempt_disable();
> >  	/*
> >  	 * Same as in percpu_down_read().
> >  	 */
> > -	if (likely(rcu_sync_is_idle(&sem->rss)))
> > +	if (likely(rcu_sync_is_idle(&sem->rss))) {
> >  		__this_cpu_dec(*sem->read_count);
> > -	else
> > -		__percpu_up_read(sem); /* Unconditional memory barrier */
> > -	preempt_enable();
> > +		preempt_enable();
> > +		return;
> > +	}
> > =20
> > -	rwsem_release(&sem->rw_sem.dep_map, 1, _RET_IP_);
>=20
> Missing a preempt_enable() here?
>=20

Ah.. you modified the semantics of __percpu_up_read() to imply a
preempt_enable(), sorry for the noise...

Regards,
Boqun

> Regards,
> Boqun
>=20
> > +	__percpu_up_read(sem); /* Unconditional memory barrier */
> >  }
> > =20
> [...]



--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl1IRAIACgkQSXnow7UH
+rg8hAf+OjAYHlowPR6uiYFDIIDuIC7zAiIQm+i0fpqLstfOXZ87wpXpbjSW7iBg
RR4jtiCB4KbdzLWtNj61LkMqvdZDT1ZWdKEr3qDavi0KEnmc1ZQ+IbokD0kOwxAG
h57vRBjlcO8WlOhgXpwDGgL+F0GtuC+P8RW3OBkW+vbQCKYGcb/8jDu2Tc/iUSs0
XQ3rY9w5fGejWTDvKTvM5eXzTTlAfvaxF2hwHvnfbr4u2ZDHxbN/ZfXh34+LXh3M
ojcYaeD1K2n21F2bKoFPsGSYIa4pTJnPc8Qilxl3K7WJVHGvihI+Cf+DkQNMR8Mt
8Lf8KBguiyTAzV6Uipv51eQMdGmfyw==
=SYi1
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
