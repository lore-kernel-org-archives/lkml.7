Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D5FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0E217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIAEbPzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfH1X0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:26:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43105 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1X0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:26:30 -0400
Received: by mail-io1-f65.google.com with SMTP id 18so3006426ioe.10;
        Wed, 28 Aug 2019 16:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoBlXvJBemCrQzD12jpiGB+4gV2+A+K5Uq/oaYZLfFM=;
        b=kIAEbPzMuxNRXuFYEiPtRR1a/KgojVQESDxJLyvyh3NwmbXEAq0U/nfjdEcuUDtB92
         2nlRfn/kxtFVVN5IUpViUy35tdTSaBaIydEX58MGPq1B1KacUqaAuV5noU0AMtaLfad9
         27j2m8soL7vuwiSkZKxsQEHnjIXjEF4Hq/XmZEaQh6VpD8Kk3HqwRWc8Y3TsiQruqcQx
         +ZqMCFNRDcPn3YNhJgpwUjSzTxles9+s2SumNLoZ/LjSSsDLMvTlGToidkVVHWJ4KHK6
         VmhaR8b90Qw0XQB/52mVmK80Mt6jfTzzqtpi5HFZecUCOfRbUlG/msILdr36Ch3cDTbe
         yxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoBlXvJBemCrQzD12jpiGB+4gV2+A+K5Uq/oaYZLfFM=;
        b=o2IbC0jyWH2wMGqXPX/SfuiaY5mfaxJZk7lMJqqqmY2eIfjcwRUww6rUz+Yl4LJb4X
         U1E1Ch5MuKyt25dQdYlj9YmR2N/VeAkdW3pJ8z0yyu2PbJwvkdvRCiAxekVJU4tVz4YQ
         KPa4ai0cLw9yAjr4K4AOGMPFTRdi1jB3aA2aJjvVE/Yzr5/tO1VcWyZjXjW3QQEY4TvZ
         JwBMOfCGzgYSycHaRYifZiyX+PtJP/UzUFSxO4L+pcbnLc07iJe8yNa7VucTvFupXqvr
         wMsK+3o/DANlispMIAUSL1WadU+7ZxMsqNCEOvH8+Pvt6BcgvfmXuUpdcpZjVa0x2Zpn
         CrRw==
X-Gm-Message-State: APjAAAUoFvLwLFNjA6giNKEGXH2nYyCKJRedmUCD4BwbXCN4eMjLpYq8
        69wreXV3zCjSElI6IHrXGR0j5FAE4s3auZgy7hY=
X-Google-Smtp-Source: APXvYqzCr9nOj8u2ubz2JBvXZlpBEYIdJ0GJ3orLlkf54oaD7wClp5YKIHvIaJ6PocaL3keC0ZUSU5i5MzGxlSf//wU=
X-Received: by 2002:a6b:901:: with SMTP id t1mr2602161ioi.6.1567034788892;
 Wed, 28 Aug 2019 16:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190812152022.27963-1-stillcompiling@gmail.com> <20190812152022.27963-4-stillcompiling@gmail.com>
In-Reply-To: <20190812152022.27963-4-stillcompiling@gmail.com>
From:   Joshua Clayton <stillcompiling@gmail.com>
Date:   Wed, 28 Aug 2019 17:26:18 -0600
Message-ID: <CAMB+bfK9Oge1T96aJkuvpoAdUSsm+YxY1W70b62gUMMBKfD8vg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] HID: core: fix dmesg flooding if report field
 larger than 32bit
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?
I'd love to see this get in.
with distro kernel I have effectively no dmesg due to this issue

On Mon, Aug 12, 2019 at 9:20 AM <stillcompiling@gmail.com> wrote:
>
> From: Joshua Clayton <stillcompiling@gmail.com>
>
> Only warn once of oversize hid report value field
>
> On HP spectre x360 convertible the message:
> hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
> is continually printed many times per second, crowding out all else.
> Protect dmesg by printing the warning only one time.
>
> The size of the hid report field data structure should probably be increased.
> The data structure is treated as a u32 in Linux, but an unlimited number
> of bits in the USB hid spec, so there is some rearchitecture needed now that
> devices are sending more than 32 bits.
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 210b81a56e1a..3eaee2c37931 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1311,8 +1311,8 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
>                         unsigned offset, unsigned n)
>  {
>         if (n > 32) {
> -               hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
> -                        n, current->comm);
> +               hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\n",
> +                             __func__, n, current->comm);
>                 n = 32;
>         }
>
> --
> 2.21.0
>
