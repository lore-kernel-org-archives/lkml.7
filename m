Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B630C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s192G3Bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfCSBpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:45:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40301 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbfCSBpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:45:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so19174486wri.7;
        Mon, 18 Mar 2019 18:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAp/nnHyZc5N/Vnxi/U3ObjewAAX8ANVXaWAzjnq4+s=;
        b=s192G3BkO0x5KVj16VAtbbZgWuLFYz4UiAgoMOPRvHUtiMnCLhezY1kDFcNbGNxQta
         YACyR+y7MAt0csIVO6V6aPxipBAeoIJTPwPqmz7EAdWjgG20+upjfg9gYp/W66ktn6fy
         dT0n5Wb72+UN8ScdYS6xO61r28hY4Y9X3z2BTk0xZdZROUtM18RvNM07EPHq5GSZSMQ8
         mrhB1eAoG/umSkytc24VGwjMIsHsxlWHHWl0YcYmLi66NbzqndGkyiuxvcRHmxBEsmZT
         qJos3lgemOrn6VusTOGxPflcKbfbNPXWg5jdyDtkyfgQndhBfjTP1JRhUMzBwnnQepPD
         Zbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAp/nnHyZc5N/Vnxi/U3ObjewAAX8ANVXaWAzjnq4+s=;
        b=THfbLDsVupXNMJmcNJPB5rZMpYVE6tusxlPjvef0U9/xNhgFjfJq/aGEIA768Q4fZF
         8ww2XMtc2L03gCVIEO/o+DUD2JhyCueFTsmiN4rWE9M2o1Iqj7Y+a3AL/aoA3LUOcU2r
         qpjxGWARUhofdo5cJupxIXxtZZ9aOFqKpjeS8Vlu0lkPVVfnL7YWcACUROiTcXhKQB5Z
         fEcWyJgE9zkwz80hBjT17qKlMayJOr4SGTiEaXd0++10c5SrGr1iQYLQBXWFbFUJ3q9Y
         iFy/oRJN6mzeQTTGBtld2SIPD7bJ2kw1TBee/WW51nvlqmH3joUGfebPOfsJ38Kj59lv
         xdVA==
X-Gm-Message-State: APjAAAWdqRm7c/M72CsN6VTbLlqETWsXhC+X3aXFhpruTJerza9hLVQE
        B/yX3Nsv4uZqvANzMvhaBY+jL51JLW160IZENPw=
X-Google-Smtp-Source: APXvYqyDXrW6QJVhLX7VyXvTKYk4mJgCz9Ud/MrltJcbYAy561ZHTFdgDgIlfENaiyx9QiSNpB9tCuaUK2TTyN3GPfE=
X-Received: by 2002:adf:e949:: with SMTP id m9mr15363915wrn.1.1552959944011;
 Mon, 18 Mar 2019 18:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190319003038.12896-1-pakki001@umn.edu>
In-Reply-To: <20190319003038.12896-1-pakki001@umn.edu>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Tue, 19 Mar 2019 07:15:07 +0530
Message-ID: <CAGOxZ52QBKS3BtKyjiSxaGBW5piLGM_Lr9WQk8_Ernbq9Ehz7g@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Fix to avoid a potential NULL pointer dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 6:01 AM Aditya Pakki <pakki001@umn.edu> wrote:
>
> In tc_dwc_g210_pltfm_probe, of_match_node can return a NULL pointer
> in case of failure. The patch avoids a potential NULL pointer dereference
> in such scenarios.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/scsi/ufs/tc-dwc-g210-pltfrm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c b/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
> index 6dfe5a9206e9..2b5bc6bd715e 100644
> --- a/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
> +++ b/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
> @@ -61,6 +61,8 @@ static int tc_dwc_g210_pltfm_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>
>         of_id = of_match_node(tc_dwc_g210_pltfm_match, dev->of_node);
> +       if (!of_id)
> +               return -ENXIO;
May be just return -ENODEV
>         vops = (struct ufs_hba_variant_ops *)of_id->data;
>
>         /* Perform generic probe */
> --
> 2.17.1
>


-- 
Regards,
Alim
