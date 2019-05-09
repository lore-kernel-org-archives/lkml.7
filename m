Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58768C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE88216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FS1bTyue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfEIILw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:11:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38853 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfEIILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:11:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id f2so1913359wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PiUStQAc2r5Zg3DaxsjfssB9tqNwXFDkwGZRTJrvo7M=;
        b=FS1bTyueMsG+AWoL4zjmP3ly8X1YXHjIPwUSwi9i5e3sqr19OLbG1cHcz8uxATn9tE
         5JHPKxNcV2PYF9ennPwJ6p4cjb/LnMY7Q8JffJ4Hd6aD5X+vkVc6OwVSQWLJ00Qx1U6Y
         kcfR+C/yM3RIVFZIF4tNw8Xr7vDbPpAeInP1FfFwFrcWnWRn6m2NMNTtX9R1T+2AkoQA
         7Y70IMpliMWr+Mz4n+6nX4rawxHMT+VFdUKmWh8zc5nnOYVT2PPRXXC9f/fLj6ihtA7L
         XtyhEGNOYIUtq7Es+40t+gvmYw0ectKU2fMZMKPWEh2sQHXRxZuh0aIv/Ewrhydpzipf
         R7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PiUStQAc2r5Zg3DaxsjfssB9tqNwXFDkwGZRTJrvo7M=;
        b=IBDM1zO6KuZDZGDdej32TMqIAizQieWqxDwydlZRnvDG9Rh3jA0rTgj+DBHvaUUeb4
         6WRQXJkdjUsAHyRwS0Q36yNq4tSxdbNdXYmHM3iQfaFBeYpzPOMctMFbTBLjwAyS5efJ
         zknRwA+nmHWFQdH2py60rrBxDjwCvU0GBZXwiusTDoOB7Cr7gB3SdUQxUts8ikh9RQp/
         aEQ/g5T9vtC9rFTQ2vogU9PE+ZmWKFPbi9wSbaG9mrMLa2XzjyoQ1tvbS7qgu7GR08lk
         8jdlcku+WnHQrVOJP6/rG+05Uy69epx8Cm7BYovLfArlyrc5C/64m14CJc6IV+wjZJ6k
         e4xw==
X-Gm-Message-State: APjAAAU39r4J/CNj8WgAILYJyLpwYYZ/eYXt2uISTOHy8bRd1AcUElLh
        QlLQfed1fsWrKaqCbUf4RyMw8w==
X-Google-Smtp-Source: APXvYqxKrbJAcRMB6/GRYZW/18lbgLrjQtaJ77NGIOkmbeT0q+RSNQj9FBgMjGSk6o2y2KkTQZs1Rg==
X-Received: by 2002:a1c:f504:: with SMTP id t4mr1744809wmh.121.1557389509907;
        Thu, 09 May 2019 01:11:49 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e16sm1175686wrw.24.2019.05.09.01.11.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 01:11:49 -0700 (PDT)
Message-ID: <5b677f1581565bd8c915a14cd91352ec4bcabdd7.camel@baylibre.com>
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the
 current substream
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Date:   Thu, 09 May 2019 10:11:48 +0200
In-Reply-To: <20190508085758.GE14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
         <20190506095815.24578-3-jbrunet@baylibre.com>
         <20190508070058.GQ14916@sirena.org.uk>
         <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
         <20190508085758.GE14916@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 17:57 +0900, Mark Brown wrote:
> > Another solution would be to use the mutex as the 'busy' flag.
> > Get the ownership of the hdmi using try_lock() in startup() and
> > release it in shutdown()
> 
> > Would you have a preference Mark ? 
> 
> Probably using a mutex for the flag is clearer.  I'd rather keep things
> as simple as absolutely possible to avoid people making mistakes in
> future.

Hi Mark,

I received a notification that you applied this patch.
Just to confirm, you expect a follow up patch to re-introduce the mutex, right ?

Thanks
Jerome

