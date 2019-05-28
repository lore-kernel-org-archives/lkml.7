Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4BCC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C572E20883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tL4iRhDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfE1OO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:14:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39457 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfE1OO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:14:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so11571478pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uILrnXKlYf2xjYbSzuRjxVZ/GKBRZG6iBlNh5FVzNqg=;
        b=tL4iRhDxBHlVQ+tyr45nAjSTrWm4FGkpU9/gqgAOrFY5B7cJ7oOHLY740uFY6v9Apt
         FqrRnmxExj3iQTQYzs/PenqdbelZVqX7ImfSm34SI3kUWnaFv2Pd1vXHqDLGJYPgxvw8
         7KLV8hWWHlsDJ/UwTZYLqE3rqDzmSrpBL95BUyqXducEuzu32sr8cYoLi6lrm/VHbu19
         kGodX0/6n5OKGvwKCkqnvqlMkPVgQ7D246As7ltK/sqPD0kwVjhXWCNgzf39x95m1k16
         0eXP9QfKOUXReSvTh9f0l8fCYrSWQokxzY+jcITzAkXcdghBa76eI6mVVXYUH34oj3Ib
         qnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uILrnXKlYf2xjYbSzuRjxVZ/GKBRZG6iBlNh5FVzNqg=;
        b=Y3/GJMyD94E0/V8QvTXf5CnDbybz1RUG6ZWYMthhmvvnYZAraeLyXf17w4wwpbZyh/
         0P0/pqTdQrfbS293RIZafXEYZhwaegl5pUrpgXZFLaUIhWCEjm60gaE05yrNgNEuw7gT
         nmxLC3AF6IHf6SCsmo1s7NmAKIIobGrD9i/Y/ulGCGQ2tGIeiS4PrcbzLGQEy7NUCAWp
         LU1RCvPGVOtxHa8lVA0Y9h0+aHvTNlllhA8PnDUAhOdp/Ly5gUNRxbyf2YsdrC2WXP+W
         3Rh13ZuAlfLZPl+DL2Jflrz5ccERFdCGqS/j+XXOOpUj7wHkh6st7jRRN+hjHXfX8KWs
         eCCw==
X-Gm-Message-State: APjAAAWp6Y94OE2XfgVaYj/DXHIOFzJ7dNhfNmNhrSonmy6qh5lJdIx4
        2l/vq8iSAOQVCjyuhOGKiuyif/QYUaAbOpDIX/CeZA==
X-Google-Smtp-Source: APXvYqyOX9PeZsCaqURSrIEWPGIBd1WFVQ7exVP3S114miK0Cy+gUD/uDqW5wGxUjPG0aHqJLJFWW3mMb6YG8JIQdRk=
X-Received: by 2002:a65:64d9:: with SMTP id t25mr132418776pgv.130.1559052897854;
 Tue, 28 May 2019 07:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com> <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp> <201905211633.6C0BF0C2@keescook>
 <6049844a-65f5-f513-5b58-7141588fef2b@oracle.com> <20190523201105.oifkksus4rzcwqt4@mbp>
 <ffe58af3-7c70-d559-69f6-1f6ebcb0fec6@oracle.com> <20190524101139.36yre4af22bkvatx@mbp>
 <c6dd53d8-142b-3d8d-6a40-d21c5ee9d272@oracle.com>
In-Reply-To: <c6dd53d8-142b-3d8d-6a40-d21c5ee9d272@oracle.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 28 May 2019 16:14:45 +0200
Message-ID: <CAAeHK+yAUsZWhp6xPAbWewX5Nbw+-G3svUyPmhXu5MVeEDKYvA@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elliott Hughes <enh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for a lot of valuable input! I've read through all the replies
and got somewhat lost. What are the changes I need to do to this
series?

1. Should I move untagging for memory syscalls back to the generic
code so other arches would make use of it as well, or should I keep
the arm64 specific memory syscalls wrappers and address the comments
on that patch?

2. Should I make untagging opt-in and controlled by a command line argument?

3. Should I "add Documentation/core-api/user-addresses.rst to describe
proper care and handling of user space pointers with untagged_addr(),
with examples based on all the cases seen so far in this series"?
Which examples specifically should it cover?

Is there something else?
