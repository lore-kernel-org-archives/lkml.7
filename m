Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ECDC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266BE2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rvfdm8IA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfLDSN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:13:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38404 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfLDSNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:13:19 -0500
Received: by mail-io1-f66.google.com with SMTP id u7so621046iop.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbjMhMLQ8ZXCsns4nZuVxnFXeq+4FdUf6xW1nrBKHDw=;
        b=Rvfdm8IAQbF27G90nuZjBxEtcEwJxiB+bs/eGLAXjvZ3cwULZ8T/egv/YLoZKttmIj
         o1UWTzyXjGfnAMRtOhBpUqnTaJP57qFcUyVVwmBiTDAs5V6Zhw8PuczWhc03XzKEtNSZ
         8vJVYsZKIQpZn4jXmdJBTjqCcmM6WRAm+LTyZvla3DgF+BexG/WPMWfQNgP9XBWhEGRC
         SR+miCcfuOkXH+qpUZ4L3/+E0wZ2WHflhUTlS7EgoOwhWMSiNhnpwRLi7xOZKojlV4Kw
         2QzONISlvHJdT/DQE+/uFSGIvTNWqGVS/y/1LKJr/wxuCC8AU3AavkB4gcEpPngiZ5Rg
         jBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbjMhMLQ8ZXCsns4nZuVxnFXeq+4FdUf6xW1nrBKHDw=;
        b=cVpEBePu0vUF23DYvWfeOf1HcWpL7Lk0qw7WlL1cstEL+yUzgYvZWeo/5xTyO8fB6f
         W5RpRW5LI2w4QP/UT2NUlN8x0K6wEylFoR5PQj6+xCg4aVxzWUBG67Smwm/OlLOswQ+P
         umCP/FEsizoVOndCFUBTumuGaYPpM24CZTWZFYYZ7G0nhl682sCWdJ0ESFLiY1iR99dA
         JARWeOESkfhtPHt8DVwbj8s7dNxyQg+j19cpnZYbi3l1IWw2tcczf/7z14a0jqKeM1/H
         YYyWXf73EfLl8ygdMHJ2KEiF7tZtgYLpASa7K5AM6AQvd3/LJQIT7zYWfRAVzi1sRa/T
         Oz7g==
X-Gm-Message-State: APjAAAX27Bp+uNdyrDjF1V3+HoLgkXcxx2ixOg46Ml3jcsGDQLaAHzr1
        5722/aE3AzGEJbZVdmDw4gl1eW3lg4fz3NbXtay+VA==
X-Google-Smtp-Source: APXvYqxckBA87s67w7YakD4b8GgZOryNfAxTyy+qPNdE82bEdoxtjPjZlJ/tt5IIpRik/K/Mqv7mj95v0hKcPAjDjZo=
X-Received: by 2002:a02:3309:: with SMTP id c9mr4378013jae.52.1575483198285;
 Wed, 04 Dec 2019 10:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
 <20191128165002.6234-7-mathieu.poirier@linaro.org> <20191203194330.GA2847072@kroah.com>
In-Reply-To: <20191203194330.GA2847072@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 4 Dec 2019 11:13:05 -0700
Message-ID: <CANLsYkyBBp_bAjsEuS=ZDY=Qza67PrwyWJUaDdBHTe1ZM1=2jw@mail.gmail.com>
Subject: Re: [stable 4.19][PATCH 06/17] remoteproc: fix rproc_da_to_va in case
 of unallocated carveout
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 4 . 7" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 at 12:43, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 28, 2019 at 09:49:51AM -0700, Mathieu Poirier wrote:
> > From: Loic Pallardy <loic.pallardy@st.com>
> >
> > commit 74457c40f97a98142bb13153395d304ad3c85cdd upstream
> >
> > With introduction of rproc_alloc_registered_carveouts() which
> > delays carveout allocation just before the start of the remote
> > processor, rproc_da_to_va() could be called before all carveouts
> > are allocated.
> > This patch adds a check in rproc_da_to_va() to return NULL if
> > carveout is not allocated.
> >
> > Fixes: d7c51706d095 ("remoteproc: add alloc ops in rproc_mem_entry struct")
>
> This commit only shows up in 4.20, not 4.19, so why is this patch
> relevant for 4.19?

Your scripts are better than mine...

>
> thanks,
>
> greg k-h
