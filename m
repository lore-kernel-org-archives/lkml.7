Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2423CC74A51
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14D920872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6q59/d5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfGKJuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:50:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35244 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfGKJuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:50:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so2690014pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=E3/j+bc8Tk5SqOw85OYmjAw37lWq5WZ74e+W7GT4X4w=;
        b=G6q59/d5IV5Dpa78hTtVT2+oyDoV4d/zMohU08nSePRszCnvypWDjP0JrggWheXN8U
         aISGjOmYX5CvM3aOP3pH1grfQuleovRSREHAIeSbgnV/XnBoF7GHV5/ORTJcKdU1Mkjv
         pKNMy9ASac8xfF5FmG2/Co+yus1cSx7ZLF6rvA6oY9WbAsJL/uHuX5Yh/658DNK/e+Ng
         aHc8fIJFHWBtekr2slvxQcMilPs1bzbq6ecP3DZRKW4m5dNFxLQfXNS0dw2H22F4qU9o
         Bq3h5PyjaWu0hGobiXd5YrTmLGxrTIDdCRqjU4u67yei70BOhpm2I5Uymun/3maDGDja
         rE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=E3/j+bc8Tk5SqOw85OYmjAw37lWq5WZ74e+W7GT4X4w=;
        b=EH4JNnMi3dMzXVu5WkWc6IufoLRjrm4uOz2FrlNhf+6kQNzkhGiLset4D1/G+xJ+KO
         oF1VTOInNeDMzxMTFMFfIULgIaHO72QnGpnb5rT1gb6n4BLfSJSU1xWijyFKmU7HTDOx
         AMK9O5kLdoXhB2pfr0agi9UxRn0FNiJCYyBpM11hukeUPO5bGiC/7dN8nHDhGfhnZqd0
         8GMAWZ+cfcQohP2yHFtJiSVfKdWf/zLHiR614Xx9zDL7SH1UOVnd2D3u2ubcwW6SRsaG
         tNuPLu+Mbwh8zd/627zz5344bwBWA2edTms4ruTXHTB2klC2sDtG4QRt/ma7UXJ5Reed
         GsUQ==
X-Gm-Message-State: APjAAAV5ywSs/lPkuokomPzupBE3fiONVDQoLV4LNlvqGgqUT2CgOoVu
        ad3ed3IXKTI9TsYJbqkoSz9LptcE
X-Google-Smtp-Source: APXvYqyIHKIyoqJ/xLIkBODlh8Zzic0vQ95MU3Yfyu/5IW5dvWqfni8w8npQg6VH7u6CjGYc3NIc4g==
X-Received: by 2002:a63:7a06:: with SMTP id v6mr3459347pgc.115.1562838616544;
        Thu, 11 Jul 2019 02:50:16 -0700 (PDT)
Received: from localhost (193-116-118-149.tpgi.com.au. [193.116.118.149])
        by smtp.gmail.com with ESMTPSA id r13sm5851993pfr.25.2019.07.11.02.50.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 02:50:15 -0700 (PDT)
Date:   Thu, 11 Jul 2019 19:47:18 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v5 4/6] extable: Add function to search only kernel exception
 table
To:     linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Santosh Sivaraj <santosh@fossix.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190709121524.18762-1-santosh@fossix.org>
        <20190709121524.18762-5-santosh@fossix.org>
In-Reply-To: <20190709121524.18762-5-santosh@fossix.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1562837939.bik9erongk.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Santosh Sivaraj's on July 9, 2019 10:15 pm:
> In real mode, the search_exception tables cannot be called because
> it also searches the module exception tables if entry is not found
> in the kernel exception tables.

This is a patch for generic kernel code, it may not go through
powerpc tree and someone doing git blame or something won't have
any idea what this changelog means.

Can you re-word this and just say something like, "certain architecture
$specific operating modes (e.g., in powerpc machine check handler that
is unable to access vmalloc memory)."

>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  include/linux/extable.h |  2 ++
>  kernel/extable.c        | 16 +++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/extable.h b/include/linux/extable.h
> index 41c5b3a25f67..0c2819ba67f0 100644
> --- a/include/linux/extable.h
> +++ b/include/linux/extable.h
> @@ -19,6 +19,8 @@ void trim_init_extable(struct module *m);
> =20
>  /* Given an address, look for it in the exception tables */
>  const struct exception_table_entry *search_exception_tables(unsigned lon=
g add);
> +const struct
> +exception_table_entry *search_kernel_exception_table(unsigned long addr)=
;
> =20
>  #ifdef CONFIG_MODULES
>  /* For extable.c to search modules' exception tables. */
> diff --git a/kernel/extable.c b/kernel/extable.c
> index e23cce6e6092..6d544cb79fff 100644
> --- a/kernel/extable.c
> +++ b/kernel/extable.c
> @@ -40,13 +40,23 @@ void __init sort_main_extable(void)
>  	}
>  }
> =20
> -/* Given an address, look for it in the exception tables. */
> +/* For the given address, look for it in the kernel exception table */

Nitpick, no reason to vary the structure of the comment.

Code wise it looks fine, so with the comments and changelog fixed,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +const
> +struct exception_table_entry *search_kernel_exception_table(unsigned lon=
g addr)
> +{
> +	return search_extable(__start___ex_table,
> +			      __stop___ex_table - __start___ex_table, addr);
> +}
> +
> +/*
> + * Given an address, look for it in the kernel and the module exception
> + * tables.
> + */
>  const struct exception_table_entry *search_exception_tables(unsigned lon=
g addr)
>  {
>  	const struct exception_table_entry *e;
> =20
> -	e =3D search_extable(__start___ex_table,
> -			   __stop___ex_table - __start___ex_table, addr);
> +	e =3D search_kernel_exception_table(addr);
>  	if (!e)
>  		e =3D search_module_extables(addr);
>  	return e;
> --=20
> 2.20.1
>=20
>=20
=
