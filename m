Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B10C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73B7213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiZ/nnSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDID2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:28:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33599 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfDID2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:28:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so68426edq.0;
        Mon, 08 Apr 2019 20:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NlspmfuHEW9R9zYRgvJ9uJ62fzkgEPlkrDc03lrY674=;
        b=kiZ/nnSqo3B9SYuvv4cehYmMnyh+KRGD1h6ycHPLRCboSgcoB2bcsIzMR6RlAmlVjD
         xp8Wu9bV+O0zKhaHQQjzf0QvC+Ei44VpphwZnYaGprnnsIoz4A/dSKJ5+v1r7qJ+/CSB
         B+MzAbWZ6LqBUpZd42lX9WdYucm4gOsYPRsbGmOQW3K0faMkfGzcm8VD/K0438I6fg5z
         3Cd5f9w2WgVGdtzo0MGnjRnbp/hZMEkY+PErSgnic6w3RXU+Yaw18ZUHJCeE2erroGim
         DybeUpK6CpZmps923Q0berzdKM2NHRxwxURYPqJP6lVzp7H2sWzRK+rmAFy2dmn7fNKg
         NAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NlspmfuHEW9R9zYRgvJ9uJ62fzkgEPlkrDc03lrY674=;
        b=DS3/gj8uR5vztA3EJ20DJ8cSSvxtyC0GLEBoZFlwZd7fqgJsLi2n8Vp+zuZuKjumd8
         drFuOCzpwED97HzELvgYrsxT1mKq6bmHu4tjMxpG58BMw0XeNL6QyiTB91SnHUz4+VbO
         pU926MDvsGlFa9GsESwTfS6DWXabGs6WHjihcqk921ENJ2aSi4B6wAgJd3u19TpsIo9C
         rFwbXa8rCUuebGQwbJj+xMK1cjEoINynt/s8Lud0q4NVjwwruZE5RmDTaJJGTWMvhoeX
         239AFZm1PpbVLWceejEuiMYaF/Sh2/iSIpc/oHKItQ+0uPBM7O9kt9JuGR/pMGko1GsT
         9DsQ==
X-Gm-Message-State: APjAAAUrhqkfoLcFczfXF8VzzDGNBw8fsc+TNqT2a2ScH44qxG5E3qwG
        CVO9zirHrWRXbio22FpSNZU=
X-Google-Smtp-Source: APXvYqyAy98csKU43hLq5PcENULKNt6LV61OMJWX4C/WzZ/3MThnqwD8UF8nHJNnNHmbdyLp/moRig==
X-Received: by 2002:a17:906:66c2:: with SMTP id k2mr19257762ejp.181.1554780530355;
        Mon, 08 Apr 2019 20:28:50 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id z3sm4229894eja.32.2019.04.08.20.28.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 20:28:49 -0700 (PDT)
Date:   Mon, 8 Apr 2019 20:28:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] acpi/hmat: fix uninitialized pointer dereference
 on pointer 'target'
Message-ID: <20190409032847.GA19002@archlinux-i9>
References: <20190405141215.2079-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405141215.2079-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 03:12:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer 'target' is not initialized and is only assigned when the
> ACPI_HMAT_MEMORY_PD_VALID bit in p->flags is set.  There is a later null
> check on target that leads to an uninitialized pointer read and
> dereference when assigning target->processor_pxm when target contains a
> non-null garbage value.  Fix this by initializing targer to null.
> 
> Fixes: 665ac7e92757 ("acpi/hmat: Register processor domain to its memory")
> Addresses-Coverity: ("Uninitialized pointer read")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..b275016ff648 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>  					      const unsigned long end)
>  {
>  	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>  
>  	if (p->header.length != sizeof(*p)) {
>  		pr_notice("HMAT: Unexpected address range header length: %d\n",
> -- 
> 2.20.1
> 
