Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE47C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739332071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="HSu8OsTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLIHEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:04:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39144 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfLIHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:04:53 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so13606369ioh.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8VrpkdgQrnMuSOUeurvVW4z5wWNDdr+43CeOmu+R6D8=;
        b=HSu8OsTo4/VtQt5rmELSu4Joyw16NEM5RVv/RNBtEfBSy/DpLzQ+ESzqWonDFjw5ry
         iuBBg7SqksIqsJ2MJ9s0w3T8lk5KE7eh/5C7XChjfLivhhGUdegPB8z+1csZwHzyiiYy
         ultBTBS3b3I4zQa2RRZ7jnW+qaQKJdD6sBwQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8VrpkdgQrnMuSOUeurvVW4z5wWNDdr+43CeOmu+R6D8=;
        b=Gqfz5Ks696F/RF4j4DrxP+1JKaSoK54ZICFpPIz+UVb63uzVA47sgA2aYt96t4MfOM
         Wd4gebTnVzrmrKUH3dZLMA3jgtGk6s4zwMVKoDr3n79VLJeSrchKmbgeL/9a6ZX4hrwf
         EcE7uLzFgOFiIi2VeHsNoPeo1Ze0+tnkYYAtNxp6KuG4jvCNKeK/h7lP9JVbbYnjsyVj
         5G8enRDNYx9R/SfQEfHdHvzB6sXUHri5gjSYkq7JV0yS7rUUkzk2D3883OnbV+QTT/pb
         NTj0ZTbAJoofXaZJ9inWxRFQJuyfhEq2FMOzHc1n4gdnel34c6mAcsBuWpOrw/sMCXCB
         CC/Q==
X-Gm-Message-State: APjAAAWMjYkx7t4ARPecYtkJUFMOneD7A+lLUrclAk43QxmMQRPL0buJ
        Ci/cnMfKOsoFIhzvtZ7Quy6R8OrunBR4ig==
X-Google-Smtp-Source: APXvYqwsZDjYTujGClfn7hASFQzQ3ywZgbD8A/L942G+ugOls0cc0a4XwERFsQxcrrOTYvGtbyueng==
X-Received: by 2002:a6b:7316:: with SMTP id e22mr20331932ioh.205.1575875092332;
        Sun, 08 Dec 2019 23:04:52 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id f76sm6543960ild.82.2019.12.08.23.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 23:04:51 -0800 (PST)
Date:   Mon, 9 Dec 2019 07:04:50 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 0/4] Add ptrace get_fd request
Message-ID: <20191209070446.GA32336@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchest introduces a mechanism to capture file descriptors from other
processes via ptrace. Although this can be achieved using SCM_RIGHTS, and
parasitic code injection, this offers a slightly more straightforward
mechainsm. It also does not mutate the tracee in any way, nor does it
require that the tracee is stopped, as to avoid causing issues with
attaching debuggers or runtimes that expect syscalls to be preemptible, or
return within a specific amount of time.

It has an options mechanism that's only usable to set CLOEXEC on the fd,
but I'm thinking that it could be extended to other aspects. For example,
for sockets, one could want to scrub the cgroup information.

In the future, the API may not require ptrace attachment, or seizing, but
right now it does as a matter of safety.

Changes since the RFC v1:

 * Introduce a new helper to fs/file.c to fetch a file descriptor from
   any process. It largely uses the code suggested by Oleg, with a few
   changes to fix locking
 * It uses an extensible options struct to supply the FD, and option.
 * I added a sample, using the code from the user-ptrace sample

Sargun Dhillon (4):
  vfs, fdtable: Add get_task_file helper
  ptrace: add PTRACE_GETFD request to fetch file descriptors from
    tracees
  samples: split generalized user-trap code into helper file
  samples: Add example of using PTRACE_GETFD in conjunction with user
    trap

 fs/file.c                          |  19 +++
 include/linux/fdtable.h            |  10 ++
 include/uapi/linux/ptrace.h        |  15 +++
 kernel/ptrace.c                    |  35 +++++-
 samples/seccomp/.gitignore         |   1 +
 samples/seccomp/Makefile           |  15 ++-
 samples/seccomp/user-trap-helper.c |  84 +++++++++++++
 samples/seccomp/user-trap-helper.h |  13 ++
 samples/seccomp/user-trap-ptrace.c | 193 +++++++++++++++++++++++++++++
 samples/seccomp/user-trap.c        |  85 +------------
 10 files changed, 382 insertions(+), 88 deletions(-)
 create mode 100644 samples/seccomp/user-trap-helper.c
 create mode 100644 samples/seccomp/user-trap-helper.h
 create mode 100644 samples/seccomp/user-trap-ptrace.c

-- 
2.20.1

