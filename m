Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F8FC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 00:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6896C2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 00:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A10E0Zkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK0A7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 19:59:15 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46955 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfK0A7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 19:59:14 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so22807053iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 16:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VbU/38+yNJ+zfC9u+frCXiwxMQpfNcWxp5XLS8niF1A=;
        b=A10E0Zkk+zRrcOORDMMGCsKvy9BHFgf9FxT8Q5Z+F9T0wHGy8ix5R/AeW+qpfr2BLY
         AuSpKXkAJKbWFrfzzgtr9gXIip0OYbus86/WG9/IaIKfRq2eNqfUL4oW0gSl7kAGiLKC
         hpLn9uWQyeaELHETva1e3D83DjU/edfu7aUWAOAV7ru9LRkEs1dfRabuSYfIFDcLaDFu
         IReRx9b2JQ1INbGgMuTdZECfpMi3o8NeOqWOkz82VQhy4PIh54PN+jRYK96gnq2z7w4q
         ywrDF0yv5vR+B5AzLX9VjE216xTiY7ZcEEGWPiRNZbxy8JRTu5eTmdXKEHIE7XLW7Xbq
         V6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VbU/38+yNJ+zfC9u+frCXiwxMQpfNcWxp5XLS8niF1A=;
        b=ZynSNrs42KZJn63In/htunXHKiZqfwb0yrEfXFjiDexYTLYYMc1Ifd5lqpQUtRNFcW
         pAJI4OghZWnL4GhoIPWj7PAFK8bhzgNmFf8CWBa1IxDA0j4KperfSPuhTizTfZW7nA+D
         G4SEh6jwEhdJ6mBMfibnsPmoYJ1myrW5OTAS4gLOXKDKpOA43c1zGcvjre6UceQpwNE7
         SdvX8PYYk0i4hFQOFKz4uebwoucXe5O5WBSkQG9ftzUUZP71uYydSJhgJofkHsl3KArU
         wNNNTR7ItRwsLYa/eRm/Y8KQhFilbBWSeMvxFyoVJKEQo6qSPMjPQVyGuOKX3PJBKQdH
         Qfgw==
X-Gm-Message-State: APjAAAUNeXC4xOT6dGwt454IRM1JiETx/99GdJQ4XsgaVWU9n1lC7r5G
        JvGQbblzgVO7rWBDYPcjWj16sg==
X-Google-Smtp-Source: APXvYqxCcCkr//QkJqo4RilDXTt5UmXBfkRr7b/U5pz2/bN55Ik8XDB5pe77KNzYh8fyijKcertCWA==
X-Received: by 2002:a5d:9b08:: with SMTP id y8mr36537219ion.108.1574816354041;
        Tue, 26 Nov 2019 16:59:14 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id k20sm3215043iol.3.2019.11.26.16.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 16:59:12 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:59:11 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kees Cook <keescook@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, bpf@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel test robot <rong.a.chen@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Tyler Hicks <tyhicks@canonical.com>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        Yonghong Song <yhs@fb.com>
Subject: Re: [GIT PULL] seccomp updates for v5.5-rc1
In-Reply-To: <201911260818.9C5DC1E@keescook>
Message-ID: <alpine.DEB.2.21.9999.1911261656110.23039@viisi.sifive.com>
References: <201911260818.9C5DC1E@keescook>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019, Kees Cook wrote:

> Most notably, the secure_computing() prototype has changed (to remove an 
> unused argument), but this has happened at the same time as riscv adding 
> seccomp support, so the cleanest merge order would be to merge riscv 
> first, then seccomp with the following patch for riscv to handle the 
> change from "seccomp: simplify secure_computing()":

The RISC-V pull request that contains the seccomp change has been sent.  
It's here:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1911261311520.23039@viisi.sifive.com/T/#u


- Paul
