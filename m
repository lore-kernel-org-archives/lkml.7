Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C1C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F4C20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GV/T5Ga4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfFXVa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:30:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41099 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfFXVa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:30:58 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so4878334ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1crQPJTAtGM5uUHM8HI5Md6CDkFNGlZyxi3sPcH+qY=;
        b=GV/T5Ga4ZWk+3W3tqaFce2Ne2RQBxrSLyrhdSzfTB7LlQz8v8cPfHUnL0gw97i2ytW
         U4a+Nfv1evzoydxm7+aE0QEItVbBUUIJG/3U7ZVO97sH5R/GBfQ/sK+TpOvu118vpAVE
         5Ebmq730K8DfY367AGv9eK+RcSiWu/TKO7xNIlIMr46k+uacGMr0RWHh9AkvQlBwPQz/
         3dK8NiOrmCOZBOFRnBLzpc7otO4y3P98/1Bzu4aZ7JDhtZf7jNuJnBC8VOF1BZHvZufo
         L+R4LgK/I5cGCdrR41cI4yo5nDHrqGqdldJiFjF0OI44NEPptk1A10JIl1ioUUvMRyJx
         zBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1crQPJTAtGM5uUHM8HI5Md6CDkFNGlZyxi3sPcH+qY=;
        b=Tg8I/dA8xbI61IQI0JRn9ltbZdmzMum/rGjZqjMghUF9zvJB18x3uC4K3Pa+/ih029
         C7HFaAinrBMQn28qkv+SIviPYS3g0noYtwxjOSYAE2m7FszhXvh60L1soCauvPGixiZi
         qsps5bRguKFS+I8bzbjocJpK1FON9LhtA9ATnNHoIx6XZZQuIuwpDRxHtbKh4otLdev/
         MgT+9XuoVYXk1Bh2uC2faQXcJh0blH8CYh5ZOLDqxgyhZPrAmoWOX/Cf6pBERdIybAzM
         tLO0f8Frzv6iSmdx5YHKi+TW7z1n11+XTn9qbagS7WohB8y7oyTz/F5m/VIwxvwYyNMA
         eNyg==
X-Gm-Message-State: APjAAAXxZ+IABSWrBhFbEcITjvjKxi01KY2CUXG71QBvImUcQ8jOxG+O
        D0yGiwObuUeyoBQ8lXiRx1x0U2y5hmZ4jT0/7u0HfQ==
X-Google-Smtp-Source: APXvYqwbJ6/OJ4cAqwtkSkNEdex1XxYWjuM6oISUMTZ0zxZxc1DgCYwtvFO6zbVNKmMolpTJMIfjoUOPVX3NdCWBiKk=
X-Received: by 2002:a6b:f114:: with SMTP id e20mr39401495iog.169.1561411857221;
 Mon, 24 Jun 2019 14:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-24-matthewgarrett@google.com> <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
 <CACdnJuvR2bn3y3fYzg06GWXXgAGjgED2Dfa5g0oAwJ28qCCqBg@mail.gmail.com>
 <CALCETrWmZX3R1L88Gz9vLY68gcK8zSXL4cA4GqAzQoyqSR7rRQ@mail.gmail.com> <7f36edf7-3120-975e-b643-3c0fa470bafd@iogearbox.net>
In-Reply-To: <7f36edf7-3120-975e-b643-3c0fa470bafd@iogearbox.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 14:30:46 -0700
Message-ID: <CACdnJuuHdX-y5VpqVFVDM3ORUXLNh+-XKxykxypvYKotHuk1mA@mail.gmail.com>
Subject: Re: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, Jann Horn <jannh@google.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 2:22 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Agree, for example, bpf_probe_write_user() can never write into
> kernel memory (only user one). Just thinking out loud, wouldn't it
> be cleaner and more generic to perform this check at the actual function
> which performs the kernel memory without faulting? All three of these
> are in mm/maccess.c, and the very few occasions that override the
> probe_kernel_read symbol are calling eventually into __probe_kernel_read(),
> so this would catch all of them wrt lockdown restrictions. Otherwise
> you'd need to keep tracking every bit of new code being merged that
> calls into one of these, no? That way you only need to do it once like
> below and are guaranteed that the check catches these in future as well.

Not all paths into probe_kernel_read/write are from entry points that
need to be locked down (eg, as far as I can tell ftrace can't leak
anything interesting here).
