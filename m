Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683BFC04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39151217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtxeRFAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfEJHCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:02:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35174 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfEJHCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:02:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so2114860wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JRWdWoewTocU8nrk2Hz18h3BUdlM7HWn5LtcY0LdbcI=;
        b=gtxeRFAUwu8fb+cBGQ/DnmXucUFlEOy68GizZHQW/AQTTHdo4E0h05hckutZ0mGg9x
         JqiRMXZjpRrEml0i6G63qnCKDl0A6d18flfT9zogkcrv0TpJaScuFje4+9VfyumCehQ0
         eRBU04ZBb1bP2v83OjOoSi3PkTqwg8z9pVr8fAaShlU1Qevy+QjiwPciiaV0BLIm29HP
         hTquskbaz3trJBO9+BUnMVbSyl4MYdwXAsqag1+JBF/Th+Q1BO7RbMfV8eLdSpOPp/BQ
         VyS4JW60ZOVe+yBblwHccZlnrnl2oABhZPJat8wqfSZZocz0r4tC/MOeGSnIfdFmtBNC
         SiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JRWdWoewTocU8nrk2Hz18h3BUdlM7HWn5LtcY0LdbcI=;
        b=JN70RJuAdQM3ZAZozmZXpBtKTR641xxtKx9cqAlFI3YvBVYIE9423fciyg+gAWXEpL
         9PE3HFP+a4xrTQZMkD8IHSs2kDB9Zasyw7vZ2rO0BF8ZOc9u4cSkmxl8yFTY5QHmXjO6
         Cm3yMPafx2xnA88X7ExEhjaY+8VZbWQ6d+oc7e9BcE2WY6vDkuGjJlLg/6ZATMPHY2qQ
         PTamdjWV4f/Q7GfjzU7DTcB88uDDv7udxaupwDsI98QfV+NqVeqmE5SwL1rYV6uMIVxo
         XaUG+AyZBxfZO5qlxHF6Zn+6ZUWDVYj2MQaXjHcLPSi2gBMS6lJpsFLbb76voaaI8+sz
         HfIg==
X-Gm-Message-State: APjAAAXiUyw9Vizzk6LDdJVdkNiraRB2RbzPdsszbp1JU7CPddDPMz3b
        rwAHPSqxaZS30ZOIIrUg4v+Bv3n927g=
X-Google-Smtp-Source: APXvYqxy5RbQWyQHmMAGJH4mhe6fz63p/mLoUwUpk3w2k2NVGrRrH3Be8C8LG2kd7wumX0JTvZTpsw==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr6085358wmg.30.1557471751173;
        Fri, 10 May 2019 00:02:31 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id n4sm3912417wmk.24.2019.05.10.00.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:02:30 -0700 (PDT)
Date:   Fri, 10 May 2019 08:02:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH next v3] mfd: Use dev_get_drvdata()
Message-ID: <20190510070228.GA7321@dell>
References: <20190509061443.GU31645@dell>
 <20190509142339.96276-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190509142339.96276-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 May 2019, Kefeng Wang wrote:

> Using dev_get_drvdata directly.
> 
> Cc: David Brown <david.brown@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v3:
> - fix build issue('dev' undeclared) in tc6393xb_nand_enable()
> v2:
> -use dev_get_drvdata() instead of to_ssbi()
> 
>  drivers/mfd/ssbi.c     |  6 ++----
>  drivers/mfd/t7l66xb.c  | 12 ++++--------
>  drivers/mfd/tc6387xb.c | 12 ++++--------
>  drivers/mfd/tc6393xb.c | 23 ++++++++---------------
>  4 files changed, 18 insertions(+), 35 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
