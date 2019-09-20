Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65701C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3542820882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6nzOE9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405805AbfITKOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:14:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393371AbfITKOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:14:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so6176216wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ZARvlMGzUOLlDd3Qz++HvoWRZDtFBjq+Ck4U0kIZJ0=;
        b=W6nzOE9+ubRnrXYaddn4a21F2+zaZqCfW5jYKljj9XjJqQ9t+UHwh8ByKvVJeZxs5T
         fNr6h9fu1qTNCNjta8Tngtiah1PSd0me8UgBwWXGumP+jzpGVEOQpqPhj9CAHNXJK+qn
         7KxxqKGRYpmRQ3h4qyXCfzUQqGIW73rHtkObqsExqBGkjXiD2JXOALqcc/ijZdPdBNa5
         mxzZ7u4kFImnnhqGHksmDkJxGROJvZoq2mtAx08mC2DufbIbzt0vcRYodcdpV/tU4iBL
         tjLELQ+Av7uCHUQLoUEKytOxo2cjZfLqKTf7grg7HYe+CmvC9NOxOmKh4bs3A2g1SBlT
         OO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ZARvlMGzUOLlDd3Qz++HvoWRZDtFBjq+Ck4U0kIZJ0=;
        b=RaNxb3WrgRFwrcOho9f+ERqi62h5ejgRzw5EB6ngm/HvlF37POUJR4mEO6e/cgWw3a
         s3c6uuMhXuBrpGYvuxC5QGtgopwNcu35XH/5C+3L3eCcwqzVkI1DGsmHLi2Xes+AYJat
         HXCYoO+erbG4e8Or6x3qpCpJNDu/6t/zMRKeSfPiX+x30EJE3VmUd0ced0/bQDLFRub+
         /9RJUwK7BPex1/+T7ZUv5rCChkfnLtNNIYnl8XnsPJ7P9EFs/GSqWwM2+iwgWcFrbLWA
         G1OjKYaliH3elv3uLcgWRQozezMzABJgT+d+oOtjXoYcvjDMGK0gamz+d+VvllAqFhun
         1uZQ==
X-Gm-Message-State: APjAAAWIvUo/xQWL//YuJKJjRfIi9OXSUPdOyXec0UWSe7oKf0HsG1TZ
        36Y8nyBBF99ccVN1bdFY4iRFng==
X-Google-Smtp-Source: APXvYqyKLOgmfl8hv9NLxhkcUW8cJq4QiBvFCFxi3sIHPyIEplkcQ/E1SKt7/3vCOBdKqIxZ7o8nBQ==
X-Received: by 2002:a5d:4742:: with SMTP id o2mr11160970wrs.253.1568974455339;
        Fri, 20 Sep 2019 03:14:15 -0700 (PDT)
Received: from holly.lan (82-132-212-65.dab.02.net. [82.132.212.65])
        by smtp.gmail.com with ESMTPSA id z9sm2200313wrp.26.2019.09.20.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 03:14:14 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:14:05 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] backlight: pwm_bl: fix cie1913 comments and constant
Message-ID: <20190920101405.yuu4bymublj45kd4@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus

Has something gone wrong with the mail out for this patch set. I didn't
get a covering letter or patch 5/5?


Daniel.
