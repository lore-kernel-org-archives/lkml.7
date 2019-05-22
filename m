Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C58C16A69
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E2C21019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSudSti3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfEVFx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:53:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34862 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfEVFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:53:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so778684wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5gjsqjo7IX+MYjphdtIkAMMrTXCVUSggkJvGSotJJTQ=;
        b=nSudSti3cbNq95ZgFSRAecS+O+iIU59MPEEHCRSVybrADbuZzF5mtNDtpEcL7L4jDG
         Gf2k3iVfd09ImO2tUauH5r78a1zIQCy/yZhwx4YCUEfytpwf5TrHPC0C5EjZpvU7Tx1e
         GIsjjkObImxGfY4Z/eqY7Z2npXSGGSEfzsM29qYIVx+haNOP9fMk6BoppQE6peAjmKG1
         I6VrmS5zC9uQdJ2C5QV1x+AJ2kqL5JgdkWgHolDkckJRu+IdYvX2atO2zp21hTxH5eQW
         Ik5Fn1RalD1gDMXJYyKQjL823oybPJay4I5m7RyRy2EXVUEb29QDjg0BlcYTTAT7wjEJ
         OByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5gjsqjo7IX+MYjphdtIkAMMrTXCVUSggkJvGSotJJTQ=;
        b=CG+cGfWB05uT06odh7h2t1kw6rfTNLwC0We9ww61xTFO/eFMxP+FptxXd6LtJtDEXU
         UikioC9H+YMU4sd6Iy5nI2BR2ZraCvXMHqtZJdztAqdoALysDQjTZMXiYXCgykOYoLUN
         gNVwPhGABfwYOZFUoKND4Y2BxMdVyQ6SkaU5xcPnd7MoEUKLAqBqpFf1nmoETD7DM2R4
         uqwG6sc4JdC+EI6rXN9vwEHVxfPgqxLUHgLQSIpHYm5vUWZB48T9Sg2bCv2h6erlj4Ah
         Y0ye0zrnKkGRNKcx/5wQiou8jb2svdSy9awh2OjLvhAw1orLVqz2JaxrYVMoDYEiP4bB
         i7fw==
X-Gm-Message-State: APjAAAWfv+T7CAwTcPcxIKRSh2DpPrlHEmyIlvZkuRl6if/f7q5HDZtX
        6V/5zzDtXUx0Oh0i98mB65CwWw==
X-Google-Smtp-Source: APXvYqw0VeHmbRFUaVBdAsWdfo5a4BUlWDZQeqyEOri4Oo8A4cuG+M7gb+hFRspLGJE99Uxe95GC7Q==
X-Received: by 2002:a1c:f111:: with SMTP id p17mr5741383wmh.62.1558504405746;
        Tue, 21 May 2019 22:53:25 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id y4sm3465996wmj.20.2019.05.21.22.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 22:53:25 -0700 (PDT)
Date:   Wed, 22 May 2019 06:53:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190522055323.GD4574@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <2741579da03893d2d4e7ad7f5fc42a506a82f380.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2741579da03893d2d4e7ad7f5fc42a506a82f380.camel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Fabien Lahoudere wrote:

> Le jeudi 09 mai 2019 à 14:13 -0700, Gwendal Grignou a écrit :
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> > 
> > The source of thruth is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> > 
> > That include file is converted to remove ACPI and Embedded only code.
> 
> Hi, 
> 
> I reviewed patches of the series and they looks good to me.
> 
> Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

Thanks Fabien.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
