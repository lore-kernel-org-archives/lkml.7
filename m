Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1467BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB2321871
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkLe4JMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfEWPfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:35:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36422 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbfEWPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:35:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so9851491edx.3;
        Thu, 23 May 2019 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u7LRGUAkc7MmENWtPTnGBlH4AqK0GL/jUqDDtZhAKtY=;
        b=hkLe4JMmxf0dcgTvJtjxIAYwmwWavbwwRoIPkmLlqnh2eTIKFOcvLi4cgcphOplATt
         POTcp28T3R8sosv4sem6hFp1nsu86K7mb0NLEno1CtbIYorggPaSWfSHaNvDQ5lcb9h1
         quewMMnxmno5KjR/Wvrh8IXKXf78dzrUgH//sYNEUImyy+hUgOG+SYx0Z+VVMr1PJxK8
         3c5badxV6idEMF2w8hx3oomth6R2Pd4UyEz2Hy4Jd3KuqKwcAJeHcZQX3s3+cQOys5tY
         IH4C0IqpRDifzFLYE3mBWv+K8X14840gPwP9A0YTV2O9Zq4dQ8RBpZv4UmvjCrm+RNh3
         MPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u7LRGUAkc7MmENWtPTnGBlH4AqK0GL/jUqDDtZhAKtY=;
        b=XNOOvaBOI379vftmpCgM5qT2AXsHQVjP4sJF84tMvYYsSwMXlletG+xmTJif9rC7IV
         7AMcRsARMq9yeC692X0FKx2uqar6gX/VYWrWh+J/A3/DSorfmxAaq/w/7NSx2jg7VN6T
         6bQNw2DHe9k/VNgf7wm6WdLEjKNQ/NYqd0kohpRrhWut8bs9pox/XFyiIkHE6zgaNVTq
         pzlIbrnh73sz5FGo94AaMnEYj+mv09xuZUtAhgwfrQJKDe0+A6/GjIVGKx2OIWBBpR4Q
         r8aZLbmzHWTQoK502nOtsLQIoZye9JbVQZslQPp2Zoz482TnuOtYy1n30n999SEdzBqj
         pwgQ==
X-Gm-Message-State: APjAAAU8aKyILRmHjDxTsDoulYh64P5ztYxvLeMRTlrutB0taMrc+5F3
        DDsZmfKCMD8tXFIeN5n/a3o=
X-Google-Smtp-Source: APXvYqx7lm1bbh3OsTk/Fnw+a8KwyrgCSMljf9Y1/4Z8cKrIXySVZ6A9GXIjHJO1dWEdwWOsXX3Hrw==
X-Received: by 2002:a17:906:265b:: with SMTP id i27mr35933745ejc.147.1558625751135;
        Thu, 23 May 2019 08:35:51 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id z32sm7942897edz.85.2019.05.23.08.35.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 08:35:50 -0700 (PDT)
Date:   Thu, 23 May 2019 08:35:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Don Brace <don.brace@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: hpsa: fix an uninitialized read and
 dereference of pointer dev
Message-ID: <20190523153548.GA112363@archlinux-epyc>
References: <20190522083903.18849-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522083903.18849-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 09:39:03AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the check for a lockup_detected failure exits via the
> label return_reset_status that reads and dereferences an uninitialized
> pointer dev.  Fix this by ensuring dev is inintialized to null.
> 
> Addresses-Coverity: ("Uninitialized pointer read")
> Fixes: 14991a5bade5 ("scsi: hpsa: correct device resets")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Clang similarly warns about this, hence my identical submission after
this, sorry for the noise.

> ---
>  drivers/scsi/hpsa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index c560a4532733..ac8338b0571b 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -5947,7 +5947,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
>  	int rc = SUCCESS;
>  	int i;
>  	struct ctlr_info *h;
> -	struct hpsa_scsi_dev_t *dev;
> +	struct hpsa_scsi_dev_t *dev = NULL;
>  	u8 reset_type;
>  	char msg[48];
>  	unsigned long flags;
> -- 
> 2.20.1
> 
