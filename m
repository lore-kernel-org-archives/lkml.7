Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89F6217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hCfBYtwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfKAJsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:48:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39709 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKAJsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:48:43 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so10273240ion.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQ4kJO/LdNtQeyAoGhBZHVEoy+027Jwn5KrrQGVIvo8=;
        b=hCfBYtwqUWB/uYMQgBc/dBVud6y7eQ+FBEqfF508+jLlEJnSO7g3I4DKK9ZPo5CZpL
         AUTLMhyDWZfZBviJ8eAX5y7dnNkAFu/1kVbzUEmxKZV8zzSPgR+wL1dIof54X4gAvH4y
         WYW2XRlw7srB+eMZim05RPR+tfIi2s3CdejWKMVhQD26KNIjT9si2YoPNsY7WboHSx6Y
         wqHDtXF/fyhNAyPHEX5CugrPj2toc57uhzf03sRg2S9JtvpdU715PBcSXCcDI4HmO9i+
         oYWCmYEu/oDePw50jOLRbhOw6juKLstRWZ/j3CHNAs4TYnvWg9MaGFb6jQRRyXEijhcK
         5T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQ4kJO/LdNtQeyAoGhBZHVEoy+027Jwn5KrrQGVIvo8=;
        b=JDN+ESfwDmn8t1xtlTSSt5/RC/L3QE4XIEC+pQ7tZdMkBwkfMuaY0XcHx9WoUCtB02
         SvGBWPoWtE7kUaUCukABMUK0zqaXp2Ftm4eU6ZHqz+ii+DtV/aSpPib/D5SzOasjCt5u
         64tDPch7HTjbJ6xeaKclGksAwtAF3CzyIizHp3ByNNJ/wOfXdyi0BIUMsI7XAqImePX1
         D2av0gNeCKZsPqnaU+/oETTJBO4B2LFfTwGVryOi6DOP2kO0x346v56y+ug710cMXSYo
         x4TRydrBAd4m31wNo6j9rD0u3JDbRvSmJ0mNXwJ0EDxF2/8rn6QitFQH8OxCuE6ysEnM
         L66Q==
X-Gm-Message-State: APjAAAWwYHHtAFLXMLGzqXVZbN51MoXbpF7o6QItNLvKWduhwyuhUGLR
        Rf2kvdagGYdFUvtZvL/i8apJoF6pNXvj/oCfpVJxVQ==
X-Google-Smtp-Source: APXvYqwckEsM3suLNprpC7KS65ZLIqZ2o+ZWoTGlDYgFYW38c/1dxLPuf/UT2gF8ys+WTKRa1scxKK4bzCbFv+AlL9g=
X-Received: by 2002:a5d:8b14:: with SMTP id k20mr9742192ion.22.1572601722746;
 Fri, 01 Nov 2019 02:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191025135010.GA6191@saurav>
In-Reply-To: <20191025135010.GA6191@saurav>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 1 Nov 2019 10:48:31 +0100
Message-ID: <CAMGffE=Sk3hHq-Xe+PhSQHZJoM+U3D=9revKnPjsJ75P8c2yGw@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: pm8001_init: Fix Use plain integer as NULL pointer
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 3:50 PM Saurav Girepunje
<saurav.girepunje@gmail.com> wrote:
>
> Replace assignment of 0 to pointer with NULL assignment.
>
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
looks good, thanks,
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 3374f553c617..ad67cdd4d3cf 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -432,7 +432,7 @@ static int pm8001_ioremap(struct pm8001_hba_info *pm8001_ha)
>                 } else {
>                         pm8001_ha->io_mem[logicalBar].membase   = 0;
>                         pm8001_ha->io_mem[logicalBar].memsize   = 0;
> -                       pm8001_ha->io_mem[logicalBar].memvirtaddr = 0;
> +                       pm8001_ha->io_mem[logicalBar].memvirtaddr = NULL;
>                 }
>                 logicalBar++;
>         }
> --
> 2.20.1
>
