Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E03C43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4807E2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575163232;
	bh=kdjjWcmGZSbFECmmKfrJjHwPqBaZXSkT9/VHe93sEgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MQSd99yRE1D5J3SLVnbAvXIzp5I+dr7afBHcTm7ydeeCT4ZQDaOy78X1tViU/3S8e
	 T3+FQl/ksobX/Ril9ObrYwMN0uYbugJDqHyelevsSG0USTnJfie4LVAKLfy5I8MZ06
	 S9Tz/T1crWneEC6EvXmgay7rzOe/hC+VyV/fs7og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfLABUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 20:20:31 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38747 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLABUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:20:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so9020057lfm.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 17:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0sdyX7pLiN3khasqHk8bUQ9XUbFlvA+ggCvkUq3ym4=;
        b=VdzPIjj7upEn6ny8xuTXugmr4OGIeP6C8ULT9OL37bMP1d2OSdpEfaoBZpqgH7LuHP
         Swrmr5nNhrVM3Imc1ILzNpFbBFdnntv8o1t1l6rtW+uvQEtkXeprLU0dLER2GAET+AAH
         xSybPBIdVnqZ6T5MIXTavVKrx2R8fXnJ5nom4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0sdyX7pLiN3khasqHk8bUQ9XUbFlvA+ggCvkUq3ym4=;
        b=RKWW+b2PjvsV+XEIbUd+nMV8NrcZGwc/mAKKKXsOeTcYkUgxd2I9FxC6IPGODoMmRN
         V52r6YNntGv9jmGvg3/MJ+YtOXTsN5++xdl+CynPSxiBNKtQHQImWTdosLLMu/ZScR9B
         VsKpvRBPsvSVFnx6xDcbrc1t7p2JtpDmd6mZR+8Qlb7TSw53YaJQM4sCszieCto+ZRIF
         h2LmDA3mdTKnqi/JfkJCbEfwxb7jnPZZDN4J4Y7YZt2EcWDEx08iet/xJ/REI1pKxKqd
         p2RqRFTHsvic5kf+DSXvXVn9Afi53dJzlnVOlppqOLYY74z68JJDUtwYgdrF6gICfofo
         VUcQ==
X-Gm-Message-State: APjAAAVXavfCavmCtt7wpEApJO0eNqVGqLgxulPLhh0njrCUT0bRL9f8
        /SODmz+i1qhlTzc2jaqyJpXv/a1A6Ek=
X-Google-Smtp-Source: APXvYqxdHYzP+n7zdGnu+BiOTdFNkwViEGCPbn74Mc18vBC4gLj0nlKfDSjVth37QX3YVz3UudQR8g==
X-Received: by 2002:ac2:5e9c:: with SMTP id b28mr25779233lfq.138.1575163228218;
        Sat, 30 Nov 2019 17:20:28 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id i184sm169570lfd.12.2019.11.30.17.20.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 17:20:27 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id y19so25251498lfl.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 17:20:27 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr25806008lfi.170.1575163226904;
 Sat, 30 Nov 2019 17:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20191130180301.5c39d8a4@lwn.net>
In-Reply-To: <20191130180301.5c39d8a4@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 17:20:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
Message-ID: <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
Subject: Re: Fw: [PATCH] Documentation: networking: device drivers: Remove
 stray asterisks
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Junio Hamano C <junio@pobox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 5:03 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Attached.  The patch itself was not an attachment, but it was
> base64-encoded.

Ok, so presumably git removed the CRLF from the email, but then the
base64 encoded part had another set of CRLF.

And when I try to apply that patch (in a test-tree reset to commit
facd86390be2, so I think the patch should apply) I see the CRLF in
.git/rebase-apply/patch, but then I get

  error: patch failed: Documentation/networking/device_drivers/intel/e100.rst:1
  error: Documentation/networking/device_drivers/intel/e100.rst: patch
does not apply

for every hunk. I assume that's because the CR part doesn't match the old code.

But my git version is d9f6f3b619 ("The first batch post 2.24 cycle")
and some private patches.

So the problem might be limited to only some versions. I'm surprised,
though - when git applies patches, it really wants the surrounding
lines to match exactly. The extra CR at the end of the lines should
have made that test fail.

Do you use some special options for git? Like --whitespace=nowarn or
--3way or something like that?

            Linus
