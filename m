Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A7CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4823B21019
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TSXgJ56l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEGWUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:20:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34233 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:20:07 -0400
Received: by mail-ua1-f68.google.com with SMTP id f9so6646815ual.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUjfyo9IQTfykk5cP53qZuYE6lGqJDNLu8EMt8QFItw=;
        b=TSXgJ56lkLW5XfW25fRGLAlniT3SnPiOpDt0bxqpL6M7cykHIMW9neXmDgJf6V2dqR
         Vupz/lhWiW/uvls/Gsv3WjxSLSGlRB+iy4ypPmFktGqIDCFQ3ud95rW7JvxCgEm3u40k
         hHQWi6r9pIY2HBwhsxA6Ci0Gk+aZcoCnsGYaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUjfyo9IQTfykk5cP53qZuYE6lGqJDNLu8EMt8QFItw=;
        b=neR8z49PxM6rOEfo1ltQsayIZnW05I+gboUhMPBWXyqE+68hghICkpqKY004nS/e3l
         D8PZMM7MQEyLqtaoG0T9BzOOyxYmLPjURv7g6G9Nb83w+/Gp56VL+OpzbE7MCQePbU7v
         U9Fy/CbM8KN/qpO806WJtFpld9yfqGF3IVFxL7fC6KDRcakCFl+ReHc+BFnETZgD4PGK
         7U6BAxULuGdLXr05BQdmpmHSugR02wtudyAu2a91hzfLQ0WqTywgXHteV4BdvcHiHq2v
         V7wEyphOmyXNuP+MSMQbMAlO54ceg0K9rcux2z5TTMNrt1tb1K1odM7EhZBVZwoHxPyy
         6Saw==
X-Gm-Message-State: APjAAAV1oUZZPjU0XVtBZrP6PYXuEDatDKtePq5xt8u5/VDv+vDBhIp/
        8ugakW3VNHVHX30obJ3sW6P+U3D+qO0=
X-Google-Smtp-Source: APXvYqz2n1jz/1yadM06gFbb4vRn1RCBC/BgBLzbyW8l0MqZHWZHgUi5bpT2DD9cIkLRmpOcWODmOg==
X-Received: by 2002:ab0:3351:: with SMTP id h17mr11622872uap.123.1557267605991;
        Tue, 07 May 2019 15:20:05 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a184sm4586205vkb.28.2019.05.07.15.20.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 15:20:04 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id p13so6622915uaa.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:20:04 -0700 (PDT)
X-Received: by 2002:ab0:2709:: with SMTP id s9mr16511621uao.21.1557267604203;
 Tue, 07 May 2019 15:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org>
 <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
 <CAD=FV=WcjfUwH62bHVELOmzViv7d329r6+HfPqAyXMjKCO7LeQ@mail.gmail.com> <30361ae7-36a6-0858-77ec-40493ef44b98@gmail.com>
In-Reply-To: <30361ae7-36a6-0858-77ec-40493ef44b98@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 May 2019 15:19:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U5heONCv=W5x6cL_JAmJaeDrjMa0CnQ=UVu+DTZZBNKQ@mail.gmail.com>
Message-ID: <CAD=FV=U5heONCv=W5x6cL_JAmJaeDrjMa0CnQ=UVu+DTZZBNKQ@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>,
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

Hi,

On Tue, May 7, 2019 at 3:17 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 5/6/19 4:58 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, May 6, 2019 at 2:10 PM Kees Cook <keescook@chromium.org> wrote:
> >>
> >> From: Douglas Anderson <dianders@chromium.org>
> >> Date: Fri, May 3, 2019 at 10:48 AM
> >> To: Kees Cook, Anton Vorontsov
> >> Cc: <linux-rockchip@lists.infradead.org>, <jwerner@chromium.org>,
> >> <groeck@chromium.org>, <mka@chromium.org>, <briannorris@chromium.org>,
> >> Douglas Anderson, Colin Cross, Tony Luck,
> >> <linux-kernel@vger.kernel.org>
> >>
> >>> When you try to run an upstream kernel on an old ARM-based Chromebook
> >>> you'll find that console-ramoops doesn't work.
> >>>
> >>> Old ARM-based Chromebooks, before <https://crrev.com/c/439792>
> >>> ("ramoops: support upstream {console,pmsg,ftrace}-size properties")
> >>> used to create a "ramoops" node at the top level that looked like:
> >>>
> >>> / {
> >>>   ramoops {
> >>>     compatible = "ramoops";
> >>>     reg = <...>;
> >>>     record-size = <...>;
> >>>     dump-oops;
> >>>   };
> >>> };
> >>>
> >>> ...and these Chromebooks assumed that the downstream kernel would make
> >>> console_size / pmsg_size match the record size.  The above ramoops
> >>> node was added by the firmware so it's not easy to make any changes.
> >>>
> >>> Let's match the expected behavior, but only for those using the old
> >>> backward-compatible way of working where ramoops is right under the
> >>> root node.
> >>>
> >>> NOTE: if there are some out-of-tree devices that had ramoops at the
> >>> top level, left everything but the record size as 0, and somehow
> >>> doesn't want this behavior, we can try to add more conditions here.
> >>>
> >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>
> >> I like this; thanks! Rob is this okay by you? I just want to
> >> double-check since it's part of the DT parsing logic.
> >>
> >> I'll pick it up and add a Cc: stable.
> >
> > Hold off a second--I may need to send out a v2 but out of time for the
> > day.  I think I need a #include file to fix errors on x86:
> >
> >> implicit declaration of function 'of_node_is_root' [-Werror,-Wimplicit-function-declaration
>
> Instead of checking "of_node_is_root(parent_node)" the patch could check
> for parent_node not "/reserved-memory".  Then the x86 error would not
> occur.
>
> The check I am suggesting is not as precise, but it should be good enough
> for this case, correct?

Sure, there are a million different ways to slice it.  If you prefer
that instead of adding a dummy of_node_is_root() I'm happy to do that.

-Doug
