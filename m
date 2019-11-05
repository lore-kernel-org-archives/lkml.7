Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DDBC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FF420656
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbGKKPGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbfKEQl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:41:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41238 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390123AbfKEQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:41:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id m9so22590279ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPAWoJPOWFI9tZt+Z9WZhKGPSIvelnJJqs8XUy+V46k=;
        b=CbGKKPGgaC64y9p1BQq2+o8j3eZeZ9xzHn8JM0uVa/q2Dp+fcmnbfaSGvPUxtlWjOS
         ynZSdksFstX3dfMBSBg9tio5MZWnxRY6E7meZbkdx/z1h07ghzvK3IuvI1rXj14LMx+A
         3PsnudVi44KqkoSJSpfg66RMkDWNbjEBwkW8KDptiEdJzM5ryLb72MooGxElnni7OIKe
         zx9XJ0wui53vXA58fv5HWJnIk+ltmjQZ8JsgFM6ipJSqo7wifvmA4eEw1JObeYBkkXSH
         Ffb7hexTfsnPXuxAufhBpC0ii8o0VzIJ7yjyvhHtQ1CwosO8muSP1sgfcpjtqOgt3GeT
         8FuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPAWoJPOWFI9tZt+Z9WZhKGPSIvelnJJqs8XUy+V46k=;
        b=ECh7Rp48axmaiJuR0LKCgunu+dhFf4qTmVqmDbshuIthoZvY95Q6aldmV9deRcEOu8
         jK9dXbJ68T/MEjMj6r2f+RHkw6yhA97nZI/+7awUrv2jC+YOOEXrrlFtBvkJhTfVtGOs
         CwVFjd9KjmSb1zXZtz/MMXr3qY9/UzHiVqkDZ/neZzj6bHWGeMLeAXH/GguWsxysiDoy
         Lexde4VcaTagrQqjfQLK+wNwu5ptB4Uy8xrX4qFGBxPQ0U5oF2KgTKt/u8MvDtyCmK9G
         PkYZ9ukjTkXmeR5XZncCNQQQUYV21LStagp4POf6URtB/IQ8ZIXcdnZO/rPKY8O88Rkn
         Knpg==
X-Gm-Message-State: APjAAAWAWeVtyt4sdlTZEqSRmaAXRME40jWUChT34gg9aY4QaIlKFN9j
        Dn98QpLVbK67XIIMiOlk4z4sT/u2kD79MLXWt5VBiA==
X-Google-Smtp-Source: APXvYqzJhVMjwxTvLIsbgfPh/CEzKCXdjh4ZL0tYyqLClkvm34sCnU8o9OP8Jjv4YmS1doxJFXVAsqkHWRlEyPnswzU=
X-Received: by 2002:a2e:3111:: with SMTP id x17mr23711544ljx.146.1572972114631;
 Tue, 05 Nov 2019 08:41:54 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com> <20191105162424.GH30717@redhat.com>
In-Reply-To: <20191105162424.GH30717@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 08:41:18 -0800
Message-ID: <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Nov 5, 2019 at 8:24 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
> The long term plan is to introduce UFFD_FEATURE_EVENT_FORK2 feature
> flag that uses the ioctl to receive the child uffd, it'll consume more
> CPU, but it wouldn't require the PTRACE privilege anymore.

Why not just have callers retrieve FDs using recvmsg? This way, you
retrieve the message packet and the file descriptor at the same time
and you don't need any appreciable extra CPU use.
