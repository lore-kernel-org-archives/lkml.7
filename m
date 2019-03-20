Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70015C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348472184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9g8y7SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCTRIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:08:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40230 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCTRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:08:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so2242276pgo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19pjDld7aQJ7Bk6oo+SlKKyQukupfxrzA/nJcvqxtQM=;
        b=j9g8y7SRted33GJVwiZeCNXqGl7bwGb30QPmrqaHo1uoFHglAMJi04UvV9DL3d+B3J
         6BfNtTPXcbgiMEpR5u9TxngtfE22rpqzsNPPXYcE+ypmNafxaTw3NX5mlhxzR6yF9j3g
         B5InCGme9mfXjKtn6szH7TyN2NhNKljx+VkWq2QBZzgcfmmXqU3ZXjJsXHH/OLs6pWoa
         JtUEXz7vwfdcS4DVkOHTgsqWbt+GkStf4nvjSjsyatLP5nVMXPpOSjkqrQV3BTAPsStL
         QSHsuTxlfkIWbq1RxE2S+D3R7iImAFDF6u/+adcjyvOcEgk6fSgWcYecq1PlTVb19MBe
         tB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19pjDld7aQJ7Bk6oo+SlKKyQukupfxrzA/nJcvqxtQM=;
        b=hvZIV03f01HnQ/a2WwqZBAasIaEUiLGn6hAswjFKsVFfzVW5ZSyONbJ9yyzEyiNPYQ
         RlHZB4qx8ZwVae3ATtPJgARm6mxdXBF48d+B1SKcrd7HAH0SMe6LWETfoJ3O6AgQllY3
         N7FR8MoMSw5xtyR6J3XXwomPYhtnoGmU6IvOt92ERfs5/T6LtKms1YrPM644Z7ScDZ4Z
         XxYEqyRaMg1Pv3nESNHd8B9vxAAQ6VzsIppHfUAiOywFQqA0hrDe/EOjiJQlkx06TNno
         +RQvkgNCMphGj3cuthNeO+uoI4JlGiTPLWQkdtYBr2dlOS387zoThgicTsIS04e6F2Q9
         pjuw==
X-Gm-Message-State: APjAAAXvczs5XTMyiqJab5ybIyPSkpfkdM0FvH7l5pCwzQoiYntuGdAP
        smB2jgzpLAFMgZw6J0f7YkvvED8cSu9W2hCeAHSWmA==
X-Google-Smtp-Source: APXvYqwIK1yONspeQIPBMxqqG0nw4FoeuiNb1S4qwfU7+l/BXuALNegkDS28rpoVGju6KMC2FlpcdUDTncn4ziWl18w=
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr9089722plc.238.1553101697469;
 Wed, 20 Mar 2019 10:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190320163315.12740-1-natechancellor@gmail.com>
In-Reply-To: <20190320163315.12740-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Mar 2019 10:08:06 -0700
Message-ID: <CAKwvOd=-vD5_Et6i1CcoQEEX7PecOUPctjn3vsi0hHOxUDkYRw@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla2xxx: Simplify conditional check
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:36 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang generates a warning when it sees a logical not followed by a
> conditional operator like ==, >, or < because it thinks that the logical
> not should be applied to the whole statement:
>
> drivers/scsi/qla2xxx/qla_nx.c:3702:7: warning: logical not is only
> applied to the left hand side of this comparison
> [-Wlogical-not-parentheses]
>                 if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
>                     ^
> drivers/scsi/qla2xxx/qla_nx.c:3702:7: note: add parentheses after the
> '!' to evaluate the comparison first
>                 if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
>                     ^
>                      (
> drivers/scsi/qla2xxx/qla_nx.c:3702:7: note: add parentheses around left
> hand side expression to silence this warning
>                 if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
>                     ^
>                     (
> 1 warning generated.
>
> It assumes the author might have made a mistake in their logic:
>
> if (!a == b) -> if (!(a == b))
>
> Sometimes that is the case; other times, it's just a super convoluted
> way of saying 'if (a)' when b = 0:
>
> if (!1 == 0) -> if (0 == 0) -> if (true)
>
> Alternatively:
>
> if (!1 == 0) -> if (!!1) -> if (1)
>
> Simplify this comparison so that Clang doesn't complain.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/80
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> This is commit 0bfe7d3cae58 ("scsi: qla2xxx: Simplify conditional check")
> upstream but commit 3695310e37b4 ("scsi: qla2xxx: Update flash
> read/write routine") in the 5.2/scsi-queue branch silently reverted it.
> I don't care if it is squashed or not, I just want the warning to stay
> fixed.

This is probably a simpler commit message. A "Fixes:" tag is a simple
enough addition, too.
Thanks for catching this and resending the fix.

>
> Thanks,
> Nathan
>
>  drivers/scsi/qla2xxx/qla_nx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
> index de2bc78449e7..121e18b3b9f8 100644
> --- a/drivers/scsi/qla2xxx/qla_nx.c
> +++ b/drivers/scsi/qla2xxx/qla_nx.c
> @@ -3699,8 +3699,8 @@ qla82xx_chip_reset_cleanup(scsi_qla_host_t *vha)
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
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190320163315.12740-1-natechancellor%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Thanks,
~Nick Desaulniers
