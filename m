Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7E8C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D922070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njfHQ0Pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfJBUwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:52:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44709 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBUwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:52:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so492118qth.11;
        Wed, 02 Oct 2019 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dV7G2LykqgYT5rhZ0q2+Dl9UTjM6dUdhYsDLKx2iJ7w=;
        b=njfHQ0Pj2mArKtJe69H3lcP4vF+5C3hV7R/QQb/tDNWLFG4JppbZXB9w28vCynRyls
         puQkBWu6UMUwfybBipZJ1Rw6SvHSvcb2VqlMJMU6VSXcQXNbxMlNqKMjCrMhc5TjoKeA
         OztSzIUKI7xszZ9TFFrvCWpbbQnczKoIbHnhEMFujmzBUG6t4/YELDphmB8XHiPDehbr
         81j0yeNkAIrESvDDQFGvzEikxZ+JIikblhtppodDgRvoET0W/2Wp+Qb7H+eO8XNGMcJs
         2E5Fb8NrvgMiCaslFyWB3mLssZMGI1iRc1bxuuNwQ4XD31OD4JIetOzRh6UfoOHz8D+l
         rCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dV7G2LykqgYT5rhZ0q2+Dl9UTjM6dUdhYsDLKx2iJ7w=;
        b=n8x0UX8ne4Ilhk2ayRlpNvv0tEkxbmRZNHFZP91fJq7i3Wa81A/SeJcTtDM7RMVHcv
         KhGHLYb9DU2zSsLMqF2wgr9O75xkpIydIWYkFdm1Fwf1DaiHTnwPKQewY6GGI0t01/51
         Nonxi3o4sZSFpZ2e98CF6RJvCRTmJcrk9XngkDgAx/WTBIs3gzA94k0iuwxwkis7fTPd
         EDHJq7IhAIJQ+u/raHO1tiHPVHl8ANojtlz1E4aNavRVvSS+ioBVjxlK1VPgouq34FkW
         JbNovBmMonY3jPUy80o2zWn25NZ17g0TCH3rVveE+bkeyvVQRNknYCm/Y7k3yMdqDgi2
         qIyg==
X-Gm-Message-State: APjAAAU5lGez2to8EvJAa8QL43iqDXR6WF71D+ARIdoWc1RsufA6JNZH
        51RYVj6Gnb8o4pxRJScr+Jn7hJ+pk37XuU1EY7c=
X-Google-Smtp-Source: APXvYqydMlkQMGe8h2Djsj5sssvOku+IQi/vN4XfsKNs2+Dobgptdmt8myS/rr/raKPEITL0iycEqxzpL4WTEaw3LxM=
X-Received: by 2002:ac8:37cb:: with SMTP id e11mr6510756qtc.22.1570049569865;
 Wed, 02 Oct 2019 13:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191002191652.11432-1-kpsingh@chromium.org>
In-Reply-To: <20191002191652.11432-1-kpsingh@chromium.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 2 Oct 2019 13:52:38 -0700
Message-ID: <CAPhsuW4nSxnghVUmObi1Mo95Jb1nMVHbSKbAMU3rD765enL+dg@mail.gmail.com>
Subject: Re: [PATCH v2] samples/bpf: Add a workaround for asm_inline
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 12:17 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> This was added in:
>
>   commit eb111869301e ("compiler-types.h: add asm_inline definition")
>
> and breaks samples/bpf as clang does not support asm __inline.
>
> Co-developed-by: Florent Revest <revest@google.com>
> Signed-off-by: Florent Revest <revest@google.com>
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Song Liu <songliubraving@fb.com>
