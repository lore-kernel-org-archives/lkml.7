Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8A4C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A7A2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563990673;
	bh=/+zREwEAtGmwxLbsUnbNo0Rx8PZv5erB81VI4+AdOfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q8RDDnqs6RKWoA6rw69TK3I7DAJZTMBWNKP9rvJ/5Wh9rAYKzqG1SKi1ic6MkZlpu
	 yWPDId3nYh5ARBcBZknrkbLrr14gfq30KCwxaHpYduF84TexC0nxBOhP4JNA8Yf8/t
	 mS8cpMGfuUlLoc1jjNVxWrTX2zbPg5dtUClxNEHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfGXRvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:51:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42295 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGXRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:51:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so32566348lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95+Ojj8whLDzTQfSvFpUfZPQNS2ad16YlfE2wY3FNvs=;
        b=Q1otmVXyrcOvARrNHCq3mme+hGOPc0EnMeptu7eG3VCcjT/HkP54TR+dyDnM4qL9d5
         FonTz95jDa6pthaSmRyHWkpw1Tde3zEXeGdzrSTuS5RS8pvNtLbrl34+D57HnUjtTzDS
         e7q295+fYzIVl3K0F+jR//YtMKvddGwPmrsD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95+Ojj8whLDzTQfSvFpUfZPQNS2ad16YlfE2wY3FNvs=;
        b=UgrKL4R/VQVw9nGFsrPn/C7UaG2TM8LIcgjTDsyXKEjRfVLYQKmqvt2tV5sHnK5JB4
         L9bMpRPbB2rprlb/3TTizddTvrC0UKEVpXmdrkpEys6aPP2E4ZxLHfTLM/9mYaawuguw
         LMBOHAOtlriu4aznk3+YNn/iqbcDI0+ELoqhAP2PF2wL1Cu8Rozu83fQsP52Lu8s8Cff
         KX75sGAsRSQdYJ9p3GRyH680otVF82bZsNMrnfTsWxnV7EHGru64xAEe3JcSyRYBQXW+
         61gWyqMCU2Wy3J87CY3SF9qLP7nGT6iOk+vlWiqyN5EN13T8WqmqppAwNtay/n91mgFC
         SU9g==
X-Gm-Message-State: APjAAAVxIKC1WIba/Tyw4xXneoyIcyJulsSMrwojbmu+Z/7RwHG6KMGL
        avhI0dSZDuEMRk816uFSFdP7L0cAsHE=
X-Google-Smtp-Source: APXvYqxIxULzOvLISGIW3oZN0fdWm+avt+gNfmiMWg29+O9YNo7tDNgHfOaFNYqNBQDDRgRlcYmoMg==
X-Received: by 2002:a19:c7ca:: with SMTP id x193mr37923518lff.151.1563990669551;
        Wed, 24 Jul 2019 10:51:09 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id p5sm8697586ljb.91.2019.07.24.10.51.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:51:09 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id x25so45406839ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:51:09 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr44841672ljj.156.1563990354068;
 Wed, 24 Jul 2019 10:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-3-christian@brauner.io>
In-Reply-To: <20190724144651.28272-3-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jul 2019 10:45:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
Message-ID: <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
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
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
>
> This adds the pidfd_wait() syscall.

I despise this patch.

Why can't this just be a new P_PIDFD flag, and then use
"waitid(P_PIDFD, pidfd, ...);"

Yes, yes, yes, I realize that "pidfd" is of type "int", and waitid()
takes an argument of type pid_t, but it's the same type in the end,
and it does seem like the whole *point* of "waitid()" is that
"idtype_t idtype" which tells you what kind of ID you're passing it.

               Linus
