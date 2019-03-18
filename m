Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE762C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EF620811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V1LLkucl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfCRS2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:28:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39823 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCRS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:28:52 -0400
Received: by mail-io1-f67.google.com with SMTP id e13so5167637ioq.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/DdqKbtFvuc9cTXnJsuN9afWQ363mq88qv0O2AXh2Y=;
        b=V1LLkuclIbUa++qGwdC3rAtieG5/WINQIWhfTRnl9clYDfhRsnLTiV2ZHue/u0hBj4
         h+VQIf0xOWknG46QHcKC0cjKxVkthG4ME7+pPL/pNYJqTBK+a9ryG6m8fTKjFZcmTuI8
         SWIAlLNXIL84+q6ENILdrwNelff7MolfXgqRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/DdqKbtFvuc9cTXnJsuN9afWQ363mq88qv0O2AXh2Y=;
        b=S+O6R+kys0yg8p3HV1nQFqLEAP3k+xfVwpDLi/n0o1StohC4BF/eqlgQbFGXQXN6lG
         3G1V28zIjkGYC+pDRghaM7Gxi1c0wz2vsPEaGWXbZ/89++xssGQNv/qPvcJwrZftNXqi
         PK0y+A+t097gTedGFaqn/aXJ5KFN7U+v7FzQcUuyAvPX6sx+bfLA8KRcmIVHAQu6Zr1r
         jA0g/vQ2A2v/M6FqzsYS0EdmSicbmRhgEu3XXqe0RQ+bePEMTYyZI/Dunsvy03ieIva/
         oY49VGxkBMhpR3DW+Vk2+98jQWIGl7k+1ondA1VDPWFQ+O+KEdQMq4CJW9ccFIDDPZfE
         kjBg==
X-Gm-Message-State: APjAAAXF4N0TXj/QdPicX28zS4QVQXbPuAfVWW0CyOi4c4J8EEIUcjSx
        lVJrMyMXjzjyJlsnNuOLpeJUxDvfNUMPFbUovJm1yQ==
X-Google-Smtp-Source: APXvYqx8jGmg+6HZGkY8O8bNMdSPwB9DydFpcXM7sspX3D5Ey244ur356hhJrzmg4WhGPL2LrnR7yHgCBS5FKwL2jh4=
X-Received: by 2002:a6b:d80a:: with SMTP id y10mr11539801iob.114.1552933731792;
 Mon, 18 Mar 2019 11:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
In-Reply-To: <20190303173527.31055-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Mar 2019 23:58:39 +0530
Message-ID: <CAMty3ZAGvCOuqcTUozBm-uR4z=jR18bfOSyN5=jfT85HGWR_1A@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] drm/sun4i: sun6i_mipi_dsi: Fixes/updates
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 3, 2019 at 11:06 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Unfortunately due to various reasons[3] the previous fixes[1] and burst[2]
> changes are failed to apply.
>
> So, this series is filtered version of previous [1] and [2] changes on top
> of drm-misc.
>
> patch-1: Fix for burst mode instruction delay computation
>
> patch-2: Fix for TCOn DRQ set bits
>
> patch-3: Support vblk timing for 4-lane devices
>
> patch-4: GENERIC_SHORT_WRITE_2 dsi transfer support
>
> patch-5: Code simplification for dsi timings
>
> Changes for v9:
> - rebase on drm-misc
> - update commit messages
> - add hsync_porch overflow patch
> Changes for v8:
> - rebase on master
> - rework on commit messages
> - rework video start delay
> - include drq changes from previous version
> Changes for v7:
> - rebase on master
> - collect Merlijn Wajer Tested-by credits.
> Changes for v6:
> - fixed all burst mode patches as per previous version comments
> - rebase on master
> - update proper commit message
> - dropped unneeded comments
> - order the patches that make review easy
> Changes for v5, v4, v3, v2:
> - use existing driver code construct for hblk computation
> - create separate function for vblk computation
> - cleanup commit messages
> - update proper commit messages
> - fixed checkpatch warnings/errors
> - use proper return value for tcon0 probe
> - add logic to get tcon0 divider values
> - simplify timings code to support burst mode
> - fix drq computation return values
> - rebase on master
>
> [1] https://patchwork.kernel.org/cover/10813573/
> [2] https://patchwork.kernel.org/cover/10813623/
> [3] https://patchwork.kernel.org/cover/10805995/
>
> Any inputs?
> Jagan.

Any further comments on this series? Can I send next version with some changes?
