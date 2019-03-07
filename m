Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D63EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E83420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoYi74SU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCGR60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:58:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37214 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGR60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:58:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so11854542pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8VsHJfo8YdLm1sjO4eMpCNwfZOE+M1UOmaF2z5vJeTU=;
        b=EoYi74SUw9dJ9NWfgJcKveZOlAIfxdfUCPyS9Lq+Co04l/ck/Ua6tiaWiE5n5r8621
         tAiZJm5z4uaYkkeAmsGWLpVXHeGJ3pDcXc0SdUvu6eko1wgPHV0l5NVzsszAi4BWR51C
         G+B3Hu3nQIDpdbo9E50t3E27yXw+1ccvPHeMEIKs+3aStXfVscF/bTbmy+lLwtCnXJ1B
         zY9v0Nx+HBFa6fBMqG+IA072WYTMMBVjnf3lTkw2kjVGRFdyPJGYZFehPS4jAGQ9A0ah
         nVdzz5+U6jJ1PuPY5kHUX0zjENUlsM/2GDLpXvQ6xnU/0/ZyeOP+RtwOd2kIQGX0qlrg
         pBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8VsHJfo8YdLm1sjO4eMpCNwfZOE+M1UOmaF2z5vJeTU=;
        b=JWCeC6Y1jxbNT0TmOJEhiTf2G5uozPXubHKC55fMXa4M2A3t4jajZRPiGFQjhTOnLR
         Ih3laIB/pqXBkC0XhZdNUH4lPpU+X8fq3/h6AiRJNVArwOPtbAQPgKa9Zv4ia5JsXAYZ
         9qWq9r/fk0cwDMxMjGmIps2qiJ/O69GvOH+vLuLiTZzXE/XRZN0Pc6EekjD1JGRTJmFT
         eLsDsdib7izPjHpxAMzDtdZuiPxDJmyCOqGIb3eoBgLrC62emfOxPuli+MfG8x0laQ5u
         5ULBREkzcrx8Xts8KcBqp997WZ2UDbZo9aM2Qb6oAceMkqiDamWpZp6uuNpaPzFXjXrm
         PpWQ==
X-Gm-Message-State: APjAAAX9tYyfsJYUJF4VDeA1wiEjugVUo4UEQoeCwJEDqtdt+n8xOFy8
        +bRr+Z6XS5uzmK2MUJvC0dEfokwdEmIEjRiJgJ+hJg==
X-Google-Smtp-Source: APXvYqzhv3AuMyTkWnLFl4VFxzOfI/H3TxwX8+aD+FLiJM3ERLnoOGCBXxiLuX3Wa90peo3iO2A6ETSPJDCO3rSxj7E=
X-Received: by 2002:a62:f20d:: with SMTP id m13mr13818724pfh.174.1551981505308;
 Thu, 07 Mar 2019 09:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20190307163515.2168-1-natechancellor@gmail.com> <20190307175550.GO31119@twin.jikos.cz>
In-Reply-To: <20190307175550.GO31119@twin.jikos.cz>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 09:58:14 -0800
Message-ID: <CAKwvOd=SY7wOD0UTXcqcY7ugprOMgbbb8y0Z-rTGQpBqRJ8YaQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Turn an 'else if' into an 'else' in btrfs_uuid_tree_add
To:     dsterba@suse.cz, Nathan Chancellor <natechancellor@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:54 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Mar 07, 2019 at 09:35:15AM -0700, Nathan Chancellor wrote:
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > fs/btrfs/uuid-tree.c:129:13: warning: variable 'eb' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> > fs/btrfs/uuid-tree.c:129:13: warning: variable 'offset' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >
> > Clang can't tell that all cases are covered with this final else if.
>
> The chain of conditions is
>
> if (ret >= 0)
> else if (ret == -EEXIST)
> else if (ret < 0)

In the few cases we looked at, it seemed that the compiler's heuristic
for coverage doesn't try very hard.  I assume once you start having
more complicated expressions is gets quite difficult to prove.

Thanks for the patch Nathan!
-- 
Thanks,
~Nick Desaulniers
