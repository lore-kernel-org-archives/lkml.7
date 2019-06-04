Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921C8218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHEln+l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfFDMOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:14:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33209 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfFDMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:14:42 -0400
Received: by mail-vs1-f68.google.com with SMTP id m8so4239557vsj.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9g3FESup/SmZ3oHvcpa2xVipr1qLAdxv85nHopg58TA=;
        b=MHEln+l+9xztHv04LW7tnFWYBlSKM3dYQANaMOcKzoy5zjY6lOv3HVpzNsHRPfdchE
         l4oTqYq04TC5clbejyu2uu3iPevSvccEF9S7qKMLb8TsZ3SFyQD7QknpeSqLHs0H5d1F
         WJy/NP95r27Bla28Faue2ayL2Lojz9RmhkN7mLoaRjiQrEg4BsnjFbIxBPQvyWGpp58H
         NI4sfj3cl0y78YYDW+T+n6C2ewvdxw5KVhFtr9e2Y2A63YomVzCVw3NcqSaDEpRebDhA
         HikVWYwAssK//+YQghI2R3rJKLROOKpZrW8ZpO1jQG+kHEHUkkH8ght8ev8izP5g065U
         ot9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9g3FESup/SmZ3oHvcpa2xVipr1qLAdxv85nHopg58TA=;
        b=negQjhTjpij+nrFDDShsgUU0no6tCsD72wl0ac/b6+QID8WIiOU9wq1rY0LWfzB9pJ
         +LF41z1puNerpj9bK2hO2Tl9zvHFs6XLOlItAqdfyfW6t9lafLQeRJzo5paP3CgiupiG
         fJJXjhtndoQcepWVss0R3EKujW0cwwMuOzcqO4bVoX0rJaRaqKke3yZZj4ne973jqQ6E
         TMn8BUI7QKroX1CNTPho68WiKufsjHOlZ0wenQGmnxGXioOXHCJJ25QHCEIE6gZKodol
         /hIOGJC2w1DLSBWQ1Yq2LEFk5xdjRsPSih3nZ8qN/oc3duLr3J0BI8W62lVZvY9pNjGh
         4l/w==
X-Gm-Message-State: APjAAAUwF3zVJbN9O3v36q2Z4sNgAHUOL2ImniYFmPoDdoMXO4Kg5u/w
        6DTuXRf2rwEdERyIyrETjO0Dsqv1OUFr5MR3JZrVGA==
X-Google-Smtp-Source: APXvYqxlMWl5gP5oUCM4QhDHfhJo9IFZQe0HOFLuHSt1cApbtQAKL7VD9D97H31Z4rE2OM5WBK4y2zb/1dPEmGVDcGM=
X-Received: by 2002:a67:b147:: with SMTP id z7mr4744202vsl.228.1559650481392;
 Tue, 04 Jun 2019 05:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190604113519.4666-1-ttayar@habana.ai>
In-Reply-To: <20190604113519.4666-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 4 Jun 2019 15:14:15 +0300
Message-ID: <CAFCwf13gd-tNn_YAiNzDCNdi-now-N4YPzd9+tqfZypyBrML1Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Read upper bits of trace buffer from RWPHI
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 2:35 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> The trace buffer address is 40 bits wide.
> The end of the buffer is set in the RWP register (lower 32 bits), and in
> the RWPHI register (upper 8 bits).
> Currently only the lower 32 bits are read, and this patch fixes it and
> concatenates the upper 8 bits to the output address.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/goya/goya_coresight.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
> index 39f62ce72660..d7ec7ad84cc6 100644
> --- a/drivers/misc/habanalabs/goya/goya_coresight.c
> +++ b/drivers/misc/habanalabs/goya/goya_coresight.c
> @@ -425,8 +425,18 @@ static int goya_config_etr(struct hl_device *hdev,
>                 WREG32(base_reg + 0x28, 0);
>                 WREG32(base_reg + 0x304, 0);
>
> -               if (params->output_size >= sizeof(u32))
> -                       *(u32 *) params->output = RREG32(base_reg + 0x18);
> +               if (params->output_size >= sizeof(u64)) {
> +                       u32 rwp, rwphi;
> +
> +                       /*
> +                        * The trace buffer address is 40 bits wide. The end of
> +                        * the buffer is set in the RWP register (lower 32
> +                        * bits), and in the RWPHI register (upper 8 bits).
> +                        */
> +                       rwp = RREG32(base_reg + 0x18);
> +                       rwphi = RREG32(base_reg + 0x3c) & 0xff;
> +                       *(u64 *) params->output = ((u64) rwphi << 32) | rwp;
> +               }
>         }
>
>         return 0;
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
applied to -fixes
