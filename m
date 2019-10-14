Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F1BECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E939F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AariQ55E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfJNRuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:50:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44150 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731602AbfJNRuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:50:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so10775763pfn.11;
        Mon, 14 Oct 2019 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xeBjfnVagKgP5qH9jlyVR2d5Q7jiCa+79wJogu5uP8=;
        b=AariQ55EpyrnjjO/eQh7fFTL53hkEDiXiVrE1qkNJZpz/NCLswHuSqaDmh88zuwY1B
         YxV53IAcfxRmiptihuXEymmcb/WijMbNFxhMe7k1Gv8Yoo/OcayoZGkXQt/LuGA38Lhe
         60wCyWnzcLT5n0+8tFd6kv1zXAow0KDHb7p8P6fqT6mlpHz+G1VOPOhR0G+tnvnBGHal
         5UNfaSJTq1jFmlLFTM5rSZrGpSfEHgYISCEiSH5/pWcExMCtYzhL8BlBUevSsA+xwBec
         nJusUVCl3igDuvgx+MBIfMb9hcWHqhJpzLh8ZcBnX4GicW+9RaRtCbL7N+5I+2LToC7a
         z9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xeBjfnVagKgP5qH9jlyVR2d5Q7jiCa+79wJogu5uP8=;
        b=M0UOodp7BrVI7aAAO02ewsRVwbFvTq7zdDLoZBIv59WXT+OXAVucJR8uUjY9wd6mle
         bebDQEikk7McV0MZK6pEwJsab08m/tDupJioPpWE6cSbmf98VHA2N122iqRa5m239Ph7
         DK6olPOYf/1zWQ/3kTmopq0GvD+Ke9uxt/k24wJRe053bHmyiLpn3JIAF93jWFJ20FEz
         9QVg/5i4ERPOAStS0QdcpZhAGrlsI2MsuC7kcZaA4mDI9hfDILotcVvupFpQJo4NPf+q
         pj0ScUzHEgiDwFKZ1xQGKrQw76sPhjKvlty5VwGn+4vK6PjyABUgZxpOvka39gxllAtM
         yzFQ==
X-Gm-Message-State: APjAAAX7JWGqYWLkcwyp/5wpObx8cZlqhqcyKPeNSXQSC1kSYvb1zAu0
        8XkG5OhQfc+t8wMMIx7hnw75u5nRdZeEpBnNG1M=
X-Google-Smtp-Source: APXvYqxNTXiGtyUOdPbeH6cq841Wndz2JyNxOwMF0jcybZ4sfdY+ZErDlXwDPRTBuiWSuplDXf8UYlzBShYWVZQWw+E=
X-Received: by 2002:a62:e206:: with SMTP id a6mr34056152pfi.64.1571075418730;
 Mon, 14 Oct 2019 10:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191004214334.149976-1-swboyd@chromium.org> <20191004214334.149976-2-swboyd@chromium.org>
In-Reply-To: <20191004214334.149976-2-swboyd@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Oct 2019 20:50:06 +0300
Message-ID: <CAHp75Vebn48hbzqKWzV3aj4NEBCta_Fn7zOQHzsznW4=6cXLsQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] leds: pca953x: Use of_device_get_match_data()
To:     Stephen Boyd <swboyd@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Riku Voipio <riku.voipio@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 12:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This driver can use the of_device_get_match_data() API to simplify the
> code. Replace calls to of_match_device() with this newer API under the
> assumption that where it is called will be when we know the device is
> backed by a DT node. This nicely avoids referencing the match table when
> it is undefined with configurations where CONFIG_OF=n.

> +       devid = (int)(uintptr_t)of_device_get_match_data(dev);

> +               devid = (int)(uintptr_t)of_device_get_match_data(&client->dev);

This still leaves it OF-centric.
Better to use device_get_match_data().

Also, I'm thinking that following may help to clean a lot of the i2c
client drivers

static inline // perhaps no
const void *i2c_device_get_match_data(struct i2c_client *client, const
struct i2c_device_id *id)
{
  if (id)
    return (const void *)id->driver_data;
  return device_get_match_data(&client->dev);
}

-- 
With Best Regards,
Andy Shevchenko
