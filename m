Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0351C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 04:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998AF2086D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 04:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqjA+u5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF3EIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 00:08:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46776 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfF3EIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 00:08:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so4876691pfy.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 21:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e0I5Wbh2bYaS07xL/I5DH0yq5CBaIl3bDJRvSpz3Cxw=;
        b=xqjA+u5Ad+vYKVP92a2BTpYUrFDekp/y9vVawsHEjKO7Fg/cSWp1lmsDpDMvwGVdoZ
         jEeR5kHt6l8rIa0BkmkyGwfIKCqldBKhSBfuGhL350FprtHOurblD5rzXm37Qck3Sk8V
         Wr6vunL4r9CLygaJMBdavGShvFfFhFmNjKFp1GYQoIYJyl3r/drB2GnTWcKHZPchmUZq
         +6CPynCiTMXQU0yldwM+CljanzIZFTyD9Ghcs7KT8BMj/w5TPFOOFX0c9s6WNnRLO9lw
         fzlM8mvdgWjRNcNB/aH7BKa2yDw6J7vMg98azPuC6dmAifTgiiVZfDwr0nN2Fc2cRxtW
         smWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0I5Wbh2bYaS07xL/I5DH0yq5CBaIl3bDJRvSpz3Cxw=;
        b=pew6awfWaHcg91SMVc25Vt64n90r2aRBUJentZLw2jjXhVI7Z4QsnzvDUQCJcJiym5
         2hTH2V3xF79E65NiRGbTsoyo22MPalighjirj8rolnvYItTHge/c2TrJaSWdmxW1O4WA
         1oE+dzeSaN/EOhozC7Tq8NpAcs6ZyZ6xBurte/+4ElRQ3OXd2pxTlCphzSdYefC7xRHE
         1oWSZqaF7vDLZc8QCPJYY/B80S2uOx86gDqLpBXJDucmgCVrdoOOd6P4gmV1gdHJW7gs
         WW41UIRwW6Fz031/g2LUvdSu0v1gGOxn1zxaljflZU9iv4PhiV7mOMbn6FnpsZx1wyc/
         RvhA==
X-Gm-Message-State: APjAAAWJ6MOMXmkKIhiWXybaJgYaoXoxR/msnWqofuKLmhn7U/ajQ2eL
        1CJJ5MxREEMEGMPzMBJjryNhpA==
X-Google-Smtp-Source: APXvYqwD9XJaDKXnwWfO9ySpWpXXJiDmPxZa092n3DTTRMCGd5MlYCVT4ZXl4LKaiWHUyZ+RcuIYSQ==
X-Received: by 2002:a63:1f47:: with SMTP id q7mr17628956pgm.264.1561867711398;
        Sat, 29 Jun 2019 21:08:31 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z11sm5832982pjn.2.2019.06.29.21.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Jun 2019 21:08:30 -0700 (PDT)
Date:   Sat, 29 Jun 2019 21:08:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH 0/2] hwspinlock: add the 'in_atomic' API
Message-ID: <20190630040828.GB1263@builder>
References: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Mar 07:58 PST 2019, Fabien Dessenne wrote:

> In its current implementation, the hwspinlock framework relies on jiffies
> to handle the timeout of the hwspin_lock_timeout_xxx() API.
> In an atomic context (or more precisely when irq are disabled) jiffies does not
> increase, which prevents the timeout to reach its target value (infinite loop).
> 
> Note that there is already an hwspinlock user that runs in atomic context
> (drivers/irqchip/irq-stm32-exti.c) and that has to handle by itself the
> timeout.
> 
> The first patch of the series completes the Documentation (the 'raw' API
> is not documented), and the second patch provides with the 'in_atomic' API.
> 

Applied

Thanks,
Bjorn

> Fabien Dessenne (2):
>   hwspinlock: document the hwspinlock 'raw' API
>   hwspinlock: add the 'in_atomic' API
> 
>  Documentation/hwspinlock.txt         | 81 ++++++++++++++++++++++++++++++++++++
>  drivers/hwspinlock/hwspinlock_core.c | 43 +++++++++++++------
>  include/linux/hwspinlock.h           | 61 +++++++++++++++++++++++++--
>  3 files changed, 169 insertions(+), 16 deletions(-)
> 
> -- 
> 2.7.4
> 
