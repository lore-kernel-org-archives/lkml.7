Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D3AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535A9218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrvDDwtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLRJhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:37:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36663 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:37:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id w1so1741810otg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 01:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Weh7WHhOC7a6++OVNVp5cWmhOd8ECBuniYjUEt6yKpU=;
        b=qrvDDwtEt6pPN5KcAMu3lKDyybEJyQJmmAqHj8Z4gf5LfbjkM7Car3C7o8CZMjJ9Hn
         z2rRP/qytcGEPlwfO3EHvOgsVAIi6sEgs11FDobBwEHHDQva79rkUUEost/KPA/cy0FZ
         XCTnpSn8MHJGOwd63yebfwBoCKFDBb93drn8PhpuxqbEk+YyX8796R1fulVkPN8JulhP
         //QH5UzUqte4HpefU9jLsGeC0gbpyp1M7xQQuPsL8GFJ4cFSJWFVsOpfq0d/lUFKqZf6
         Xpf5wYwOGMVbL81Gq2UBGtxg7rj4xbIRxTz1VS3fj2N5pH9Hlbk9y0WuYOh28/o2PjZe
         XX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Weh7WHhOC7a6++OVNVp5cWmhOd8ECBuniYjUEt6yKpU=;
        b=mbVbEy0wWYkxtJChV2e5rQjXZ4tAbv/7La48+mvh0qKHqJR9SB+cWxC6hh8y2MP+d3
         8FMu/ybMgGFur6jvVBiN4fadg5NGyZwKlFXbzSNy5sD8sXF1vdvp86lkWsESQntpxbDE
         rDuNt83ON2imw873rSQlD++LRUN0WRAecsuAhLdXbxjckw3Z9tCup2XBnlAKftUNBEt0
         mWKdAFEJiUc7PbhnfsjIUmNDY/8RHTsUwqVa2EjCRADBGzAi2TbxrDJU52I5emLJfyTL
         7wJvDI6fa0tpD8/hX3Dyqvri+HrLWWKipjwAJ7cWiXrlQrnP7BzcA9YeGNe3LW5hGUnE
         45WA==
X-Gm-Message-State: APjAAAX6w7+z3xG/QPsTX/+n6wUseOubUihQzShXKXVsl9fKESi8X+KB
        dYmJZN96G+UzQ5Y2OXSpFMnR2P1xtNovQLfQ0ljs3Msr
X-Google-Smtp-Source: APXvYqwpIZeEQArmJJlsRBJXNXZctfsZZCxc7KPNSnmOIIwBlbNt+9GpPKaZ/AWjIlCPofTt1eIUcixaL6amWExH6OI=
X-Received: by 2002:a9d:6a8f:: with SMTP id l15mr1617342otq.59.1576661869171;
 Wed, 18 Dec 2019 01:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20191216084207.19482-1-oshpigelman@habana.ai>
In-Reply-To: <20191216084207.19482-1-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 18 Dec 2019 11:37:22 +0200
Message-ID: <CAFCwf13GyEop7rWZ1i8E3=EXgtN6w3WJbB40KdsiG15ViMv-gQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use the user CB size as a default job size
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:42 AM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> When no patched command buffer (CB) is created, use the user CB size as
> the job size.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/command_submission.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> index 8850f475a413..41e95513c591 100644
> --- a/drivers/misc/habanalabs/command_submission.c
> +++ b/drivers/misc/habanalabs/command_submission.c
> @@ -129,6 +129,8 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
>                 spin_unlock(&job->user_cb->lock);
>                 hl_cb_put(job->user_cb);
>                 job->user_cb = NULL;
> +       } else if (!rc) {
> +               job->job_cb_size = job->user_cb_size;
>         }
>
>         return rc;
> @@ -585,10 +587,6 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
>                 job->cs = cs;
>                 job->user_cb = cb;
>                 job->user_cb_size = chunk->cb_size;
> -               if (is_kernel_allocated_cb)
> -                       job->job_cb_size = cb->size;
> -               else
> -                       job->job_cb_size = chunk->cb_size;
>                 job->hw_queue_id = chunk->queue_index;
>
>                 cs->jobs_in_queue_cnt[job->hw_queue_id]++;
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
