Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6579EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B03D2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568414806;
	bh=AUQO8d9VJ4RK51BExwpPz05dLMQ/YQtJhgMZREkUBFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RNJbBngDeoa+rmZiQv8hixHVnONfOwcs5OWw1ziK1BLdavxbFwU9YqVEQKs90KdnC
	 t/aXLRjrNN9I29k0z5SsmiGKjDYCIiw7DjMbTCekqJPmnP5O2k2wXjwfjddD55oKqC
	 AyQQH3sMqw6cyFH88drMSoiEXPdCUfsIV3w4HUXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbfIMWqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404024AbfIMWqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:46:45 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C59B214DE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 22:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568414804;
        bh=AUQO8d9VJ4RK51BExwpPz05dLMQ/YQtJhgMZREkUBFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BoNjEodSpg4W5JjE5PixENkat8hk/T/F8P5COcIWRKMgKmRjkf5lQ69wkRqSYKbLl
         Y+fUQ0sW7u2XKQ3Qi69AlDyCbyxuno0guXJz0QlTre74OGxjKTKLN7SXUzC72WTRyk
         JGAeVci2sX4Zc1O7TVRcxZ5D3x48lv/t+1zgVK7c=
Received: by mail-wm1-f43.google.com with SMTP id v17so3784501wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:46:44 -0700 (PDT)
X-Gm-Message-State: APjAAAWixg1TzNpk27Qc17h7iD7q69+I/RCu3R0r5B/lkYmmZhNljFS0
        0pw8k1RdNFVD27uIOfJl3yaFyCwOX3reRHrTqDi5OQ==
X-Google-Smtp-Source: APXvYqzovU9CoIckvZrb5up1dANha9rMnGksogEuUHzcXG4fzddunxgVWmFjPMJL8L0HEijtct0cTWyd8+Ng4qXHuDc=
X-Received: by 2002:a1c:7a05:: with SMTP id v5mr4810174wmc.173.1568414802878;
 Fri, 13 Sep 2019 15:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190913210018.125266-5-samitolvanen@google.com>
In-Reply-To: <20190913210018.125266-5-samitolvanen@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Sep 2019 15:46:31 -0700
X-Gmail-Original-Message-ID: <CALCETrXVVB4xP2Vv-BsvELsViamjgi-ZccPhOEP2sMxBZ4dyBg@mail.gmail.com>
Message-ID: <CALCETrXVVB4xP2Vv-BsvELsViamjgi-ZccPhOEP2sMxBZ4dyBg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86: fix function types in COND_SYSCALL
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 2:00 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Define a weak function in COND_SYSCALL instead of a weak alias to
> sys_ni_syscall, which has an incompatible type. This fixes indirect
> call mismatches with Control-Flow Integrity (CFI) checking.
>

Didn't you just fix the type of sys_ni_syscall?  What am I missing here?
