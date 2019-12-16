Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5934CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FEE2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFRXrT6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfLPKyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:54:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33610 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfLPKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:54:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so6698042wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aiLOtGNg5sB0YZvpngPYjrYxUnnjI0jwnwUxn6kd1V8=;
        b=HFRXrT6fl/0+dF4GHo1YNYZl8uVd8tYwus79SJ/QGdtE3qf71V0QZKa3D7yfRAZRkL
         E15tqX9n1GFp1NAHQEQlH5h+AQqCVvjGspa5KRuvKBcNV/VFFiVPQSssLh8iXuh4Naas
         4LupMIdw5+LZh9p08wKZuy+AX8FTUZifOjtF0TVlLzY6cHsCawxHegHo1M4bng1LdSx2
         3vo7tTMVR/azYJLnMyg+FiK9oEdXuoHf8S24/aJIkrlj+Aj4xSs3WBOFVyGu9uN+thjd
         4QNhqb9G8d2Nnu6AlNEt6kXyzAQZZBRSGtby2adXQYQgXwNIP9UjkE+6I0VjEx7M7jBH
         +8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aiLOtGNg5sB0YZvpngPYjrYxUnnjI0jwnwUxn6kd1V8=;
        b=Xg0kx08OvJKIH/4yupSWI4m/b3lVhliY4aIqCNdvwK8P4WF9YG7FCq6VbK9e5Sg8ld
         Qo4s0SSVZUTMiVwC1z/C6kBVa0ocJUcYexRDwIL9WmzHBNHINzRFLjptjqg+oRZdi75a
         GvI7eK42K6L/ewj4yLVuo8ImqETOu+JoWhZrZYT4dzkA4souFR7JbPZ+iC6SMxpt+NZE
         BRx6dvFzAlUeA8HucHf7NKOXmuBAZ0nvgObJ1zbfQAiMvmrqyljad7OFamr090jqxz1H
         dp3xkkBJ/0SIG2x7XVfyduGVBU0aEGG26P0hUzdxwou5Jxv0RttW5rzS7ez410C6Z5+w
         9mwA==
X-Gm-Message-State: APjAAAVhSGBM0lkTor7B4q1Xky5yPIle/FFzE2gIYgKT4IH6P9kBVYZ4
        Gb5jjWvDol4rIdSfvOTMJIesMw==
X-Google-Smtp-Source: APXvYqy7p7NgcJE7iuh7UCymMPmlMPFvbBjOrnjytJZbgKelWBewL1SEqup2qHEbfkqfDaPbvQG/2w==
X-Received: by 2002:adf:e609:: with SMTP id p9mr28494951wrm.397.1576493693287;
        Mon, 16 Dec 2019 02:54:53 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id m3sm21143182wrs.53.2019.12.16.02.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:54:52 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:54:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: madera: Improve handling of regulator unbinding
Message-ID: <20191216105452.GH3601@dell>
References: <20191209113251.18692-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209113251.18692-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Dec 2019, Charles Keepax wrote:

> The current unbinding process for Madera has some issues. The trouble
> is runtime PM is disabled as the first step of the process, but
> some of the drivers release IRQs causing regmap IRQ to issue a
> runtime get which fails. To allow runtime PM to remain enabled during
> mfd_remove_devices, the DCVDD regulator must remain available. In
> the case of external DCVDD's this is simple, the regulator can simply
> be disabled/put after the call to mfd_remove_devices. However, in
> the case of an internally supplied DCVDD the regulator needs to be
> released after all the MFD children, except for the regulator child
> itself, have been removed. This is achieved by having the regulator
> driver itself do the disable/put, as it is the last driver removed from
> the MFD.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

I'm okay with it if Mark is:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
