Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FBEC32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D020420848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLh77sCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgAFFyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:54:15 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41783 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFFyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:54:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so70179784otc.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 21:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hDtkJjW2Kv95WEI4mCl7TMRHHpVZYlG43rWG0dS0SY=;
        b=WLh77sCkmBSqVE/95oEStXw747K44xXd3s/Px2ugsYNLeRQxHjbt9L0DffeONvhHKU
         V/3onuIi11+jVDGvhlwm09XXO7nqyuP3LVA8b6sFerRNbv/wmPbc4myKN3qdooXG2Gg7
         50NaubNrB9xv6f0LcIH5WLVkblXt2heqj7zFx3JdeVNeVaEmNP+BDgELdE8glsClO7QY
         FyGIwg+nbiAZcp7dzm9oSsPjGarGpx+CSF9UrFDik5KeWZkOvy5uA0ieObsNUNNDOzXo
         1Sm/6KVUCyI+ayZewzqOMh3TIzEJkAT9zKCNvAShEm/lkPmr1G9MPwUnnw2IVzKlO0AS
         qsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hDtkJjW2Kv95WEI4mCl7TMRHHpVZYlG43rWG0dS0SY=;
        b=Y+afu7sVsDriDJCpCZvZm78mwMsmsyd8wV86SVXjybyHWv1HjUW2vnp4ITu1AHBt4C
         PaVQZYPABAnW4+TaiWRRnHiZrnm7eda00lw7+zcz5eTLNjz51DwDBPa5rbF0z7S1j207
         DQnj5u0qSvzWcSInuU67zexsW1dpGjLeqtYgd/BuDABWM6Aob6RdOnME9UiJFY0acPEU
         azT0CCSrHg4BmTkNDWXCqmGEA/x88EIqz0OJbADLi/btGg2++KtIK2MQRRbKDarNBt3B
         ZbYHXQ3/xrMTmCoaBLl7/n0yBuoUsrKa7dP21loOD4wj8bAwapd/4TgmLzO7KYkXin/h
         Xmww==
X-Gm-Message-State: APjAAAVL/0ImxIMxCfl4xEw/1BHKAaKQtZHQcwqugR1fTV9foZfYs+Tk
        PgY/1zkgKHBdAG3eIqJ88t2XeDVXr2hZUHRYeTQ=
X-Google-Smtp-Source: APXvYqygCG1DchgxREnMBBHI2KTwy7axLy80UERAPlzqfYnrFnUIp7lmSVUs/AOrzbj6AT2UdUMjBc6AsX1M67hmwx8=
X-Received: by 2002:a05:6830:68a:: with SMTP id q10mr11906983otr.145.1578290053815;
 Sun, 05 Jan 2020 21:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20200105150539.7404-1-ttayar@habana.ai>
In-Reply-To: <20200105150539.7404-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 6 Jan 2020 07:54:07 +0200
Message-ID: <CAFCwf13cqR2SK2wfGqXDCGUgPLNZa8knkdYSBar9B-AD1py5=w@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Modify CS jobs counter to u16
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 5, 2020 at 5:05 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> As HL_MAX_JOBS_PER_CS is 512, it is possible that more than 255 CS jobs
> will be submitted for a certain queue. Hence, modify the
> "jobs_in_queue_cnt" parameter of the "hl_cs" structure to be u16 instead
> of u8.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/habanalabs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index df34227dea31..77fe4315dbee 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -763,7 +763,7 @@ struct hl_userptr {
>   * @aborted: true if CS was aborted due to some device error.
>   */
>  struct hl_cs {
> -       u8                      jobs_in_queue_cnt[HL_MAX_QUEUES];
> +       u16                     jobs_in_queue_cnt[HL_MAX_QUEUES];
>         struct hl_ctx           *ctx;
>         struct list_head        job_list;
>         spinlock_t              job_lock;
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next
Thanks,
Oded
