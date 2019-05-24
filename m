Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AFFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937422175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558718275;
	bh=BydsfJd27m9QuoiO790irqMOSPQgkXQY0Mipecaxdus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=joWIsnrMhIkJxq3NysXYMrfrweJUk2TdE8b+tGWSOTyq6EMkH3cdE0Jap7EKMjyyg
	 jZhraXv8Pk6CeRhBJV4lAkVWObjm1jdtMkxjVZDbglkpnV4tXSBglLWjUGklk5s2Np
	 OUJ8otndyzWnqMc+2SAc8pGhQ5Gb3vqzzAhKfyFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390901AbfEXRRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:17:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44744 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfEXRRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:17:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so9283090ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ML4p5mcs8CCYKS6Y514UR5w+hmsPZJf1FTtO2sA8c+s=;
        b=AiCXN5KMEp+e3cqt0hrF/4+aZQT9G/jyX0f3aCeEh87IZM8bYAYIOVEzTDeZ9mWQ6n
         FvPFsJFX9bxzDPUY1VBtXeqTeFyp1Z9qGkIB5F7dktR56aGRsWkPzDRphEPuucbqY/eO
         PYL8D329894MFdcKUy1yeJCYmt3XWIzuQoTnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ML4p5mcs8CCYKS6Y514UR5w+hmsPZJf1FTtO2sA8c+s=;
        b=P+OM75griDKO2UvDTMPkH/C3qHJ41Bvk0LbydcceJYZ64FE9B5ncN75R8a+Ejru2SK
         +rfAwEHkPvJc5aNfayOy6CoWXTTfMRwb86UEMieDIKrIbe0Qr3xSieRoBHjxoHwksSJA
         ZoWqJdTXdPI5xkrlpFm/65upTtLvDcDXt7o+EcGjOdogpU+4gq4i8VTJKkyFZhlGFlpR
         9Cp7csQorFyqwX+6ttfXRoKq096i1ImKf5LHyFk2nv5NXQwgR4IRP1vTb+lSsZF+RSex
         FJv9LR2UdKgTE2rhBpRAzyOgwD3X0ZlDJjJwZILWSvh/tJcvwCJSodMhEPyTK05ofCEQ
         PgtA==
X-Gm-Message-State: APjAAAVcyNbdOH9AMzlZYbE14jHPMqMB4wpoMwL2yeHWAvqyxGofrIcL
        EM1v1uCoVgVnT5OBP2mj0tKQnhk6u9o=
X-Google-Smtp-Source: APXvYqyl9Tbg7jzRqEtKcpWl+SOp4EEhI6PQiyEdcWDZhmAlpk92bYW6EEbtjL1HsCkC5XexpVXfOw==
X-Received: by 2002:a2e:1412:: with SMTP id u18mr18721672ljd.197.1558718271486;
        Fri, 24 May 2019 10:17:51 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w75sm710979lff.85.2019.05.24.10.17.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:17:50 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id u27so7691988lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:17:50 -0700 (PDT)
X-Received: by 2002:a19:f60f:: with SMTP id x15mr642060lfe.61.1558718270205;
 Fri, 24 May 2019 10:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 10:17:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
Message-ID: <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 8:19 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> This patch is intended for testing on linux-next.git only, and
> will be removed after we found what is wrong.

Honestly, wouldn't it be much better to try to come up with a patch
that might be acceptable in general.

For example, how about a config option that just hardcodes
console_loglevel as a compile-time constant, and where you can't
change it at all? There are not that many paths that set the console
log-level, and the few that do could be made to use

    set_console_log_level(x);

instead of

    console_loglevel = x;

like they do.

We already have a number of loglevel config options, adding another
that says "fix log levels at compile time" doesn't sound too bad, and
I suspect a patch that introduces that set_console_log_level() kind of
model and just makes "console_loglevel" a constant #define wouldn't be
too ugly.

A config option or two that help syzbot doesn't sound like a bad idea to me.

Hmm?

                   Linus
