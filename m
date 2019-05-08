Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9415A214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxblosv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfEHHKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:10:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39487 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfEHHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:10:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so1762659wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fGuAYgw5EIXhHcZe4wZO7BCOH5ehGx59NX/kTz3Mzg4=;
        b=vxblosv9H/aGlrk4vcuDokn0HyXXH4dyVKTZwU7VFFKTuc3QQbQeuPi6PhHmWXStYH
         vf/RDu/V21NnuGswDhvwpcC8+gG8o8FquTCI8kz32GbrGhs0tbzYU8oQLuzFpN/Sp82k
         zum7qvsx0VxQIMty1P+rvflIt1GHjx3bxNrtWrrJk14YehgQKbuS/9lcCF53QCuJs5bu
         E5Lm9+Gio1zsGYDW7suw8WTnVu7Zh1ctO0wrUyHKohKmglGNWYgOjLkyYLbc5H+Ix//H
         oR0XfBtQy6lPBLnf5nP2Ze0ahXA4P3hn7ABRjzpB8H14DkeqD20YZhewsI7pWXaiNCwA
         hEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fGuAYgw5EIXhHcZe4wZO7BCOH5ehGx59NX/kTz3Mzg4=;
        b=o1bvUdfZQltriSxlJPJLD9S7mSjp0E97fro4LoABOetKTZ3u2A0fxOAhJuqqiCOCLC
         kBBZg2OkpMGRNYF8mt7JJCuoZDg52NMc5J6inXGiZ80rTLbw2NtT0NnETQt9QHfMnu/O
         zCn4Brj5J7RC2su8sm8Gb9V0xNrtkD4UbUWPqK0/JT1pVMqo6jXVb/ip8gbpuundxAR7
         naCvc7BlAghdXlELxJS9coj/MCs47Fjp6nvCLuVejUvDL2knXJLHDTmRKy4bdqMV+/VQ
         W2hjphD4DN+6qFC4i30d9Pw9oRmMA9ZkAyObw2f6DTJSWEvQi3oIIzUuRbAtT27mAgFX
         orrQ==
X-Gm-Message-State: APjAAAW68tBjhq5AVE3+LfkDnT9jG8chF2ibcZFpkOKua/kmSpA6sSyx
        B8y+8m61kL+FVgVhYFvM46eTuA==
X-Google-Smtp-Source: APXvYqxPLdM3f/kTKxoVlqUZDFR1kdq3D0/akXTslI/7UWvyMQ0wjP8c35kJTxztmLoJlFFbbEEYBA==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr1695345wmz.100.1557299423324;
        Wed, 08 May 2019 00:10:23 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id c2sm13872530wrr.13.2019.05.08.00.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 00:10:22 -0700 (PDT)
Date:   Wed, 8 May 2019 08:10:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
Message-ID: <20190508071021.GI7627@dell>
References: <20190403213428.89920-1-evgreen@chromium.org>
 <20190403213428.89920-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403213428.89920-2-evgreen@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Evan Green wrote:

> Introduce the command and response structures for the second revision
> of the host sleep event. These structures are part of a new EC change
> that enables detection of failure to enter S0ix. The EC waits a
> kernel-specified timeout (or a default amount of time) for the S0_SLP
> pin to change, and wakes the system if that change does not occur in
> time.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Made unions anonymous
> - Replaced reserved union members with a comment
> 
>  include/linux/mfd/cros_ec_commands.h | 57 ++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
