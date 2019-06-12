Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EC720874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1zV2wo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437171AbfFLIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:31:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbfFLIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:31:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so602789wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H5W3E9cOzUJxWwVYxO+yb51ErcnMPVK+SL4opotcBac=;
        b=t1zV2wo7etW4QH+rcxFBMWSscFLjoDZvgSFRgm4gY0wA8+UoeJ2vavuAoOfY5oshey
         AHQ35AERzlftVpaXHvktU1tZGzrVLc2d2wZnYirVFM/8lJ1+JiD1pXqqOL5/15QN6bVg
         f1/L2whjjpkOtny8nNuxB0QiyPMjQFokCqNVNey08Y/8ncIoc2KzcvJdcrJ10A6PSC1F
         WtAO1jJio3/LVIh8+LzoubIcewTxOySbYtKQilSAg7udGF+2RlfU9yrnYeZNolcndo8c
         URBn1JBpAlozO5kJvVIc59Bnb8pBrsNi2A038G6XuiLoXsgN/7HGS8780xhYzCFiznJ9
         6YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H5W3E9cOzUJxWwVYxO+yb51ErcnMPVK+SL4opotcBac=;
        b=bgQaEkUgODqhOk3w0oJLsAD6hdOLCS3OZcKnjLylP+Gc+f8Q4q/wSFXjVLf3pUFkEA
         mRaKJsT+5sD11Z4H1iSymzmp/Py0zkma7bQaaVPL0oQ5Q0kEP+i2rwhmG4OM4wUKmABK
         D03iJopKTecLP6zBovFFgNpRTKD6xxD8kMsJJw+XpEGMI9pbEzMxDVffBUpp1Zb2E3Rh
         1AbbttDXLDOQ1f/lEjyg7rPfynYYZALTR2VtlssbVpuJOUxmaAlX8DgYg/lFwNSB/aIO
         gzPko9BaH5eq7xJbowMsbN+XSIurkZx2GQVgfhBijk0ASHK/75IjDQCSV+WMbFTXAIaL
         tSoQ==
X-Gm-Message-State: APjAAAXytf9nM/hxvu7f41HxNzos2HlFv1ByC7P4M9pKK+qwCg+R5LtF
        OgWlqB2DrxDAdr4zPk7uJnVO/w==
X-Google-Smtp-Source: APXvYqw5DOg8Yb3mXUYmhy5QCQzcrOu88ail/4XiF9p6Oboi0PbyoymIsJn8tHpHkuS82dyat1Sx8Q==
X-Received: by 2002:a05:6000:1c6:: with SMTP id t6mr9726824wrx.236.1560328311032;
        Wed, 12 Jun 2019 01:31:51 -0700 (PDT)
Received: from dell ([2a01:4c8:f:9687:619a:bb91:d243:fc8b])
        by smtp.gmail.com with ESMTPSA id t140sm1663646wmt.0.2019.06.12.01.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 01:31:50 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:31:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     arnd@arndb.de, natechancellor@gmail.com, ottosabart@seberm.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/4 RESEND] mfd: madera: Fix bad reference to pinctrl.txt
 file
Message-ID: <20190612083148.GU4797@dell>
References: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
 <20190520090628.29061-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520090628.29061-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019, Charles Keepax wrote:

> From: Otto Sabart <ottosabart@seberm.com>
> 
> The pinctrl.txt file was converted into reStructuredText and moved into
> driver-api folder. This patch updates the broken reference.
> 
> Fixes: 5a9b73832e9e ("pinctrl.txt: move it to the driver-api book")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  include/linux/mfd/madera/pdata.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
