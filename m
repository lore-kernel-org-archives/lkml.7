Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A59EC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4419B249EB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEvGKN01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFDF7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:59:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34840 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfFDF7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:59:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so14410705wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Jarh7LeGfPu45XYPSBuK6f+8okfPC3JzoLqM+4fRdvo=;
        b=vEvGKN018/l4/qofPxgpuz03Gx/QPZ/zz9kygVUIfCgek99F0lwpmRVHExCKlQ3Wc8
         SFMZ82lJS4sEdpwDFEkYEFeAEkRBAYWKBigHVRrPsX5hNkxe/Z+cL5HVllIX2hRLN7x/
         onfCCFjyD0vzuSDW2yDGywHRQ6hU1bsqFfxOAJdA89pE9QLoN6kB+XW0S9HH/MOZ6P94
         ZayreXbfY3uKs0H+5AOZrah/BoOGh0b7tTLgcoNauK72WVOe55ngmd/lD1Ob+nlVn9Yp
         5AIVSIkp7ALsPR78CD4jY4mopkwOPatH5GLhWqyJREba3XCq3ODg9diPdBncU/T3yvNK
         VrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jarh7LeGfPu45XYPSBuK6f+8okfPC3JzoLqM+4fRdvo=;
        b=B6q0X3LDWmonlQOheFwvomDXkwyPzkRemvSSPKFnHfl6BQJTV1oVVw9Wi6jsw9stu+
         U7lWfUsgioSBU9YvhbavlRcFC+MR0RwNu7Ti/jLznzuxmYwNu1nkuBgaX4+htYrjYVfe
         8rF/xl/gzxlpt8Zsbl961vsw6TD8KuRvuCqTyHhtWk6D6TbG7sn/4nRr/rKRO7xvHKHC
         hyIBUkHRbwV7Or9kVHHwQpEQ4bbYH2rpTerSV3tZNoUL/PFPteKUvRp4ZZ4OspfRjqbL
         GHem3Ok8jzwHC2Fj2Jk91OyirUqzDHqGRq/D9zPjuwt10Eknke/YZAiJaFaq0pmy5bRK
         S22A==
X-Gm-Message-State: APjAAAXX6CyMk2fuEyHan7edhvbwjbImv63ctFAdO2bQc4qVcwwiuF/x
        502sFcPylfJgygqtSk8kQlZJhw==
X-Google-Smtp-Source: APXvYqyGn3pYiQrB0R9AEkK3CMobRDAxMJXZBRFJcH4t+l072iVHqtfvkX8LRbZpJoFgIKm6vUBIvQ==
X-Received: by 2002:adf:f041:: with SMTP id t1mr18830108wro.74.1559627958374;
        Mon, 03 Jun 2019 22:59:18 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id e6sm9199122wrw.83.2019.06.03.22.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 22:59:17 -0700 (PDT)
Date:   Tue, 4 Jun 2019 06:59:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190604055908.GA4797@dell>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jun 2019, Gwendal Grignou wrote:

> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
> 
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> 
> That include file is converted to remove ACPI and Embedded only code.
> 
> From now on, cros_ec_commands.h will be automatically generated from
> the file above, do not modify directly.
> 
> Fell free to squash the commits below.
> 
> v3 resent: Add Fabien's ack.

Thanks for doing that.

In future, please ensure *-bys tags are in chronological order with
the first one either being a Suggested-by or your SoB.  Reviews, tests
etc usually come *after* first submission.

I've changed this for you this time, yes in all 30 patches!  :)

Anyway, all applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
