Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C4C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3E02073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpxmVt7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLIIpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:45:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45366 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLIIpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:45:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so15126174wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lS5EB4HEGJnoEZM0Q8QP8ZUTGrcRpoG/kU7pZTufxIg=;
        b=UpxmVt7VPR2MB6pBbSi46J2EBiVs1sP6jU91/qUTYeuXu3Bsu1DIjK7rZkgIvAV6kB
         +1s2N30klDwVHcmRDEQ/5Href8kpgmXc/XQ1XbUhRYQVzjBbUE2ks4b6WmgVf4FDAtjG
         7tXtsjxS14res9hn0BSaVn98bi3ahvOdX0Rxo43Xwmtldi3R776mJ3+ErHFoJfPjGyTJ
         Um/1uaTmJ/gwAqoiPIS+4BPcKcLtRz6fM4dRgu+ruMVWMrdu6vKWfGniNxHGpqwqlbm4
         qmD15cb2TxAfohXqIXb2feBk4gWxecf63rYZ0b9JMOij0GB1IrsjQCKRih+l24qMCpmf
         e6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lS5EB4HEGJnoEZM0Q8QP8ZUTGrcRpoG/kU7pZTufxIg=;
        b=ptmZJM5QbdZQs7PxSOExAMWqWCpJnq93Dd+Bkl7pRk5+1d0qMq9H47/Fvfwc7N1PUW
         269z6a7Gk9mFITZTDcQUAzunbH8muONo3K3osgt43ZNbioFOdBaOOnAf+Qqku1Z5muua
         nnAgdcTJeWseJyULA3VaC8J4FdHn/GjWinz5EDdSd7NGSLmEX0wK+2AwEIPCQrBaJqAm
         nT9KQAo8CrSMJk9za5UbcI4JFIa0mTn/Xaw9LlTeUCM5PMGF6dz20n0Lv62capn/SxOt
         ZVSbgGtfPLK+8MbtaO7IG+QHARRUM8Q5hPtHGQKfCeUedyBOjvh+I72eAPnhKW/h08JN
         Rx9A==
X-Gm-Message-State: APjAAAV+JPSlKSbd8+phDsisXpIY/Fx0l92ggLyyB0DQ3flbFjrM20Dv
        KIoIuXhD6TLckEpD4jGzBkoRHJyNQrs=
X-Google-Smtp-Source: APXvYqxl33oDgk3salqy27f1o+8IrOJyS1R9Y8p3tmAqcGvmLPGddpOLInBa8KAQmgqcIb8Oy5rDZg==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr681908wrx.87.1575881113378;
        Mon, 09 Dec 2019 00:45:13 -0800 (PST)
Received: from dell ([2.27.35.145])
        by smtp.gmail.com with ESMTPSA id t12sm26721021wrs.96.2019.12.09.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:45:12 -0800 (PST)
Date:   Mon, 9 Dec 2019 08:45:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mfd: syscon: Re-use resource_size() to count
 max_register
Message-ID: <20191209084507.GF3468@dell>
References: <20191115084931.77161-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191115084931.77161-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019, Andy Shevchenko wrote:

> Instead of open coded variant use resource_size() and replace
> weird '- 3' to more understandable '- 4'.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
