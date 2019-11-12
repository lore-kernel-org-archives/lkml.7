Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B98C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1032184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4dSANX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKLADZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:03:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53078 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKLADY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:03:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so1174060wme.2;
        Mon, 11 Nov 2019 16:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2hJz4lCOfkMCCr9Ga5SGhhISRmp/Zo6cNfw+JBvPD4=;
        b=C4dSANX8A3Iqlp5SW3GLXjgDjn6AiIxum5KhabRQL0u9+NJELsKHGj45sobE7NfEbN
         u09hSXCRTmpfvoFaIdgeRH9JioWuWwZo39JSTIcjveLJvfCZ18V2+RmkwGFj0zRo1GZS
         UFhbxkdk0trUCPfP6M06Ml6LPigGLiBsfI4rhSsMYsMgAOK8jrqY+kSDFQugU6BjJJnO
         KKYfpEvemBg8cKUSiM2PpHRF7in5UmfSoRGNUJ0pMctheHk9e5mpVKp2LLyqOB7/QmxK
         Fp6sClwwusxFR4fYG5BCCaP5kRxadtysU3j2fd3qGQbh7N0SYdongW+pWHgW9yDZp90U
         kIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2hJz4lCOfkMCCr9Ga5SGhhISRmp/Zo6cNfw+JBvPD4=;
        b=gNw+5hVql963DpB4dm4vx32fhJmTWKwzubYzB6ugupvSkq7UXdCbNtJqfFHEKDL4dr
         362Yhjm9i3FZvARiMo/RCPqUvS/ytkaMoxNz7eg4CbXlsOcHSbSEnswNyldkIBuh6br3
         4sN5UhUtCNLs/F2neOXIv15oAej3sbPvxxP5jvlmCRWulAkLA88eox5jaAjE2chCAoKH
         GHpr+fXQIpisXEnwHFMintsralm+/NAp/4/Vp+2VeulW12vMYrpGnIFVnRddu3ozsnqx
         zq8JZS9fbrsFOL1Q6rX51f9EO66S6UbgzAXKDoJlly/0F4K1LP8IjQWkRemc30UyoCPe
         yDIA==
X-Gm-Message-State: APjAAAVxCOVZdKEXYolozw9IdMvH+oAzq3zZgUlptjBr8D6dSKAEFDPa
        tRofvxg9ciaR/RxD8XpWXln/IHZRNbMAjk9Nr1A=
X-Google-Smtp-Source: APXvYqx3qSAucNJ8c2QmwKh+XFtnsSnVSsWogTf4eRg+5fTby7qdsdZaAXPlJz2/DRqoC7NEHbalVcg4b1liF2DPg2w=
X-Received: by 2002:a1c:6405:: with SMTP id y5mr1369685wmb.175.1573517002088;
 Mon, 11 Nov 2019 16:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20191111181122.28083-1-madhuparnabhowmik04@gmail.com>
In-Reply-To: <20191111181122.28083-1-madhuparnabhowmik04@gmail.com>
From:   Phong Tran <tranmanphong@gmail.com>
Date:   Tue, 12 Nov 2019 07:03:10 +0700
Message-ID: <CAD3AR6E486EAJ5EW_Wr4qiPeZU_M7TnDTC0g-CB+=6ob9Ru6mQ@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: RCU: whatisRCU:
 Updated full list of RCU API
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, mchehab@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 1:12 AM <madhuparnabhowmik04@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>
> This patch updates the list of RCU API in whatisRCU.rst.
>

Tested-by: Phong Tran <tranmanphong@gmail.com>

>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> ---
>  Documentation/RCU/whatisRCU.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index 2f6f6ebbc8b0..c7f147b8034f 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -884,11 +884,14 @@ in docbook.  Here is the list, by category.
>  RCU list traversal::
>
>         list_entry_rcu
> +       list_entry_lockless
>         list_first_entry_rcu
>         list_next_rcu
>         list_for_each_entry_rcu
>         list_for_each_entry_continue_rcu
>         list_for_each_entry_from_rcu
> +       list_first_or_null_rcu
> +       list_next_or_null_rcu
>         hlist_first_rcu
>         hlist_next_rcu
>         hlist_pprev_rcu
> @@ -902,7 +905,7 @@ RCU list traversal::
>         hlist_bl_first_rcu
>         hlist_bl_for_each_entry_rcu
>
> -RCU pointer/list udate::
> +RCU pointer/list update::
>
>         rcu_assign_pointer
>         list_add_rcu
> @@ -912,10 +915,12 @@ RCU pointer/list udate::
>         hlist_add_behind_rcu
>         hlist_add_before_rcu
>         hlist_add_head_rcu
> +       hlist_add_tail_rcu
>         hlist_del_rcu
>         hlist_del_init_rcu
>         hlist_replace_rcu
> -       list_splice_init_rcu()
> +       list_splice_init_rcu
> +       list_splice_tail_init_rcu
>         hlist_nulls_del_init_rcu
>         hlist_nulls_del_rcu
>         hlist_nulls_add_head_rcu
> --
> 2.17.1
>
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
