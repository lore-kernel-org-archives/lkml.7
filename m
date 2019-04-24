Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46465C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106E8218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556078815;
	bh=2KQd6tkT3d8buTBZNm+upIk4tIGvSKgiBs7iT6k4kas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FgkCfnTn7TPtBE/80WcSJC3+yuDUwBHrmxNFjZPPrgcBL/UPp2hPRGrQz0Orvkw3M
	 eX328Rfr+jgYDVDBbTys9MA4VrcjFKoMFeXm4f2sF1xnlWrOlsjvGHwQjqnrJQocSj
	 biYVAsCa3VloUP96edn9AYKhK8Oc2K+XUkDYmopE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfDXEGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:06:53 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:40632 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfDXEGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:06:53 -0400
Received: by mail-lf1-f45.google.com with SMTP id o16so2640983lfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 21:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IDtG7ntUkheeWk6RH7nN91KAL6RfYZ5oEz3oZPha90I=;
        b=gxVwFj7dKy/BKTbhCsVIh3amlIAWd53xKHh4h2xxAzXm90PAjTwDYHrk+iOApta+/d
         OTT/gTRdiTU88LjYTprhjcq/CRe+mo7lwApXwv3g5/X20S7NpkpwOpYQvaAwjy+seRWI
         aYFerqmVgCh3AdvDdGMSOMggVHrTAjkZjB/aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IDtG7ntUkheeWk6RH7nN91KAL6RfYZ5oEz3oZPha90I=;
        b=NWlz+Af5ckE6jbhInzcalLY1i/iGL1g+Pa1DoToXUYaJ4VhYNLzfd+ZrMB1wLAxNsQ
         TNBKQMxL44uB4fbXDZ2hJf2P6+ytWOiYktg4UxJSBy0YJgfXeGkxBY+L+A9l8Wzqy9HO
         W1b/3cxAhhd7CejZX6EN21FRin+tM8vtL6JeP/qui9pskTkdiwUDsXwjQX9n+dErAryd
         jkKSlJiDgZp/qYK4pdXrzoDsk4/Mg/dNqZWpMVeQDuQUxuFouA186ciCelWi1b2OYlBP
         6SUtwTw0LC6vTGhJrxc3ogiPB+1bBF8oUDrjtGx/TtXrNnNdqTniV7+DNUUM4AOWk/0i
         atxg==
X-Gm-Message-State: APjAAAWnp7DUyofIVFD2hgo+0YqINGCjcFvZDuUAXjzYReeJ3xkeE/ZL
        gzlLX6E/Gn7Izc68jCmbM81ULf8jWHc=
X-Google-Smtp-Source: APXvYqzHAS2u0S7ouVcDS8C7+LaChX33bLF+D9VAlcIeB+VkQU2nozzDtOa3mQ0haDwgW7Fjh09WcA==
X-Received: by 2002:a19:2d57:: with SMTP id t23mr14596322lft.99.1556078810919;
        Tue, 23 Apr 2019 21:06:50 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g5sm1007530ljk.59.2019.04.23.21.06.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 21:06:50 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id d12so13459008lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 21:06:49 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr15686065lfa.136.1556078809501;
 Tue, 23 Apr 2019 21:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
 <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com> <A160B301-5F50-4E0C-B995-A626886A91E7@amacapital.net>
In-Reply-To: <A160B301-5F50-4E0C-B995-A626886A91E7@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Apr 2019 21:06:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMd+O1Dqvp-=fHWW195AhWKPcvDm=Oe6PaHvg+orScgw@mail.gmail.com>
Message-ID: <CAHk-=whMd+O1Dqvp-=fHWW195AhWKPcvDm=Oe6PaHvg+orScgw@mail.gmail.com>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 4:57 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> To clarify, this is =E2=80=9Cfail if you can=E2=80=99t find the files to =
install, but don=E2=80=99t even try to check whether those files are up to =
date=E2=80=9D, right?

Ack. Exactly because the whole "check whether the files are
up-to-date" is generally part of the very complex dance of doing all
the version stuff etc.

               Linus
