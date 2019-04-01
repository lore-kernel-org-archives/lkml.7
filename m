Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D0D213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsKKW7UH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfDAH0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:26:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38037 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731862AbfDAH0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:26:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id e80so7622698ote.5;
        Mon, 01 Apr 2019 00:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxeoz0EGyi0xZFFWRWMstm0HweGrj5Qnaf8mdj4U0cg=;
        b=NsKKW7UHYIsNWeW1oBjmWVaOirg7/Rt06fbx6lmBG11OXlrwYttZQfeFEr7mwc2eCr
         EDItYpJR/AUVTWyKA76HI01ObtHJ6KvmRiaszxQvaW1fJy2J+ss7nkP5r+Cv/S6fTNvT
         7C6uAyyKdA96ddjPCdzQ0mhXvv1+ZtQchZaEYy7MnDUvm3NzUwOWSLr4g8NWJYq60v3V
         gmP+55IJYNtibgAWL1K2JOjqAsFF1EbzFmhEyU/0HbyFyY3h1HN9OXzCC3HtZVStiEB6
         3ittg9H+EmbOYK1Lx8hqTMIwll2kRWqNRsbcr7eoZ9NiPbMFnbcWasXBeR3AHF90+VwF
         Navg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxeoz0EGyi0xZFFWRWMstm0HweGrj5Qnaf8mdj4U0cg=;
        b=BgVexITwCUK62EOw/Q1kMpwTD4ONwlh2oC9cZ59LDlvZyuxyeR1k5v6xRqNPFWghw0
         KPPFWYWukQBUeCu31eRW2hdcEUthyntf3gOrHSdzyshmxWgjWFQSLJbXN+Aa54IRo14L
         3RxVa/l42TVWU5fYyl2g/3T2+cjAL1rbC4DcApwEgIv7jQRvq1UFNomRu0Pm0Jl09B45
         5XUjiU/wF63HUNp9l3eNoEBanEQDB5x1CiWk1397C5e0qklPxv3iKrv0WQruayrIRBv4
         RErbYqq5sRBvGhzNWSphpjF2Rz18h3S4OyTDq/TTyDlQzIbATqczJcL29/Ta8xrrCulA
         8dLg==
X-Gm-Message-State: APjAAAW55M8GAhGT6I1Rx4CEVGyDzsaUZBCE84ORcVjRqZv8Ko80wrf2
        Ww9TGO9Ww21/fF4RZr6nCR+QyNC+gLJNVwx4drA=
X-Google-Smtp-Source: APXvYqxp7IsC9EaAvMbXimaBOWgomI0Tke5rVvWQav+2o18i4EB3ZnuElQtObW1mgY932pbhoxFX16htppQM3MfAZTQ=
X-Received: by 2002:a05:6830:2009:: with SMTP id e9mr19572016otp.142.1554103566496;
 Mon, 01 Apr 2019 00:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <1553602674-531-1-git-send-email-mojha@codeaurora.org>
In-Reply-To: <1553602674-531-1-git-send-email-mojha@codeaurora.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 1 Apr 2019 08:25:40 +0100
Message-ID: <CA+V-a8tXq2CjZ+LmOzyg_Jr9Mc0MevjYBFfQ+FJwsW+UDd60_g@mail.gmail.com>
Subject: Re: [PATCH] media: vpss: fix the order of resource clean up
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:18 PM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
> Clean up of resources should be in reverse order of vpss_init().
> Fix this inside vpss_exit().
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>  drivers/media/platform/davinci/vpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad

> diff --git a/drivers/media/platform/davinci/vpss.c b/drivers/media/platform/davinci/vpss.c
> index 19cf685..e380fd3 100644
> --- a/drivers/media/platform/davinci/vpss.c
> +++ b/drivers/media/platform/davinci/vpss.c
> @@ -507,9 +507,9 @@ static int vpss_resume(struct device *dev)
>
>  static void vpss_exit(void)
>  {
> +       platform_driver_unregister(&vpss_driver);
>         iounmap(oper_cfg.vpss_regs_base2);
>         release_mem_region(VPSS_CLK_CTRL, 4);
> -       platform_driver_unregister(&vpss_driver);
>  }
>
>  static int __init vpss_init(void)
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
> Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>
