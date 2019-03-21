Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C84DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EA820835
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PMbomH2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCUBS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:18:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42206 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUBS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:18:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id p1so3341363lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tSgqGCzoe0vKrf6LYwH3NpBnwDmm4M1mXq/D9diiEk=;
        b=PMbomH2tSKo7UaLXKOuTn79jz1cQPWkkGt2TOqUQbXhpzj1558S8m5uWwy9XnjolW5
         UEvMginWfZJLI6ZqKBcdPyCXRy6AWozPsfzHlU77Ia/sjKFoFHgdFLQamookpb8/a59l
         I0+/5HTb4Ntwzb4Wc1oqe2qRRDWqy90dcJptGstHDtZ8BR2Xzdx2sRh50JjStJwS3+0h
         Co1L5fRTKtDMUbeIcUtPLM42URu4aUz1WiXEC2K7yQCsj9ZS9dqRGEPUqob2HFhsnrJj
         5qg0uJ78/Uhi/XbFqvkwFsfNl0KwzcnwvFxkWrmhb9NlIerf6ebX2YnnxBJK9/Ral6Zx
         MIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tSgqGCzoe0vKrf6LYwH3NpBnwDmm4M1mXq/D9diiEk=;
        b=bnHliAqdKB/PZnmaauGB4ydtN2fHIz8U17iyzSRhwluHIuyLgrab1kGMw2cmBbwRhI
         UeZjOy2sNPzblcQV95dviBVEAs7sIXUNdrgkTFRw5rwW2eZ4R/Qpf4Afc18C9l3LNx6d
         ejD5xgwG49v/HLvVK99GJZ8cEAU3NIJoDKaOcX7WuLP7+54LFBIShY2sAJwHhjyC6uxH
         DFC+ylR9N5tV9iPWiSXrvw9hWR9REHJQFTqq7SqcGZyPfNQGXEamyDD2BD2guWndjFrT
         /2fcJjCMdX1506SzugmDP9cwxdd7pZxlvQcTUfmYuA71GE4DOMGrrkj8GxzA/bXLFpEh
         dkeA==
X-Gm-Message-State: APjAAAVERpGQO+m/F/3J5JrrRa6WMtq5AbCL8ud+QOFQd6fMLjt7MwDD
        3FVg7Pg1LAkEidXyN5JVrcf1jggOk+F4sO7GrqJ3
X-Google-Smtp-Source: APXvYqzIvgddKFVF8GnPncpKxDohZR7p2F4mw9wMDs0DH7GbbojKMsEztRF0Ufa5KxGhFFmFeKUeJzSXrpLsrAb29Lg=
X-Received: by 2002:ac2:5921:: with SMTP id v1mr401783lfi.135.1553131134014;
 Wed, 20 Mar 2019 18:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232853.GD16301@altlinux.org>
In-Reply-To: <20190317232853.GD16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:18:43 -0400
Message-ID: <CAHC9VhRY64ZvHk5wMCAe_7qoQoqQN8tEKU2z92YH5-9fRtvEdA@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] c6x: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Mark Salter <msalter@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-c6x-dev@linux-c6x.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:28 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Mark Salter <msalter@redhat.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/c6x/include/asm/syscall.h | 7 +++++++
>  include/uapi/linux/audit.h     | 2 ++
>  2 files changed, 9 insertions(+)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
