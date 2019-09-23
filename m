Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EDFC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6A72089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569257158;
	bh=3UTYXbA1y2iJiQv9ednGvEQW3ctThZH1qSxfiADkjlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RqGI00A+EAUFSdMNZSWdFGed6qHcGiK/gDdD7+V8h0EUYcK5algow6C/shEqP73Od
	 s0TzXWEvIvoWEdYMC7KTwwFohwYo+HMajrl5rxf7O6+AdrV1iLNcdcytbFz1RGAEDA
	 9yMpO+XbyW9Nxx1GXliuW50kaITEEk+rgUMbCjKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394285AbfIWQp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:45:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52226 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389238AbfIWQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:45:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id x2so10783262wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZottsNo9dP9sxiK9k2Pisr2Qm5tcc6fwuMDqhOgSTY=;
        b=tMZN3qs6hI36MtxXansvCz/9HtOMK80Big7wr6EXaKZRHQWG4QknhAt351wakmR4tJ
         GPUZbkFxRevtVBanOftItQA+LFY+HuZgYXo97VDX4dvGIeQAjBQ9Vl1iuZJ+JdFhmcy1
         Lurinn0tilmvc+f5Z6JT8scmuRu59DiqjKCYSwAONmbExQassv0X2PLaRpzvWclmuxlw
         3XIx+/n8nh4SPYVYPXPRDd5HL2CbgWu8DPpXc3ZW7oZcU4kRJIYXKyP0ZgCdl53uul1e
         EHUZc4jOqRmX5y+CEvh9zJfKlxEjE96AT/zQhOXSPTzOFlFQ2T3oRFd2u3UpiEpOOd4d
         1fKg==
X-Gm-Message-State: APjAAAXZ8oqs1Ta/CoIL7EYBmOu4IsmMG67hd6izpmcTVsbNgYWHs9Dh
        +UcLgXqpmhDwxmLwtk4CQFc=
X-Google-Smtp-Source: APXvYqz5f2hHpzllsCbosbkpt9BL/y+iKOdw90u+mTixiKOOTkgT7ZkZkVdfwtOVDS2lG85rkzerTw==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr386973wmg.133.1569257154376;
        Mon, 23 Sep 2019 09:45:54 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id g185sm22261538wme.10.2019.09.23.09.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 09:45:53 -0700 (PDT)
Date:   Mon, 23 Sep 2019 18:45:50 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] drm/panfrost: Reduce the amount of logs on
 deferred probe
Message-ID: <20190923164550.GA17765@kozik-lap>
References: <20190909155146.14065-1-krzk@kernel.org>
 <1858ea3d-8f33-66f4-0e71-31bf68443b24@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1858ea3d-8f33-66f4-0e71-31bf68443b24@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 10:36:25AM +0100, Steven Price wrote:
> On 09/09/2019 16:51, Krzysztof Kozlowski wrote:
> > There is no point to print deferred probe (and its failures to get
> > resources) as an error.
> > 
> > In case of multiple probe tries this would pollute the dmesg.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Looks like a good idea, however from what I can tell you haven't
> completely silenced the 'error' as the return from
> panfrost_regulator_init() will be -EPROBE_DEFER causing another
> dev_err() output:
> 
>         err = panfrost_regulator_init(pfdev);
>         if (err) {
>                 dev_err(pfdev->dev, "regulator init failed %d\n", err);
>                 goto err_out0;
>         }
> 
> Can you fix that up as well? Or indeed drop it altogether since
> panfrost_regulator_init() already outputs an appropriate message.

I'll drop this error message then. Thanks for feedback!

Best regards,
Krzysztof

