Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DE2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D066208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560795225;
	bh=WHBjN/NQaGm0PFo8fJ51VUzdgIPTifu47nPHqcExNLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pDytFuft/C6Bntys6Hn12OeHShi5iH2Xu56FzUgIXHzhBUix+mVJFeggzU0fwo3lc
	 VNHlM8UF+nJr2svizjSVip/l/OjKeALrl1uycbEBgp60OQtQVw2oECwgMnWNsMgN9t
	 XvsV7zlHgrSGG41Tr0gZHu+9biQYkMwRXfWk68m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfFQSNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:13:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41002 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfFQSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:13:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id s21so10245802lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J081FiTz/dcpmcwzq5O6GF0XKXf+1rYscrgrosKZT9c=;
        b=HBku58NGVAv95CcjvbfqVxo4zSvDzDkjpBqEa1eT1BUBn499MwtAVYnMb8KuIY8q1x
         tRdMVTbOCh2URPJ2ZL0QtQNOYWR65ySiiK8lBU7nvffrP+x6MGzSjtH5IXIMF7+XVEV/
         Dp3mtWFQ74+2UcMPuzNH0qKa44Gwg/tiwMvL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J081FiTz/dcpmcwzq5O6GF0XKXf+1rYscrgrosKZT9c=;
        b=TcntC5MqbQpn95gtO+RDweBgZIHsYJspgmWrqxO2kOr4rksgUvVmpMgHOe1qug5MYQ
         XkgP4o64WVJ9ezfB54QFWrIeQgNg+r5rD0tQb8upTBvJPJKuKPK9WVR5Hs9MhGVEHl27
         Y/bcOQP24z5i/HrfGhQ+gGlMfCPXg5Aj2w6JjtDeVVZMrKanTDXN1YurZZjZ7xBrtDJn
         h6xDYN09ruSAtxt840oosx9bHWUiMshVmw8kHWTYBPXzHlSyY3y957fFta3sJaa69A3+
         k3fJd9MjFE2VvhvcQ8IxIKuG8DWaK4HrVSL3+LHny22EmsOL8EMpMEL80hVSOgjzdehK
         gBIQ==
X-Gm-Message-State: APjAAAVjVtIAtLp69i657C3q79AJbKidjlbHKfjRNx2aRezYW/XxWzMA
        u3pO9GSejC867kz/zXk1/6vW9xok7PA=
X-Google-Smtp-Source: APXvYqxFjqH5wZ52Z6YED/Zrl6csxYtTShW0zQQvkbW4knsBSTV4CmadESYhENcbM3sr37ApEzkung==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr28721200ljj.17.1560795219209;
        Mon, 17 Jun 2019 11:13:39 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id i23sm2207516ljb.7.2019.06.17.11.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:13:37 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id p17so10286523ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:13:36 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr17483710ljj.156.1560795216288;
 Mon, 17 Jun 2019 11:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com> <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
 <87k1dkdr9c.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87k1dkdr9c.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:13:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
Message-ID: <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:03 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> There's also __kernel_fd_set in <linux/posix_types.h>.  I may have
> lumped this up with <asm/posix_types.h>, but it has the same problem.

Hmm.

That one we might be able to just fix by renaming "fds_bits" to "__fds_bits".

Unlike the "val[]" thing, I don't think anybody is supposed to access
those fields directly.

Of course, "supposed to" and "does" are two very very different things ;)

                  Linus
