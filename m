Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF84020863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LqjRIelk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfCYQ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:56:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41591 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfCYQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:56:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id 10so6537259lfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SV+Wi/wugJg9W8EtYqN5uMtHVktIBc2I+s0E8W3K8TY=;
        b=LqjRIelkpS+3gGvqhVpKsfiI4ypcklesl/TkYrsu03ZozpG0sv8ArTsUkiUvja9r9N
         zAd4cuie4IqTCYkHu1bSpcdaKbtn2PiO3EhDyKDjVtU848KfB6Gebcy8S8PlyNYNhLfz
         HOv778+4zd0qJ++FvYEHSY3EYm013aqtF2kw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SV+Wi/wugJg9W8EtYqN5uMtHVktIBc2I+s0E8W3K8TY=;
        b=JO1JcOk4QyHY9YlMxrZ7VUVvGgzLv5B2+09lA/hukHsi1n9laDWqpbcBikqDDlLVSV
         hAUkDlkT2JXRik+QExNovjTZYfbjAlEhVrrpuiLaVAvDaW0fYRuAneDR5/JND4BRgN5l
         KAYIGb7gM208txRI72kwASwtKZB7/F8WcnFIzB0qXD/YkaZ4l6M3aHwSdYj46Y7etyHu
         ht14iz8mFDXae1+gBZc0HvBULPFqLSvi0GfZ4+kjh7qA5z3CNfHvonUT00iBK1fSoMIM
         liiOdh46VB7KHDrKxna5BME3yDuE8DxB9FMwIERzVWaHiV/lO4sYXyvI7AG5Gi/7qFrV
         p45w==
X-Gm-Message-State: APjAAAWqc9AKzm6GjLCfBSzEabIXkpa9+8Zbs6Irb0updG5WDqNafgl+
        8I+GvM+LSUureyYf+uJLUf7IOWg8Fg4=
X-Google-Smtp-Source: APXvYqy25/K/qQoEJJ1jAHxJneQUb7mDT/iE1T2kauUHalOlfFud05fxyReUKg/jpfp3R2LRzQV7LA==
X-Received: by 2002:ac2:51aa:: with SMTP id f10mr12687648lfk.82.1553532996210;
        Mon, 25 Mar 2019 09:56:36 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s67sm3439610lja.57.2019.03.25.09.56.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:56:33 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k8so8497672lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:56:32 -0700 (PDT)
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr561045ljk.12.1553532992388;
 Mon, 25 Mar 2019 09:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com> <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
In-Reply-To: <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Mon, 25 Mar 2019 09:56:21 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
Message-ID: <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Vladislav Dalechyn <vlad.dalechin@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, kai.heng.feng@canonical.com,
        swboyd@chromium.org, bigeasy@linutronix.de,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, hotwater438@tutanota.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Mar 25, 2019 at 9:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Dmitry,
>
> On 25-03-19 17:02, Dmitry Torokhov wrote:
> > Hi Vladislav,
> >
> > On Mon, Mar 25, 2019 at 5:57 AM Vladislav Dalechyn
> > <vlad.dalechin@gmail.com> wrote:
> >>
> >> From: Vladislav Dalechyn <hotwater438@tutanota.com>
> >>
> >> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
> >> caused by an error setting the correct IRQ_TRIGGER flag:
> >> - i2c_hid incoplete error flood in journalctl;
> >> - Five finger tap kill's module so you have to restart it;
> >> - Two finger scoll is working incorrect and sometimes even when you
> >> raised one of two finger still thinks that you are scrolling.
> >>
> >> Fix all of these with a new quirk that corrects the trigger flag
> >> announced by the ACPI tables. (edge-falling).
> >
> > I do not believe this is right solution. The driver makes liberal use
> > of disable_irq() and enable_irq() which may lead to lost edges and
> > touchpad stopping working altogether.
> >
> > Usually the "extra" report is caused by GPIO controller clearing
> > interrupt condition at the wrong time (too early), or in unsafe or
> > racy fashion. You need to look there instead of adding quirk to
> > i2c-hid.
>
> The falling-edge solution was proposed by Elan themselves.
>
> Also if you look at: https://bugzilla.redhat.com/show_bug.cgi?id=1543769
>
> And esp. the "cat /proc/interrupts" output there, then you will see
> that the interrupt seems to be stuck at low level, which according
> to the ACPI tables is its active level.

So how does it generate a new edge if it is stuck at low?

Is it bad touchpad firmware that does not deassert interrupt quickly
enough? I scrolled through the bug but I do not see if it had been
confirmed that original windows installation actually uses edge (it
may very well be using it; Elan engineers pushed us to use edge in a
few cases, but they all boiled down to an issue with pin control/GPIO
implementation).

>
> As for this being a GPIO chip driver problem, this is using standard
> Intel pinctrl stuff, which is not showing this same issue with many
> other i2c-hid touchpads.

Well, there have been plenty of issues in intel drivers, coupled with
"interesting" things done by firmware and boards.

If you want to keep on using edge you need to make sure that i2c-hid
never loses edge, as replaying of previously disabled interrupts in
not at all reliable. So you need to "kick" the device after
enable_irq() by initiating read from it and be ready to not get any
data or get valid data and process accordingly.

Thanks.

-- 
Dmitry
