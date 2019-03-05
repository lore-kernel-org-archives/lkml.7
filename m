Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37432C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04C0206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vSOWIOdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfCEOSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:18:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40260 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfCEOSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:18:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id w6so7730152ljd.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 06:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yU8UZ5gXBpppu/3qAECTdK+2nhUb58EoBGf70qQ+PIs=;
        b=vSOWIOdFJ2B/VQ8F+ev3eoT3oKsSR2kCbagChwC2h/jMmwHIEGTQGZjOwnIg/c9Fyy
         PhoKt+OutwE5IGYMP9L+JQDxmC3fOv2G05DvIOuiEt+Rzfz4u+E5vWYX2vTADbJqiEIe
         94WVXfkj2mgQO0Ru/MOm4jgnRbWSQHIsZbimC9iiWHHWwuCibrrtryGuto8WUbqD+vDo
         0z5c3RDiOyd02xEAK5JqXcx0IlI7oBmhVjsaE4mGKilRZmeX/fdGTbUd/peaa9fA5mTR
         6m1A9eExjLJkN0krYW1SOJxghhIn8GvVfRmCaYvXB7H8N0iQ5cx5jogrd63c92s04J2m
         Fmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yU8UZ5gXBpppu/3qAECTdK+2nhUb58EoBGf70qQ+PIs=;
        b=pKPArMja2E/w4EDwXT74Zm2QY+AZFrKbJJQTpXTkUN584xF7Z4NLgzSCpsDtSE6IeY
         p1Rf4We+SqF9e2koHpiO3z7R8FMVLVApe8UJmWjPChvDVMbZbl244Fsx+8u+r3H/fYww
         hDenJ2/nrsCwwvf0UDvJw75W7xG2/wgKVqaUeRbsh0grHslVCNGadWGpuo8lOHWQzkbm
         1hTV0ZdovOaqbUMudwbxl20RBCQ5DWctNGNqvVFQVD4CScJZ5FMk/UafHEQWBZPaZf2n
         IG/sAt5Tokf5Vbz5O+A+AYV8qbj8G1rPeEjhbwGo2BS2Fnae5SkXR31GAxxIsZxNYv1W
         1sJQ==
X-Gm-Message-State: APjAAAU0nOKCnL+OnCTToF66VczYjHzyrnKCHzOVK29jL3l3Pl+3yJhd
        pUlG3GpfFuUwwRTfPpIchP7wg/THsmKC0DlMwSEr
X-Google-Smtp-Source: APXvYqwmbxDpDVwM3gizIsIQmopZCqC8ctKrY7zt8fmolo8EEZZlemDbl+XI7pBwwMTuit1hTHfGfBoltOkIddPM+Fs=
X-Received: by 2002:a2e:9001:: with SMTP id h1mr14114855ljg.5.1551795492340;
 Tue, 05 Mar 2019 06:18:12 -0800 (PST)
MIME-Version: 1.0
References: <1551784466-15610-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1551784466-15610-1-git-send-email-lirongqing@baidu.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Mar 2019 09:18:01 -0500
Message-ID: <CAHC9VhQaoWM1nuvm_UeX_np_y0QAenQeWE8XWDUVh1oAOsy9XA@mail.gmail.com>
Subject: Re: [PATCH] audit: fix a memleak caused by auditing load module
To:     Li RongQing <lirongqing@baidu.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 6:14 AM Li RongQing <lirongqing@baidu.com> wrote:
> we should always free context->module.name, since it will be
> allocated unconditionally and audit_log_start() can fail with
> other reasons, and audit_log_exit maybe not called
>
> unreferenced object 0xffff88af90837d20 (size 8):
>   comm "modprobe", pid 1036, jiffies 4294704867 (age 3069.138s)
>   hex dump (first 8 bytes):
>     69 78 67 62 65 00 ff ff                          ixgbe...
>   backtrace:
>     [<0000000008da28fe>] __audit_log_kern_module+0x33/0x80
>     [<00000000c1491e61>] load_module+0x64f/0x3850
>     [<000000007fc9ae3f>] __do_sys_init_module+0x218/0x250
>     [<0000000000d4a478>] do_syscall_64+0x117/0x400
>     [<000000004924ded8>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<000000007dc331dd>] 0xffffffffffffffff
>
> Fixes: ca86cad7380e3 ("audit: log module name on init_module")
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  kernel/auditsc.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index b2d1f043f..2bd80375f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1186,8 +1186,13 @@ static void show_special(struct audit_context *context, int *call_panic)
>         int i;
>
>         ab = audit_log_start(context, GFP_KERNEL, context->type);
> -       if (!ab)
> +       if (!ab) {
> +               if (context->type == AUDIT_KERN_MODULE) {
> +                       kfree(context->module.name);
> +                       context->module.name = NULL;
> +               }
>                 return;
> +       }

Hello.

Thanks for the patch, but I have to ask if you've considered freeing
the module name in audit_free_context()?  That seems like the correct
way to solve this issue.

-Paul

-- 
paul moore
www.paul-moore.com
