Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32165C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004DA2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vobkcxAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfCUBUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:20:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44673 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfCUBUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:20:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id n18so3895869ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYD+kPpAMrhPDLYsTiKw9ucgLLiZcAnOMGuJPLCs3og=;
        b=vobkcxAPBL/oCV44uZDOZ5435EeEydo+k33Yufpl8ulveWOLED/i4kENjIMROqT2zY
         3ZAmJBc+MPf/+Ti8YK/vXuUV7a5YN3rYfRoydNckS5iPrHKs/u2ZE6540R1LKAJAUNfS
         ZcyG0IOS0as52Wuta4jmEf+DOQ9zT5zUmnzXWURS1+fwbsO9AlNh42mAb2BY4tC4NNJN
         cdQes5loJKmnAh6LYgyWpQ2RRZU9dCwf6MvQ1X04/Tr2J4R1bSVV1eJpdmgtSxKlQyxr
         Nq3MXlUhPQGl/i9bilnXGKqRYKol0PdcACkBDhSQtgneFU5SGImAPU1fn4TSj0zBIXsF
         OT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYD+kPpAMrhPDLYsTiKw9ucgLLiZcAnOMGuJPLCs3og=;
        b=UAKkwWxoEARa6OOVXxOIHZ3f/G3hdYCjIefCO9skWqiukGpS+hp82IhmVTEynKMXcU
         SihoaxQxWF9w5TLgAHHm6WwgX0fCgEiEqypmWL8bkcSzPjJiCzARNUmjvsfotM4JCdsQ
         KbXXcIQNOcAJhoaDRY5JmVbtjTauDet8GIV0vSc+yPtTgQBJB2TX0BOmns7aYLOrhPQP
         OIFF0aBPGhLhzL4vNPqcjZF3xKUYm3YTPMStnrApdu6G/hVHuJB/T28EPJk6oLLdwW7h
         VhF2bAyYg3NRSibCeOztxqoapT/XmlY1Y8Q8ZL0Az7hHr6W8/wnKpiwcU2IcKstWVl4u
         RpCg==
X-Gm-Message-State: APjAAAWSYaNYAHEZ1QHjS0BxtEmOwvAGAjfX0p4NmaHzFZh99+gNeoRI
        hT7VlOkvaPI7hYSodQ/C3LC6b9bnkuvAkVQjSSTw
X-Google-Smtp-Source: APXvYqwSKZKGgvBenD8QkjCgEluxB8x3HLieE3npA0UcyZ2jd0PwOe0w4q8Cbf78g2QBuaciwVPjbrrADZqXlR8i5F0=
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr376796ljg.161.1553131222092;
 Wed, 20 Mar 2019 18:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232938.GH16301@altlinux.org>
In-Reply-To: <20190317232938.GH16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:20:10 -0400
Message-ID: <CAHC9VhTbPbGT2ZyPF=q8SEoOqpbT0Fj6QhVL1CX88fE4Cvd8CQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] m68k: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:29 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/m68k/include/asm/syscall.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 arch/m68k/include/asm/syscall.h

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
