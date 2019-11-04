Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A657CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EDA2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjhxObLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfKDQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:42:57 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40621 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:42:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id m20so935537vsa.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z61Nf+IXfPnYSf/CB16houpRDee1KdZw1ehNvN59rnE=;
        b=PjhxObLSYnDarkuAbAcbN/xcMBh9/RLTTwOBpfJMobbA2sy11V60GhbV1hoQ3TnrVQ
         MIGqkV7apEXKziLYFAgmPcnR7gDQ1QIfFx/fgaFfieqf9BvRpo2jDlght+XCs8RdEaeA
         x8ARi7tdM/WujTuWotF0tyekaX2W6yMiIuW12MuP0uaNGXCLGc9wvXUnbz0dJin1Q31V
         ddXKsHwKyEREN9TPTpjsetiMHoYvt7iPZtSmkRC9qkz3ySM678YNrAr5VbKNNH+CjtlH
         7GUkM+JblIdOMXy6FxStWdstKENAqGAK8jaJpNvnDfUZEztTCL3vbhro+Z+9dJyt/fJF
         aZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z61Nf+IXfPnYSf/CB16houpRDee1KdZw1ehNvN59rnE=;
        b=EKcj2QQilP7NccAkMkxilFvzGDVXKDhBJYuXvYFVcu0z6yCgJxmn+dN7QVLTJ0wWY1
         LgnrF7/+fqAoTWSmnd4B/BL0Sa+f5A0lBHeJnzn7Cu54bSFYV2tgqiR8DVazHdNlb0u5
         AS2hFwdTMMzJD5lDHlXBUqvq6gR1t/mnlaFdM0YbuFm1+8PvVa6FgtLaIbLO/pTUOH34
         QctB2dI+XmyyZhSOWebToiuPIAs0C0cA0U782WMPSpWHEyQfA0OYHbOeNBCbnVXc3QcU
         ynOA6J0MZTjRnr2NVRZyXIs/P5QTQF7wCwzap/+pCTx/hJeHUmKFkVcuYClBnK2mXtXM
         QR7g==
X-Gm-Message-State: APjAAAXb57+UnX13DS8JG1FWQC64wg1G2j4yPOWJ+lk3dI+3lcFXS7jX
        1AtGvSavtp8E8mHnpASBHH+uI4FKPIQiaSNYAJ85+g==
X-Google-Smtp-Source: APXvYqyDVcfgLDeXQC3A5gJNX8/wN+mjRR+GghpG8/3JWVcJW3k8DuwIYEezXPcXMkAZs+NIu3TLNRNVKUeU+c1tML4=
X-Received: by 2002:a05:6102:36a:: with SMTP id f10mr8580793vsa.44.1572885775766;
 Mon, 04 Nov 2019 08:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-7-samitolvanen@google.com>
 <791fc70f7bcaf13a89abaee9aae52dfe@www.loen.fr>
In-Reply-To: <791fc70f7bcaf13a89abaee9aae52dfe@www.loen.fr>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Nov 2019 08:42:43 -0800
Message-ID: <CABCJKuegREpQiJCY01B_=nsNJFFCkyxxp63tQOPT=h+yAPifyA@mail.gmail.com>
Subject: Re: [PATCH v4 06/17] scs: add accounting
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <dave.martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 5:13 AM Marc Zyngier <maz@kernel.org> wrote:
> Is there any reason why you're not consistently using only one of
> "#if IS_ENABLED(...)" or "#ifdef ...", but instead a mix of both?

This is to match the style already used in each file. For example,
fs/proc/meminfo.c uses #ifdef for other configs in the same function,
and include/linux/mmzone.h uses #if IS_ENABLED(...).

Sami
