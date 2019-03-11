Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F88C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A8E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFrDtf/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfCKQEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:04:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45491 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCKQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:04:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id f16so3830730lfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/4qEUcYdrj81JAUOKKSkmmZfLbmLspDvwoI6v3CsUs=;
        b=FFrDtf/7kNu/XOmX25bQ4E9GpZ+MwHodPG9Z2bb07eDXEML4eZsferx/jpDfvkHxod
         fLjCFZGsCNtvsL5WwvOP9vXKkZbj7WaqKLGIOyTt2MqBAkN6F332zNPuZIxnClAfHZ6z
         rLwqKZFWmtBgTLTzq5kV2xlnC1tPs/ZAELMWg4sPK8yh9IBTT7Ixx7Z3iCjzrDP0Uc5C
         rkoakoFT+/aFDxbcDDyxSYaNqUv1zf4DFATGIw9LFXKmRU+0zxeV1XBlspak46aA8Tzf
         F3wb2NlSR/iAUPfYq6LlDkbG5+ayEib+ewWqZMMbSNqfngu+wtAmyPrRLzNQ4y78jpRj
         TtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/4qEUcYdrj81JAUOKKSkmmZfLbmLspDvwoI6v3CsUs=;
        b=eMjY7vduxj4vU58RGhr1MvbvE9awuVZOeZJNBmHMB1ummZZB76Uic0U3CGpnmm2biq
         pKqi0gbXwFc2R9/iz8zK5v9iKHWS75wVK/f0XxWfKOSK2SIwyx+dbkt0C+NlYmxTR5X4
         jE0X3AmDn7qFAL8+/HCppOpX7k3C1CmRqzIl26C4X2C4LlFyQQiUbN2Vyr3WXbo29Gru
         BrzbcL0PieGIbWwOd/sajkU0QX0ZPpqyIPM4rkGYmFEIP20puXkLhqC1fTS/YrYjhkk0
         aUkfWrUsyec8UP5JURGa5YFBYM+qLCZ4bp00BlzejBJNvBzzcF0k5u/mL1HeOMW0xOSR
         Z6kw==
X-Gm-Message-State: APjAAAX57BmI6yiDYYf5rNeNOIJxmnF/5ZPxcbAti/GzZ50Y2y6PPTXw
        rdmjY0Y+C8JF/aGl3REif+quSUmJPHIFchHsB8M=
X-Google-Smtp-Source: APXvYqxxtKQqVhh7npHuAp/daNaCYhRcGLczu9jWIkCjCbhvvfyhr2IJ3OUa/p0cSX528rh3DPT70bZQ9/D/VJrSmP4=
X-Received: by 2002:a19:aa44:: with SMTP id t65mr16335222lfe.31.1552320281395;
 Mon, 11 Mar 2019 09:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <5c86820f.1c69fb81.149f0.0834@mx.google.com>
In-Reply-To: <5c86820f.1c69fb81.149f0.0834@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 11 Mar 2019 21:34:28 +0530
Message-ID: <CAFqt6zZ6RmhyTmfgSRW-tAAFc=ESBcOng8NcL1KrBKY13LOaig@mail.gmail.com>
Subject: Re: [PATCH] fs/coda/psdev.c: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jaharkes@cs.cmu.edu,
        coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 9:13 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/poll.h which is included more than once
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  fs/coda/psdev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
> index c5234c2..f2bb798 100644
> --- a/fs/coda/psdev.c
> +++ b/fs/coda/psdev.c
> @@ -39,7 +39,6 @@
>  #include <linux/device.h>
>  #include <linux/pid_namespace.h>
>  #include <asm/io.h>
> -#include <linux/poll.h>
>  #include <linux/uaccess.h>
>
>  #include <linux/coda.h>
> --
> 2.7.4
>
