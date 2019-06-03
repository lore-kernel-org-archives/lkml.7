Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C0EC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2070272AC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtAdhoHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfFCHau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:30:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43815 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCHau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:30:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id r18so1822897wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M4ll74/WKhSFaghcnaaP+t7DHNq0bSr1SP/Y1vqsSMo=;
        b=GtAdhoHtwc2UCM/fNKoxa3pte2zyqWg9Y3CCRrmtcD31LG/urmbFSPuGMbFvz+tvHV
         ZHH+NJQXciB7dg1bAYZLAvo24X8JhL0ncnZrlbuzu/prk/t/FDmJxedrQbr6wxmc2XDf
         qXdYr4UUHDxRlIBwbYCsrY9oR/DPZaKjXxH3u2ItvDIhpNMZVFOgYfppSuEMcAj/lFJ0
         fiW7yxk8volCVJiAeDPF5lbDa69vCSfMcHiX4hr/rs5i3/LR6h5Vzm2BifbCms9wu7QD
         fLYHxdQlfOKpD/+WKLAQcUsVG1cwdmfqFSzQ6Fr7dc2dnM1iUI+V39wl5tMGoPl1OIy8
         9+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M4ll74/WKhSFaghcnaaP+t7DHNq0bSr1SP/Y1vqsSMo=;
        b=Dxc/mG4dOwMr8/fTQNiMrxIdgnVAjRrJ24WnGR39YqFG1scQzhpg+/ku0SeH5jcds0
         QrgT5vb3W/k3rcRCrurGCAC9bTLblIGPILw/EoDQZdwFnHynLSIIynqCpmYtS/O8QSSD
         tIThu01bzvXFD5QFI9qIGcEOI8A/2hvkJxey+8T1rG0rhNFKbDLOhljJhB4Jf78C3cVc
         PvuTRS6KKlUo/rpOd93BHpE7pQzKKum5+XheQb3uLAqs5McZoGm5ulqcT4NC4+Zcqq2y
         ohU5BYAhGkOyLQpa+hp2H0ao5zjgDTEl8qTtMZLSLOsaK8EX1mwCG3Z8t8rHD1RAL7qM
         jFVA==
X-Gm-Message-State: APjAAAV5lxFEsW4Wcv3R5FPW6xASXkyBHJQD0/fECEdAq6hCLaQbHW5e
        HaiWYZO9t5Gq37l/h+21LYoclN/WNW0=
X-Google-Smtp-Source: APXvYqzfy2LHhRFy7PNkZKC5674AEGU8ujPSR9Q7IvezsJ54X8ybuyDE/zf++yvc5EpUmcd0tgVCig==
X-Received: by 2002:adf:f743:: with SMTP id z3mr1307228wrp.129.1559547048775;
        Mon, 03 Jun 2019 00:30:48 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g185sm13041249wmf.30.2019.06.03.00.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 00:30:47 -0700 (PDT)
Date:   Mon, 3 Jun 2019 08:30:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "moderated list:CIRRUS LOGIC MADERA CODEC DRIVERS" 
        <alsa-devel@alsa-project.org>,
        "open list:CIRRUS LOGIC MADERA CODEC DRIVERS" 
        <patches@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>, javier@dowhile0.org
Subject: Re: [PATCH v2] mfd: madera: Add missing of table registration
Message-ID: <20190603073045.GE4797@dell>
References: <1557569038-20340-1-git-send-email-dagmcr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1557569038-20340-1-git-send-email-dagmcr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2019, Daniel Gomez wrote:

> MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
> OF mathing mechanism and register it.
> 
> Before this patch:
> modinfo ./drivers/mfd/madera.ko | grep alias
> 
> After this patch:
> modinfo ./drivers/mfd/madera.ko | grep alias
> alias:          of:N*T*Ccirrus,wm1840C*
> alias:          of:N*T*Ccirrus,wm1840
> alias:          of:N*T*Ccirrus,cs47l91C*
> alias:          of:N*T*Ccirrus,cs47l91
> alias:          of:N*T*Ccirrus,cs47l90C*
> alias:          of:N*T*Ccirrus,cs47l90
> alias:          of:N*T*Ccirrus,cs47l85C*
> alias:          of:N*T*Ccirrus,cs47l85
> alias:          of:N*T*Ccirrus,cs47l35C*
> alias:          of:N*T*Ccirrus,cs47l35
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---
>  drivers/mfd/madera-core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
