Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F991C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CB1218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Vl43Fxtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCUBUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:20:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34878 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfCUBUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:20:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id u21so3397047lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+MhTq812rzgq2qgmD7TcGZsYzh1Dk2rx4Cmr18RHXk=;
        b=Vl43FxtrPCqsQc0IOAw5HuNS7Ic57b8Qc+qlPftvfvQJ2aAHHp1K6cXfP+IcugzNo9
         yDpP9uTtYyupNlCHPImLDXCqJ9xMLE2M2lDSkIdr1PrXYy0DJ5UN+GzI18DlqbXu8RlU
         EuewIzL4kzHQmVMO+ZttKlQ9ZtuLzAqzTqd9+LsoT4ZvQdtIkDRnFz7cLgNd3WkD2w53
         z3YkKS2nAHJ99IOovXb80afzQR25UIjK54XQKP6Lu9+UcmcTzQe1tEk5Sbh2F/fEEvV9
         866S0you88SvrGVHHNcU5trHl9+v39DrI6RVzqAZM7OMVXMS+SpwgYx1Q/oXWFFvnIvp
         Ueaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+MhTq812rzgq2qgmD7TcGZsYzh1Dk2rx4Cmr18RHXk=;
        b=l7tTpi9ZQAIvNVV+9Kk+4XsEESeO50htnhEdO6U11TvnOepgwVzOmTSwHxzfKCQeTP
         OpJmH7E0LnCQNj1+lsumeYBDs/L7QrsoajfohMfacW3DffUPAzAeljLBBfFMoKTFWqeF
         6m6Cl7hJUYcxlSmdFPnmdzkZyxjfVWDqRJryEtg91i2Np3hM8eLEa4A/Uks/SF5cjw2d
         bHhs5F+DuEmFT5BA/GHivj74yoB8pk+UEPtGnspmmFXMm6TMqoQ6lxFnt+e0nK3G/0dI
         I4WYMSiLKfyhvGYbbI6JvxHkSc/RRMqWGixCRz/4/jMdqDXSrfL8g+JrHSondS1rp/7I
         8Zmg==
X-Gm-Message-State: APjAAAW8Y+OR2ifkdUSX5oW/UWA3NYRwEtCsAcOeMUpSGCZK/Sy+TKWP
        wePxqun0Q7y0tW/7NemFU5McFfAtG0DR38nUVfF3
X-Google-Smtp-Source: APXvYqyK+oR/6C+vCE1ZIhUQMvXbFlr1kn0CNvjLjTgvAKcLQuQfA1M3KpPBL5TMXDnJdXxS8pRUL2WPbgIcEP9t2B8=
X-Received: by 2002:a19:ee11:: with SMTP id g17mr383839lfb.117.1553131242651;
 Wed, 20 Mar 2019 18:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232947.GI16301@altlinux.org>
In-Reply-To: <20190317232947.GI16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:20:31 -0400
Message-ID: <CAHC9VhQ5VvjOkz0WP9cMxGq=p8rFP4ZCW8iGf5Msq+w1pFTjUQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] Move EM_NDS32 to uapi/linux/elf-em.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:29 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This should never have been defined in the arch tree to begin with,
> and now uapi/linux/audit.h header is going to use EM_NDS32
> in order to define AUDIT_ARCH_NDS32 which is needed to implement
> syscall_get_arch() which in turn is required to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Acked-by: Vincent Chen <vincentc@andestech.com>
> Acked-by: Greentime Hu <greentime@andestech.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: added Acked-by
>
>  arch/nds32/include/asm/elf.h | 3 +--
>  include/uapi/linux/elf-em.h  | 2 ++
>  2 files changed, 3 insertions(+), 2 deletions(-)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
