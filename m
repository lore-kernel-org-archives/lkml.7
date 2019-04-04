Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0594020855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjaRVFNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDDII2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:08:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37352 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDII2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:08:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so840333pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Mp1oHWeHTUtm10kXUx613RnhgAkqJiWHeDd7CtnjsS4=;
        b=gjaRVFNjeavT8zGQy2ubWKkzBJVxaBC3O8Yg8x+XGHBdO8nD/z5qGq7v3OXE99sjq3
         t44VKo2u/dfWipZIRWyHvPOUHCQpjpXe5d1sKlsjPanEu7EHmUXbj+zoy6RxhgGm7dZc
         WA7CFwzeyc+qhNLJixiu6FGPjWYxVEvL/ddoCstp4rX9BbKiqSzlA81fHxTSggw4GUDc
         LT+Y0o0tP4FJTz2Jwn8P73GctrZ02kAYG2I6VZtvdcgJLdU+jZPK3W2yKorvC39QKU/v
         xVFjSgBFiBjg4NVyyDZAHwuweWoIdC3bJ3whlo+Cnk/LWPs9ex1W1NCtSwZxDi1V76Ll
         /xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mp1oHWeHTUtm10kXUx613RnhgAkqJiWHeDd7CtnjsS4=;
        b=eO5dKhkY9Iyi0cqK2KvwAfk/5MlfmBElCP1frZ81ZfTd0BS5lafDmXF8URYInG/Tyv
         EdWURSsBbpMrqaxClTgCO2y6WRjy+Gzgy5sC1GjPyxjQ0bc9sqk8/DDZhkjq79uuTg0u
         2k/Wc8NyPRb8YnMuOdrRymxYfpHTeLae8urcEFEzMuSc5HEzLY/cCiX60d/y0qFA9FCb
         +b8TjAhe1m6/a5r5MDkkaWF1dh6H2YT6yhwNvyZGQwn7WG+/8ZewsLvrUPWX22vjMcyF
         EAUtLZHPtB8OI7lY4PfLwn+PGud0dnZgZ/XbzEYb9IrOeSzu6nSH1U/06Un6kl13VFUQ
         LEPA==
X-Gm-Message-State: APjAAAWYsEJjloRvws0uB4es2lyOBuXALaXWrXo/n8sWj5UxVnFd9TWU
        MCYTx+MIltlHJ7Z36GQ5thEPDf9iH65lEQ==
X-Google-Smtp-Source: APXvYqwloU2gBVe+wUHpJAa+srUOWmEodXMbbwTChUuYt0JeZVM77sBDLatz+4M2olopxmKZOfxcOA==
X-Received: by 2002:a63:7885:: with SMTP id t127mr4329645pgc.338.1554365307272;
        Thu, 04 Apr 2019 01:08:27 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id j28sm39730016pgb.46.2019.04.04.01.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:08:26 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:08:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: cs47l90: Make DAC_AEC_CONTROL_2 readable
Message-ID: <20190404080822.GK6830@dell>
References: <20190403095917.6351-1-ckeepax@opensource.cirrus.com>
 <20190403095917.6351-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403095917.6351-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Charles Keepax wrote:

> From: Ajit Pandey <ajit.pandey@cirrus.com>
> 
> There is a second AEC loopback on cs47l90 so the registers for it should
> be readable.
> 
> Signed-off-by: Ajit Pandey <ajit.pandey@cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/cs47l90-tables.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
