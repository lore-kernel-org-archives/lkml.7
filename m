Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B28C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2F022BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2hgN96N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfGYKvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:51:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38896 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfGYKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:51:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so50265698wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aFZmX9sNgpkpsOgJa93uhuROSagbLyOEgd3pn80ckbM=;
        b=P2hgN96Nz+x7siCD6pHNjp+/b6oSwNyXTJfpDUNuhQ7kkvEOItehsO+gm9XjSFAYMS
         SSku6PLqJyIrtdF/lPMnxI0A8eazV9qRS8UfwDObiz1gVElYeSNV4Bk2hfaZ/gjSs2+g
         kIt3woG1hJ44Cc0dffmzBfwvCLfCRzZYoV/zxuZ3RE4S4Vq32ugoFPwez5H+PitNrRrF
         +DbNQEXccVSQ/Efy7b5bJe0nW1/Pk8Sfz2UQgrsgecDc3Ue5LKC9AfyimV4Q5r4flQWd
         UXKc7pdwfEcguD9BBxL5xn9DzJ1lOroUT96P3kjxZHGjRHnA96NDYFhZlJv10Bb9uCUq
         oVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aFZmX9sNgpkpsOgJa93uhuROSagbLyOEgd3pn80ckbM=;
        b=HqWv2GgDA+OJd63hnk5o94VgQqa7MiHJjRKW5QnheAFEOA6BzYtg7dVovV27gUayMb
         5FqYrA4uVMcLiONxEWvhBM5TuFK+atmvay2jGD/qlY/ukz7wUo3Bj67BLctThOS+sD1O
         2S28jlgcbMLNyrJGVtgPh1yp5+1iDamCn459JA4Gw/Kq6q5XXM8y6h+Jxdfg4y0lx8Nt
         Q7AD/8FOPVNSonjTSbC+jVnaCBUaVjdeRmujcrEHuGCxfNO9G/U0qoiZtJ3StwvBej60
         xhNRc4JCL1jsqfqQXbhuz7G9Ub5IHsrW6wAqxBcfwbq6uEriR5HxFfnnvLDOaQNEEn2x
         icSg==
X-Gm-Message-State: APjAAAU2WuJRWvEI81beCir5URqJ+AIN30PvT5dcpcD8FULnwO0TRkSE
        W9yWIxTOVGGkf19qryLKXA4CvQ==
X-Google-Smtp-Source: APXvYqw2Th0YoM1U1HmCt0CXrb7KEvK5m/AFvQZ68lol1gQyYFZSUG4hb8qmZx94AaP7f7bj+hGRGg==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr43823285wrm.230.1564051874593;
        Thu, 25 Jul 2019 03:51:14 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id 2sm64378105wrn.29.2019.07.25.03.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 03:51:14 -0700 (PDT)
Date:   Thu, 25 Jul 2019 11:51:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCH v2 23/28] drivers: Introduce
 driver_find_device_by_of_node() helper
Message-ID: <20190725105103.GB6164@dell>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-24-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560534863-15115-24-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019, Suzuki K Poulose wrote:

> Add a wrapper to driver_find_device() to search for a device
> by the of_node pointer, reusing the generic match function.
> Also convert the existing users to make use of the new helper.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/amba/tegra-ahb.c    | 11 +----------
>  drivers/mfd/altera-sysmgr.c | 14 ++------------
>  include/linux/device.h      | 13 +++++++++++++
>  3 files changed, 16 insertions(+), 22 deletions(-)

Looks good to me.  For the MFD part.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

What is the merge plan?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
