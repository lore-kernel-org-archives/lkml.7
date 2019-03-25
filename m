Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC5EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F32520830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQ3+xwbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfCYSal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:30:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40294 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbfCYSal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:30:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so8795430ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibmine5CoYu+qwC4nsM/es1TEToU8N581offEqa03Jg=;
        b=LQ3+xwbVq0zaFEK2XfsapsupqeUvol/qn0i1bJhdWYbQh20ZA34zMArXfEXwDT8Dil
         GR+jse4z+rLNFNXTSKDQDAhHY1PzNujlhn39b9q0Mhm4i2iBV6sR6HHQ4dJ6Jez9LHNM
         kx1Hnkr2USGwkqddJnHNB/5DoxohADfmwimcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibmine5CoYu+qwC4nsM/es1TEToU8N581offEqa03Jg=;
        b=T1yXoY3AnqmmnNDpIdGJ2iYgKPHJXPANGjQBPPCf4GBqPb2hJHRXhYHt0Pqv/jhSSp
         O1e5ZZYY5cvfKMsExKK2b51KMn/ivWYpLW+/IfvvjXiCRmjkxzRvlPO02GCFhhOmZRcz
         CnBres29zuDRGZdVTcB9YTeYdRAgIuv9xkCDIya8ZU4dZza0TRi78jOgt6KUIPdeNaDU
         j96KLcR8K62xD5thVcR+0OVWYYWxTdhVXWi1X8C12OK2Rf1zsgQUWuwgutnTveHAzi2K
         4Iaw/eLLIWJI/p9c1eJAOIPFV8iC9LOENc+5LSKoKs/+HxdmRJnGEeBsGg1dZE7OGPO4
         OzjQ==
X-Gm-Message-State: APjAAAUHO1IAprCGa58wj16anZWru9B449Lr+mpF0dTyZVNfhy0vMiQ+
        t0vy5KyH7Co0cJsicXfwELdZv967D10=
X-Google-Smtp-Source: APXvYqzFoEkgOwT8KqLg+0DpxJinSQxmpJraq8SL4/W10LcxwN3MBLLVQRF9aQ5ZkCr2SjYAASKseA==
X-Received: by 2002:a2e:6e14:: with SMTP id j20mr3474867ljc.172.1553538639026;
        Mon, 25 Mar 2019 11:30:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id w22sm1633353ljd.42.2019.03.25.11.30.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:30:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u68so6750815lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:30:35 -0700 (PDT)
X-Received: by 2002:a19:9794:: with SMTP id z142mr13924225lfd.46.1553538635692;
 Mon, 25 Mar 2019 11:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
 <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com> <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
 <Laq4ykv--3-1@tutanota.com>
In-Reply-To: <Laq4ykv--3-1@tutanota.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Mon, 25 Mar 2019 11:30:24 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ9iqOW6zrR8p3knhiPwf6YcdLXd5v=F28shNZwaXVfPZQ@mail.gmail.com>
Message-ID: <CAE_wzQ9iqOW6zrR8p3knhiPwf6YcdLXd5v=F28shNZwaXVfPZQ@mail.gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     hotwater438@tutanota.com
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Vladislav Dalechyn <vlad.dalechin@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Swboyd <swboyd@chromium.org>, Bigeasy <bigeasy@linutronix.de>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:23 AM <hotwater438@tutanota.com> wrote:
>
> Hi.
>
> Mar 25, 2019, 6:56 PM by dtor@chromium.org:
>
> If you want to keep on using edge you need to make sure that i2c-hid
> never loses edge, as replaying of previously disabled interrupts in
> not at all reliable. So you need to "kick" the device after
> enable_irq() by initiating read from it and be ready to not get any
> data or get valid data and process accordingly.
>
> I'm sorry, but how edge can be loosed? There is device ID and quirk's which are associated with that ID, and quirk will always trigger edge irq.

If edge arrives while interrupt is disabled and replay of the
interrupt does not work when it is reenabled (and I do not think it
ever works for GPIO, you can hunt for Thomas Gleixner emails to that
effect on LKML), then ISR in the driver will never be called, so
driver will never read from the device to reset the interrupt
condition and interrupt will never be reasserted again -> edge lost.

Thanks.

-- 
Dmitry
