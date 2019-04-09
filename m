Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70023C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382EC2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="myzeeAj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDIUrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:47:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33582 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDIUrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:47:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id e5so14824126oii.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyDk/9dlhI5kjqXMFYaoIcxr51Gg4hwSfB6MpA4YNh0=;
        b=myzeeAj1RmCZTa0NhTaLGBShCrB/tfva8Uoiki+s4FGVjyyEcJpFRQ+IsWbLEx2Ga+
         0D1XvCH5vKTwoT+kS9GPsl9OStq7Kd7I+sF5WZP+QEXxUqj9iHQN48JJ3zGCE/lAMe0T
         hejPX9roOxJpk3jR2LwtZKN0yO4mfQtTePQOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyDk/9dlhI5kjqXMFYaoIcxr51Gg4hwSfB6MpA4YNh0=;
        b=tHU5AAKL2mcw1LlZxz9UD0kTZWFJFkcvWk9FmG6tIRUuJ8CCB2pj7a/3BMmZPboapK
         Gu9gXFW2bLvz5c4nEZSBhWa7iiKZdmkreir+jp5t08kvtzuk20dKsp8YM1vhTHRzyH6d
         xmcXREX/AugWf9bpcE2IaHsm+3UZoz1dYy7Xjc2I+upCJTIDVNVap4gY0SYeVLqUIYXs
         1Pw0HKIs3idKENW4CUUxASCmT1l6P3HR3mxSFgloI/TlvEseuNlSG1StoynHd9TGayaS
         k9BSMbUNRPI0fnbWJ7A2R+jekuXwEDSFZ42/dvt26+3u4/OA+p0Z/+YJVM8Ty/d0xyUx
         Vzkw==
X-Gm-Message-State: APjAAAXLtmEumHg0DfG3FmBzknktPXz9LMAe0OrpmCqVZlDIxBZAsrTW
        KLyRh+o9uaC/Zqwyh6Ul2BZ3xDw12SU=
X-Google-Smtp-Source: APXvYqyeR8GI7fYGggk08+bl4U1uU4x7dJb/W+v95r3meZVhiPU6PAwfcwrDa2q9PGDkeWJbdpYKgg==
X-Received: by 2002:aca:51d0:: with SMTP id f199mr218982oib.104.1554842828801;
        Tue, 09 Apr 2019 13:47:08 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id k65sm14056204oia.16.2019.04.09.13.47.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:47:07 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id t81so14772815oig.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:47:07 -0700 (PDT)
X-Received: by 2002:aca:378a:: with SMTP id e132mr178588oia.171.1554842826817;
 Tue, 09 Apr 2019 13:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003156.205051-1-ncrews@chromium.org>
In-Reply-To: <20190404003156.205051-1-ncrews@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Tue, 9 Apr 2019 14:46:55 -0600
X-Gmail-Original-Message-ID: <CAHX4x87OcNofMLQTWJJR1NgaDQ=xT3MQpTv6pzkViyTbZwwKgw@mail.gmail.com>
Message-ID: <CAHX4x87OcNofMLQTWJJR1NgaDQ=xT3MQpTv6pzkViyTbZwwKgw@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: Add Wilco EC Event Handling
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Oleh Lamzin <lamzin@google.com>,
        Bartosz Fabianowski <bartfab@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I know people had questions with the structure/uses of the events in the
previous versions of this patch. Does this clear things up?

Thanks, Nick

On Wed, Apr 3, 2019 at 6:31 PM Nick Crews <ncrews@chromium.org> wrote:
>
> The Wilco Embedded Controller can create custom events that
> are not handled as standard ACPI objects. These events can
> contain information about changes in EC controlled features,
> such as errors and events in the dock or display. For example,
> an event is triggered if the dock is plugged into a display
> incorrectly. These events are needed for telemetry and
> diagnostics reasons, and for possibly alerting the user.
>
> These events are triggered by the EC with an ACPI Notify(0x90),
> and then the BIOS reads the event buffer from EC RAM via an
> ACPI method. When the OS receives these events via ACPI,
> it passes them along to this driver. The events are put into
> a queue which can be read by a userspace daemon via a char device
> that implements read() and poll(). The char device will appear at
> /dev/wilco_event{n}, where n is some small non-negative integer,
> starting from 0. Standard ACPI events such as the battery getting
> plugged/unplugged can also come through this path, but they are
> dealt with via other paths, and are ignored here.
>
> To test, you can tail the binary data with
> $ cat /dev/wilco_event0 | hexdump -ve '1/1 "%x\n"'
> and then create an event by pressing fn+Esc.
>
> v3 changes:
> - Made commit description more accurate and useful.
> - Added an exclusive lock for opening the char device,
>   so only one userspace process can read events at a time.
>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
