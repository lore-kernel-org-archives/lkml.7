Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3F7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678B520748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWRY1ezw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfKYSG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:06:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45735 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbfKYSG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:06:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id b5so13560947eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTWwAKuUWg6UTMneoPZbAREPm14DI1ekGnAm26buzY4=;
        b=bWRY1ezwpLymA3aar8+vP8SxFUOc8S0tO/Kjgt5KgdQEJkpCltoXTQELabIwT9rEqv
         31RQnGq0zKY1Vf3zn9YliA+PtZ2tM9ePuU9el2Mq4D3Dx628BY+TEP6Z+JJjoV6S6Hcu
         RatAxqGLf2b/6L8ayW+1UzV37ZjRpVdFyItvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTWwAKuUWg6UTMneoPZbAREPm14DI1ekGnAm26buzY4=;
        b=flJRXqDAfypFdHBQsJQ4ZoeLzZ4tcUU1F5xJSrqXn6sh3mVeyfi5m2DgHMh88RVPM/
         LmEngl24XiU9StRJ70AgadJH7/9AJvsOQ32HwBz8sNtdTEYXoKv2NjvU72jZ9Abz00CV
         lQ3BxtdxAiOyAIpeM3lgn5A1xJXotaYWcOKPw9lnPFbP06vLegjKD2ULIN5W+Op0r9iQ
         SyjupW0tF12oR61PI6YZ1SGPIC1mdFPx+Rs2Jvtd2rM9mIsn1V1BAZm6iadZQxdQDUaa
         NKDbhTmsG/zqNkj4kwXFALfcb7sKeG/xA8DkC99P65cFALlvdTx9b9WSY4fk7c8635mR
         4TJg==
X-Gm-Message-State: APjAAAXmR4XdjWp1LILGbI1MdEQOjL029S2sClMdUC104Khz4FLBlyyB
        cr5dI0hMxDcb1RH8LJUWZQxCIZFhRrI=
X-Google-Smtp-Source: APXvYqyLsgi+WpPXQJcSgXfUo6JviPCAkQrxIFznyLDpAPlt4HiowCE/yOoLUTk0ffmxse8pVX3/Gg==
X-Received: by 2002:a17:906:b819:: with SMTP id dv25mr20464467ejb.182.1574705186024;
        Mon, 25 Nov 2019 10:06:26 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id s14sm308220edw.50.2019.11.25.10.05.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 10:06:16 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id b11so268102wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:05:55 -0800 (PST)
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr114777wmi.69.1574705152759;
 Mon, 25 Nov 2019 10:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.1.Iae79baaa31014e8b1d8177bcfbcd41514af724f9@changeid>
 <2dcedacb-8d08-6a58-23af-e834ef9e80fd@collabora.com>
In-Reply-To: <2dcedacb-8d08-6a58-23af-e834ef9e80fd@collabora.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 25 Nov 2019 11:05:41 -0700
X-Gmail-Original-Message-ID: <CAHQZ30AXvNbT54LsYtF=W_xgnY35QByzGYbjaY0xc92O6h+SRA@mail.gmail.com>
Message-ID: <CAHQZ30AXvNbT54LsYtF=W_xgnY35QByzGYbjaY0xc92O6h+SRA@mail.gmail.com>
Subject: Re: [PATCH 1/4] i2c: i2c-cros-ec-tunnel: Pass ACPI node to i2c adapter
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 9:06 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 21/11/19 22:10, Raul E Rangel wrote:
> > The I2C bus needs to share the same ACPI node as the tunnel device so
> > that the I2C bus can be referenced from ACPI.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>
> Hmm, isn't this change the same as https://lkml.org/lkml/2019/11/21/208 ?
>
We both found the same problem. I wasn't sure if it would be better to
include it as part of this patch set since it was required for the MFD
patch, or to reference it. Let's just take Akshu's patch and ignore
this one.
