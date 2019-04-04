Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD6DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1F220882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlqeVYxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfDDIXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:23:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40281 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:23:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so847628pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uwGP6HaIqRJT/WKMsorXRwq7DOvCS/JkRh6JfEfLOYY=;
        b=OlqeVYxPpWduScEK1xrb/lN8SLfLImTA8F1W0P9T4lLsA6/qOrSCLVPhdVtJX+6UEw
         CdfAIFmb68p/6plxzpe06Wl3gkOzj/7y45KXvJCseoEcOMUnqe05LiSYoUx2FUNmlOTw
         iaEXXHMmp5LgxKUxGpqn7M6UjZG4eH5AO5WaB9wWgEVS1eJNhOx/qCivbw1VwYuuLzIO
         NHDg/ybQmfUU0FFjAPhenwWlRipx+HQ1N0Gw92IOBnODP0+0eEGoHyDueBI1io7wySnf
         e6V1i/3pU3RzAIzq5aYfVxMEtdzxA0WS4C3wI/lZ+DSi4LqS6606crJJrwUxw1GgGK0K
         7I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uwGP6HaIqRJT/WKMsorXRwq7DOvCS/JkRh6JfEfLOYY=;
        b=h80DhVEAL/m0uHKIgI4sBuXnMIU/KRZxUzCHesfuVlBbPO1kXV+7TYJ758ZyXXtqh3
         zCSYdQwOotQmVqmvTpgl/lr6PMQmFjUwlPEN0YGqIaFi3r2mfjQK0b8/6ta3Gx9Fo7+Z
         anim0iWgydUkDzvFP+S0Vfd2ndssHUhjTetkOkgyVHdr35udznloIfqss+al8X+qntUY
         X1QvGAVuCHulxKiDCaduiz1zVKkvV/nceJML8Yb4z+wiLQ0/Czzc8l4ro9vqK4/SR7IA
         hi1iKowxADt0zTaJJAGTXSihPbGEDl/NLUuIxWYu7OVRRiufRCmd4hzx2a9iMpo42TOP
         NRLw==
X-Gm-Message-State: APjAAAUoBDNebeK6ToGYYBuhQfkmbMix57cnvLgaiRuxd0UvZz3VFHZX
        V0Zxybt1Uh4d7r2dGc9DjVCiZA==
X-Google-Smtp-Source: APXvYqy+6VJrLmd1m2s7lX5NrTtCNjTTzePpzSGbVsqCQd3Gp+jM2pRX5jEoIQW/JugdemKKYyXh9Q==
X-Received: by 2002:a62:12c8:: with SMTP id 69mr4526915pfs.184.1554366220664;
        Thu, 04 Apr 2019 01:23:40 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id p2sm62557981pfi.73.2019.04.04.01.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:23:39 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:23:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
Message-ID: <20190404082334.GQ6830@dell>
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

Always good to have some additional Chromium reviewers on patches
touching this file.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
