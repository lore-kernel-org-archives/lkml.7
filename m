Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF991C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A865421900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bswQh2za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfGVXXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:23:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43899 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfGVXXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:23:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so18376136pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SkLiXHjoGqjfEw9X0EGifhhb+KhqQv8+F1IP2BsxfY4=;
        b=bswQh2zaokNmjpMmcJtfAxGTLcPm2xs57WvQHrvl2dvTqk/eF02SJ1mHs7QWhn0fke
         dr7I6tQjr3Vfs5qt4hzMnj6xeCmH6bMThGiGVABRnHE4yf6OQHVH+gvafrTOJQLAFoy+
         I2s+TAqGDPU1/O2wF9PGE02QrzkZR+xvPem/BoaSeDSOx17wBfqxACVvIgoZ/5r44JVr
         ArjqocEAVUyOJGBFvCo30qwEHZsIZsIH7J/UPDOFqnMCOsOHzCxGIbZ9qF91PUEe4id5
         amkhIjwFWrtA2aeLC7h0gxbU4ODm82YazVyb9HHinhsmHjrwj2vzFUxPPRJqQpuUg281
         1+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SkLiXHjoGqjfEw9X0EGifhhb+KhqQv8+F1IP2BsxfY4=;
        b=qBUcQ/Unf+MAq5zDN+Vpg49knx0JNzNwBRgnwT/reLChJG83bL2Qwio4Me2y7VbCKB
         95CCUDjZQ3f8tZeK/tcqpAxVl8pIe3/ROYbrwGPsGD1cQmOF4EnTduLsaeuOTJlj0OM6
         /4KYx5DGEQ+1snlnaT18gAwPfYaep7zRrddBtOW4YpRZ6C2oZ2dSfa33LESR9mmGLalx
         uFhtSTJgPd4S7t0+I8OtMv6i2gFFDSd6xw5DCkT60JRUfenWBYQZfJVidx7Cmaca2kTD
         B+vdWEv0r7KhMjrHUImLIBmnwu6yqz4vls2IIZQr4PXbj0irk4RQKwGuA8AsXkbARqLQ
         XBeg==
X-Gm-Message-State: APjAAAUkjKUQCW+ccqYOY6RwS0YmQWZXuTCa3LP1QhyCxlWCW/4VTE5v
        0ocU35khTN9p31V18/njwUWcx4rTTUA=
X-Google-Smtp-Source: APXvYqxLurlZ+S3BELfmTb9cU6XqzknjzCTO2ipHWJ6uIUQiIvoYlcDJ/CvO5PFtBYIdX4wDFmwltQ==
X-Received: by 2002:a63:4185:: with SMTP id o127mr34695446pga.82.1563837792374;
        Mon, 22 Jul 2019 16:23:12 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r13sm51029776pfr.25.2019.07.22.16.23.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:23:11 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:23:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     agross@kernel.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v5 0/5] soc: qcom: Add SoC info driver
Message-ID: <20190722232309.GS30636@minitux>
References: <20190711213911.23180-1-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711213911.23180-1-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11 Jul 14:39 PDT 2019, Vaishali Thakkar wrote:

> This patchset adds SoC info driver which can provide information
> such as Chip ID, Chip family and serial number about Qualcomm SoCs
> to user space via sysfs. Furthermore, it allows userspace to get
> information about custom attributes and various image version
> information via debugfs.
> 
> The patchset cleanly applies on top of v5.2-rc7.

Hi Vaishali,

There's no context in the patches so they do not apply properly. Please
resubmit them with appropriate context.

Regards,
Bjorn

> 
> Changes since v1:
>         - Align ifdefs to left, remove unnecessary debugfs dir
>           creation check and fix function signatures in patch 3
>         - Fix comment for teh case when serial number is not
>           available in patch 1
> 
> Changes since v2:
>         - Reorder patches [patch five -> patch two]
> 
> Changes since v3:
>         - Add reviewed-bys from Greg
>         - Fix build warning when debugfs is disabled
>         - Remove extra checks for dir creations in patch 5
> 
> Changes since v4:
> 	- Added Reviewed-bys in multiple patches
> 	- Bunch of nitpick fixes in patch 3
> 	- Major refactoring for using core debugfs functions and
> 	  eliminating duplicate code in patch 4 and 5 [detailed info
> 	  can be found under --- in each patch]
> 
> Vaishali Thakkar (5):
>   base: soc: Add serial_number attribute to soc
>   base: soc: Export soc_device_register/unregister APIs
>   soc: qcom: Add socinfo driver
>   soc: qcom: socinfo: Expose custom attributes
>   soc: qcom: socinfo: Expose image information
> 
>  Documentation/ABI/testing/sysfs-devices-soc |   7 +
>  drivers/base/soc.c                          |   9 +
>  drivers/soc/qcom/Kconfig                    |   8 +
>  drivers/soc/qcom/Makefile                   |   1 +
>  drivers/soc/qcom/smem.c                     |   9 +
>  drivers/soc/qcom/socinfo.c                  | 468 ++++++++++++++++++++
>  include/linux/sys_soc.h                     |   1 +
>  7 files changed, 503 insertions(+)
>  create mode 100644 drivers/soc/qcom/socinfo.c
> 
> -- 
> 2.17.1
> 
