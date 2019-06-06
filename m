Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A0CC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6011D20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGxZBNrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfFFQlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:41:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44497 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfFFQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:41:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so3381387qtk.11;
        Thu, 06 Jun 2019 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGgWKLVUyf6qVJ+NU9IfZosO/+IoPXVvZ/ps5UGeu24=;
        b=uGxZBNrHxgZdNcDG6YFfhOi/xD/sPDDtJF3/oIgyNuoBBJ3gSCkwPmRhZwKvIPmzEV
         5O4lGaoysr4ntjPBXirh8/EIu+oqy3w5wG9GgFVRO9NtBZlurQSlxpiNOaEsflMI6+wR
         3PmfjqHYlwe5WZnlSPKPwNBwz+ae7O3sbOjtMeiJJ7w6lN/D8x6ptYEGdgBsbuZF7q5z
         QZ/kTkfm1XWMsFEgk2X24ful9SRsRnq1+No3VXrnmLEdfhrMRueTg4XV/wIbecP275xm
         93VQydu2CkYwkR8MEPjgW0jEKrSL/mdkIiqqYR5vs3a2Jv9U8cFl/P9rYTkE23F4v3+i
         Titw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGgWKLVUyf6qVJ+NU9IfZosO/+IoPXVvZ/ps5UGeu24=;
        b=PZ3sR2xVZ1QZzdQvfr0uyySmaRxr+g+LUtMORLd0qgo5YgwA/LUSLwNNEtOr4KkJLa
         A8WFSmAtZPpee6qLLpvKzv71IQMPRVxWEJfu+afKt8uIu5IRbQyTzQmyHbT/OdzPsQ1F
         WThZwo8pCf+vLc7vJ4eGcBuz7z/S8E4U+OJrh4s7fABElJo6rVnImpdxo0iO8t8sBRNQ
         1Yn9zjEnJ1hdDV0HotPhCDaVzFvByDUpa8kZWPItF8szZOsLOmLt7lnhm5X3I7PaEZh+
         0PxU3jba5mAUSrasf3CQu8XnNBtJ1tdQwwmy36ga13LLhcTG9cOyc6cMplAnk9VdnAO7
         scog==
X-Gm-Message-State: APjAAAW3hBFDhPmmWOqKApsqVCz7JwEY33LEnq1j8QHENeOEgSkIrwBe
        s63ak/Zswn3H+L0kGHrmDeRLs+JbZ5ECLOT+M+VpDoVQ
X-Google-Smtp-Source: APXvYqzq39fh1m/kAw0clUqxX/svZkbL+HECGhzW478Xc72QCUetcoO+HPVlfMPNYaQ50DUO5JnsE/4nkiDZY14+nO8=
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr29916950qtf.139.1559839283036;
 Thu, 06 Jun 2019 09:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190524024459.6875-1-marcos.souza.org@gmail.com>
In-Reply-To: <20190524024459.6875-1-marcos.souza.org@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 6 Jun 2019 09:41:11 -0700
Message-ID: <CAPhsuW5Ea_bDRwoE7=AamzOsvLMdfQRTPh00iFHNrx8iU5ZOZw@mail.gmail.com>
Subject: Re: [PATCH] md: md.c: Return -ENODEV when mddev is NULL in rdev_attr_show
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shaohua Li <shli@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 7:45 PM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
>
> Commit c42d3240990814eec1e4b2b93fa0487fc4873aed
> ("md: return -ENODEV if rdev has no mddev assigned") changed rdev_attr_store to
> return -ENODEV when rdev->mddev is NULL, now do the same to rdev_attr_show.

nit: checkpatch.pl complains

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#84:
("md: return -ENODEV if rdev has no mddev assigned") changed rdev_attr_store to

I fixed this in my tree, so no need to resend.

Thanks,
Song

>
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/md/md.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 45ffa23fa85d..0b391e7e063b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3363,7 +3363,7 @@ rdev_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
>         if (!entry->show)
>                 return -EIO;
>         if (!rdev->mddev)
> -               return -EBUSY;
> +               return -ENODEV;
>         return entry->show(rdev, page);
>  }
>
> --
> 2.21.0
>
