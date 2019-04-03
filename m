Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E814CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A3E20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skKq/Zky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDCD1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:27:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39352 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDCD1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:27:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so7416173pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VIlPlQcAI/mK/i/+J8oLfRXIynUQ/gIlKCFkuKPblzA=;
        b=skKq/ZkyEMa2vCaZ3pWT0sbi69OEy4HM3B3Q7C5d6k8AsaTq+NMYiB4Qjdx+uzbUKA
         FIUoq47UFK8WQ2c6f5I8NNqUajgl2bDBi6c3K8rQN6VShGoVAGCNQAdQnVdOnKf483kS
         VVuXExtuGjq116QkBj8+wqcczrDj5lqzGTKghy356mp2701L5JxNFMR6w3o61PEnKaKe
         CS1JmcpgFm3fmTi8JAFrI8FqodgNtF/FD6sKooDBxIEz2OrKJg7NBd36Pe3oIpsSmPXR
         TzLTE3PP00vJMseW2vpQhh3h0tWSqnDfGUJfwbg9U/rWdRqo5AOrnYlOMFHHD1bl7ijA
         JuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VIlPlQcAI/mK/i/+J8oLfRXIynUQ/gIlKCFkuKPblzA=;
        b=eSwrIu4AVIEDFju9CjMvwyXe8ylAm5DKHv/JJnsFDlTYiHBkUahBijZ9bQPOs7QyTB
         b1acQNlH4WgsjyKB8e/fyjptj+FT3XfPFpCxeIrj/Y2EIPv53OwEgmYHW9QURrZVTAd7
         pbx8Dnh+WyMrILZSXFwBm3T6JsXakGg2uXxvcpDQdnayyc/flQdo/VZHyvJpK4wMehAn
         jRMXY8YUq0bK3XY3Grgns8Cmnns/+dol6SYBO+17gQ46iaPxfyYhAgpLmsdTnStfWFgF
         2OTJ3Er/JoIU7RmChs+1lTZ3SHbLFRg9Zv80bzLT9NVK0lu+DqWzf2YuiyEt7/9jqmU1
         0LKA==
X-Gm-Message-State: APjAAAXeuTaN1dOrK32IKcB8q4kW78X4keH+/WrEyldvG7sJMh+5cD+U
        KU+hwV+FYPBelvc/QFbMQzu2Ew==
X-Google-Smtp-Source: APXvYqyTwy98LR/6YVmwm+evtLbSz2wXwI6/JqbkKnUdiozGqfZZThBJdGK2ZUme4qHtfls7artdvQ==
X-Received: by 2002:a63:be02:: with SMTP id l2mr47943360pgf.48.1554262070580;
        Tue, 02 Apr 2019 20:27:50 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id e123sm22911464pgc.14.2019.04.02.20.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 20:27:49 -0700 (PDT)
Date:   Wed, 3 Apr 2019 04:27:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH 2/2] mfd: cros_ec: instantiate properly CrOS Touchpad MCU
 device
Message-ID: <20190403032745.GI4187@dell>
References: <20190307175253.14785-1-enric.balletbo@collabora.com>
 <20190307175253.14785-3-enric.balletbo@collabora.com>
 <20190402040153.GL4187@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190402040153.GL4187@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Apr 2019, Lee Jones wrote:

> On Thu, 07 Mar 2019, Enric Balletbo i Serra wrote:
> 
> > From: Wei-Ning Huang <wnhuang@google.com>
> > 
> > Support Touchpad MCU as a special of CrOS EC devices. The current
> > Touchpad MCU is used on Eve Chromebook and used the same protocol as
> > other CrOS EC devices.
> > 
> > When a MCU has touchpad support (aka EC_FEATURE_TOUCHPAD), it is
> > instantiated as a special CrOS EC device with device name 'cros_tp'. So
> > regardless of the probing order between the actual cros_ec and cros_tp,
> > the userspace and other kernel drivers should not confuse them.
> > 
> > Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > 
> >  drivers/mfd/cros_ec_dev.c   | 10 ++++++++++
> >  include/linux/mfd/cros_ec.h |  1 +
> >  2 files changed, 11 insertions(+)
> 
> Applied, thanks.

Looks like this depends on:
  
  mfd: cros: Update EC protocol to match current EC code
  
Removing until it's applied.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
