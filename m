Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BD6218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2cacxpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCUVEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:04:10 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:56299 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:04:09 -0400
Received: by mail-wm1-f43.google.com with SMTP id o25so165677wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmLQAkWMV9z50jNE1vvUYUGGe42hiMblAbS9eQXJDAk=;
        b=M2cacxpchLqFUz+kvjdG7JQ/spPv+b+/H//DhNHjKFYfqOEepl56VmXdDxM7B1T2Nt
         buMucZ6rMcJ8LE9jKJXfNjZo6nOkL8iL/L5hIAcKmY+Kdu6/caaQoN5xB5NKK2xN665f
         fwngW6kG0fs/FnDtHZOKi1RFgP1EOxtsck05JKKStXhRB8mEq+gdKL6rGlryvPNvQP/x
         betWE2d63jgrlhxrnbfpcHhvLxP2SlHD9SlNDpb1MShBo7rvDe9+AkSfolrMdo81ZmL2
         cWM99JOi3w9Z69uhFvwg8Fd8F00WS6DSHyGmfPJTVvkZr+1YJLL+5P4M81X1U74Rdlfj
         yNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmLQAkWMV9z50jNE1vvUYUGGe42hiMblAbS9eQXJDAk=;
        b=iPCjk/cFYLDOHfuWpUH3nUgLL/xLCDYKIe+akwF/tkifEe4WMtwr+mSyszhhNXbLuq
         RhLlRuheEtSUtoMmPbrQlsPbLcM8cgGgsSUz9Mu4UhwDQqAof0VntXgSOC1/6m/l9O4b
         gHqjFi3k/ZXaxaPe8YO3sbpsyx38UFO9720U1iRDW5MjsYjx+pNZdMBGeXoST7OxQoci
         SIY7M25ucqu0V3MbgFGD4a2oOn5Scg44EeUSDNRjbL5+kiAkA/1v+cgCzo3jnBaWM5Wj
         aL7wsRwJDAZp2loI13knXENLyKPFrPE5wE5wczCDDJoajlTqnJ8aE2CzdEGJMkXbjNjV
         tMQQ==
X-Gm-Message-State: APjAAAWkxKmUGqRzi0z9l+35koxegb2ql8Oi19jzPJPez99+xrMsPwk1
        F2tA/LafRrJfAc3Ge/NejmuFi2OumjbBW5s+oCUcb8OkGds=
X-Google-Smtp-Source: APXvYqxUtx/mTZrWs0G1ybvHbGTeAMmUi5QeHcIJediwSIeEI0j8HBP70+Ggp7HJAm1WrcnvFbWHZy44rbgAJMkpPjs=
X-Received: by 2002:a1c:a64d:: with SMTP id p74mr710114wme.89.1553202247706;
 Thu, 21 Mar 2019 14:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <6f3801ea-476f-6715-db9b-0eb188c5711d@linux.ee>
In-Reply-To: <6f3801ea-476f-6715-db9b-0eb188c5711d@linux.ee>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 21 Mar 2019 17:03:55 -0400
Message-ID: <CADnq5_O-sFxVsbxouJBRYi=H+RCmc0==jB7XVTifvWm-+EQLnQ@mail.gmail.com>
Subject: Re: Radeon HD 7450 brightness oversaturated
To:     Meelis Roos <mroos@linux.ee>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 4:41 PM Meelis Roos <mroos@linux.ee> wrote:
>
> I decided to put a discrete graphics card into a PC and found a fitting Radeon HD 7450.
> It works, but there is strange whiteness like the brightness is oversaturated and
> light places turn into other colors:
> * on fbcon, right after radeondrmfb initializes
> * in X after powersave
>
> The colors return to normal after a VT switch or two.
>
> Screenshot of one such washed view is at http://kodu.ut.ee/~mroos/radeon_washed.jpg
>
> Kernels are 5.0 and 5.1-rc1.

Is it just kernels 5.0 and 5.1?  There haven't really been any display
related changes to radeon in ages.  Possibly a duplicate of:
https://bugzilla.kernel.org/show_bug.cgi?id=198123

Alex
