Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A22CC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641B42084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ux5jbquF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfHNSCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:02:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40675 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbfHNSCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:02:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so7171otb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GKs5FPWymwQ5gbNZtdTdyRE1Nom6j8+Rxk1X5Ak3ho=;
        b=ux5jbquFlU00xiYhyCHomWd5e32yEqg48ZmXd5Kocjz5nhLaYh6WxI9VNlnCNfdxXe
         Yiip9K8vSXkS/iwxJk5PeIQ1aniVfrXPti8aC2lM/bykilrlvCUl16CRS2nKiJhmNlmh
         CWonW6QNpGzk7nOcd7UR0Zb/ewa6RGZ1S5JFj73exIoBaDEtPZ4R9pSNe4S0BxWBKsYn
         2RqAWQFosegu+aSrRCE5Gt3tAK/jb5qTIhRDF7Ty0EJ3W3EBXWcmX5wuXfXeGMsShLre
         lP9LQKbLCYB17G8cXA7Sgq7qyhzp8TnBxoz+XJ5SDnfoOqDCUh8upgGBhxaqLxoMixrj
         XN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GKs5FPWymwQ5gbNZtdTdyRE1Nom6j8+Rxk1X5Ak3ho=;
        b=cQfahDX71MzeArbv1bVgHkdrA9WNjPKjYGUGtmYmuaTyFvaxoKiuumlm4VjHRGjwqI
         r4MBmvPIkPWz0MdsNGh4JhC3MyN+mN5xBHVAfqxlG8FUUUDEEBxpn/6RkhWNUKk6iWsU
         AARaZBqCPZ2FcGq8O4Lf6cNLB8u6iGDGgCZTRfqETr9HownbnaBcCMZkAro1QU0WJ3pj
         skfQp4ks+dYFh3WHy2uEJTz2ho48XhX5IwIaLWcTGN3+x+vEftx0zSiK6eYeqLGo72ST
         VMKbRpLborK2y6jo0TobQYKcL9GhhjXzI6hNA9JMSR2oJDrBEQWVXGpw6xykyd81ieJz
         dglA==
X-Gm-Message-State: APjAAAVOiHFucEr+B3/jrz3b2Y4kAJVhhUzg6Xku0L3XVuwx+xd/R1SC
        wr0L/CPi5wn5mVOJnvwEtK8/rjsBgEVK3mAaWrb+4A==
X-Google-Smtp-Source: APXvYqzmpHudrjVFaOAaYw4VS7cZnHmFbCJw0EyJVqf5FRTM6F8GCZmq3Mx8zMllZGVFxW/G3bIOgn3IkDXpEgvjxPc=
X-Received: by 2002:a5e:9404:: with SMTP id q4mr1266718ioj.46.1565805764794;
 Wed, 14 Aug 2019 11:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
 <20190808000721.124691-16-matthewgarrett@google.com> <20190814072602.GA27836@zn.tnic>
 <CACdnJuuOhuw71GDwQOrPQxUexpvpZNJocr6m0dYzJw+MMaVKWQ@mail.gmail.com> <20190814174732.GD1841@zn.tnic>
In-Reply-To: <20190814174732.GD1841@zn.tnic>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 14 Aug 2019 11:02:32 -0700
Message-ID: <CACdnJutcF6ZdQKwz7L+i9FUuD8SBsHuhk8rwQpwfDsCpM1y9dA@mail.gmail.com>
Subject: Re: [PATCH V38 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:46 AM Borislav Petkov <bp@alien8.de> wrote:
> Yeah, ok, I see what you're doing there. AFAICT, you do that in
>
> setup_arch->acpi_boot_table_init-> ... -> acpi_os_get_root_pointer()

Right.

> I hope nothing needs it earlier because then we'll have to restructure
> again...

Passing the RSDP via command line is a pretty grotesque hack - we
should just set up boot params in kexec_file, which would leave this
as a problem for legacy kexec and nothing else.
