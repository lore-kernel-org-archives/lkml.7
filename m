Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FFA218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KhSP2s1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfCUBGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:06:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33972 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCUBGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:06:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so3380351lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRfQgEu7iJuleGhxfH7sfxJ874sbbcASDpCkna5nzRA=;
        b=KhSP2s1Vb3engZ971Feq06l1FEjF8U1ArmfVyj1IuROybX3XVShnVnPQLf8O/udRPR
         x32EZ8XxkT3eI/S9rg5xQE80oRhz/R6g4DZZ71E4ko4CzAaL6TWbSbQUahHN//eR9vT6
         94SiQ5FZjEtMxwzm63fEAEP3ZnWgL2hYLwJZoLM/PkQJghyVMZYNwWmqdwEoArXcbxnz
         9i1yXyhy5cPRWVzIsGtNchGoMGXevSL+s4lzYFxUPvwnNRX6S2TsgzNFavtRarm7fTJs
         rYx4ZkGgkwGNYE828uGrmbvvL6eTqDUgwnoUfuKjf/oDSV2lR9QkawTXMyO90lXJyDjb
         VGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRfQgEu7iJuleGhxfH7sfxJ874sbbcASDpCkna5nzRA=;
        b=dtuio79q1T/esSftipJt8AhU62ysxVK6P2fPEmv53SamJeplYeUt7mVA2vwHvNqWEo
         iH48qIzUWy6PPpHhPPlLrmMBHuJswrSh1T88GIuqxVq7YiVlWuZFX0YmbVuaNOXXYz2i
         8m4w0GMsZltKlO9pSB3qXywNQ62tieubl+J7D+6CXZ7NxhaE/NuH2SyFVuCNVWueY0rS
         I1v8QiqH5my7qfZJRrVdHjca2J5D/3baGpbKKQKX+zmP5oE8jsKT+QrvODu8HhUxz8uN
         fuWs3l40sTc0lB97NZInUH9WU8o3KlImmp+v9/4uOUvKIu7Ryw7SyStJidc37SBO5O04
         lTRg==
X-Gm-Message-State: APjAAAUgomqRyfPZswYyToKpgXOTjeqvuRIYsJYULyRQsAxzAuW9bG5d
        r9JB95ls/CY1DtMZQqxvhdzvRXudRZac0nEOtda6
X-Google-Smtp-Source: APXvYqwShQDPuLf8UDJ22ZI3wjlAllwOjdjZMj6oFyVM72kuMjgAN93D1Hqz06D6bY+SX/i5+9EF/MbRK0RpqZ9c8dc=
X-Received: by 2002:ac2:5205:: with SMTP id a5mr411646lfl.102.1553130359189;
 Wed, 20 Mar 2019 18:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190320135922.8772-1-yuehaibing@huawei.com>
In-Reply-To: <20190320135922.8772-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:05:47 -0400
Message-ID: <CAHC9VhQEbxOhMpq8e7wWX5F65K6CsOw-9_51_Cp-pWm5HnovNw@mail.gmail.com>
Subject: Re: [PATCH -next] audit: Make audit_log_cap and audit_copy_inode static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:59 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> kernel/auditsc.c:1150:6: warning: symbol 'audit_log_cap' was not declared. Should it be static?
> kernel/auditsc.c:1908:6: warning: symbol 'audit_copy_inode' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/auditsc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
