Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37AAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C735124680
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cxx1pArM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfLSUWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:22:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38411 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfLSUWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:22:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so3727653pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsW/j1Crrs313MkKDSnDNbKlrshzMf4od6PZBBKr95I=;
        b=Cxx1pArMA1dCG+vdMqR0CO3SVpBUWxpFIs3cuP3P27CupTI87usG38HorhvjALmrX6
         QyzgEyCgcDkramgZ7qIh+L+TKfuJPmdXxExRJpnjB7Zx0IP+0BOYdBXG2RJMUmTJD60v
         OjtsQQ6z3UTnMwyQJCuCHoYO9lqbg3DtrWnSkYk1vicghmJwdbzV4dRZz1qvfOZvDHwN
         zHHwcPJLSp9OU2JbBzjmbFZyY8iqt2XdlluHAPATqSBTWhu2J0HjuzAESm4mEfIT1lMp
         JnWNWeyi2tI6mJcfcYkKvW2v5gCkYlwkxYqP/mBow6aJ3NByA/sJPaQjT/u7Vy0fFFC/
         6sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsW/j1Crrs313MkKDSnDNbKlrshzMf4od6PZBBKr95I=;
        b=UuCczGEqEDQvQ3wwd5AeBVPlkPQq5LGStjT90YgBx7kbKKbDKtbg4Vb0j84T0aRVrn
         KrMUyaO/iHl2d8sXGiEnJmViWM3hrRd2KrUzZFio25fbRbPYaMBtK2JKbAOUJy56oCLF
         0yRaAAQZEQLSSE49+rQ2RRVGWqDM2s45uUlSxJrYdSYlDr0U2asdn5nQrcN2DFXmO7xg
         G4qvbe26d+3yzHji+wrcG2sRq0KEbUmk/+Xv6kSfIyEXGtKC9SVPZTqQx9kdgn0ejSS/
         w2nV1G2LH/XHP7scWrfOKG5jgN7xvygUWMHIr2eEEifvFms/hOMyy2nxpYBc7J9dznny
         5DFQ==
X-Gm-Message-State: APjAAAXRRZlDKqaGrD4UjiXl3ptE8mJ17LNyElcIvpMRMNqUPliMPVRc
        y/W7QCw88zaY0US8zxS/qq7zD3UDNkVqw/HdHX/A/g==
X-Google-Smtp-Source: APXvYqx7TULpvCuBBqKMKSSguT898fWlQzY/uebdX+PZW3Yo9Etjdi39QBGNAUnvO/GUVvsaElIAhNEYkDPFmQEqwbA=
X-Received: by 2002:a63:d249:: with SMTP id t9mr11165747pgi.263.1576786940683;
 Thu, 19 Dec 2019 12:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20191218015252.20890-1-natechancellor@gmail.com>
In-Reply-To: <20191218015252.20890-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 19 Dec 2019 12:22:09 -0800
Message-ID: <CAKwvOdk_CqpdJdKLQ-a5AK8pci7yMic9pgJW5x-iFosYbk8CMw@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla4xxx: Adjust indentation in qla4xxx_mem_free
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 5:52 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/scsi/qla4xxx/ql4_os.c:4148:3: warning: misleading
> indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>          if (ha->fw_dump)
>          ^
> ../drivers/scsi/qla4xxx/ql4_os.c:4144:2: note: previous statement is
> here
>         if (ha->queues)
>         ^
> 1 warning generated.
>
> This warning occurs because there is a space after the tab on this line.
> Remove it so that the indentation is consistent with the Linux kernel
> coding style and clang no longer warns.
>
> Fixes: 068237c87c64 ("[SCSI] qla4xxx: Capture minidump for ISP82XX on firmware failure")
> Link: https://github.com/ClangBuiltLinux/linux/issues/819
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 2323432a0edb..5504ab11decc 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -4145,7 +4145,7 @@ static void qla4xxx_mem_free(struct scsi_qla_host *ha)
>                 dma_free_coherent(&ha->pdev->dev, ha->queues_len, ha->queues,
>                                   ha->queues_dma);
>
> -        if (ha->fw_dump)
> +       if (ha->fw_dump)
>                 vfree(ha->fw_dump);
>
>         ha->queues_len = 0;
> --

-- 
Thanks,
~Nick Desaulniers
