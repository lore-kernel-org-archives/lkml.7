Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57CCC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD5221019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWvJMfVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEHHKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:10:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50839 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfEHHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:10:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id p21so1802297wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b7lc8MdkCqyR2PsiTxcZvlpTg1WA4A/43JRqN8UJdR8=;
        b=ZWvJMfVQgx0dnDMtn7xAHVlSAYjSe+t9RBXxC+OECxkFhg2aiQ0ZtQcT3xyNrOw142
         btC4TPoMtNFVyeoPwvOrla2kHmSVHzXSV7e3C0+0ExNTwjsa+qHSKxe2ZT3aZIGkB/ev
         6Dte5xpI+cJnxXajqlXrwfCJpCsk07nHGC1HzR7easCoKgHFBe65gBo0p+rD27Bzl1R+
         NWSh0zyTFF358mbyyKmSogIu1uO82kbKkI1/NUmQNlH3ZqWQ3NOe1tLWgzWHpS5h29Wc
         KNTfBVoCxZfhEKiIIU7IwZcgGdXgYx7z9q/b/T3D7ES9Lh+H1IT871agPnxNaNSshh7f
         XFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b7lc8MdkCqyR2PsiTxcZvlpTg1WA4A/43JRqN8UJdR8=;
        b=KPEN+/YVVhTTPJI8N80Mv2TaKH6hkFvf4QSsaYicOnGoBezz3mT7kprvLL0eVSxauU
         dWLTKq4iKQm0AubZEIohdKiJHK5K0rzHYc8AB8n8RLkjaLePegV4R/kgb6D8UWgkspKM
         2ih6ZqTIYAoKJBUC2OEkclplXwrhzQX/jqitxTgewwyk5h/sYESVUNxRIXySu3F/TP/w
         CPk3Oog8QsbzuZt77P7BAWokVZzuFQLnn0pFEXh1Sv5VPUUOVpS5PpSM478lljY546ZO
         W2SL9ZblLYSmB7areP3k1nBtr7BppEnamZGecua0aesjNNsQQfwx6WZgkXuMwpaBw4zX
         AcFA==
X-Gm-Message-State: APjAAAUO0CBmxjhOCGlANO2xZTASYUlDd++SsBQlcRDWb3FV3VRVt1a6
        61GRaezj046OF/E2AcNttbQ/UQ==
X-Google-Smtp-Source: APXvYqyduTqdi1PRP26+SPgAie/nOrz5wXCP7i1wRKKHY0x+Nwk6PkkXda46rX0NIxUGcDBBBAPKUA==
X-Received: by 2002:a1c:2104:: with SMTP id h4mr1725641wmh.146.1557299413205;
        Wed, 08 May 2019 00:10:13 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id o4sm1330264wmo.20.2019.05.08.00.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 00:10:12 -0700 (PDT)
Date:   Wed, 8 May 2019 08:10:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 2/2] platform/chrome: Add support for v1 of host sleep
 event
Message-ID: <20190508071010.GH7627@dell>
References: <20190403213428.89920-1-evgreen@chromium.org>
 <20190403213428.89920-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403213428.89920-3-evgreen@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Evan Green wrote:

> Add support in code for the new forms of the host sleep event.
> Detects the presence of this version of the command at runtime,
> and use whichever form the EC supports. At this time, always
> request the default timeout, and only report the failing response
> via a WARN_ONCE(). Future versions could accept the sleep parameter
> from outside the driver, and return the response information to
> usermode or elsewhere.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> 
> Changes in v3:
> - Consolidated boolean logic for host_sleep_v1 (Guenter)
> 
> Changes in v2:
> - Removed unnecessary version assignment (Guenter)
> - Changed WARN to WARN_ONCE (Guenter)
> - Fixed C code to use anonymous unions
> - insize is only bigger for resume events.
> 
>  drivers/mfd/cros_ec.c                   | 39 +++++++++++++++++++++----
>  drivers/platform/chrome/cros_ec_proto.c |  6 ++++
>  include/linux/mfd/cros_ec.h             |  2 ++
>  3 files changed, 42 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
