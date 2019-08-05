Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD5C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D9A20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3Jze4jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfHEHR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:17:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45090 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEHR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:17:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id h28so55276064vsl.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEcUadHXWt33HMQdDgSeAKvTfA2rNyZ6IARX0W+jn4E=;
        b=E3Jze4jbk8v4bCCKp+/huj4YLKUWLvrxZFVF/kCE12qIWkQjuraZpc0df1+VdCjt9I
         6wuRaUt3gSQ8QUSKQB7mon5lEXHR7fuO9FSYIeZWGGf78+ykXSQrJt/MbP1DIto50SxF
         +BfnuqlHdAyxnP7DqiXY3vIrTQ3ZNbdmf1R4Ep0kSsyLZB2SkriQrAAri/B2GVqU2OLB
         I3UDHqwoQxh9ir5JiVLFgcPaJC0X0jKSg7WtPpXnOJpeDRPsDWhhXuIdJfZuvQm1fId/
         x6A0rkmiHC5qgK1+uMyhAAGdThB5mnLCqERO7djadIXTtQ/oHSDXI/HOU/Th/GnmlrA9
         zNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEcUadHXWt33HMQdDgSeAKvTfA2rNyZ6IARX0W+jn4E=;
        b=goCYWwsnE/23Sjt84mAgBUUzMPoncHnmiOORqta1sp1UbuCeAv2kkNlJT17h2tXrIA
         BUdvK83J+O74ELGgJITYqOn4XGW6wRSrcp5PPUX69zOxwERAzEssrYSZ78sYFvxXnvOd
         b+JNU9Uo4WaZMWr5HAsWYzsydK4kK55icBW6YS1Tl1XlXm+Qy+nFu+EoFbPpSyOA6y5d
         uqUxhegrdZaeaoK/layT8P6FWUkOL4BLHXHtKTF6FAJly9i4gNrqfH4V4Iqk/p8a13P0
         qX4gQqf3gp3IAUS+l5ujExbKeJCmvsLsGEYXnropu3mni0P6QxOji+lBJojwDktQO1bA
         1hNw==
X-Gm-Message-State: APjAAAWSkemR7k9NEK+5pttvPDZ7KR1/4MtxHeZncAfB+CiQfqSazSdt
        xyJqW4ro6xx7hLrylooJWwcNOoDyqw1HxLoqIj64hg==
X-Google-Smtp-Source: APXvYqwQut/wHazS7Y2F5Kb/YuEqVPhcSdRYnqFrxjYYdHA8Z7HkVqTC8twtGBaUyNA/ddSnssS/hwPRzHKFHQj/XYc=
X-Received: by 2002:a67:f7cd:: with SMTP id a13mr30605473vsp.163.1564989448027;
 Mon, 05 Aug 2019 00:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190804070329.14503-1-ttayar@habana.ai>
In-Reply-To: <20190804070329.14503-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 5 Aug 2019 10:17:02 +0300
Message-ID: <CAFCwf12WFRf-UorVkfKSwLthsW-_=Gc7vcvisVC6Wh017o+2Eg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Update DRAM consumption on context tear down
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 10:03 AM Tomer Tayar <ttayar@habana.ai> wrote:
>
> The patch adds a missing update of the DRAM memory consumption, when a
> context is being torn down without an organized release of the allocated
> memory.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index 42d237cae1dc..365fb0cb8dff 100644
> --- a/drivers/misc/habanalabs/memory.c
> +++ b/drivers/misc/habanalabs/memory.c
> @@ -1629,6 +1629,8 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
>                         dev_dbg(hdev->dev,
>                                 "page list 0x%p of asid %d is still alive\n",
>                                 phys_pg_list, ctx->asid);
> +                       atomic64_sub(phys_pg_list->total_size,
> +                                       &hdev->dram_used_mem);
>                         free_phys_pg_pack(hdev, phys_pg_list);
>                         idr_remove(&vm->phys_pg_pack_handles, i);
>                 }
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -fixed.
Thanks.
Oded
