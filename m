Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C3CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 02:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9DB20679
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 02:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeCNK9eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfKCCB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 22:01:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45394 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfKCCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 22:01:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id q70so14241823qke.12;
        Sat, 02 Nov 2019 19:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtWw9pnB10IoNSgX++YxasocwBeAuCD6teI4D7Wy2nQ=;
        b=ZeCNK9eHU+qs8XbzbOfB/mq0rbZ/ZHWIXZCAwkRvIWjLdpcSt4mTbX06t0J3/60QWd
         T4dryz74XDJt7xT6SFiZM0Yasky/W/Ak8PE4Z8nnNSjDpenpyHcZ6x+DZqxvpIrcSbXK
         9W4PcHG7FkFWg9HfWFpiMvusMfY4BQeCefTI7iESGwKa50PtnWoveU29zjUO3sr9wGOh
         JnZn+N3UAxziz/UM/YFaIqBXb70dxEJPnPhx04oxn1xwuwgvWtQHXZ9eA6Sl/YMcD5i9
         A0cGWtnlPvs5ZAr4PkgHPPUUdPi1nGZ7MiVtPBpWx1KAKGHAJtxf7W9jaCMuz8orodmF
         xNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtWw9pnB10IoNSgX++YxasocwBeAuCD6teI4D7Wy2nQ=;
        b=c7BlP8fowZjvc6p8l6eJDU9n5tADdC6tRfrEzf+E+f3YlL+35vxtALBkzNGeDD+arD
         RWQyJa6j1jEOGDI7Kkgl9yWD33Ggt8PaMUsRtaNuJaj2b6ETc+Y82TS3QEWe8kkRE7EA
         blViz+5jy+mfQqo21+vgq3b/u6eul6UdAivON9LypoMoZd/mxKqHuAdNr32wR9wYPT5s
         piCqez+rcYzO5MOJNVl8xjajj+sLW+F7/X6i5aPcM9FVUS5l6aa1jR6eciZvEbC2JzNF
         upGa6pgVHPydrn5q1Fvwqr42w6XQIA3VkMJiDhmil921ylDgxG3qhzXVQPETUP1qHNii
         nRSw==
X-Gm-Message-State: APjAAAVj3yVQI6x9Ma0LHxu5ahqyEaEs2xObS4qoQbrc6CuSEJw5+Vrn
        XcHGcM2mO/dZOe3ys/oItAvUnJQ7v34=
X-Google-Smtp-Source: APXvYqz/xTF/ZlAuH+N9dRgWOytt2YzniwjmUmF/m6uRK2E4ro8wPMuzqnIOSRCCUCJvksQ7logOiw==
X-Received: by 2002:a37:6d41:: with SMTP id i62mr16712408qkc.211.1572746517256;
        Sat, 02 Nov 2019 19:01:57 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m10sm6540392qkk.125.2019.11.02.19.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 19:01:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 77AF7213F4;
        Sat,  2 Nov 2019 22:01:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 02 Nov 2019 22:01:55 -0400
X-ME-Sender: <xms:EjW-XSJKlyqIGXCrC7kWGZBpBSRMiO3QXZWUsZ1iX7KEDwC0094ERw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddutddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepud
    dtuddrkeeirdegjedrvddttdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:EjW-XV-8I48HCfSa66-XzlhI7EyRHuDR-eO_8ugaAl8LItY6_l8asQ>
    <xmx:EjW-XZKybzI-ww6QckjHkSX9EnyHSw5DM0hAOyI461wzLwEZ1Fukrw>
    <xmx:EjW-XUE5waL_3UZmK_W5qxxbq_4rGhe13zC5ufEIUqAuS16VKE46Dw>
    <xmx:EzW-Xb3-25HPRccxY3Qkthv__I3eOE-IgfTaEj5tW550Krab6Sh37g>
Received: from localhost (unknown [101.86.47.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 310A080059;
        Sat,  2 Nov 2019 22:01:53 -0400 (EDT)
Date:   Sun, 3 Nov 2019 10:01:50 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20191103020150.GA23770@tardis>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-3-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-3-laijs@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiangshan,


I haven't checked the correctness of this patch carefully, but..


On Sat, Nov 02, 2019 at 12:45:54PM +0000, Lai Jiangshan wrote:
> Don't need to set ->rcu_read_lock_nesting negative, irq-protected
> rcu_preempt_deferred_qs_irqrestore() doesn't expect
> ->rcu_read_lock_nesting to be negative to work, it even
> doesn't access to ->rcu_read_lock_nesting any more.

rcu_preempt_deferred_qs_irqrestore() will report RCU qs, and may
eventually call swake_up() or its friends to wake up, say, the gp
kthread, and the wake up functions could go into the scheduler code
path which might have RCU read-side critical section in it, IOW,
accessing ->rcu_read_lock_nesting.

Again, haven't checked closely, but this argument in the commit log
seems untrue.

Regards,
Boqun

>=20
> It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
> may access to ->rcu_read_lock_nesting, but it is still safe
> since rcu_read_unlock_special() can protect itself from NMI.
>=20
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree_plugin.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index aba5896d67e3..2fab8be2061f 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -552,16 +552,11 @@ static bool rcu_preempt_need_deferred_qs(struct tas=
k_struct *t)
>  static void rcu_preempt_deferred_qs(struct task_struct *t)
>  {
>  	unsigned long flags;
> -	bool couldrecurse =3D t->rcu_read_lock_nesting >=3D 0;
> =20
>  	if (!rcu_preempt_need_deferred_qs(t))
>  		return;
> -	if (couldrecurse)
> -		t->rcu_read_lock_nesting -=3D RCU_NEST_BIAS;
>  	local_irq_save(flags);
>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
> -	if (couldrecurse)
> -		t->rcu_read_lock_nesting +=3D RCU_NEST_BIAS;
>  }
> =20
>  /*
> --=20
> 2.20.1
>=20

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2+NQcACgkQSXnow7UH
+rgDxwf9G5kWC0JEq0CJjzKt4Nb9XnKiLk78qm0uXcSTbHCEdlZXHFOyBss91GMN
I8ZcH53f3xi4HJo7b/zKw6Cj9VB0Wr+Daylhya2QLbQfnq3sz1f89zWOlkoKXGIE
I8F3veP1+2o4IJdzmdd046X5BoBFlBUENlHyWA3zfLtOFAoE7C5zBmOy+wND0nb6
f6AxckADeRMCSJBuFheWvvKu4LeppbN/32alTDEtFTAhGQotk2/+wFVN8tVIcYfT
N5HTRsOXdcgZrN4WNQSBk1+YUV/r9CYUOJxss9EChK6N6jlSG5o0auIRQhHlxilF
KCl8YsvEjLyCORMQWZUzD1/CAYgjyg==
=oLcF
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
