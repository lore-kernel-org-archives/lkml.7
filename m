Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07869C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A9221901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfGYOek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:34:40 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47383 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbfGYOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:34:40 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqepJ-0001Jq-24; Thu, 25 Jul 2019 08:34:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqepH-0006NE-M7; Thu, 25 Jul 2019 08:34:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
References: <20190724144651.28272-1-christian@brauner.io>
        <20190724144651.28272-3-christian@brauner.io>
        <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
Date:   Thu, 25 Jul 2019 09:34:28 -0500
In-Reply-To: <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 24 Jul 2019 10:45:38 -0700")
Message-ID: <87zhl2uqrv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hqepH-0006NE-M7;;;mid=<87zhl2uqrv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+gVaTKVGLJz8XxpXm33KW5W1R4i/Eu1S8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
>>
>> This adds the pidfd_wait() syscall.
>
> I despise this patch.
>
> Why can't this just be a new P_PIDFD flag, and then use
> "waitid(P_PIDFD, pidfd, ...);"
>
> Yes, yes, yes, I realize that "pidfd" is of type "int", and waitid()
> takes an argument of type pid_t, but it's the same type in the end,
> and it does seem like the whole *point* of "waitid()" is that
> "idtype_t idtype" which tells you what kind of ID you're passing it.

Just to emphasize this point.

The posix declaration of waitid is:
>int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);

Where id_t is defined as:
> id_t - Used as a general identifier; can be used to contain at least a pid_t, uid_t, or gid_t.

And the BSDs at least have defined P_UID and P_GID.  So that flexibility
has been used.

So it looks entirely reasonable to have P_PIDFD that just waits for a
specified child.

Eric
