Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5197DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D492080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkMQKmnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfKDTAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:00:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43152 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:00:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id l20so3032796oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ksr/h9CCVfqZZQjRKQaKSNEP4lA439YVqkZQJ3uCxu4=;
        b=CkMQKmnOy6i1xFV6dMi8Bspp2+SiqjFCPxIRLAHuZecPhMXOwhJ0ejY623f5E2L3n8
         BjP9BeUUlCqWt2o6uBCqmUg2OQ38lNyqN7+o7tRZbrWJDjzFnfedi5+KAsRIakiIYnxS
         MFP+ZnbOqfvvJhOCHS8mHURidBYca+h47mZLk0d/OQVIGJk9dPEc8ryZ6XWdeVXza8bw
         W/gF61xyTqrCzN4Nnr6/QQDt2PqWxlGtnCImJjErygRstjnpOeT0/y8S1KCkvMYKejoP
         ErUpYl/s8Fwd7vKYzpdkexc+TxgX1fMlNd2vs7wICk2khqMalQuMN7qYcNgsYQZzfH4s
         sSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ksr/h9CCVfqZZQjRKQaKSNEP4lA439YVqkZQJ3uCxu4=;
        b=cR+KZorzjSshjvEfem5VfSqczd4/grdMHRHQ1FOu/r3PZOLHFpQ2eJGIYyrHO+qrv9
         w4jFD0Wkp4Bd1y6AeqwWJ2kzhz/Av0nHzeojWcfm3lGfanLeGqelVn8wLmpDlmuV1YsX
         yVp1fL268ifS3jM9XYW81yHjld0TS7g2nbSgy78HpzhaMqH8L1/mXk5zXXGzb6d2cFlS
         aEwdk6Dbxmua0F/OxSJfnxAbTBraEtyDKzw+0uD7yOXKBnknaXcuzWOiK5Kf/qEjf55+
         O4WnAtdZwR8hHMOiUX3LK8XkdQK/WWaQfqN2ddSro+HUnUon7hLIEACyRfsWKPxKgKqr
         vxEA==
X-Gm-Message-State: APjAAAUG3YPyq6WpvN+tttwERfDnUIltLKvMGVbZ34WmbaZglI2ouLZ+
        NSlAXaK0bMZkPE8mXB+DcDw6xhykAulbL/YPQoHVzWav
X-Google-Smtp-Source: APXvYqx9RH4q18tPgDzGIegAC/ekwamy9juTr/AzqXzj083HVVgnfDpFlteVk7Iw0sWNnT/Cj5W81rCPE1MlbyKHkRE=
X-Received: by 2002:aca:1210:: with SMTP id 16mr489352ois.128.1572894020603;
 Mon, 04 Nov 2019 11:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-3-john.stultz@linaro.org> <20191104102445.GE10326@phenom.ffwll.local>
In-Reply-To: <20191104102445.GE10326@phenom.ffwll.local>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Nov 2019 11:00:08 -0800
Message-ID: <CALAqxLXq=4dw=WfJZhXh=Ft3SHK1QUJZRt+rwy4ZuKTbjZUEpQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] dma-buf: heaps: Allow system & cma heaps to be
 configured as a modules
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 2:24 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Oct 25, 2019 at 11:48:34PM +0000, John Stultz wrote:
> > Allow loading system and cma heap as a module instead of just as
> > a statically built in heap.
> >
> > Since there isn't a good mechanism for dmabuf lifetime tracking
> > it isn't safe to allow the heap drivers to be unloaded, so these
> > drivers do not implement any module unloading functionality and
> > will show up in lsmod as "[permanent]".
>
> dma-buf itself has all the try_module_get we'll need ... why is this not
> possible?

Let me look into that.  Thanks for the pointer.

thanks
-john
