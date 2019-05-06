Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB41C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C882053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178454;
	bh=6ekGxk1cgLDq3WsKx5cmGBr/cNA9+TIZZTguJ/soLIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v4A923T5Vr7vxB5/PZeVQ/okF3tNZtedZoOkRZOjOIdCQbiacYiY0EalLfqGiw2Ji
	 zSnsHr/ebSbMMNIo9jutcq8xVRQa7Yp6zhdQoD7dfj+YYzVcatfc9AN3OA+op81OUT
	 b/vk7CmER16z+qpmWDzSOE9ntK1T9xUlUzhIWVus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEFVeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfEFVeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:34:12 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4953D20830
        for <linux-kernel@vger.kernel.org>; Mon,  6 May 2019 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557178451;
        bh=6ekGxk1cgLDq3WsKx5cmGBr/cNA9+TIZZTguJ/soLIg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hdhfOh66K1gA4j0VEG9xPa0LH1QlVqPUDFtnznYSEsbudy40JPhqU3EAZMsPSz9GN
         8tnpeFT3qN9YZ1oYL/k9zghyzTiAUGiTz7ioKZEtSyrcGfmRqPp3G/7IsYJpxiCCuW
         Did/vpksAzUaIydS2IcAxaDlTqcSLzS2jfj36A1U=
Received: by mail-qt1-f174.google.com with SMTP id d13so16676971qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:34:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXA+nYlGj8+wbPN22MFqxw92xKbg86MJQSxlwTJnKb35qZx1pPh
        72O+iaOYTqS0vvDRLnnlPHNO2AK+KSYU86trAA==
X-Google-Smtp-Source: APXvYqym5WoCRfUO8WlubAy4abQU//cny0O18+/BpnPmj0RqU9av4V1NT47hZC4WHFVq/E0Uyx4rDVwImA2w5QX1g5s=
X-Received: by 2002:ac8:3862:: with SMTP id r31mr5076391qtb.26.1557178450547;
 Mon, 06 May 2019 14:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org> <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
In-Reply-To: <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 May 2019 16:33:59 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+NyMmRqOUehpPCo_PpnU7k+UmPGv0DUGH1uCb54WOtVA@mail.gmail.com>
Message-ID: <CAL_Jsq+NyMmRqOUehpPCo_PpnU7k+UmPGv0DUGH1uCb54WOtVA@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Kees Cook <keescook@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 4:10 PM Kees Cook <keescook@chromium.org> wrote:
>
> From: Douglas Anderson <dianders@chromium.org>
> Date: Fri, May 3, 2019 at 10:48 AM
> To: Kees Cook, Anton Vorontsov
> Cc: <linux-rockchip@lists.infradead.org>, <jwerner@chromium.org>,
> <groeck@chromium.org>, <mka@chromium.org>, <briannorris@chromium.org>,
> Douglas Anderson, Colin Cross, Tony Luck,
> <linux-kernel@vger.kernel.org>
>
> > When you try to run an upstream kernel on an old ARM-based Chromebook
> > you'll find that console-ramoops doesn't work.
> >
> > Old ARM-based Chromebooks, before <https://crrev.com/c/439792>
> > ("ramoops: support upstream {console,pmsg,ftrace}-size properties")
> > used to create a "ramoops" node at the top level that looked like:
> >
> > / {
> >   ramoops {
> >     compatible = "ramoops";
> >     reg = <...>;
> >     record-size = <...>;
> >     dump-oops;
> >   };
> > };
> >
> > ...and these Chromebooks assumed that the downstream kernel would make
> > console_size / pmsg_size match the record size.  The above ramoops
> > node was added by the firmware so it's not easy to make any changes.
> >
> > Let's match the expected behavior, but only for those using the old
> > backward-compatible way of working where ramoops is right under the
> > root node.
> >
> > NOTE: if there are some out-of-tree devices that had ramoops at the
> > top level, left everything but the record size as 0, and somehow
> > doesn't want this behavior, we can try to add more conditions here.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I like this; thanks! Rob is this okay by you? I just want to
> double-check since it's part of the DT parsing logic.

I'll leave it to you. It does fall into the case of supporting
downstream bindings that weren't reviewed (IIRC reviewed maybe, but
not accepted) which isn't great precedent. OTOH, it's a small change
for a largish number of devices.

Rob
