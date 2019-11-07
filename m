Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A94C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 05:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87892166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 05:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORPPosFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfKGFyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 00:54:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34513 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfKGFyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 00:54:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id t4so1027221otr.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 21:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8WMiQe0VQDjoyKQb/Q1dgHH8ZGJEBdgTxTKVf+T+d0=;
        b=ORPPosFhWE3zKGUEjFHEXL4y2uO4VYNssFO/dITIhmo/ufc1VZAlPHDd7b6GE7doWl
         FrwfhE8/eCmJhp6es62joxO/H6TzNYei4vDpTHfknb6tqosNL/Qo/UGWZPLKTIUV+HCA
         uvY4Lfl792bAEV3Xs0CanTl6JGlv4wr5gIDynZ+MX+m+wqi0xWUIPRwtr72AF0Z4WAoI
         snZYgb0yOC2pDuaXT0yWL9K6PpkeXTQs20dOJiqMC1fHUzlwuEkRsLVof/Nx7pD/Gry1
         D2Sg8ufOI784E2JPo1atYAwQy5xPUvP/E1ZpSqhc7BZIk3pjhHMM5vAeZORSdsgeF19f
         a/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8WMiQe0VQDjoyKQb/Q1dgHH8ZGJEBdgTxTKVf+T+d0=;
        b=Daq4IIGkL9VzxcS3CHuhQq3umoa6+zufe2X4bOjR8dSCPqqbzeQI5ZSQmY/gWJSkPk
         O2aHqkpzzOXeccS6SoNRze544sGp+3+PLYLjQ88mI0c84tHMmxITdtlV0npA/Mvp3Etf
         DVQI/PR7+S1m+vkgGImn93iDU58pwbuq/kNYgWtxu6QYW7mEB7M7XfcbnMb+6d4GhM+g
         UrTEcb7nFzb6p9dvEM9fhg/2Qzb/VFXSCRAGyfF1AQxSKq2wLqXnPdTqj5e8ut07WFFX
         x9WoNAF44OLxXvQ/0EqIUPKpPvY0hmewLEFKmtL5Otf0+mGdRlNjXrEd3eK4gm7OM8mF
         Z/wQ==
X-Gm-Message-State: APjAAAUKXA/uk4evKhbE8ea+Iu5MP/2A1GZpWoukRdFHZZXtn45yNTp5
        HxiXKzsQUY54sjSYWgFzrq5W/z+9ParrXnwViL1hPQ==
X-Google-Smtp-Source: APXvYqyM23HvT4YIwpUXDZLD1fpZ3vh1A4qEU1lt+YKirrx+bKUeYCEqwkp3sHwVS9mlTJP9q1b50L58yznJoPUQB30=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr1373544otn.225.1573106056538;
 Wed, 06 Nov 2019 21:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20191105065000.50407-1-saravanak@google.com>
In-Reply-To: <20191105065000.50407-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 6 Nov 2019 21:53:40 -0800
Message-ID: <CAGETcx-X4OTrGfBkP6CtC6=GV=KA147VO6jJL+o6hkC1iCkeeA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] of_devlink: Minor fixes and new properties
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 10:50 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Sending again since the cover letter missed everyone/mailing lists.
>
> First two patches are just code clean up and logging with no functional
> difference. The 3rd patch adds support for the following DT properties:
> iommus, mboxes and io-channels.
>
> These patches are on top of driver-core-next since that's where the rest
> of the of_devlink patches are.
>
> Greg and Rob,
> On a side note, I was wondering if I should rename the of_devlink kernel
> command line to fw_devlink and move it out of drivers/of/property.c and
> into drivers/base/core.c. This feature isn't really limited to
> devicetree, so I don't see a need to have devicetree specific kernel
> command line option.  Please let me know if that sounds okay to you.

Hi Rob,

Thanks for the reviews. Can you let me know what you think of this too?

Rob/Greg,

If I rename of_devlink to fw_devlink, I might also make it a setting
like fw_devlink=none/permissive/enforce
- none would be same as disabled completely.
- permissive would use SYNC_STATE_ONLY for all device links created by
firmware. So it won't block any probes even with cycles but
sync_state() will still work correctly.
- enforce would be the current "of_devlinkg=1" behavior where direct
dependencies would block probing and the child dependencies would use
SYNC_STATE_ONLY.

-Saravana
