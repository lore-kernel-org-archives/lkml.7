Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C93AC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECA2217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfGLUlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:41:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42834 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfGLUlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:41:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id h18so9504809qtm.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 13:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZ6pCCksBvzF32wfLcjXw5BujFEKtwTChIfct1iKQmw=;
        b=GAJyR0h/PvIuypkSEuEGU7ePdr8RZ+WkiEUBX1YimnyqNUbN5qMffhJmlqVSbXh2zR
         5iBtZtk0mv5B9DpiQ0lsqOSEY+Gj/k7sLtn3G0O3g1NCrGZ2aMMh86wMA4Pfes81n7Bm
         n0eUK5EGWLZohZPNlpHQxZMruVhphP+G8U6hWcSZVky/WdWDJpFaZr0zrr1OWyjqx4no
         s9QRvE11hfoMmZIbDnHTJK/Qg11eXkkz5oc5Ra7rqnFRUZaUewan+7aTrpIoFGtXf+9B
         Ybgna5Mis/8aI79MrEau/IRpkqJHXKzdD3/P5e5l+AscW831oqO6fXpvRxIvostwovZi
         i1aQ==
X-Gm-Message-State: APjAAAXTzV3n7e66rrmdddGu2f9aBMnaZZn99YOeIQY0yu66R15MRwan
        blqjg3BCJGmL7GamoquUMhT07J3gdnNocOx7665gXwBKqNo=
X-Google-Smtp-Source: APXvYqzv7gtxcHtNZ32bx9rVdTwlSlysoUX5hT/yWcdlU+5aXVZT+pp9bX6fIyuF2LP87lyPXLM0taRoo+zJVK6nOqA=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr8416126qvf.62.1562964075762;
 Fri, 12 Jul 2019 13:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
 <20190711172621.a7ab7jorolicid3z@treble> <CAK8P3a0iOMpMW-dXUY6g75HGC4mUe3P3=gv447WZOW8jmw2Vgg@mail.gmail.com>
 <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
 <CAK8P3a2=SJQp7Jvyf+BX-7XsUr8bh6eBMo6ue2m8FW4aYf=PPw@mail.gmail.com>
 <CAK8P3a1_8kjzamn6_joBbZTO8NeGn0E3O+MZ+bcOQ0HkkRHXRQ@mail.gmail.com>
 <20190712135755.7qa4wxw3bfmwn5rp@treble> <CAK8P3a13QFN59o9xOMce6K64jGnz+Cf=o3R_ORMo7j-65F5i8A@mail.gmail.com>
 <20190712142928.gmt6gibikdjmkppm@treble> <CAKwvOdnOpgo9rEctZZR9Y9rEc60FCthbPtp62UsdMtkGDF5nUg@mail.gmail.com>
In-Reply-To: <CAKwvOdnOpgo9rEctZZR9Y9rEc60FCthbPtp62UsdMtkGDF5nUg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 22:40:59 +0200
Message-ID: <CAK8P3a0AGpvAOzSfER7iiaz=aLVMbxiVorTsh__yT4xxBOHSyw@mail.gmail.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 6:59 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> > The issue still needs to get fixed in clang regardless.  There are other
> > noreturn functions in the kernel and this problem could easily pop back
> > up.
>
> Sure, thanks for the report.  Arnd, can you help us get a more minimal
> test case to understand the issue better?

I reduced it to this testcase:

int a, b;
void __reiserfs_panic(int, ...) __attribute__((noreturn));
void balance_internal() {
  if (a)
    __reiserfs_panic(0, "", __func__, "", 2, __func__, a);
  if (b)
    __reiserfs_panic(0, "", __func__, "", 5, __func__, a, 0);
}

https://godbolt.org/z/Byfvmx

$ clang-8 -mstack-alignment=8 -S ibalance.c -Wall -Os   -c
$ objtool orc generate ibalance.o
ibalance.o: warning: objtool: balance_internal()+0x61: stack state
mismatch: cfa1=7+8 cfa2=7+16

       Arnd
