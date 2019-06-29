Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792BBC5B577
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464D4216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NX/E0Blq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfF2TEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:04:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43481 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfF2TEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:04:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so4059214pgv.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJ63361E8dsG3z2xPB9fFpVPGIWLlMbEVzu+QndpyIg=;
        b=NX/E0BlqnT+uz9qblZjXXFu3/K/FYOmmeDQjhOXu7z/PqHsEjoxkqRzCE8gSomvfPN
         rgGuzMGZTAFDx8heZotHTHPzEjqB2C+mnsPkB9J6pbBjFq9wJI7ljmMNaz8vjHak30Ba
         a/KDQ1MD/pbzIvd1hfAvWJTPn3p17G3XK1V9KUztIh7JHmj1ThDBnuFPh22pa5Mi53hl
         5wmEdLa0jgd9MUxpKlovofSSObqjbHuJNLSlR8+iNwqcdaw2AAvVfg8sbgqj9sMYT2OC
         3poXpSPvcYQbD9IMuWKejcBGZIKHdkyM33JlrE5+A031oYonyGNSn92yV0zuPdFn1RBi
         Mq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJ63361E8dsG3z2xPB9fFpVPGIWLlMbEVzu+QndpyIg=;
        b=BQTkM1vq1bxVN+UcZboqlfrjAUQ5kE8zzaatOh4OG/ko8wpiaCFZV0gIlorZHmZLOp
         7tP73vZxh2rgSME/wnznaXXlct5O/Sm/okW9FFBZZrHiebQot2e1LxZIbuxhMJc0aY7V
         wQuFwMZeoOSHjC0Xoz8ARc/KeRkUWifO2JlfVPZW9JecR+GzdRnjo8TxH1tA3r7coT3J
         3+ODuFCWpvkw2AvoemjKWTy56/zc79j4PVY8baAUC9nY4WEks7i+S95IuCCMea7ZwrWh
         rqCvpTFMnjQ6UkAMOFqSkQYa2GF3kDkHA9j52JQhYuFtgOzZY9p1BQaJW1ODcD+8agGy
         nxEg==
X-Gm-Message-State: APjAAAVQ94E/ttRYVkuVo9I5fpA6X6kBaaRU/fqdLdIQ4ZWHA38Mz+as
        NwOyguW0tOFhx2O2lW5Ue8Xj6pFCUo4=
X-Google-Smtp-Source: APXvYqyjlKUvT5kDN94EI2+RgRwCFl8Em05upW7HoAJ85wnqCari6NJcFpI6jC5hAt3FLaY+o5qfNA==
X-Received: by 2002:a63:1f47:: with SMTP id q7mr15914252pgm.264.1561835069807;
        Sat, 29 Jun 2019 12:04:29 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c8sm2920333pjq.2.2019.06.29.12.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Jun 2019 12:04:29 -0700 (PDT)
Date:   Sat, 29 Jun 2019 12:04:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: Use struct_size() helper
Message-ID: <20190629190427.GF23094@builder>
References: <20190607185314.GA15771@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607185314.GA15771@embeddedor>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jun 11:53 PDT 2019, Gustavo A. R. Silva wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct resource_table {
> 	...
>         u32 offset[0];
> } __packed;
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following form:
> 
> table->num * sizeof(table->offset[0]) + sizeof(struct resource_table)
> 
> with:
> 
> struct_size(table, offset, table->num)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks good, applied

Thanks,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_elf_loader.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 215a4400f21e..606aae166eba 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -247,8 +247,7 @@ find_table(struct device *dev, struct elf32_hdr *ehdr, size_t fw_size)
>  		}
>  
>  		/* make sure the offsets array isn't truncated */
> -		if (table->num * sizeof(table->offset[0]) +
> -				sizeof(struct resource_table) > size) {
> +		if (struct_size(table, offset, table->num) > size) {
>  			dev_err(dev, "resource table incomplete\n");
>  			return NULL;
>  		}
> -- 
> 2.21.0
> 
