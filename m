Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C36DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8DB206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5d/gOKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfC0RBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:01:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38529 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfC0RBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:01:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so10000767pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xJSt6Z6aWnfPGKUo9Ab/ADnYDzeywNJbfuZO23Q9f8=;
        b=t5d/gOKb+NIa3dkh/n2QpbwIM7SIFSlw6SpeSoCu9qL6WAN3WvaCwZMisvHDt8wbV3
         YkEHAf8HXbXM0g9jmE1n6uhhq1ZtYdj+mSxbFkLl/BP5mL9VE0iD0RKN1LdWFoJhbXuW
         lLyHSqPn1bTLAt8FaayGyZHoovok+XrhSA2WyKIL9a5TPqQCLQz+e0+PQFZLO+IQaD/V
         d1jS89Bw/T0F0vlq2pu0U8EiC07VVZ6lFfbjgGjpvVJUABpz8JY8GeNC8Gr3/QAsk1yJ
         /Htb/B5iuPhvXS4rY6gBh/P9MOCMm6Ir8XMsueATyNSjhYaIQ59PZ4xhxQoy2Q4Si7xM
         4qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xJSt6Z6aWnfPGKUo9Ab/ADnYDzeywNJbfuZO23Q9f8=;
        b=j3FNMt+szDlwQJPjWzf0mbgDMkF77d3r30gEhoAlH7qPOVnZKW6zTkRCGeMc31TBF7
         CkJPmK6cI2flXKP8mIaFXcYLdhEmhZcBnKF1MwGT/P0FaaiYpNw1M3ImUMUtT9LZ9t6F
         2vHAoVG1ZvhzZC3ueFnehbFXdMI9anaIsy2XTUI1Nnvry9hwS5lNN1UFqhTcTUrL+ArN
         YyXC3sOu17wYN3esHuXjAg3LIYBhDJ1PzHdfsUHZlF+8uOz14K3c3RJFC4LJEf98n8dI
         zp+w8yMTpPWfD50xWNcKau67PpThDQyNjtDjtaJuCA5p72FwUeYdVM8K7cSVAyZWWCJ4
         90aw==
X-Gm-Message-State: APjAAAXnhucizGwu718xfpU1sbTJnVLJPi6No17tsL8R5WofzGMGRaLq
        jkRdwgCtwzdOSWkpLorF1jCaZmCtF1HxwlFhuLVsAg==
X-Google-Smtp-Source: APXvYqy6DZInMyNHgPBrajynzu/Pb1WI5vRe3Oj7p42iSEIse7uqNZ5O1wBKTPZWVbR7qcsFm9ZOrTGpPnn0sgh1LTA=
X-Received: by 2002:a62:e80f:: with SMTP id c15mr36065060pfi.93.1553706113725;
 Wed, 27 Mar 2019 10:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190320163315.12740-1-natechancellor@gmail.com> <20190326220444.10040-1-natechancellor@gmail.com>
In-Reply-To: <20190326220444.10040-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 Mar 2019 10:01:42 -0700
Message-ID: <CAKwvOdkLJaO3H25JU19qPtMe=LTJmxUicPvE=vWOKw7nqDC=-Q@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: qla2xxx: Simplify conditional check again
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Joe Carnuccio <joe.carnuccio@cavium.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 3:06 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when it sees a logical not on the left side of a
> conditional statement because it thinks the logical not should
> be applied to the whole statement, not just the left side:
>
> drivers/scsi/qla2xxx/qla_nx.c:3703:7: warning: logical not is only
> applied to the left hand side of this comparison
> [-Wlogical-not-parentheses]
>
> This particular instance was already fixed by commit 0bfe7d3cae58 ("scsi:
> qla2xxx: Simplify conditional check") upstream but it was reintroduced
> by commit 3695310e37b4 ("scsi: qla2xxx: Update flash read/write
> routine") in the 5.2/scsi-queue.

Nathan, thanks for following up and rewording the commit message to
clearly state how we got here.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 3695310e37b4 ("scsi: qla2xxx: Update flash read/write routine")
> Link: https://github.com/ClangBuiltLinux/linux/issues/80
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Reword commit message so make it clear this is just a reapplication of
>   a commit that is already in mainline, as suggested by Nick.
>
> * Include the authors who reintroduced this warning.
>
>  drivers/scsi/qla2xxx/qla_nx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
> index e0b4387fd6ba..359ebb634d96 100644
> --- a/drivers/scsi/qla2xxx/qla_nx.c
> +++ b/drivers/scsi/qla2xxx/qla_nx.c
> @@ -3700,8 +3700,8 @@ qla82xx_chip_reset_cleanup(scsi_qla_host_t *vha)
>                 spin_unlock_irqrestore(&ha->hardware_lock, flags);
>
>                 /* Wait for pending cmds (physical and virtual) to complete */
> -               if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
> -                   WAIT_HOST) == QLA_SUCCESS) {
> +               if (qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
> +                   WAIT_HOST)) {
>                         ql_dbg(ql_dbg_init, vha, 0x00b3,
>                             "Done wait for "
>                             "pending commands.\n");
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
