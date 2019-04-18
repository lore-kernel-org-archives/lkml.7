Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0761EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9819208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555601870;
	bh=BJYuwYaw0D+reBrMP4ImSZ2HALbxnVIGAq6rKhvWD9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qIw/yicIEHi66srrs/ynl5BjsAwnllyTpieWHNGUo9SqcHRSOb+6loCOtVIh9yQNj
	 Vuh+97FNGMgSoCXRpEWLjC+G8YKO4qnkNze0UWKMWHZnAhp7p7J+EQ5/b4eslusNdE
	 EZMaUrTBFyGc4xb2K4CHxtK40AE/iLoxfBlnorlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbfDRPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:37:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42382 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:37:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so1963651lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XodPk0tO9XZFc6dEjJ8GEO6K1zX/cqdhaYzeogsAOy0=;
        b=cp2WXtU1lsKtCNNoK1F9P/xc+sX2rJfZ5ANlGelmk1WlUNeyJ0knbIKFQGhbNy+PKo
         83Cg6Fmik+4cSKXhO5XSkjbAyX9KmccJgvbWbSiR6+7Fc0gAf0E39IXtkNeqrjibNkTq
         mP4nj4rH54HzJWtQ2p89/O5aMymCsPUurVh5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XodPk0tO9XZFc6dEjJ8GEO6K1zX/cqdhaYzeogsAOy0=;
        b=GCwAltoePQgvb8JzQc4fje4x/eGYanwzgXbKVTfrx1j6E+mxjX8Dder1A6W1PL8sQI
         ew/XkbfE/QGhDaiG2tLzuKD4hqb8U9HWTydZgSMZw5g3Asq7oMcLteoiSjybyP/t7r0O
         hpNeBfOlIr3xfd/EWcfAyyk7G/bsowjMvFM83ex9O6mTS5qpmt/vhUd8JmzSgS/GKn5Y
         7rSBrChsdLPMn2Kc4HxH5CxcM7kHg+mIWhcLTHkS3SxUK1OGyYvZdU+Ef2hUrui11f9s
         9c4LI3MKQBFJRw1380LL1IjPeMWxRini5HN/j64an6HandsY7xpVmARuA9SSOZrvq6mf
         5L+w==
X-Gm-Message-State: APjAAAUq3beRuYWTAbw9KebIP9uckxBl8+5iggv/g1QwkcATxZZWoRfM
        Lgbp3LEgtATmZq3fwzNHjCocI8AmKfg=
X-Google-Smtp-Source: APXvYqwG8YEBIfWlpkMYOoqK5GUPSPWN8CwVMyHAPeivKLh/x5sNEs3w5duYHBhCcizGGlIlfE1Ctg==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr5411356lfn.33.1555601866392;
        Thu, 18 Apr 2019 08:37:46 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id n23sm520588lfh.86.2019.04.18.08.37.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 08:37:45 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v1so1978234lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:37:44 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr22565410lfg.88.1555601864559;
 Thu, 18 Apr 2019 08:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190418101841.4476-1-christian@brauner.io> <20190418101841.4476-4-christian@brauner.io>
In-Reply-To: <20190418101841.4476-4-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Apr 2019 08:37:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB0A_WsBpr3MFujWKi7WW9XLxUpq=z_uYTv+J7uE0wRw@mail.gmail.com>
Message-ID: <CAHk-=whB0A_WsBpr3MFujWKi7WW9XLxUpq=z_uYTv+J7uE0wRw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] signal: use fdget() since we don't allow O_PATH
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jann@thejh.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 3:19 AM Christian Brauner <christian@brauner.io> wrote:
>
>     It's just semantically correct to use fdget()
> and return an error right from there instead of taking a reference and
> returning an error later.

I've applied this one directly, because it ends up affecting the
existing code, and I'd rather just have the initial release of
pidfd_send_signal() right.

The other patches I consider to be "future release" material.

                    Linus
