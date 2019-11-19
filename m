Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4F4C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788DF222D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4QCLj99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKSVos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:44:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52934 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfKSVor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:44:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id l1so4867057wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Nrt9YNbUr3U9gHzMz6e0kT9IMuvwrMlvi92HFqThdyY=;
        b=I4QCLj99TuCM6A9Q9f1kfcj8OykxBoHjFDuH2HYSxTG/W5aqdVYTwEXMLgzEh/D1qL
         CS28XXg+OHcLnyuHaveBEjxaOYQZIiBh/h7aCzyjVDQ9e2qB8epd5vd5NFWfjs7atvwO
         ijCK3z8deH1CKXmWb4dqHKmTu6gqOqC/V/fvom++ENBB9YcnvmH2AZZHZhWp5g5prW1/
         FYboPMUYkO9QlwfUIuwIQuBCxzOMneDweSNhbhhrZZiStQ1AO1KWwBza2K4a/HTlm38d
         JR5HZGAIVVCi07SfA8eNScFedxIrEC8AEOZg22S5PVp/sp/XeQkk9Bfp0SphRvYEQtXI
         ma0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Nrt9YNbUr3U9gHzMz6e0kT9IMuvwrMlvi92HFqThdyY=;
        b=reGSPzqLloQcQirJ5mbe4n1KVce0orNdWi2XwSKch42r4bfQfZOhu/noXn8xDXQSQj
         SHAmhZEAkUdDmNN/ZDSfeWS4G4d/y4sbBGjsZONQAWp4iqd8KT++4iBQAvt9+EL9ekSb
         AVSPXn3OIkWo7Q10Lz/9lpFqaEjTyWHHqSNeDAfhZcnpzuzAC9ev3Sqv9mHditoLVnDf
         tXS8FtcuSyZQvPQLKpyZUEgNk1PSbv/3ClHMXclqiX2oT9VNMzmg9I8bzHi7bqKpcNUE
         E8qM2oT1RSuI7VN0/7UUH9T5fQnC/lbMqzkGcsx2OhIU60ARlEqJMksPulHcu8im5jt+
         HZ+Q==
X-Gm-Message-State: APjAAAXb82RgDPCxRf8yUz5qJyVw+WZnTyqUqNInrbWLFB/zZkIemFDU
        LcNrafQjf12+DNdklcYs+s8=
X-Google-Smtp-Source: APXvYqwPVuriXQIpCu/4BKQGwErtHUpDT940MNeBaYw3O5vD4WDGS/hIm7toQZYOLIIVBZoKFUU8RQ==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr6204wmb.142.1574199885393;
        Tue, 19 Nov 2019 13:44:45 -0800 (PST)
Received: from ?IPv6:2001:a61:3a4e:101:8d4d:f454:a7e5:543d? ([2001:a61:3a4e:101:8d4d:f454:a7e5:543d])
        by smtp.gmail.com with ESMTPSA id t133sm4571321wmb.1.2019.11.19.13.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 13:44:45 -0800 (PST)
Cc:     mtk.manpages@gmail.com
To:     lkml <linux-kernel@vger.kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.04 is released
Message-ID: <5c4f8af1-723b-1b10-5163-f8f8b14b38ca@gmail.com>
Date:   Tue, 19 Nov 2019 22:44:44 +0100
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

    man-pages-5.04 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from 15 people, with around 80 commits making changes
to just under 30 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.04

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2019/11/man-pages-504-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.04 ====================

Newly documented interfaces in existing pages
---------------------------------------------

clone.2
    Michael Kerrisk  [Christian Brauner, Jakub Wilk]
        Document clone3()

wait.2
    Michael Kerrisk
        Add P_PIDFD for waiting on a child referred to by a PID file descriptor

bpf-helpers.7
    Michael Kerrisk
        Refresh against kernel v5.4-rc7


Changes to individual pages
---------------------------

clone.2
    Michael Kerrisk
        Rename arguments for consistency with clone3()
            Make the names of the clone() arguments the same as the fields
            in the clone3() 'args' struct:

                ctid        ==> child_pid
                ptid        ==> parent_tid
                newtls      ==> tld
                child_stack ==> stack
    Michael Kerrisk  [Christian Brauner, Jann Horn]
        EXAMPLE: Allocate child's stack using mmap(2) rather than malloc(3)
            Christian Brauner suggested mmap(MAP_STACK), rather than
            malloc(), as the canonical way of allocating a stack for the
            child of clone(), and Jann Horn noted some reasons why
            (MAP_STACK exists elsewhere, and mmap() returns a page-aligned
            block of memory, which is useful if we want to set up a guard
            page at the end of the stack).

ioctl_iflags.2
    Michael Kerrisk  [Robert Edmonds]
        Emphasize that FS_IOC_GETFLAGS and FS_IOC_SETFLAGS argument is 'int *'

mmap.2
    Michael Kerrisk
        Note that MAP_STACK exists on some other systems
    Michael Kerrisk
        Some rewording of the description of MAP_STACK
            Reword a little to allow for the fact that there are now
            *two* reasons to consider using this flag.

pidfd_open.2
    Michael Kerrisk
        Note the waitid() use case for PID file descriptors

pivot_root.2
    Michael Kerrisk
        EXAMPLE: allocate stack using mmap() MAP_STACK rather than malloc()

quotactl.2
    Yang Xu  [Jan Kara]
        Add some details about Q_QUOTAON

select.2
    Michael Kerrisk
        POLLIN_SET/POLLOUT_SET/POLLEX_SET are now defined in terms of EPOLL*
            Since kernel commit a9a08845e9acbd224e4ee466f5c1275ed50054e8, the
            equivalence between select() and poll()/epoll is defined in terms
            of the EPOLL* constants, rather than the POLL* constants.

wait.2
    Michael Kerrisk
        waitid() can be used to wait on children in same process group as caller
            Since Linux 5.4, idtype == P_PGID && id == 0 can be used to wait
            on children in same process group as caller.
    Michael Kerrisk
        Clarify semantics of waitpid(0, ...)
            As noted in kernel commit 821cc7b0b205c0df64cce59aacc330af251fa8f7,
            threads create an ambiguity: what if the calling process's PGID
            is changed by another thread while waitpid(0, ...) is blocked?
            So, clarify that waitpid(0, ...) means wait for children whose
            PGID matches the caller's PGID at the time of the call to
            waitpid().

uts_namespaces.7
    Michael Kerrisk
        Add a little more detail on scope of UTS namespaces

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
