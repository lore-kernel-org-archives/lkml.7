Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66855C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B8C20844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dancer-es.20150623.gappssmtp.com header.i=@dancer-es.20150623.gappssmtp.com header.b="pIRJbQFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfGHNpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:45:49 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:39177 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbfGHNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:45:49 -0400
Received: by mail-yb1-f173.google.com with SMTP id u9so4723562ybu.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dancer-es.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=b6Yj5h+3IsVQ18bhf9sXOFecVAcErsPfHOLYMmegy60=;
        b=pIRJbQFeE+0ZOAxaZErUqzu6QzU/Mup+HORtT3lnYT0auZlgy1/Qpoc5nQoX6R3Om1
         4odkYQ3ceEQyFDQVNGy160ACz6NF1q6+zWgIKKhAQNgTRNiTbfWMH66dRPS4cSEStb/S
         wepq7Jg+/2p8fbUy651TAdbssmhIFAhtgZ/aZnDoiAImRLks0a2jVLodJZ3TU9in1XOB
         PVXenhIRMp+u1mtSxRYIdrDhRAKPR6rqfioIU94DrAaDUb22nKp2FKwBVpI8IrcApQeC
         moj9dVFyVA1gUzfQYn1rAkNh4jWNOh2hxJH7ZPSCk/Tz6KXa06v0coAgayaegfYA72ut
         tRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=b6Yj5h+3IsVQ18bhf9sXOFecVAcErsPfHOLYMmegy60=;
        b=OybmGVUKO8lNnrrF7hx1h9zGo718fH5/VMj7LaO3faGLHnSkMSOggDOmtNxNsCprAc
         RTkoB5BpoyIKYnDKcZjgYjPF24ztc8jIzWdKC8ceD9cx7zMdjj4JiybjfXDQWwde21Jj
         tgkaX4J4MBt24nARLnEO9fL52onMUopdNuBoTOTWLXZtIMQ0ZKrsfuSzZUBB4f9QVQro
         9EYy7qFTLn7BTeWLHf2cxtofA8LrZvGbODNrRqDohQ6xqzoXHo7c184NAT1X98rY1wf7
         1XJ5qSmOcDjVQlZkFzRQOg5IPdeqyK8hZ2vSpHtZwZ0CeQIQhEQSqG9YjSElxHnlKsMP
         vItQ==
X-Gm-Message-State: APjAAAXrz5aU9lwKbAqna42ve/4mjmb4Ls26q72Tl4lTfseanLp7UCKh
        onmiO7pfWdKATtEJnh0XZOTbpkclYXSxQqr8Tj+rtQ==
X-Google-Smtp-Source: APXvYqz3ndSGiFSbSJKXCtaMbNyLmLsyHwsjvnjTlzsFbg2idtCMF1txFC5dUkwMbdjYkxN//h0mQAA50lXoxV7aibg=
X-Received: by 2002:a25:5a88:: with SMTP id o130mr10963597ybb.69.1562593548302;
 Mon, 08 Jul 2019 06:45:48 -0700 (PDT)
MIME-Version: 1.0
From:   Liam Shepherd <liam@dancer.es>
Date:   Mon, 8 Jul 2019 14:45:37 +0100
Message-ID: <CAB8B+d3QEJ4kqzXnT7xaE26F8qqREeNm2M2=DKv+2vUsTSu4sQ@mail.gmail.com>
Subject: Cannot build 5.2.0 with gold linker
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        keescook@chromium.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It results in this error:

Invalid absolute R_X86_64_32S relocation: _etext
make[2]: *** [arch/x86/boot/compressed/Makefile:130:
arch/x86/boot/compressed/vmlinux.relocs] Error 1
make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
make[2]: *** Waiting for unfinished jobs....
  CC      arch/x86/boot/compressed/cpuflags.o
make[1]: *** [arch/x86/boot/Makefile:112:
arch/x86/boot/compressed/vmlinux] Error 2
make: *** [arch/x86/Makefile:283: bzImage] Error 2

This was introduced under this commit:

392bef709659abea614abfe53cf228e7a59876a4: x86/build: Move _etext to
actual end of .text

The commit was reverted on 5.18 by Greg...

commit 474ec2dcfbcf268a4124145b5e08847595f67a4c
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Jun 5 20:40:30 2019 +0200

    Revert "x86/build: Move _etext to actual end of .text"

    This reverts commit 392bef709659abea614abfe53cf228e7a59876a4.

    It seems to cause lots of problems when using the gold linker, and no
    one really needs this at the moment, so just revert it from the stable
    trees.

However it's still present with 5.2.0. Is this intentional?

In case it's helpful:

# gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-pc-linux-gnu/8.3.0/lto-wrapper
Target: x86_64-pc-linux-gnu
Configured with:
/var/tmp/portage/sys-devel/gcc-8.3.0-r1/work/gcc-8.3.0/configure
--host=x86_64-pc-linux-gnu --build=x86_64-pc-linux-gnu --prefix=/usr
--bindir=/usr/x86_64-pc-linux-gnu/gcc-bin/8.3.0
--includedir=/usr/lib/gcc/x86_64-pc-linux-gnu/8.3.0/include
--datadir=/usr/share/gcc-data/x86_64-pc-linux-gnu/8.3.0
--mandir=/usr/share/gcc-data/x86_64-pc-linux-gnu/8.3.0/man
--infodir=/usr/share/gcc-data/x86_64-pc-linux-gnu/8.3.0/info
--with-gxx-include-dir=/usr/lib/gcc/x86_64-pc-linux-gnu/8.3.0/include/g++-v8
--with-python-dir=/share/gcc-data/x86_64-pc-linux-gnu/8.3.0/python
--enable-languages=c,c++,fortran --enable-obsolete --enable-secureplt
--disable-werror --with-system-zlib --enable-nls
--without-included-gettext --enable-checking=release
--with-bugurl=https://bugs.gentoo.org/ --with-pkgversion='Gentoo
8.3.0-r1 p1.1' --disable-esp --enable-libstdcxx-time --enable-shared
--enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu
--enable-multilib --with-multilib-list=m32,m64 --disable-altivec
--disable-fixed-point --enable-targets=all --enable-libgomp
--disable-libmudflap --disable-libssp --enable-libmpx
--disable-systemtap --enable-vtable-verify --enable-lto --with-isl
--disable-isl-version-check --enable-default-pie --enable-default-ssp
Thread model: posix
gcc version 8.3.0 (Gentoo 8.3.0-r1 p1.1)

# ld -v
GNU gold (Gentoo 2.32 p2 2.32.0) 1.16

Thanks,
Liam
