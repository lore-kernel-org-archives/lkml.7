Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC880C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1902086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qb8ENpxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfHEMeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:34:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43633 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:34:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so57812128lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFq8Cl73tLG4+pSCio9gqyV6ILbsyB08y8V4KloCMss=;
        b=qb8ENpxDn1mCWZhT54r9bq1+0CIKvSbaMm0QFAX6pxht+cd7JaOGJydVCItL3UHRgb
         yB30aeWpB9+iekLe+s6wXqpwZuWRzCIDohg6tyRUOp45/E8t9KvTQpSiVALAeNoVjufI
         AbwHWChR/0wu4yepBB4BQpWal8tVU4Ce5mlGPHD7fY9y4WeaqFGhCjwmYP+HYSfpOt7s
         jl0e0Rz5FekBob9Hmp82mJ6ZTs6D41AX5dV1CGTEOzthTSQd05Yi1CVQe5lhZPDemSYj
         hCW8Lr9BV0hCZBbFU4EhVhe+Bim2DCzTubCWo70dko8uujlkowJqzLH8XWRTg8ELeECO
         c2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFq8Cl73tLG4+pSCio9gqyV6ILbsyB08y8V4KloCMss=;
        b=oJ4BbsRmbQ3s2N1s6zbKhD+psAJkylSiajZNnMlmXCKmRdQQ+0U6/O1zMWVoUtIlrA
         tK1Mi4gtyqBYHVL3ti10vAaCw5zqQnNxkLN8I8icMFAyiMH1diuFP+S4bcOumyan3Ehg
         Thvr062zo/DTP+KvUGM0qpRCda5D317YMqcTvqwKta5fwCSNY7/5wRBl1Z8FLZN8Yeub
         5eYYzm0arpB6JqaeTVG7/9Vc/gAuLPgt7KRDge7Q0o4Q179sVnGH36YInuTZ7sZXmZeb
         eH7hUIO0pnFFWEsmf1HBg767HGQBYcCdktkX/bt5ul6qm6CWX96bXHLKUFGLhr5qwwRH
         Kdww==
X-Gm-Message-State: APjAAAWre0tOxXbo2T+2FI2ai1+lBAqwqGAedn6Ln7a1oTA1krn0kLHJ
        pIU04aUMnUGuWgxToqxcQkZXnnYtekhSik/nIm63kA==
X-Google-Smtp-Source: APXvYqymitYgepyvOK+JBZy7GrH60GHKLfiwb1GSsoco0V37RW1vdVWTSekr1srhCc8x8sy1Ia5WB5n1Q1D0K0/ub9k=
X-Received: by 2002:ac2:5976:: with SMTP id h22mr3729701lfp.79.1565008443805;
 Mon, 05 Aug 2019 05:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190726134531.8928-1-sudeep.holla@arm.com> <20190726134531.8928-7-sudeep.holla@arm.com>
In-Reply-To: <20190726134531.8928-7-sudeep.holla@arm.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Mon, 5 Aug 2019 14:33:53 +0200
Message-ID: <CAN5uoS_TA5ELTLtHnUbWhaOHyUDjoKZz0S8SfmXBfR+n-=_M3w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] firmware: arm_scmi: Check if platform has released
 shmem before using
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep,

On Fri, 26 Jul 2019 at 15:46, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Sometimes platfom may take too long to respond to the command and OS
> might timeout before platform transfer the ownership of the shared
> memory region to the OS with the response.
>
> Since the mailbox channel associated with the channel is freed and new
> commands are dispatch on the same channel, OS needs to wait until it
> gets back the ownership. If not, either OS may end up overwriting the
> platform response for the last command(which is fine as OS timed out
> that command) or platform might overwrite the payload for the next
> command with the response for the old.
>
> The latter is problematic as platform may end up interpretting the
> response as the payload. In order to avoid such race, let's wait until
> the OS gets back the ownership before we prepare the shared memory with
> the payload for the next command.
>
> Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 69bf85fea967..765573756987 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -265,6 +265,14 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
>         struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
>         struct scmi_shared_mem __iomem *mem = cinfo->payload;
>
> +       /*
> +        * Ideally channel must be free by now unless OS timeout last
> +        * request and platform continued to process the same, wait
> +        * until it releases the shared memory, otherwise we may endup
> +        * overwriting it's response with new command payload or vice-versa

minor typo: s/it's/its/
maybe also s/command/message/

regards,
etienne


> +        */
> +       spin_until_cond(ioread32(&mem->channel_status) &
> +                       SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
>         /* Mark channel busy + clear error */
>         iowrite32(0x0, &mem->channel_status);
>         iowrite32(t->hdr.poll_completion ? 0 : SCMI_SHMEM_FLAG_INTR_ENABLED,
> --
> 2.17.1
>
