Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56831C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7DA217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554427479;
	bh=bPs0Akbi49t9N1H7jv3nKG9OkDPB4Dxy2vyIfQuMTvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LAVYX/WmhQSTpM/fapEYjFh4sjenIRPZWKvnMpodAbPf0zzoxfr4qNN4j+SlrYlYS
	 8uEntSq1z0/UBo4h1MSveCAqzqfH1bXHgSs3ZbaKqQE3NQR4DfZgS89AZ3O/IPSBXz
	 VLLZgUoCD4xp6qZ5aYwIhCme0JLPyheOsSgLWYfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfDEBYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:24:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41454 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfDEBYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:24:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so3739231lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0GW9oDJYe1XnhWH3U4bcKf2iDVhzMAag36yaAtJZfU=;
        b=eUK+sB+/M1eRzKoI/snv3w00hT2ZpELsv0V8Nc8nz3h6Gco86ButjCPHFLdeTyRkTW
         VYrRe2kjGlkKXKokXgSkp1i2lGkoo9taAbqX5z7s6o1VJrfFB0JBfW4oLucHWxnWsefK
         Hg2vwK16BZA/yDfTYrD/CLo5O+IMOS+q4zWVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0GW9oDJYe1XnhWH3U4bcKf2iDVhzMAag36yaAtJZfU=;
        b=jAmVYaZYEFEQ8pkGtqHNW0ojwRm9bORoIw78YangLT+uMuZcl+RPjiSwjam3G6XpAK
         h4YKtgsVYG62qUGp0w/6zKgoTIQNUUqmPmNJF6R9k/573eH16ylcwRwZzHszo/WiuK/A
         zaT66DYRO0Bvvlz9gog3stTX4NWkM1fMxTkhN69+fFblkQ2g9sMt0lZxlg+K/iMRwh/F
         dlo+nTxPdZr5ktijK54NfLxxbUxNU9lJai1v5XjdTHhQQOAgb4rOxLZXXZZ/cBDXRdwg
         yU/dGYPoYGjKT7bmrHVdg54PBsUUFF9iTBvdl1HeC2FpQXVEjKnrlztABxLOtLGg7vt8
         j7oQ==
X-Gm-Message-State: APjAAAVCY7mvCnHw7sybe0UXRHzUxHPMKR/Rt71fo9vGY8C38hUC2QDq
        OpFixDUZIcBp/Luak15aBUVP35yzj08=
X-Google-Smtp-Source: APXvYqyTmiuzYeY1FwB5cuNgVsilG+0HdB1/uUaHMuDAxblDhURevIIlYR7sMT2qNvLnNnhPYCJ3Bg==
X-Received: by 2002:a2e:8347:: with SMTP id l7mr5147920ljh.17.1554427474326;
        Thu, 04 Apr 2019 18:24:34 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s10sm3955202lfc.20.2019.04.04.18.24.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 18:24:33 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id v22so3746447lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 18:24:33 -0700 (PDT)
X-Received: by 2002:a2e:9597:: with SMTP id w23mr5077129ljh.111.1554427472884;
 Thu, 04 Apr 2019 18:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org> <20190404092803.1bffd135@gandalf.local.home>
In-Reply-To: <20190404092803.1bffd135@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Apr 2019 15:24:16 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh1wv_g2cW07OG1n5oHFXxZUc2192ZQ+6p5Cj+46FDQVQ@mail.gmail.com>
Message-ID: <CAHk-=wh1wv_g2cW07OG1n5oHFXxZUc2192ZQ+6p5Cj+46FDQVQ@mail.gmail.com>
Subject: Re: [PATCH 0/6 v3] sycalls: Remove args i and n from syscall_get_arguments()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 3:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Is this something that can go into this -rc release or would you want
> me to wait till the next merge window?
>
> The reason I ask, is that there's two arch patches in this series that
> have stable tags attached to them. But I moved things around such that
> they are applied before the global arch patches are and can be applied
> independently.
>
> Should I move those two patches up front and just add those to this
> release cycle, or would you like the entire series now?

I think I can take the entire series. It's removing code and fixing a
couple of bugs in the process. Even if not all changes are pure fixes,
it looks good to me.

I assume you've actually used this and can trace system calls with
arguments properly, so that it's all tested at least on x86-64?

                    Linus
