Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A53C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73C920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scqPx9y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfCGSta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:49:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40522 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfCGSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:49:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so12123989pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5nD5lI25mx+rWheyjTpCjE5WYJxFv5Twp1sA2+3TRI=;
        b=scqPx9y0jsqVXTi1Z9kIafcD8dyJTVgZYQoZkVPJaHfkv3F8P7qOeFs5Xbpa9yvCqV
         3s8m1cIIlF6dKK/PL730QcEDixKPorZ8JxQf8EujFHL7CVGGJQ8p5Wf++JE2M/idHO6P
         mtvicDMsFgg7JYaMlxH3N18bKuIpTAKMNwFrLXYBEVvvDzzwFNiLj1kRgBD9/j89ZpWJ
         XWY1xvv/DO+U0HNZyv6v7XMOOT/TRqgUGMFmHLr++5g2CVTWgrbk3MA8ConAfow6sBoz
         OF5nOWHIfFl3fTwGWCWypYjEPxPtrTr2+D+72gUx+CH0g+o/bdsL8j/yKSmV+L5qkr2R
         McpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5nD5lI25mx+rWheyjTpCjE5WYJxFv5Twp1sA2+3TRI=;
        b=GRL7izi2qr80X02MgwgwHjSz1GH997Bx92pyGkNT2+sXDleuqnjTrlUS5sTbmSkM5k
         mWkBlm8mTdtHvz6MoMNLN+Fy6hYg/xvVcCl3b6QtKNpbYhJ8eFdIBMDFyMiKif5wW3pE
         nwGMQeytUzBI8+A65AUqw+vomgqDRiWaeWcdoZlKXQ//HTTzJLrVmsbl9rSUbsF03lkZ
         OMoN0K9DBiQYAxHMKR7t0VA/o68PmAflE7rUKrlXjPC+JSF79RPRKlJqJnedWhViuobZ
         O5LxLlfOGLAkDUpEvzji8v+u1l49607QI5/I/tGUqzRr5SYiTc5H+i0ZwfgAAYUTlHnP
         LKJg==
X-Gm-Message-State: APjAAAUSDtKGiDtagXsmtEIhh4/ZgyWFxFDzAbFVQiF9X21mZuBilzub
        z5ILdujJsJZ56Geh1FDFrS7T2V+nulEe2yAvYIy7utcJkAc=
X-Google-Smtp-Source: APXvYqwCtUH+AYE9/UAH/zRSTnUSYtGaNa7aKQjj79uR3oxKSMUzSbU4nfIHq7lNeI6PbnexurE9de+CRYw5CNLM58g=
X-Received: by 2002:a63:c70c:: with SMTP id n12mr12914507pgg.302.1551984568234;
 Thu, 07 Mar 2019 10:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20190307184125.21419-1-natechancellor@gmail.com>
In-Reply-To: <20190307184125.21419-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 10:49:17 -0800
Message-ID: <CAKwvOdmFduT6bd7=xAsC0YcaJZL6MUUoMzmb2dW9YMGD0x4eqg@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla4xxx: Don't call dma_free_coherent without dma_alloc_coherent
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:41 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/scsi/qla4xxx/ql4_os.c:5915:7: warning: variable 'buf_dma' is
> used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> buf_dma is initialized by dma_alloc_coherent, which is only called in
> the middle conditional statement. Use that same conditional to call
> dma_free_coherent so that buf_dma is always initialized when used.
>
> Fixes: 2a991c215978 ("[SCSI] qla4xxx: Boot from SAN support for open-iscsi")
> Link: https://github.com/ClangBuiltLinux/linux/issues/391
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 16a18d5d856f..88bb52456efd 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -5982,7 +5982,8 @@ static int get_fw_boot_info(struct scsi_qla_host *ha, uint16_t ddb_index[])
>                           ddb_index[1]));
>
>  exit_boot_info_free:
> -       dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
> +       if (is_qla80XX(ha))
> +               dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);

Very tricky code flow to follow in this function, but this patch makes
sense upon closer inspection.  Thanks for the patch Nathan
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
