Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A198C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50FC206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rglDr0Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfLPKkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:40:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54283 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfLPKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:40:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so6156174wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0cOoGQDuF/leHeXuVHIG0bZx/FGWnrkDzH4GLJ+Xmks=;
        b=rglDr0ZgAqwDbidXmZemfp0sTHE+rLRQktXE++mmU05D/hZEV0n33gZOLBn2P+d3j3
         7w9JqaceUfQSm9s8EUkB3V0qugmYa9VR4CXzjdsCeoiV7Qmvr2Ghxk3Gjmwd3V9pALst
         3PTk7GKBvlmZMfUNbNxkWkjXPbPwY3k/wNRKB20GIF6ihp5FHIXT1xRgHx0VKENX+De9
         FS3WcQENBYBLdc//BPm+dGEigNSzLLHqC1hddATytoVugn7TfKavSrEis8FpMG9HBTir
         ile9lmEaf3MYPF1rUAk2SwaJcTISDViFsoAMa9eGoSm+Ea/3mY7Il3QGa5de2OvWaV+a
         IH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0cOoGQDuF/leHeXuVHIG0bZx/FGWnrkDzH4GLJ+Xmks=;
        b=YW5kl6LAqfkowshz/E53UXWJsdGtX0VAZ4/coN/Ax68hmFmzJHT0M8H03p2mWxqnhB
         oDD/2+5ibZme/Lx+pNPh90OkNUNLwLzJ6HdirvPdrCAs7SSiti+XakAkxbXjU7JFIJo/
         m2L382jnkwYiUzFdwa72PVHBS3JzKbMykc0QJUA1JhgsfSH8IaAyskNdVctO81HBRvrM
         1tP0GfkElpuiXLiZY/StnTPTmDBxS3a8Tagi3KSfTGX6PLC1GpV0tp1THk6ZQn9MekC+
         BRLBTq9lcJ0ClciV7WnCQSLPDKKHbrAShhCVJAHIw9KKQfeE6K+7/cXfwklqYokfsmPn
         rCDA==
X-Gm-Message-State: APjAAAVyaAuu3t5HQ1mf2+ej5bOhvjVGorgKO99Nzp8KtJr+wIWnd8vq
        zg1AFjh76L12wv/DObQCIR44Ig==
X-Google-Smtp-Source: APXvYqwEW+frht1CgarnNf3wI38Y+hg/Ob6gWBcEWROUsJKOZnZAYDi9jLdbazMLQArW6shJjosFtA==
X-Received: by 2002:a05:600c:21c5:: with SMTP id x5mr28517225wmj.72.1576492847164;
        Mon, 16 Dec 2019 02:40:47 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id b17sm21288906wrx.15.2019.12.16.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:40:46 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:40:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Yicheng Li <yichengli@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        gwendal@chromium.org, enric.balletbo@collabora.com
Subject: Re: [PATCH v4] mfd / platform: cros_ec: Query EC protocol version if
 EC transitions between RO/RW
Message-ID: <20191216104046.GD3601@dell>
References: <0f223903-ec93-a5ec-e858-fa0e2e282cf3@collabora.com>
 <20191125221517.91611-1-yichengli@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191125221517.91611-1-yichengli@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019, Yicheng Li wrote:

> RO and RW of EC may have different EC protocol version. If EC transitions
> between RO and RW, but AP does not reboot (this is true for fingerprint
> microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> still uses the protocol version queried before transition, which can
> cause problems. In the case of fingerprint microcontroller, this causes
> AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> interrupt handler, which in turn prevents RO to clear the interrupt
> line to AP, in an infinite loop.
> 
> Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> might have been a transition between RO and RW, so re-query the protocol.
> 
> Signed-off-by: Yicheng Li <yichengli@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec.c           | 24 +++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |  3 +++
>  2 files changed, 27 insertions(+)

This is not an MFD patch.  Please drop it from the subject line.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
