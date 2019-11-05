Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB2DC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94CD217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uv+lqTeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390004AbfKEPz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:55:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45116 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389096AbfKEPz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:55:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so8819127ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBjPVawkw1D9alty2gxLh6X6OcB+iTnvmGu5mIHwLJg=;
        b=uv+lqTeLWQdQa3Az+claLZ2Why5fQC8C3uqj/IVPZrAu/WNR4AVwgyjksYefYB//Lb
         6MQfsmN9eqwJC8gCdiVTJqA6uNqBe3y3dmPqF2me9g9Jg33v8hzZBWCT0tt+bHnA8HIk
         almprJnYwnBhBEVLwEWJtGqpKDYAKJfmY3cssi4VAasH8tZfn/UgUFxJyhyVkwD0hVwX
         bUskZyfPEsz8sxqVqdaGQ0g7EVvRetUYPr0XpAxLBuWk2VppC53JYQ4cvvyw/Tk32c3g
         Y48KJDS8SIgYst++jQrQDEExvG07MbUpzJPdRNXfXVIYCsNtIBzk+7qIeQIMKt5h1aU5
         x0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBjPVawkw1D9alty2gxLh6X6OcB+iTnvmGu5mIHwLJg=;
        b=sE5Hdr7nqhu6A8n88I5YXJmd3hHfN6QN04faZT3o5TnG3RXyOOkFlVcoJGoiYfP8jZ
         EnCl4HsULdWm2f3/Z1NBz9nui94YfxirKBeJp6c8c/i8IKe73/s8aITomZ+D4MvP+gXR
         VbnxJiIHJpUZQ/H5gv2V/3kToJOSOprR0zNFQLhf6PE98VLqsVPLsHxPdED4ZZJNZJWB
         Xgh6NID8t3QaiVE/f9kGmRq0v8OKOE0VBynoj4IimdSTUvvmmVN7zILlGSaFtds3uZ5D
         bRC1LvAIj3KY8zc1l2CcuVpU6wcLm6RieMs4RMpdaV0tdzh4a+CG6cdXgKfhE6RF9+j1
         7pXA==
X-Gm-Message-State: APjAAAXv1/Umlv7jgHyEjzT2ICz/f0l4woDp8HWXy6LIHibCQZ4tajaQ
        T6wjtclxfJwUCPodWJmbHLMVYJyyUOiRiPxMpG8lCEWPAo0=
X-Google-Smtp-Source: APXvYqxzXAYCCtN4vYGeUwBs7NzYo7aq+jmkHe7kRaIoNYXrHcoEVfLgw9HeYSsNg1dpsk5d7gY8SOAg2C6mzEQPfuY=
X-Received: by 2002:a2e:b4aa:: with SMTP id q10mr19425669ljm.250.1572969353779;
 Tue, 05 Nov 2019 07:55:53 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com> <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 07:55:17 -0800
Message-ID: <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 7:29 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
> descriptor table from the read() implementation of uffd, which may have
> security implications for unprivileged use of the userfaultfd.
>
> Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that have
> CAP_SYS_PTRACE.

Thanks. But shouldn't we be doing the capability check at
userfaultfd(2) time (when we do the other permission checks), not
later, in the API ioctl?
