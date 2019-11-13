Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184CAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44EB222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ix+CLznp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKMLwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:52:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47014 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:52:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id o65so1679730lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 03:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFFqqw3Ufa59nPQnO8AKe8pY9aTYmmOb+lK9fMEzTEM=;
        b=ix+CLznpSQ1tLLZNz6RZCFgQPIdlVL5Q151AabB6uzzkATEHkpiVu9sFStKHPccleW
         PbED9WU5uFMaahVpLXgFur/D3fLr0bGcHOg8RFJA/WYt961ovBJ3uhiU6ZCpLNg/sE4R
         p+ANHITh49GCRGISYUr590QTEHKy5VhPju4bAkYic0G791xmPvDu5G9v2T1YxEB2tHoI
         D8OYSkKrJB4xwN0X0p8Cm594DYemIlXIxQhjW+v6kOX7pAJbB0mxJuuKacyfkiBcecOD
         daDXWjmeJVLUbFkfEeF2yWoIugHe+j1hv2+S5GscZ5fsfVTC/5BOqSN6sfqpkYa+ey9R
         9t6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFFqqw3Ufa59nPQnO8AKe8pY9aTYmmOb+lK9fMEzTEM=;
        b=AhkJKkh3EgxbfjBlopsOvWdTFj08TP/IovTzNCCd+wHYvWWajQpPYCouL+NTtXBW7G
         4kZCn1Stg8aoiC60lHObmo+s/1ZZ8tQcclDOomxGEp6AYUH9UMy86mG3VYfUHtSxBgYV
         D8ONjZsHRYlHskisIkvuYFFaKnYWrlnztVvBgl5iGzBkYJrz/FYpVufCpzB568x28hsh
         jgEvbhy5W4QGmKr2R5EGahdUytHyJK8MrQRvyW5c9V56b5x8Y72wRuYU2mMA0GDaL0oc
         fLmHl2Vi8rc1EOcKpgp+yM80kti8UHxOlm9ow/fToqZ40o+AKOHEU91jBzpiRvAmXHtE
         YpQA==
X-Gm-Message-State: APjAAAWZczTcmSxWuFOgUMEgRQY2Z8/tduAAJbgjyLy48V9vAB7AG0+9
        1r0zk0Be/nmy98d/qa3vmBmJUsD7GjuDRScFVgQ48A==
X-Google-Smtp-Source: APXvYqzsyQcFkqMZpLWI3lpEJvXQ9RpSigELq+4YJMGbdlmhcpv7Scg9IpZbaobC2l9k1GV1ST0Y+vojiL21+eqgTQU=
X-Received: by 2002:a19:9116:: with SMTP id t22mr2284983lfd.99.1573645965075;
 Wed, 13 Nov 2019 03:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20191011122323.7770-1-ckellner@redhat.com> <20191014162034.2185-1-ckellner@redhat.com>
 <20191014162034.2185-2-ckellner@redhat.com> <20191015100743.t6gowsic7c347ldv@wittgenstein>
In-Reply-To: <20191015100743.t6gowsic7c347ldv@wittgenstein>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Nov 2019 17:22:33 +0530
Message-ID: <CA+G9fYu=Z+mZs7+571PbChODV2drUYrxkdWEb7=XqkK2O3_Tyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pidfd: add tests for NSpid info in fdinfo
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Kellner <ckellner@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Tue, 15 Oct 2019 at 15:37, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Oct 14, 2019 at 06:20:33PM +0200, Christian Kellner wrote:
> > From: Christian Kellner <christian@kellner.me>
> >
> > Add a test that checks that if pid namespaces are configured the fdinfo
> > file of a pidfd contains an NSpid: entry containing the process id in
> > the current and additionally all nested namespaces. In the case that
> > a pidfd is from a pid namespace not in the same namespace hierarchy as
> > the process accessing the fdinfo file, ensure the 'NSpid' shows 0 for
> > that pidfd, analogous to the 'Pid' entry.
> >
> > Signed-off-by: Christian Kellner <christian@kellner.me>
>
> That looks reasonable to me.

on arm64 Juno-r2, Hikey (hi6220) and dragonboard 410c and arm32
Beagleboard x15 test pidfd_test failed.
and on x86_64 and i386 test fails intermittently with TIMEOUT error.
Test code is being used from linux next tree.

Juno-r2 test output:
--------------------------
# selftests pidfd pidfd_test
pidfd: pidfd_test_ #
# TAP version 13
version: 13_ #
# 1..4
: _ #
# # Parent pid 10586
Parent: pid_10586 #
# # Parent Waiting for Child (10587) to complete.
Parent: Waiting_for #
# # Time waited for child 0
Time: waited_for #
# Bail out! pidfd_poll check for premature notification on child
thread exec test Failed
out!: pidfd_poll_check #
# # Planned tests != run tests (4 != 0)
Planned: tests_!= #
# # Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
Pass: 0_Fail #
[FAIL] 1 selftests pidfd pidfd_test # exit=1
selftests: pidfd_pidfd_test [FAIL]

arm32 x15 output log,
-----------------------------
# selftests pidfd pidfd_test
pidfd: pidfd_test_ #
[FAIL] 1 selftests pidfd pidfd_test # TIMEOUT
selftests: pidfd_pidfd_test [FAIL]

x86_64 output log,
-------------------------
# selftests pidfd pidfd_test
pidfd: pidfd_test_ #
[FAIL] 1 selftests pidfd pidfd_test # TIMEOUT
selftests: pidfd_pidfd_test [FAIL]

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/kselftest/pidfd_pidfd_test
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/pidfd_pidfd_test

link,
https://lkft.validation.linaro.org/scheduler/job/993549#L17835

- Naresh
