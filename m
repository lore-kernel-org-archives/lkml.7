Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003B5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06C521926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563989876;
	bh=tUbjma6wnK8/sAbaZn8K00CEeOWMSwub3fWq32Z6ysA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2rbgnihTz4V6zsbAtkQhe4FLrWVidthSzfl7lgpMHeFDTGW+wcDkQahcE6aScg0A6
	 o8B0WO8LVRz8bp4KEDxkttCRNt0QyHtVkHT8EpwgjYPUkyQYN8lkMLLfqa3amEqkbv
	 7gfebJJflJt3FU7IK24UdYT6kGCISibG9aLBLrQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbfGXRhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:37:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34185 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfGXRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:37:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so45322933ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHWcMU5Vdp2RzMeARQZwXgD9/0N7iPyalNjDDuAMZL0=;
        b=SbHSIb4uHTOyzVxpD/Qq/cOAkqA69PjiJ0SQszdK9GQ98snpnSWwFTpob3Yq1Z1yLR
         aae8Jprm9a/rPT6zRqYrIcAnPFR6xdNtyvTjIWZQmV8Q5oF4DIzZO1qadBBHOiNU57pC
         IAfGdcRk+5unMEIhEVPbzA5TfmURWmXgvrIAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHWcMU5Vdp2RzMeARQZwXgD9/0N7iPyalNjDDuAMZL0=;
        b=qCpRShjV1VoSs8EYBlGgAi7JfvrvrfziqfusUAZ0m2PGR2gr8ZvNeH6uqbCilNh0ze
         Gcq6ls/day/6qY2Xc7eHcH3a1jravZlsISwb31MFK5vpU7ONy+I9DdMoMeUosBVtFK2M
         wc1EAbrN2Wd9hRDvBegr7+QYrsd3vkZUI0cvDNSqUhPusgdld0s29BdnAbb9QIL2+QwE
         HCLSjPD34r3jIHfM+TIcXkQGxdL/HD9TJXR4V90WJOJ5+ApLxhNOJ1b00RRi8ey9uO0B
         UvsxRIqp9tDb/mBzz2K9pDWWIEltV+MYO+T4LmS7IhVZFlI8sr2yGRSoYZ7KaCwULrHF
         R5OA==
X-Gm-Message-State: APjAAAV/FUSz/hP4nUdJ46xS0yHo75GbJwl9witP8KA+ToL3vVsSDzUh
        Rt5zcybNxrlJ8wJlhCk3uiLTY+M7ntw=
X-Google-Smtp-Source: APXvYqzzpVKgkl0Aw4gAVUh1DFlYldstDxnVPXvAmxjHy5cp/p4tQ2561rZNYTaja/GTPWDppnFp4Q==
X-Received: by 2002:a2e:9155:: with SMTP id q21mr42725990ljg.198.1563989871636;
        Wed, 24 Jul 2019 10:37:51 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v2sm7113999lfi.3.2019.07.24.10.37.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:37:50 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v24so45389481ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:37:50 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr13840192ljg.52.1563989869832;
 Wed, 24 Jul 2019 10:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-2-christian@brauner.io>
In-Reply-To: <20190724144651.28272-2-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jul 2019 10:37:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
Message-ID: <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5] exit: kill struct waitid_info
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
>
> The code here uses a struct waitid_info to catch basic information about
> process exit including the pid, uid, status, and signal that caused the
> process to exit. This information is then stuffed into a struct siginfo
> for the waitid() syscall. That seems like an odd thing to do. We can
> just pass down a siginfo_t struct directly which let's us cleanup and
> simplify the whole code quite a bit.

Ack. Except I'd like the commit message to explain where this comes
from instead of that "That seems like an odd thing to do".

The _original_ reason for "struct waitid_info" was that "siginfo_t" is
huge because of all the insane padding that various architectures do.

So it was introduced by commit 67d7ddded322 ("waitid(2): leave copyout
of siginfo to syscall itself") very much to avoid stack usage issues.
And I quote:

    collect the information needed for siginfo into
    a small structure (waitid_info)

simply because "sigset_t" was big.

But that size came from the explicit "pad it out to 128 bytes for
future expansion that will never happen", and the kernel using the
same exact sigset_t that was exposed to user space.

Then in commit 4ce5f9c9e754 ("signal: Use a smaller struct siginfo in
the kernel") we got rid of the insane padding for in-kernel use,
exactly because it causes issues like this.

End result: that "struct waitid_info" no longer makes sense. It's not
appreciably smaller than kernel_siginfo_t is today, but it made sense
at the time.

                 Linus
