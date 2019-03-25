Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36246208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="vHVyTH2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfCYRFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:05:31 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:50790 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbfCYRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:05:31 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id D97E220E6A;
        Mon, 25 Mar 2019 20:05:26 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id v5FSEMVxnl-5OB4eE5r;
        Mon, 25 Mar 2019 20:05:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1553533526; bh=z9ctgYcA/eZKhetKhIjEaWibY8L4Zk+HbgQAwjGnQcI=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=vHVyTH2pMK9fFySa72ld8g/Df8GG5XUW8CIArHCcgdg50QMA83746HcIHHzdrOzfQ
         bLLwVFK+1jGfVP9yTel6rL2PFHqnfWKfkJ3COJPxq/YMBGaLjNTofFqGE6Tz1Yi1Oq
         V9v1grEMCl0k67CQ0nAk9vSyN80tY1c/g0H3X8Js=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:1496::1:63])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 485xXsuUV1-5OLaxXMo;
        Mon, 25 Mar 2019 20:05:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20190325162052.28987-1-christian@brauner.io>
 <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8075dfac-94d2-b8c5-e37a-afe9b88bb48e@yandex-team.ru>
Date:   Mon, 25 Mar 2019 20:05:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.03.2019 19:48, Daniel Colascione wrote:
> On Mon, Mar 25, 2019 at 9:21 AM Christian Brauner <christian@brauner.io> wrote:
>> The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
>> I quote Konstantins original patchset first that has already been acked and
>> picked up by Eric before and whose functionality is preserved in this
>> syscall. Multiple people have asked when this patchset will be sent in
>> for merging (cf. [1], [2]). It has recently been revived by Nagarathnam
>> Muthusamy from Oracle [3].
>>
>> The intention of the original translate_pid() syscall was twofold:
>> 1. Provide translation of pids between pid namespaces
>> 2. Provide implicit pid namespace introspection
>>
>> Both functionalities are preserved. The latter task has been improved
>> upon though. In the original version of the pachset passing pid as 1
>> would allow to deterimine the relationship between the pid namespaces.
>> This is inherhently racy. If pid 1 inside a pid namespace has died it
>> would report false negatives. For example, if pid 1 inside of the target
>> pid namespace already died, it would report that the target pid
>> namespace cannot be reached from the source pid namespace because it
>> couldn't find the pid inside of the target pid namespace and thus
>> falsely report to the user that the two pid namespaces are not related.
>> This problem is simple to avoid. In the new version we simply walk the
>> list of ancestors and check whether the namespace are related to each
>> other. By doing it this way we can reliably report what the relationship
>> between two pid namespace file descriptors looks like.
>>
>> Additionally, this syscall has been extended to allow the retrieval of
>> pidfds independent of procfs. These pidfds can e.g. be used with the new
>> pidfd_send_signal() syscall we recently merged. The ability to retrieve
>> pidfds independent of procfs had already been requested in the
>> pidfd_send_signal patchset by e.g. Andrew [4] and later again by Alexey
>> [5]. A use-case where a kernel is compiled without procfs but where
>> pidfds are still useful has been outlined by Andy in [6]. Regular
>> anon-inode based file descriptors are used that stash a reference to
>> struct pid in file->private_data and drop that reference on close.
>>
>> With this translate_pid() has three closely related but still distinct
>> functionalities. To clarify the semantics and to make it easier for
>> userspace to use the syscall it has:
>> - gained a command argument and three commands clearly reflecting the
>>    distinct functionalities (PIDCMD_QUERY_PID, PIDCMD_QUERY_PIDNS,
>>    PIDCMD_GET_PIDFD).
>> - been renamed to pidctl()
> 
> Having made these changes, you've built a general-purpose command
> command multiplexer, not one operation that happens to be flexible.
> The general-purpose command multiplexer is a common antipattern:
> multiplexers make it hard to talk about different kernel-provided
> operations using the common vocabulary we use to distinguish
> kernel-related operations, the system call number. socketcall, for
> example, turned out to be cumbersome for users like SELinux policy
> writers. People had to do work work later to split socketcall into
> fine-grained system calls. Please split the pidctl system call so that
> the design is clean from the start and we avoid work later. System
> calls are cheap.
> 
> Also, I'm still confused about how metadata access is supposed to work
> for these procfs-less pidfs. If I use PIDCMD_GET_PIDFD on a process,
> You snipped out a portion of a previous email in which I asked about
> your thoughts on this question. With the PIDCMD_GET_PIDFD command in
> place, we have two different kinds of file descriptors for processes,
> one derived from procfs and one that's independent. The former works
> with openat(2). The latter does not. To be very specific; if I'm
> writing a function that accepts a pidfd and I get a pidfd that comes
> from PIDCMD_GET_PIDFD, how am I supposed to get the equivalent of
> smaps or oom_score_adj or statm for the named process in a race-free
> manner?
> 

Task metadata could be exposed via "pages" identified by offset:

struct pidfd_stats stats;

pread(pidfd, &stats, sizeof(stats), PIDFD_STATS_OFFSET);

I'm not sure that we need yet another binary procfs.
But it will be faster than current text-based for sure.
