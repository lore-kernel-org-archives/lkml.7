Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4333DC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C1A2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/q67Kmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfJKVXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:23:25 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39557 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfJKVXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:23:25 -0400
Received: by mail-wr1-f53.google.com with SMTP id r3so13359332wrj.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=V5ajZ38hOut9b0P+xkh01BJ673dSZ4kdFVeJ1B8BNl0=;
        b=Q/q67KmceKy0NX2fm0ooIV0VMcL30di58a04UZo1MKmk4DS2czyAiZOn7jyalYXAH1
         zekcUlrnGkUqV2GMnBVUelwbZIhZ5q4m1AfHX56YwMM7rkNg8MaRShWUqGBdA+CUhpJW
         Laut4NYsvOSASgemmKKyqWLFGyZXKoLR4bXHnJv3NsydYT9vV17wE2rR72jiPPLePgGa
         5M4wAsMZnUhasKNIMS2v1/kkJRfpEtRwzw7itqbGkGKxjaVoESOg3s8GITB1bBEvuagn
         3REZFejmLhYxgJdxtH1ToYWKi1+ZTl7m5VImgbOsSynNnt6pbJg7FVGjGTYZLGsl9ZQ0
         8nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=V5ajZ38hOut9b0P+xkh01BJ673dSZ4kdFVeJ1B8BNl0=;
        b=lChZohhYscTuTPz6PRw3NstjYkQ5lkOm79syQ39iaPU7XPm1yz+Zw8NF8gbgOvsrrB
         IIj5SOOmD2xQbcc9cYddnk0EyKaZonQFYEgp7ne2Y6nz+T5nw/FjdRMUCtnSyPvOb4mb
         Mno57k8KT2mvVYmLpbo9AG/F4tt9CnqZiXFWwgMALd15DjFYxXsmhlMRLE+lnkPJx3mQ
         BMfMkaU42mPa1TXeVwMzENG94F3TUC2HdNeugE19f0iURGHMDlB1E5bhyFcPEdBmG1BO
         GiHKXFYt4iPfWmQRsv8eXSnvn5uJm9Re35L8VF+EzHRjhlLWys9uh05O9kb2/Bx+xgs6
         YK/g==
X-Gm-Message-State: APjAAAUuyt/zh7BbQE6fc1zuKpwB6QRVaJF5DaJmiv397BGgMAnoidIQ
        WgykrfQCGX4dcCD8gVRmbNc=
X-Google-Smtp-Source: APXvYqzvA6z3TX+lxIAMgw76yAGm1o8Dpc7j1zQuwbjyXi7fPySTexmfXazOKZIJYYO3ofN3jZkBRw==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr3071630wrr.114.1570829002841;
        Fri, 11 Oct 2019 14:23:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:3a5c:9a01:fb47:94a9:abbd:4835? ([2001:a61:3a5c:9a01:fb47:94a9:abbd:4835])
        by smtp.gmail.com with ESMTPSA id a10sm10135644wrm.52.2019.10.11.14.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 14:23:21 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
To:     lkml <linux-kernel@vger.kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.03 is released
Message-ID: <797361b7-cf6c-d3b4-c6a7-1ab2da7f4f42@gmail.com>
Date:   Fri, 11 Oct 2019 23:23:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-5.03 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from 45 people, with over 200 commits making changes
to around 80 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.03

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2019/10/man-pages-503-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.03 ====================


New and rewritten pages
-----------------------

pidfd_open.2
    Michael Kerrisk  [Christian Brauner, Florian Weimer, Daniel Colascione]
        New page documenting pidfd_open(2)

pidfd_send_signal.2
    Michael Kerrisk  [Florian Weimer, Christian Brauner]
        New page documenting pidfd_send_signal(2)

pivot_root.2
    Michael Kerrisk  [Eric W. Biederman, Reid Priedhorsky, Philipp Wendler]
        This page has been completely rewritten, adding a lot of missing
        details (including the use of pivot_root(".", ".")) and an example
        program.  In addition, the text prevaricating on whether or not
        pivot_root() might change the root and current working directories has
        been eliminated, and replaced with a simple description of the behavior
        of the system call, which has not changed for 19 years, and will not
        change in the future.  Many longstanding errors in the old version of
        the page have also been corrected.

ipc_namespaces.7
    Michael Kerrisk
        New page with content migrated from namespaces(7)

uts_namespaces.7
    Michael Kerrisk
        New page with content migrated from namespaces(7)


Newly documented interfaces in existing pages
---------------------------------------------

clone.2
    Christian Brauner, Michael Kerrisk
        Document CLONE_PIDFD
            Add an entry for CLONE_PIDFD. This flag is available starting
            with kernel 5.2. If specified, a process file descriptor
            ("pidfd") referring to the child process will be returned in
            the ptid argument.

fanotify_mark.2
    Jakub Wilk
        Document FAN_MOVE_SELF

ptrace.2
    Dmitry V. Levin  [Michael Kerrisk]
        Document PTRACE_GET_SYSCALL_INFO

regex.3
    Rob Landley
        Document REG_STARTEND


Changes to individual pages
---------------------------

mmap.2
    Nikola Forró
        Fix EINVAL conditions
            Since introduction of MAP_SHARED_VALIDATE, in case flags contain
            both MAP_PRIVATE and MAP_SHARED, mmap() doesn't fail with EINVAL,
            it succeeds.

            The reason for that is that MAP_SHARED_VALIDATE is in fact equal
            to MAP_PRIVATE | MAP_SHARED.

mount.2
    Michael Kerrisk  [Reid Priedhorsky]
        Describe the concept of "parent mounts"

rt_sigqueueinfo.2
    Michael Kerrisk
        Note that 'si_code' can't be specified as SI_KERNEL
    Michael Kerrisk
        The rules for 'si_code' don't apply when sending a signal to oneself
            The restriction on what values may be specified in 'si_code'
            apply only when sending a signal to a process other than the
            caller itself.
signalfd.2
    Andrew Clayton, Michael Kerrisk
        Note about interactions with epoll & fork

mount_namespaces.7
    Michael Kerrisk
        Explain how a namespace's mount point list is initialized
            Provide a more detailed explanation of the initialization of
            the mount point list in a new mount namespace.
    Michael Kerrisk  [Eric W. Biederman]
        Clarify description of "less privileged" mount namespaces

signal.7
    Michael Kerrisk
        Enhance the text on process-directed and thread-directed signals
            clone(2) has a good description of these concepts; borrow
            from it liberally.

user_namespaces.7
    Michael Kerrisk
        Improve explanation of  meaning of ownership of nonuser namespaces


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
