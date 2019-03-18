Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6952AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A232064A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ffVuWB+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCRSXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:23:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39615 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCRSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:23:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so5174739ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4b/JKrTcJBBqwU4hv1f+Qtxhzo5mF/Q9o6zvm0V0Ihs=;
        b=ffVuWB+AkayioDUscm8Vn+XMNDcLDPWvg5fNDaKk2NGkMwq6mv32dWfUMUQOF9ndUj
         Y+PeBYrlka+UPYNIz7fMelxtW3LiyiERdlXS2/ULyslplGGhGDrolw2x9A6JdzoIJS0e
         xShsDxAzBS5hBzp79Td77v+3WniN+UBRm7wXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4b/JKrTcJBBqwU4hv1f+Qtxhzo5mF/Q9o6zvm0V0Ihs=;
        b=CUcXqdmwOIM253/qHkWO0ku4yY+KqWUcaJShdv95MRb6WI3TYXWB+qhBmbeVW+qxdL
         0wRoGZ2iDSft1BxnkSTo9BRV8Pg/XAeiYcKS9dXAkztvOLtB8Y3Fu3Xj6xAXGzio40N6
         +HnZwN/lTF+2M/7mFqNE19aEDr+GAbCw7pZnVYOrRuHDtzkEWaLlAwAGMRHwjwMQPtBo
         NvV/XwnORvUFaYG+V3htBisPOhOjEFOZkYqKLIgnuHxpfgbTtjvQO7xBkT8rY4yXcyrI
         +RWg1nZRAWNj+R6mjt/d9EVGrMuHqbahcHHvAJ2OGqBOCSlEg803GPcDyEkmIGlGe0K8
         ZC5A==
X-Gm-Message-State: APjAAAXbbBEEaT7pb47nY47m4+RG+m/wrk+NfdD2Bi1zYBAEJQM/D1pD
        S8+QK6G2gH083GxkGJ7FKoyhC939Z4E=
X-Google-Smtp-Source: APXvYqyAgbW5ZdwR0mGPgvuUwc5W5Bq3BzchBNNmptNFEja2UsZE+zOdUJcDlWGs1F0sqN/Ftn91fQ==
X-Received: by 2002:a2e:a312:: with SMTP id l18mr5945306lje.197.1552933414940;
        Mon, 18 Mar 2019 11:23:34 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id v11sm718935ljd.3.2019.03.18.11.23.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:23:34 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u9so12363166lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:23:34 -0700 (PDT)
X-Received: by 2002:a19:4b14:: with SMTP id y20mr10319263lfa.36.1552933413777;
 Mon, 18 Mar 2019 11:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214730.6545-1-valleau@chromium.org> <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
In-Reply-To: <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 18 Mar 2019 11:23:22 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
Message-ID: <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel versions
To:     shuah <shuah@kernel.org>
Cc:     David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 4:40 PM shuah <shuah@kernel.org> wrote:
> usbip tool is tied to the kernel version. This is reason why it is
> co-located with the usbip driver in the kernel sources. This is not
> a typical tool scenario to be able to use new tool on old kernels.
>
> I would like to understand the reasons for wanting to run new tool on
> old kernels.

On Chromium OS, we ship more or less the same user space for a variety
of systems, but not all of those run the same kernel. That's not
exactly a novel concept -- many good tools are written such that they
degrade gracefully when running with reduced feature sets (e.g., older
kernels). While we are working on reducing the divergence and number
of kernels we ship, it's currently a fact of life that we have to
support multiple target kernel versions.

Is there a fundamental problem with VHCI such that it doesn't have a
stable ABI that tools can be written against?

If stability is possible but you just don't care, then I guess we can
fork our own version...

Or even worse, we could build N copies of usbip for N kernels. But we
don't do that for any other user space component.

Brian
