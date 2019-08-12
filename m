Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83052C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511032085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5kHaBH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfHLHj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:39:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52315 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfHLHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:39:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so11223733wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M13tLMxCexcc8Z1uqfW6aAj4BpGJ9ZJbzcQPVQwL51o=;
        b=W5kHaBH5ar5neih6e2V4kFpagCZINwjYVGEKK4Bqxuo9Ch5k8VnxdzthNOQ1kCwJgc
         hfi0Qwyh/0b/ZgitbpGSibu0fJysjhL0nBEZPZHfwukaCuYsGXye9WX1ZIiu6hP09QsK
         HMPX1mC+ibxRs37XnZnsU8NMnNjTW+36c96SQzlUnA+I6EYyhgdvqlBL3SQYJ9h9syWF
         v+51aQzC3gLTR6bW4pYHoT6E9lyy/JVVLRqxwZJrGIplwGTvGfRbxGUDVTYHSxYZ/PC1
         2vC6FbftV21+EwXRn30E0nmGX0qQIJVTLptRbvzNt+tM+KSuFAAf08ThidsG6yd/s1tL
         oSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M13tLMxCexcc8Z1uqfW6aAj4BpGJ9ZJbzcQPVQwL51o=;
        b=Vk6ffKCnpF8G+k+E3JGUFYlfoTRv3DYBmqnZtQYdU4DoiUWwmhDcgD9LhYs7r5F5hT
         Hha7D0ueysGpVHRt6CE1/wugdxNp/N6i/JC0ou5EaWwbFV4gLh6bvi2U2NzFAPsVRem9
         QZEPzZDRVogdYjhCy6WY87IfAAt4x5BP/5Wp4M4q3HHMrkDqkD8u5ncJk+K1Xrvusm+T
         ayhf8skmfAzql+p1UcF2fEHNTvRiQQy+THtghg8mmT8oK2+ohvpJTFrZYhIQYxs87BFf
         zUTr8rQnCccWpauZqCHE0eK4HFawwvK+fxNax6wSoVH3fWquYnLS3KiXlt+utzMKmfzg
         RQPQ==
X-Gm-Message-State: APjAAAUP9W5yrNAjlEfLT7K16DyCeJfFD2ELO+A0LQfwgRzmSXtlDny3
        IMSkDcJX3WBTnPppfIzOvimWQw==
X-Google-Smtp-Source: APXvYqyGqn5ITtulwW9kTlid+OHGP9VuUkCGhXl/QBcHYrK9vTHNB4YheHPMWezSiIlzH2x6xBegVQ==
X-Received: by 2002:a1c:c1cd:: with SMTP id r196mr12621147wmf.127.1565595566948;
        Mon, 12 Aug 2019 00:39:26 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id c12sm3076016wrx.46.2019.08.12.00.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:39:26 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:39:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH] mfd: da9063: remove now unused platform_data
Message-ID: <20190812073925.GQ4594@dell>
References: <20190722182628.7533-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722182628.7533-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> All preparational patches have been applied, we can now remove the
> include file for platform_data. Yiha!

Hiya,

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/Kbuild                   |  1 -
>  include/linux/mfd/da9063/pdata.h | 60 --------------------------------
>  2 files changed, 61 deletions(-)
>  delete mode 100644 include/linux/mfd/da9063/pdata.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
