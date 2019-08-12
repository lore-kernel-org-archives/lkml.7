Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF682C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775752087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROBzXKYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfHLHrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:47:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53119 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfHLHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:47:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so11242797wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BQ7IIT2+cZw+C3rJ+/zStn6DoC25TwFqSpopweEwxb8=;
        b=ROBzXKYFj+AppV9wFOtjvC8zTZ55gOCAVqc/IlenY+RkHnJwLX1Ujjee7t4x9o/5zJ
         EqyRFbRaubSTBXH64s9LqQTbxRqYuH8REygwGcrN9xux5ENE33/qzgKNudq/4BVmhbE+
         XDbiW/u8M7/R4GyywhNb4n4ixuVmuF6FjxaPVfMnn0hLO/XRbEno/rYgpun+iov0KT2k
         Dy6ucAV+lyg/rpsLhTN+NxKzNasJx8gAOpnAeAxhND6gcdDSlSr2Tw44JitfCShpPBWI
         poQq7boXHuZ+yl0oBdPs01bF4GTDb6iIx0PvKmaXEjKZs03k1aOXMgC0pvvUOpF6TOqT
         rAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BQ7IIT2+cZw+C3rJ+/zStn6DoC25TwFqSpopweEwxb8=;
        b=mouVD4QX/+J+q9qbvv5UbWBfdAoVibk/yFnA28kseqw/a7u4tw6fAczmmI+AW8IWUb
         BpvUw3EQMRQtK5PgFCAQdVeD/gbRX/Ia7o0AgFrtROD7AXQ8dnEu+QJZHbPYexI5nqxj
         PlPRs8Sn7p36VuGWwKqf+mcaQRH1FXxGeYasHMOzZH/CDwbGbddTkPvbXfNeRhwVhydC
         /ywOHw04mjv2oFa9d+6DwHm0I93fai2i3PslmrCDthoygMl5/D+375S16LgM754t+Ni8
         geaE9Hg2Df6TwWBe2pB6yg97ULnavw0xD9PdqoUpJrzuYu/bByeQRdmh2FD9v0jZJqUE
         5VbA==
X-Gm-Message-State: APjAAAWyXNfYAYCmbxByYbEbV5kVUgBoVECro2a1aoM7RknKlQ8Xja27
        N4uR7NQhoLgU/AyVGTQrDW55kSzkdZM=
X-Google-Smtp-Source: APXvYqw6dZ/IlLB/gbIJ0vIoaxGTBFEZkMPxysZQbmdcsbYP6FwmQa9PFVqHXDH/KYDuQtx2Gko/jA==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr27530805wmf.0.1565596056765;
        Mon, 12 Aug 2019 00:47:36 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id 39sm11895188wrc.45.2019.08.12.00.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:47:36 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:47:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/14] mfd: max77843: convert to i2c_new_dummy_device
Message-ID: <20190812074734.GZ4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-9-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-9-wsa+renesas@sang-engineering.com>
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
>  drivers/mfd/max77843.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
