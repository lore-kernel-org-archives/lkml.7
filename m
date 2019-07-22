Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48496C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E5D218B8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lbzR2JAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfGVU53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:57:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44640 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfGVU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:57:29 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so76986426iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjNVdtHkZg8It4YZUOH939LIztpaI1Zp3lcG00+nZjU=;
        b=lbzR2JAR1Xj8v+LEHhuv9HHjJ4d7YIm5QqhsKkrwvOifG5eoDrfVRRllHmnKA/7Yzt
         GT2JF5v9TVpFuX926EjboYL5oSVmwjs2vMtLRG5M2AubrOtCPSaVg9JbP6cVUcJcOEgA
         55/inpf42lOPhWucflo/PmL7+VtgqwdmQAQiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjNVdtHkZg8It4YZUOH939LIztpaI1Zp3lcG00+nZjU=;
        b=prtMsqCsOpvDH7KSE+mXw3Oo5xZ8byya163eLAbf4exKUeqdVwlLcA678jOGjhEOpG
         23TQJ8SP0eL+X9GJsDpNFGN7ehNKirf6urj+kaGjx6m3EUOK2b6WPnR4ozLj7U5hSXrR
         l0rSx8EumIHgdz0hgqLRyGkITuC9vih5KiXONP35eaFOvJuc1DLlU+npKC0untUrouBn
         dvpzdk8P0KJPHHjlMEC9tuM1YhX00pX2OV7IdLc/ehkf/d1tvHAmCfYCAeC4BhFjTBFu
         eudZPfMJL6qM8REcxD2leLPvgJrWtB3iaEcMqYOk4ww3oFQ6Mxm58FPmG79hVDxZPvxp
         cjqw==
X-Gm-Message-State: APjAAAWx3vhhNOMwLxDRsjPTUXYipsM5c1sI4a3FEiQt9Cm1101eqZ7z
        biVH3jrC1CINBuay6s0l1Joid3sX5fQ=
X-Google-Smtp-Source: APXvYqw9siN4W47oYQ1eT9CCdXmInxuAOzEX4m8AqMGe3WveRuRMRdCrXd5aWCRo028NFJQzt2NNlA==
X-Received: by 2002:a6b:691d:: with SMTP id e29mr19372395ioc.96.1563829048352;
        Mon, 22 Jul 2019 13:57:28 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id p3sm59241508iom.7.2019.07.22.13.57.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 13:57:27 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id g20so77062140ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:57:26 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr62856397iob.142.1563829045931;
 Mon, 22 Jul 2019 13:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190722181945.244395-1-mka@chromium.org> <20190722202426.GL104440@art_vandelay>
In-Reply-To: <20190722202426.GL104440@art_vandelay>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jul 2019 13:57:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vk5V+gJhW8=6ZFfgV6LdN2U3-VkZvqn7QWDw-215-Z1Q@mail.gmail.com>
Message-ID: <CAD=FV=Vk5V+gJhW8=6ZFfgV6LdN2U3-VkZvqn7QWDw-215-Z1Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
To:     Sean Paul <sean@poorly.run>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Adam Jackson <ajax@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 22, 2019 at 1:24 PM Sean Paul <sean@poorly.run> wrote:
>
> On Mon, Jul 22, 2019 at 11:19:45AM -0700, Matthias Kaehlcke wrote:
> > The DDC/CI protocol involves sending a multi-byte request to the
> > display via I2C, which is typically followed by a multi-byte
> > response. The internal I2C controller only allows single byte
> > reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
> > supported when the internal I2C controller is used. The I2C
>
> This is very likely a stupid question, but I didn't see an answer for it, so
> I'll just ask :)
>
> If the controller supports xfers of 8 bytes and 1 bytes, could you just split
> up any of these transactions into len/8+len%8 transactions?

It's not quite that easy, I think.  Specifically a 1-byte transfer
isn't really a 1-byte transfer.

It always sticks this on the wire for a 1-byte write:

Start
Slave address (7 bits) + write (1 bit)
(wait ack)
Register address
1 byte of data
wait for ack
Stop

...or for a 1-byte read:

Start
Slave address (7 bits) + write (1 bit)
(wait ack)
Register address
(wait ack)
Repeated Start (1 bit)
Slave address (7 bits) + read (1 bit)
(read 1 byte of data)
Ack
Stop

Putting more than one of those in a row is not the same thing as just
doing a whole bunch of reads or a whole bunch of writes with no "stop"
in between.

As far as I could find out about DDC/CI it's part of the spec to _not_
send the stop between the reads / writes.


-Doug
