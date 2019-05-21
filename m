Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5155CC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309CC21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfEUNul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:50:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37604 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfEUNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:50:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so20550478qtp.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BcI8SrwWpWpzDX2RDw6Fe1SStdMkivlk8QeS9IOKEI=;
        b=K3sf6Vab3P7kPuKQpZZivsok5gftjlm2pEOtaV0heWg+qoGcvGHOA4GWvp1UmDcEW1
         +onEV6auG+HdGEdI/1o/ObaVWr0uvdgTZ/iGXB8Yyh2CR8/N3jCdIpFJV58ai4ih05JF
         B5h0LdaBt9oWbKPCJfoJX99hUtBUqgGddKkvcDt/L/vgR3UKe/D0oHfhT0yKnI8SpLnk
         HGdm2qutJWk44eCLVpFa0Qtjx7ZoqQL7mStZM+W+ClMQ3a7h79yCoXCaDAXSymy2ckNX
         wkXB5zRzh+5lNOnUVE4JqDS1B0ZIl+oiFf0ELaOpcZWGqBnAbsL157FwHg+MXYyqXbzw
         oYqg==
X-Gm-Message-State: APjAAAVABT6UdB+8I8eYqnK+JTNAaamuTk8Si2xm8CUTgGVt5yZOR4J0
        /m0UxzH3KQp/+bsfzBtmtTDzxhMcwwCYHUXoPISimuADAB0=
X-Google-Smtp-Source: APXvYqywGZxccJZ3mHo+OGbyjqCmh5/Qb5FHQVhlFJYuoIXjaC79ddwZ5U88+QsSvUntl6f54n4RZ3GZ1uJeo6/MGPs=
X-Received: by 2002:ac8:7656:: with SMTP id i22mr48085135qtr.260.1558446640196;
 Tue, 21 May 2019 06:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190521133831.4436-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20190521133831.4436-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 21 May 2019 15:50:27 +0200
Message-ID: <CAO-hwJJfRXEdwMq9KLXDMs37CnHXnVhUzD5sbd5uzoeVdKQdvw@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: handle faulty Elo touch device
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 3:38 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Since kernel v5.0, one single win8 touchscreen device failed.
> And it turns out this is because it reports 2 InRange usage per touch.
>
> It's a first, and I *really* wonder how this was allowed by Microsoft in
> the first place. But IIRC, Breno told me this happened *after* a firmware
> upgrade...
>
> Anyway, better be safe for those crappy devices, and make sure we have
> a full slot before jumping to the next.
> This won't prevent all crappy devices to fail here, but at least we will
> have a safeguard as long as the contact ID and the X and Y coordinates
> are placed in the report after the grabage.

Grmbl, I forgot:
Fixes: 01eaac7e5713 ("HID: multitouch: remove one copy of values")
CC: stable@vger.kernel.org # v5.0+

Cheers,
Benjamin

>
> Reported-and-tested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-multitouch.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index ef635964cfe1..a344a3cf5398 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -642,6 +642,13 @@ static void mt_store_field(struct hid_device *hdev,
>         if (*target != DEFAULT_TRUE &&
>             *target != DEFAULT_FALSE &&
>             *target != DEFAULT_ZERO) {
> +               if (usage->contactid == DEFAULT_ZERO ||
> +                   usage->x == DEFAULT_ZERO ||
> +                   usage->y == DEFAULT_ZERO) {
> +                       hid_dbg(hdev,
> +                               "ignoring duplicate usage on incomplete");
> +                       return;
> +               }
>                 usage = mt_allocate_usage(hdev, application);
>                 if (!usage)
>                         return;
> --
> 2.19.2
>
