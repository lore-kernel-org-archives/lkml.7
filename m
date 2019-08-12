Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CEE208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWCwWP0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfHLHqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:46:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37099 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfHLHqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:46:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so10882468wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lrPgrszRi4y8yAbGcnuUhC0Hrlx2Ru6O0e/W/S4/MlY=;
        b=WWCwWP0grDhwslIWs2KnZ305qgob3XPk9M3sgO2mmvsSMESNX50WyFFIdfCAavlUMH
         QUXwu5xTll63Dhi5gzDBOqnz2fKZ09uhbBM7PsFpyJJv4udGfsPDLiAi6kFA9etRHhU2
         oYFJXthPuh/7zEEai/vSsN/irH81rGOPt3VYhJO9hXUYvXcp2Wp/EIHL1O+59l6QCn3T
         WhCj40TFuobw00GGjhf6KEfuSneGeGlnP0txRQmSCTssXJgruxNcZXFbfM5P2lGJIXRV
         wI81cpRxIVSOFODIOKxzA1QgzrRkCD8vayvaHQ8v49PdIfHzBfaKAGRNACqneqeAzMfp
         DenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lrPgrszRi4y8yAbGcnuUhC0Hrlx2Ru6O0e/W/S4/MlY=;
        b=V1HPevLXEcpqJHNF+4Zzx3CGqxm81Gvt4Hj2m9eeZsziSTcXrD41N+ydQZowxdF8Q0
         F+p2yMOLsJjPmWdtu9c+lZRRDldqgDj+vKVToAP9LCwFbJavlWwNIUdrlsFJHDAwI3vL
         BO59ELJ30T8lWK4zz5gV7FhhxtkPpza7pvbx7O4nzk+ucuzko0Dw/nwQryPyQtLgbuYA
         /2qpz/xeoMJJx4ANojKDaISrcdIcjlwojhcyWA3cRqWd1VmP6VUVwpAuZ0CItKx67Hmu
         uozmunyZamte+LRknJ742es9FqX4N5RmUSI3Ufiz4R7iuJqqOAKKXNI4oI9T9R/lJrop
         /o0g==
X-Gm-Message-State: APjAAAWLDRDchJB/M/fnmUQbp+SZECHXOiAkOut9MVrXT3+TJUzhknmB
        0wiXfm63WCL1soWqaiQpkt0O6B80e5E=
X-Google-Smtp-Source: APXvYqxiQGXbmZVhHNJQeBSroRneZRbmavKdwsrCkohTxJN0/4x1INuaopF398ew3A/xpu/Mmh8IkQ==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr26130638wme.29.1565596007143;
        Mon, 12 Aug 2019 00:46:47 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id f17sm18136349wmf.27.2019.08.12.00.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:46:46 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:46:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] mfd: 88pm860x-core: convert to i2c_new_dummy_device
Message-ID: <20190812074645.GT4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-3-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/88pm860x-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
