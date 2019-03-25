Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F3AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963C92087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNv5BZwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfCYSCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:02:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40341 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfCYSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:02:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so3622322otp.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWe1rzyEspOqvxXDkY+RjbRvVDpiSKgfsNXo/BlqlWg=;
        b=cNv5BZwZLdlHjE2DxxVa0Z9U+Fpo1IdARDptFGPNbknmUgY1q92B+LwKYoFI2ktlRF
         pclX0ha2yGPbzgVR2lrUKthVJw2J+7weaKPXIZlWAbDBc0QfMLz6ffnzxAaavbT0HYX2
         mszE2MdUXJqEPBmiCKzXbK5EzMG+mafnr1hrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWe1rzyEspOqvxXDkY+RjbRvVDpiSKgfsNXo/BlqlWg=;
        b=gRZKft9Fx88pS7XQVxWFq77Z1ynPMpYIFweLVb5A4kevAHqtlU4jS+IoWjU37IIpaX
         qjWInMsk06WwLuiYf1rt55JFun4TsCfJIoV/s5L6OpOGT0XgsrvLIIudxZpT6B0muDyj
         jHrzrFdwqI4uXbmz8nPntHmzR8wTdjtMLs2n6tiIHvmDMm+txSJfQUU4FthGZgTH2594
         l4uDvzz3JkCJNjRXi6tVZFJjA3dRMmkc5uGILjJmd0a/hlDs5ehlXPvnDD8pg5Tn3wae
         jdP5G/JFkfMyrWUIHOLWMV+K2Iq+PYpkqU0N8KdFVAA27/2WPqjgTOW7Vp9fiCmZKt4m
         YcWA==
X-Gm-Message-State: APjAAAXEZbk7pHV1u4Xkzci9Yf2Zavf46apfJ/iQq9ettPgRWm6Bw+Yv
        KBs301cMkaWsedXerpTJRdTjECMODToM0IvlxGCJnQ==
X-Google-Smtp-Source: APXvYqzA0Kf4JOvY4zy/7LmvghfL+CzsuizsiWycdv0SKs4JCKASY8Q+9JdDMJSZRHAhxwSXPLAUP5glleRHT6LkCF8=
X-Received: by 2002:a9d:7455:: with SMTP id p21mr19730542otk.180.1553536956223;
 Mon, 25 Mar 2019 11:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <1553523143-23072-1-git-send-email-mario.limonciello@dell.com>
In-Reply-To: <1553523143-23072-1-git-send-email-mario.limonciello@dell.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Mon, 25 Mar 2019 12:02:25 -0600
Message-ID: <CAPnjgZ2JVkE04gE1agJwQcfufoqYHv_=3CAjxpOyOMn61XwgJA@mail.gmail.com>
Subject: Re: [PATCH] r8152: Refresh MAC address during USBDEVFS_RESET
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     linux-usb@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, lk <linux-kernel@vger.kernel.org>,
        hayeswang@realtek.com, Daniel Campello <campello@google.com>,
        Ryan Hong <Ryan.Hong@dell.com>, Crag Wang <Crag.Wang@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 at 08:12, Mario Limonciello
<mario.limonciello@dell.com> wrote:
>
> On some platforms it is possible to dynamically change the policy
> of what MAC address is selected from the ASL at runtime.
>
> These tools will reset the USB device and expect the change to be
> made immediately.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/net/usb/r8152.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
