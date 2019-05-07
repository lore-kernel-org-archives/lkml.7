Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26F3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD56720675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjfzsWfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfEGWRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:17:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34976 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:17:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id t87so8794131pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=110XxIZf7ROUEfUSzklwiJI5L7urbcXK4X6uNMzpVGE=;
        b=PjfzsWfxbR/DNi/xzPYZpmyRAEaAi7Goo6jksrwdZdU1hpa2OT78WNgDKfVRHO8JVu
         HrX7aDHflMAinidKfihXRKFJRoUQ8k7PWP7g7upZqqguFQn4QZsR2Im6kH8Dvd/hdksp
         QQ4hPUOXyvOI2zeiCMNMNwq5jFhoKIG3NdhzE01GG3nyHvDKopIR/GVuRNUleaoPvGyw
         bLgmPYzmSCYXhRqenSAWjnvSDHTZY7dhYVS5hmpqFxVIids35u12sO47XOL6frLe451t
         wRsM2YZxYB3Ou1PoANxyAGnFLmrKe6+kAS9RHU0GNU6t38Ggt6QYDF3skw3b85z8vN3C
         qfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=110XxIZf7ROUEfUSzklwiJI5L7urbcXK4X6uNMzpVGE=;
        b=PGvOHbHEjA7R5Mf9fdT4nmPeINhHDm4+IdDvX6oTPfcsitkgoDAK1POJDMwyFLMeH7
         /8bFee3y/hr1+KpQ394LFzD2dPdbox80q5I9o3hPu439vDte6OrW+eqblV8JcCMY9WPq
         WIZxK8TVfi15bjavj4RPw15kRrPpNHh5QY+qt1aAn9sv0uugXc2mm84pUzvRRaN+IHyW
         VRtrgWXFKjZzHhKo2Nfx1T9YBQp11jn6N5cbVeUKJi989kW2onKZsbx6ezhOsLHtCH6V
         ql+GRqbSDeNL4/Pph7umw5Mw8ewsZ0HVxJyt5SlFk07VdWx+tmfemPpGYrZ3UAZs5FWj
         e4gQ==
X-Gm-Message-State: APjAAAUi1CZ6bQvwjvJioNaasHPaMBstPQiFYT69FOwv+MrEpy3K9trL
        dcyz/NLKiLdfmxXmlXcnPtg=
X-Google-Smtp-Source: APXvYqy+wB6AQ+5yWcjxyBjQ/EnnQ0UHSs24ZHqrZOMhZzy5yZmaaArc8kh3kSLz6/U5+AGu79AMTQ==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr45044759pfm.251.1557267460394;
        Tue, 07 May 2019 15:17:40 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 132sm9044957pga.79.2019.05.07.15.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 15:17:39 -0700 (PDT)
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older
 Chromebooks
To:     Doug Anderson <dianders@chromium.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190503174730.245762-1-dianders@chromium.org>
 <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
 <CAD=FV=WcjfUwH62bHVELOmzViv7d329r6+HfPqAyXMjKCO7LeQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <30361ae7-36a6-0858-77ec-40493ef44b98@gmail.com>
Date:   Tue, 7 May 2019 15:17:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WcjfUwH62bHVELOmzViv7d329r6+HfPqAyXMjKCO7LeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 4:58 PM, Doug Anderson wrote:
> Hi,
> 
> On Mon, May 6, 2019 at 2:10 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> From: Douglas Anderson <dianders@chromium.org>
>> Date: Fri, May 3, 2019 at 10:48 AM
>> To: Kees Cook, Anton Vorontsov
>> Cc: <linux-rockchip@lists.infradead.org>, <jwerner@chromium.org>,
>> <groeck@chromium.org>, <mka@chromium.org>, <briannorris@chromium.org>,
>> Douglas Anderson, Colin Cross, Tony Luck,
>> <linux-kernel@vger.kernel.org>
>>
>>> When you try to run an upstream kernel on an old ARM-based Chromebook
>>> you'll find that console-ramoops doesn't work.
>>>
>>> Old ARM-based Chromebooks, before <https://crrev.com/c/439792>
>>> ("ramoops: support upstream {console,pmsg,ftrace}-size properties")
>>> used to create a "ramoops" node at the top level that looked like:
>>>
>>> / {
>>>   ramoops {
>>>     compatible = "ramoops";
>>>     reg = <...>;
>>>     record-size = <...>;
>>>     dump-oops;
>>>   };
>>> };
>>>
>>> ...and these Chromebooks assumed that the downstream kernel would make
>>> console_size / pmsg_size match the record size.  The above ramoops
>>> node was added by the firmware so it's not easy to make any changes.
>>>
>>> Let's match the expected behavior, but only for those using the old
>>> backward-compatible way of working where ramoops is right under the
>>> root node.
>>>
>>> NOTE: if there are some out-of-tree devices that had ramoops at the
>>> top level, left everything but the record size as 0, and somehow
>>> doesn't want this behavior, we can try to add more conditions here.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>
>> I like this; thanks! Rob is this okay by you? I just want to
>> double-check since it's part of the DT parsing logic.
>>
>> I'll pick it up and add a Cc: stable.
> 
> Hold off a second--I may need to send out a v2 but out of time for the
> day.  I think I need a #include file to fix errors on x86:
> 
>> implicit declaration of function 'of_node_is_root' [-Werror,-Wimplicit-function-declaration

Instead of checking "of_node_is_root(parent_node)" the patch could check
for parent_node not "/reserved-memory".  Then the x86 error would not
occur.

The check I am suggesting is not as precise, but it should be good enough
for this case, correct?

-Frank

> 
> I'm unfortunately out of time for now, but I'll post a v2 within the next day.
> 
> 
> -Doug
> 

