Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A642C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AE62239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/AmoBeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfGWQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:57:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43392 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbfGWQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:57:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so42572736qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bctZIRJmF0Tt66epBoIW8Nv3zbBghWNg0cSJA3lvz58=;
        b=m/AmoBeOCFr0QaZjltESdsZE4fOROqUL06GHXh0L+7fh+af27xkAW20v/yQphJ2PRI
         6VjowW5mw+hZQYU1tset+mrRNA/vq5KMxhiR3MJetGBuySXEu80cNuztkUafdZ1Fr5uI
         Ow1mCKVOl7XYDOObd5P0WXvNLA6IvVjUBX8vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bctZIRJmF0Tt66epBoIW8Nv3zbBghWNg0cSJA3lvz58=;
        b=JIezuTgbHmgmmZDdPiHQhLWB599o0lySt3+4Mw/jiZRYapr1+AOqLCSCdn/xN8z0LE
         CtOglGbir6BHPvnWlK2rHxuPNKQ1y1NNI2CXyKzBrOGUyazI7lcRGZSTDl3yKDCxTP+D
         N1K7WtlzpP6gzSfhIb/4NiQ8fwsm6QzhbRMZvyQdB3/HjZKMOmklNtfPBhY7zUsR2D8c
         +5LkQEp7THpsv8L/FB5+To48F5PDu3LV1s0gQQqg7Ira49V+PSY8ta6/0TZ1YLlVVROF
         apW8hb9WYFPLiXoMfetTx65a7GhF7Qgqp6aOVy7l2IDNQGKTjYdEJM3fOJXLpHOS5fHq
         NrkQ==
X-Gm-Message-State: APjAAAVcRDep81STVW8R66aJQtdP3LQNI68AT2Kvtux3ghvCCY6qaBjw
        dPTaio81jtga4f+HedN3a7r8kqAld5yhnFayx/cfnw==
X-Google-Smtp-Source: APXvYqx7dnBZ7AYtOXCbCEB1ql70DdqBWrp5Cp3QwgfTdYFMK1cTaFd7Gg8L91xqsBe3NjLBTDRcue8FC5XAS9tIjrM=
X-Received: by 2002:aed:3742:: with SMTP id i60mr53528186qtb.376.1563901026650;
 Tue, 23 Jul 2019 09:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190722182451.GB24412@kroah.com> <20190722223337.36199-1-ravisadineni@chromium.org>
 <CAJZ5v0ikknRGPg0fhPRB2oLxtC0kD=8DX=6Z9MgtAYTO+YZ3ng@mail.gmail.com>
In-Reply-To: <CAJZ5v0ikknRGPg0fhPRB2oLxtC0kD=8DX=6Z9MgtAYTO+YZ3ng@mail.gmail.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Tue, 23 Jul 2019 09:56:55 -0700
Message-ID: <CAEZbON5aC+iYzg58YH59rvfvcUYkjwQyjA9wAJstFEQvUei_-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] power: Refactor device level sysfs.
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Todd Broch <tbroch@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

https://patchwork.kernel.org/patch/11045069/ seems to create a virtual
device under wakeup class with the same name as the actual device. I
don't see a way to reliably map these virtual devices to the actual
device sysfs node. For example if we have to know if a particular
input device has triggered a wake event, we have to look for a virtual
device under /sys/class/wakeup with the same name. I am afraid that
depending just on the name might be too risky as there can be multiple
devices under different buses with the same name.  Am I missing
something?

Thanks,
Ravi

On Tue, Jul 23, 2019 at 12:44 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jul 23, 2019 at 12:33 AM Ravi Chandra Sadineni
> <ravisadineni@chromium.org> wrote:
> >
> > wakeup_abort_count and wakeup_count attributes print the
> > same (wakeup_count) variable. Thus this patchset removes the
> > duplicate wakeup_abort_count sysfs attribute. This patchset also
> > exposes event_count as a sysfs attribute.
> >
> > Ravi Chandra Sadineni (2):
> >   power: sysfs: Remove wakeup_abort_count attribute.
> >   power:sysfs: Expose device wakeup_event_count.
>
> I don't think you need this at all, because
> https://patchwork.kernel.org/patch/11045069/ is exposing what you need
> already.
>
> Thanks!
