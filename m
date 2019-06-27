Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3424C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A727217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HexkE8au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF0Bm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:42:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38775 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfF0Bm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:42:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so563447ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVb/Y6glWIWB7wEHcORRZuH9XfM2nYOaiwKwDNV84XQ=;
        b=HexkE8auAfT9XS2t4CecqwNCA1BOxOvU4oRFUbTU8BEArXiTmvqbwfnNmh7+kNMvgN
         PI/6M/mmozaebV05j6HuCtufjxivV41VCnqwFkJ1F+4Zw8Iz6PDTzYWS9fqOwUHscyX1
         DLdEWW5sHbNd1VpOqCVAMrmoXTDxv+gd/ZIKpSbcX4+N06mpXccO28hvpPq1+rJeOfe2
         IGOLjBjTX6Hor3m0Ez4ttuOJnRReGJV08pgV3sz3nqcd1We8i8cacEHFJM1452MU8wyq
         Cxw2gn103yqeeK2wobNY86H1IbxikIBG1zQ+WE4P/2tcolOQMRhEeNpd87Yq0uyGx/WT
         mRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVb/Y6glWIWB7wEHcORRZuH9XfM2nYOaiwKwDNV84XQ=;
        b=FHv/9NW7EDnydp2GzBAc12Ku9DIZ1vScDcXzl+3qWq45JtC6U+5Mvm0YWk2RmV01Hu
         4Q3z6cjbz+/li+JrSHlyLu7q+2OtouQfzCSFQeB+Q3KVmA+5f5IXZhnQ0TpDCdDlwozK
         iVe1BFXHuJ8rR1Ce/hyW2Jc+hkig06QoDpOl9pGi55XoyQoUr2RyJ2caTxc2/NMYk2UM
         K83fz6DHp72UOtzsKDdtLxj/fhThyZtUvvHbnqikW1C1lVPQT+YbJKRvvm7qLIH6koaS
         KZHSS+u4Z4XUFP3mXV6rK5U8GA5+izn1lX9v9579aOi9RXz5tRW2JrUJgIADHk6vm92n
         Hf2g==
X-Gm-Message-State: APjAAAXKLwELYRlTNH+fvQB4MNFCXhhPghx1ovnOMsgzr7GDmVE9HS/g
        pSx7b2h4+7QmwItjXfYSsEzEN78LmKF6Y8VPo2w=
X-Google-Smtp-Source: APXvYqwQLCNDpRNU0O/KLxQUdZvN+d3OhMFrCvjNmjF3pV2emCMXXWcLTH6WjvSTQa2kb5BZ613x3SxadB1GrU+MaYE=
X-Received: by 2002:a2e:93cc:: with SMTP id p12mr777027ljh.11.1561599772479;
 Wed, 26 Jun 2019 18:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561595111.git.jpoimboe@redhat.com> <426541f62dad525078ee732c09bc206289e994aa.1561595111.git.jpoimboe@redhat.com>
In-Reply-To: <426541f62dad525078ee732c09bc206289e994aa.1561595111.git.jpoimboe@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Jun 2019 18:42:40 -0700
Message-ID: <CAADnVQ+veayfD70Xsu8UnNrLdRW6rh9jxPb=OGoiYT-O=_zW=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] objtool: Add support for C jump tables
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 5:38 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Objtool doesn't know how to read C jump tables, so it has to whitelist
> functions which use them, causing missing ORC unwinder data for such
> functions, e.g. ___bpf_prog_run().
>
> C jump tables are very similar to GCC switch jump tables, which objtool
> already knows how to read.  So adding support for C jump tables is easy.
> It just needs to be able to find the tables and distinguish them from
> other data.
>
> To allow the jump tables to be found, create a standard: objtool will
> automatically recognize any static local jump table named "jump_table".
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/check.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 172f99195726..8341c2fff14f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -18,6 +18,8 @@
>
>  #define FAKE_JUMP_OFFSET -1
>
> +#define JUMP_TABLE_SYM_PREFIX "jump_table."
> +
>  struct alternative {
>         struct list_head list;
>         struct instruction *insn;
> @@ -997,6 +999,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
>         struct instruction *orig_insn = insn;
>         struct section *rodata_sec;
>         unsigned long table_offset;
> +       struct symbol *sym;
>
>         /*
>          * Backward search using the @first_jump_src links, these help avoid
> @@ -1035,9 +1038,18 @@ static struct rela *find_switch_table(struct objtool_file *file,
>
>                 /*
>                  * Make sure the .rodata address isn't associated with a
> -                * symbol.  gcc jump tables are anonymous data.
> +                * symbol.  GCC jump tables are anonymous data.
> +                *
> +                * Also support C jump tables which are in the same format as
> +                * switch jump tables.  Each jump table should be a static
> +                * local const array named "jump_table" for objtool to
> +                * recognize it.

Nacked-by: Alexei Starovoitov <ast@kernel.org>

It's not acceptable for objtool to dictate kernel naming convention.
