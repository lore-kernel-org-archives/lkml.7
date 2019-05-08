Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE53C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E89216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao4+iwy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfEHIOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:14:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45115 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfEHIOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:14:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so25899148wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OH9b6t/TLuK76vMzLD4yfDH5o9LjeesvXcNNKPZiqKk=;
        b=ao4+iwy4VzPLtRRS6ee77KoYNqBsLHgi6KKY8sD5npu00BOBI+kynmQsoxUpkfFrxv
         h2XHezcIWPR5pt/kUJveXbCXbpivZkwPSJJQzXkGcMCG1VGjUyq6cnFzDR8MkwvZoPvK
         ZMcCgVQ+iiCJJgp9wfHHkKukl7A650GVP5d2Fh/Z0Ch+I2m/dBXNQ25fL8I+LBvjeISL
         ZmUFNAjANxHSWfv+UoT59ms2O6YiDdWBoszqQ2B+JMxUvMHkMd7fkY/LG7oWlprVRrC+
         nyfMfY04iKEOjBtE6kMwQeYSe8wfSqmHXT/uT6muzPXGjYIaTJ0bbDoHoXUSeQ+2AQVm
         qbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OH9b6t/TLuK76vMzLD4yfDH5o9LjeesvXcNNKPZiqKk=;
        b=E53jDqghU8GHO1JTDAapupskx+0xtBiu0qenas29OcyXGvREmr60L+ba2RHGrcSXxU
         gTVbDk0pYZaCqLKHqvVXfporEt5cjlhZYO0Gt4WBCzsxQ61bq9QxImB3stYzC9IVlgcd
         9HMpA5MTwdn02UcIAFryBlewvQrfPKkw4abYZ9hj89Lxn2lrgahqi7E2hdCYDh/BB9Cs
         4uGScs3ZzG4o/QDA0wQ495UEWN5uZbbmpR/vaavdVbS2rN1+ixfvJPjxC3bQdGnSM16T
         AoiLpTjiDCa/GWmYbTooQ7hTxMsLAi2wQMkuK1SOLbhy8270CsY2xfh+l9ptG4HRgU7N
         v01Q==
X-Gm-Message-State: APjAAAWYChgIutfrn1xZW7vdpqcYHoeQDfAFFgQKoteEhuCpZ++KcUou
        hyKmTEnF+vmHuo64T8tEl6XyJw==
X-Google-Smtp-Source: APXvYqxBOq5bL9FNh9DehHTdY/dfxx2xPaMdYA4VLzGSePUeGEOBnnK/l7PJwME7xGUzN6xzTkfXTA==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr12680185wrj.212.1557303280611;
        Wed, 08 May 2019 01:14:40 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id d6sm12411899wrp.9.2019.05.08.01.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:14:40 -0700 (PDT)
Date:   Wed, 8 May 2019 09:14:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com
Subject: Re: [PATCH v3 0/4] mfd: cros_ec: Instantiate CrOS FP, TP and ISH
 devices
Message-ID: <20190508081438.GC3995@dell>
References: <20190408094141.27858-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408094141.27858-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Apr 2019, Enric Balletbo i Serra wrote:

> Hi Lee,
> 
> The reason I'm sending this patch series is to clarify the build
> dependencies of the following patches:
> 
> [PATCH 1/2] mfd: cros_ec: instantiate properly CrOS FP MCU device
> [PATCH 2/2] mfd: cros_ec: instantiate properly CrOS Touchpad MCU device
> 
> and I also included this patch in the series:
> 
> [v3] mfd: cros_ec: instantiate properly CrOS ISH MCU device
> 
> The first version depends on:
> 
> - mfd: cros: Update EC protocol to match current EC code
>   - https://lore.kernel.org/patchwork/patch/1046363

This patch is yet to be resubmitted (requested 5 weeks ago).

Please resubmit this set once the dependency has been applied.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
