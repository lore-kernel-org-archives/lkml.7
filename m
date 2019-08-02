Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF49C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0538F206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjXesG98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390001AbfHBKSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:18:17 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34932 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHBKSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:18:17 -0400
Received: by mail-wr1-f54.google.com with SMTP id y4so76606352wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=508KXix+sprGMAHd2n+tuvOMkgvWVQJBCkC3Q3AseuQ=;
        b=SjXesG98SSeWdplm75Ac9GzduziUgUXbmqhfO+qR46Gj8D1ROu48pMDx7z99IE+MDm
         nEpSVAgpLYfloqWirZvXalDWaPG1qPpibYjzeS2lm2UM3KkxIgpN8YlGChqH+FZDB3pa
         ev4YVQ58UzGJ3yRagWidXve6DSmIR0M7k39w3qzYNb0KAimqBGsbAVrwwdYT9QPDeYP8
         /PPrGMkdsSQXS1ajDJIC3FjblD7DMZ8rlQqj5d9xY/ckS2SqNnk3tGCcw8t46gNYotzj
         X6u1TeGF8aWHT9j5L5ErOcEZ6r+lvW6nmTkcE11OmbKXjUBRvYTP7hzFcxqLANMnm7By
         IVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=508KXix+sprGMAHd2n+tuvOMkgvWVQJBCkC3Q3AseuQ=;
        b=GqhATZZq9R42aWaggndw9iiMghLCklQQf5VOrVbnpk6Ix97Qyx3k/F/jftdolCRNXM
         v+rEmS4trff6vasHMBNgzsRsni+zZdTLYXid8y6/ZNKZZABRlFQ0jdq6zCHCD2l6oGur
         zlSwle7/13pAtOe0fK/YvLQwzHbleB95LbP19wlgZyHaaftMIP6nH9N5StLC5kMvLv1Q
         fntCqYFaDMw0QSCxcU1Map75LvLIxvPR2yfGv30ROV/qkXWX/nsDplqlDOHvthjYNShp
         j4lIKtEw5/va2hOmNPYmMMLg0U4HNTR1wwgZXKnswfSopfY+AQ6roR56vblxZV7uejod
         5JdA==
X-Gm-Message-State: APjAAAXd1IT2HbUK/TBXWwkMahIcu+Jld54+snbMqN/d8J7nKUCmxuqx
        IYrpLhwB0gN3/whsl4KyUPI=
X-Google-Smtp-Source: APXvYqzwbgp+27A9YyuN8Jgh4RZm1DHJ0Av796s5QL9unVGCAqNIaZx3Dva+dT8fJz9B3vyuom/BMw==
X-Received: by 2002:adf:80e1:: with SMTP id 88mr58615703wrl.127.1564741093893;
        Fri, 02 Aug 2019 03:18:13 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id y16sm160765773wrg.85.2019.08.02.03.18.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 03:18:13 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.02 is released
To:     lkml <linux-kernel@vger.kernel.org>
Message-ID: <fc258087-ec3b-6ce7-c4cd-c441fde86518@gmail.com>
Date:   Fri, 2 Aug 2019 12:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-5.02 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from 28 people, with around 120 commits making changes 
to over 50 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.02

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2019/08/man-pages-502-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.02 ====================

Released: 2019-08-02, Munich


Newly documented interfaces in existing pages
---------------------------------------------

fanotify.7
fanotify_init.2
fanotify_mark.2
    Matthew Bobrowski  [Amir Goldstein, Jan Kara]
        Document FAN_REPORT_FID and directory modification events

vdso.7
    Tobias Klauser  [Palmer Dabbelt]
        Document vDSO for RISCV

Changes to individual pages
---------------------------

pldd.1
    G. Branden Robinson  [Michael Kerrisk]
        Document glibc's unbreakage of tool
            After a longstanding breakage, pldd now works again (glibc 2.30).

execve.2
    Michael Kerrisk  [Eugene Syromyatnikov]
        Since Linux 5.1, the limit on the #! line is 255 chars (rather than 127)

mprotect.2
    Mark Wielaard
        pkey_mprotect() acts like mprotect() if pkey is set to -1, not 0

pivot_root.2
    Michael Kerrisk
        ERRORS: EINVAL occurs if 'new_root' or its parent has shared propagation
    Michael Kerrisk
        'new_root' must be a mount point
            It appears that 'new_root' may not have needed to be a mount
            point on ancient kernels, but already in Linux 2.4.5 this changed.
    Michael Kerrisk
        'put_old' can't be a mount point with MS_SHARED propagation

tkill.2
    Michael Kerrisk
        glibc 2.30 provides a wrapper for tgkill()

dlopen.3
    Michael Kerrisk
        Clarify the rules for symbol resolution in a dlopen'ed object
            The existing text wrongly implied that symbol look up first
            occurred in the object and then in main, and did not mention
            whether dependencies of main where used for symbol resolution.
    Michael Kerrisk
        Clarify when an executable's symbols can be used for symbol resolution
            The --export-dynamic linker option is not the only way that main's
            global symbols may end up in the dynamic symbol table and thus be
            used to satisfy symbol reference in a shared object. A symbol
            may also be placed into the dynamic symbol table if ld(1)
            notices a dependency in another object during the static link.
    Michael Kerrisk
        An object opened with RTLD_LOCAL can be promoted to RTLD_GLOBAL
    Michael Kerrisk
        Note that symbol use might keep a dlclose'd object in memory
    Michael Kerrisk
        On dlclose(), destructors are called when reference count falls to 0
    Michael Kerrisk
        Make it clear that RTLD_NODELETE also affects global variables
    Michael Kerrisk
        Clarify that constructors are called only when library is first loaded

on_exit.3
    Michael Kerrisk  [Sami Kerola]
        Stack variables may be out of scope when exit handler is invoked

capabilities.7
    Michael Kerrisk
        Add a note about using strace on binaries that have capabilities
    Michael Kerrisk
        Add pivot_root(2) to CAP_SYS_ADMIN list
    Michael Kerrisk
        CAP_FOWNER also allows modifying user xattrs on sticky directories

mount_namespaces.7
    Michael Kerrisk
        Clarify implications for other NS if mount point is removed in one NS
            If a mount point is deleted or renamed or removed in one mount
            namespace, this will cause an object that is mounted at that
            location in another mount namespace to be unmounted (as verified
            by experiment). This was implied by the existing text, but it is
            better to make this detail explicit.
namespaces.7
    Michael Kerrisk
        Note initial values of hostname and domainname in a new UTS namespace

signal.7
    Michal Sekletar  [Oleg Nesterov, Michael Kerrisk]
        Clarify that siginfo_t isn't changed on coalescing

unix.7
    Michael Kerrisk
        Note SCM_RIGHTS interaction with RLIMIT_NOFILE
            If the file descriptors received in SCM_RIGHTS would cause
            the process to its exceed RLIMIT_NOFILE limit, the excess
            FDs are discarded.

user_namespaces.7
    Michael Kerrisk
        Describe the effect of file-related capabilities inside user namespaces
    Michael Kerrisk
        Describe how kernel treats UIDs/GIDs when a process accesses files

vdso.7
    Tobias Klauser
        Mention removal of Blackfin port in Linux 4.17

ld.so.8
    Michael Kerrisk  [Matthias Hertel]
        Note some further details of secure-execution mode
            Note some further details of the treatment of environment
            variables in secure execution mode. In particular (as noted by
            Matthias Hertel), note that ignored environment variables are also
            stripped from the environment. Furthermore, there are some other
            variables, not used by the dynamic linker itself, that are also
            treated in this way (see the glibc source file
            sysdeps/generic/unsecvars.h).

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
