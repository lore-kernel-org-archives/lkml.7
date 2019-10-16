Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B60CFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539CE21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnV6duwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393532AbfJPRES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:04:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41823 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391091AbfJPRER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:04:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id g81so2486976oib.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSGWH28HRKXwBsAljxNnBMneVoGGH/xuNYpExPGbSaY=;
        b=SnV6duwiaal+yGD3AuPhlJcCXxUGyQLB+r75PKs+qHRyI/QWizQJVUfcvWk9X9i2OQ
         zJImBN8zyWaB/wS3UnRh5d9ZrP0JQce4Es6JbeJB5vbTkPcSiZ52CcoL8YCe4TglWK8o
         186yTn3eE3xJXnC+4uUIwEmwTtnTl4kooRUrgqgOXhI+gzk/Spuvr6zuBj97NDv8o1UC
         nSBDhRyZEEVSGLN0cVa3qVKmVWV2EOOWtc4T7Zgw7d3GypYKUZ54HRZw1lO1/hl1fzN1
         hGggQEji+g3hrpoN+TsUs+Ye9Z0ut6eQ0vJlg9n8BuPfAGiF3nIIKgIDjEopKsAyv5Vb
         XJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSGWH28HRKXwBsAljxNnBMneVoGGH/xuNYpExPGbSaY=;
        b=DehaTrrG6FtG27qcXTWxWe8hM6WkS6UPmBzn3XnmZ/v4KMdOAO5r5lt6mmB5nrBCph
         t2Ex/kGsFml9Nv1K9PgkcMuCYMVEJJfBFeOI+FrUyMXbri/WlTodMIF45KF7Kv7Ecb7o
         18wifbHgdIVvCy1u9dyrk45bRGB1E5mKTGZZVf7Eyz8zAi40Yp7tTlz191EokPs/oMDp
         tmtZWfQAr5j03l9Cf848iz5HnvPxb9o6ZGJ3PP/nYTfYvzxEPY+GU33hE6dkjZd2qJQt
         4n0Op91LdiUyMGBIm91T4mkVEGWrWPoCbHAylsV6lki41bt6FSbCn5vz4b6R/aurRbT6
         jxOA==
X-Gm-Message-State: APjAAAW6k3DcDdwz9+afd0Pc41NC3UJ3zc8k5Ya/03A/k4Nkh4g6jOpj
        fr14f6ViX8y0RARSrtb7Z3+pLIUjsWjloKTW61oV7g==
X-Google-Smtp-Source: APXvYqyJf907NHVLtjRanj3dokhHHBREfhg/3ZadjyyyP26vVviAVhDiWn+UNwp7oYMNCmFsgbDqBfpdl+UYkHN8IG4=
X-Received: by 2002:aca:5015:: with SMTP id e21mr4471718oib.121.1571245456250;
 Wed, 16 Oct 2019 10:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191016083959.186860-1-elver@google.com> <20191016083959.186860-9-elver@google.com>
 <ce0d1658-c000-be20-c997-34ca488e4406@intel.com>
In-Reply-To: <ce0d1658-c000-be20-c997-34ca488e4406@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Oct 2019 19:04:05 +0200
Message-ID: <CANpmjNOjJsqEtS5jrZ66f3RQSEASjG-N9oMQ377KhmoWJycxXA@mail.gmail.com>
Subject: Re: [PATCH 8/8] x86, kcsan: Enable KCSAN for x86
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        dave.hansen@linux.intel.com, David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 at 18:14, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/16/19 1:39 AM, Marco Elver wrote:
> > This patch enables KCSAN for x86, with updates to build rules to not use
> > KCSAN for several incompatible compilation units.
>
> First of all KCSAN looks really interesting!
>
> For the x86 code, though, I'd really appreciate some specific notes on
> why individual compilation units are incompatible.  There might be some
> that were missed, and we have to figure out what we do for any future
> work.  Knowing the logic used on these would be really helpful in the
> future.

Thanks!  I will add comments where I can for v2. For most of them, I
followed the examples of KASAN and co, and will try to reevaluate each
one.

-- Marco
