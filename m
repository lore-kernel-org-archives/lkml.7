Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4DDC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA782217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McY3ahFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFNRjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:39:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43833 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNRjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:39:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id i8so3378571oth.10;
        Fri, 14 Jun 2019 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cj2YrBABqIUb4Txe30KGzJW8RcKX3Bp0Oxq3kwUM50w=;
        b=McY3ahFypbSAMYyRfmmRMV8/iE9xZkOoE+0ZZqDXoByn7wAXTIbeZV6GrfX1ZJmWTD
         8USK/I2OabMvXToALZJk4XOQxEsxwUdeZTx25Qx1bq+QwQcjGTisCsZed1PBiu4dCb+x
         9EdZh0cEnPIN2ZFnj0KxY1f2H7HkbAhVO+ZEbtWF4GlVj3srXt7t30EN27OWzlPchBLY
         rcKf1OWHKSEKroYp3seUHgyy+t3p7A+Tc2ZQQcuJbLjKeMl7HMVY52oyO4ZpdnJxdYiA
         7TmMuneIbZMRO1zVI2O0MoPvHAqrqFMT80uguqHvQBcd/t4vnZi4UPP5XU2JaRJgTPhK
         y4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cj2YrBABqIUb4Txe30KGzJW8RcKX3Bp0Oxq3kwUM50w=;
        b=sYSybEotB+3aEyNXhsNJKEwiQKuZvnKtIjGFaYu0CoLpcbELMcU7KoKO13fThfKrpF
         Ot/87eX0UGfwOD9EX9pSS6wY1I6uTGSerc4oT98fMmPU/1SKJjSTHlM2hW3c0fj8oFPN
         xcc5hZJUBL4eSrqQ6L03m2sKcjJZhJwwnbXA/fp7sEo5C26tc6zY3g0rkDSG2cwgMxUi
         zvuSqjLHsLDM8V9RbYoQtRko8y+D101d2f3MUPiWkAbzqJFeO49ee57KfPj/fVNKv7A9
         IOcd0dzYXKoRv4iwJoE9VBxW8qmJ/P2qwzb0hlsDXRxT2FGkjtKPLVCdumaTRUrYS+Ck
         tzHg==
X-Gm-Message-State: APjAAAWCWA93aw0BCvnRtzSgc2pZJqydxUuSASqFwhEoqFW3nY89FRAj
        DUTVaCXujCveBoP5g15B7lTVVKtWQmfrw0IScBc=
X-Google-Smtp-Source: APXvYqzDLVyL5bAx97oQdtyfmEVzLY2t0mWNZu08wY0EKWFkCljWotLIqEQM++YaBRCVfEJnNHO6E61CTNlaQKg6V60=
X-Received: by 2002:a9d:4546:: with SMTP id p6mr10564274oti.34.1560533963424;
 Fri, 14 Jun 2019 10:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190612221549.28399-1-prsriva02@gmail.com> <1560458898.4805.76.camel@linux.ibm.com>
In-Reply-To: <1560458898.4805.76.camel@linux.ibm.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Fri, 14 Jun 2019 10:39:12 -0700
Message-ID: <CAEFn8qKjw+OQrxM8Bk1PXxjJ1CjkH0ritSXRx56wZs7xYLhZCg@mail.gmail.com>
Subject: Re: [PATCH V8 0/3] Add support for measuring the boot command line
 during kexec_file_load
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 1:48 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
>
> > The kexec cmdline hash is stored in the "d-ng" field of the template data.
> > and can be verified using
> > sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
> >   grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum
>
> This information should also be included in one of the patches.
>
Noted.
I will add this to the 2/3 patch, since that the one that adds the template.
- Thanks,
Prakhar Srivastava
> Mimi
>
