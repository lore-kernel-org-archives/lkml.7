Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4278AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6D1218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hKHmU445"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfCOQKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:10:02 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46691 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbfCOQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:09:59 -0400
Received: by mail-ua1-f68.google.com with SMTP id j8so3268468uae.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kE5A+CZCQ970cuz5dKKKfTnoUsaz55mW0Rz8hAw/vKE=;
        b=hKHmU445IW/COhLh4C9icWVxuotJ3n1hCtm7Gll2wbtPW4oq5SvQlNfsGLiOslggPx
         rRw566RrEYUaSv3edGRRW9MQlE5W4+P4BUQWyE/f7O72f0uo/ZBhU4H5d4B68siXDRbD
         lEjpw9QGwmZcXVVIIqjXAyY0txLfCl7Z36WBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kE5A+CZCQ970cuz5dKKKfTnoUsaz55mW0Rz8hAw/vKE=;
        b=kh8WUJVEfpPzeUhNjtRwDruHiPbszzw1wxcrRdl2A4KY6VtT6Li2W/l9xpX0+bEAN0
         Hw+sEhP3sDrjnrT4nmvedER/5vryQJSWbP30KlEg0sEbkxGAvDKMfjCcoKhYyHyA3zLc
         oA9EQ5T1UnUuiFvfr1VWaXSNBSEbA6T2DKVKW+GH/MpRH4whYbS+/s3Nq6g/udUopf/c
         Ma4RWjprwxRDF3yTLkmksMs737okOItpa3joEGP4vzzod76ZK9bQiVui40LRpuqXkwEl
         lZ/PK7GF3TlwTjIZmykA04+asv1zCbbIDkUEdoR/jjtnzUwN68sLoKlS2NhUPJNOuYlp
         t0EA==
X-Gm-Message-State: APjAAAWfeDasgdrwjWmkTJ9Sytz2o/Dv/EwpUJ2EC2ibQwoaC9YJWcg/
        nQrjT2PJUVRpwSWFR0V+CMcngL74W08=
X-Google-Smtp-Source: APXvYqynXmTgof9GTxcnXVNTPRsYq5yXJveWPepEobM7PJMIiX0wRHvEM5S+I+B1NnueGEPG8HibCQ==
X-Received: by 2002:a9f:2d88:: with SMTP id v8mr81241uaj.97.1552666198208;
        Fri, 15 Mar 2019 09:09:58 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id j4sm2037364vke.0.2019.03.15.09.09.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:09:57 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id z6so5717988vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:09:57 -0700 (PDT)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr2431791vsq.48.1552666196638;
 Fri, 15 Mar 2019 09:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190311093701.15734-1-peterx@redhat.com> <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
 <20190313060023.GD2433@xz-x1> <3714d120-64e3-702e-6eef-4ef253bdb66d@redhat.com>
 <20190313185230.GH25147@redhat.com> <1934896481.7779933.1552504348591.JavaMail.zimbra@redhat.com>
 <20190313234458.GJ25147@redhat.com> <298b9469-abd2-b02b-5c71-529b8976a46c@redhat.com>
 <20190314161630.GS25147@redhat.com>
In-Reply-To: <20190314161630.GS25147@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 15 Mar 2019 09:09:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+WwcYTavVRp2M1AashdCwf2YX=RmUtO_5bHXPK9iZhGQ@mail.gmail.com>
Message-ID: <CAGXu5j+WwcYTavVRp2M1AashdCwf2YX=RmUtO_5bHXPK9iZhGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        KVM <kvm@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 9:16 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
> So this will be for who's paranoid and prefers to disable userfaultfd
> as a whole as an hardening feature like the bpf sysctl allows: it will
> allow to block uffd syscall without having to rebuild the kernel with
> CONFIG_USERFAULTFD=n in environments where seccomp cannot be easily
> enabled (i.e. without requiring userland changes).
>
> That's very fine with me, but then it wasn't me complaining in the
> first place. Kees?

I'm fine with a boolean. I just wanted to find a way to disable at
runtime (so distro users had it available to them).

-- 
Kees Cook
