Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1543C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864322085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566201556;
	bh=XPrMmamMwIL21GA2ba4GQaEgUzj8AlEBglz3YOl3+ek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QiZ9yEzyfec0byEzT+/TqRcN7B8UW085gRhyhtImigBH/kuwNiqknr67LKvlJmlTP
	 ngFDGUQa6GrMoPAAG3PRtFHO+Vwuve2KiTKsHMwZEPsONh05nzjRKe1wGXiChMNyl/
	 qy0mMqqrNl/BcsR+KHusAEI/AtqA1glws8E5yN2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfHSH7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:59:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35980 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfHSH7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:59:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id c15so645914oic.3;
        Mon, 19 Aug 2019 00:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUSptt+CdgIB8+WPNPFqtbQpxW0z2SyMLqmPWc3Ld64=;
        b=j6nxumxAM9QVr1gFpXym+QDnOnewWmPCSmOdKJ2Z+UgqPdWMeCJ/aI1fkCgUdC0S2D
         EMiOB/u5QAWDwW+M/ebWTz5YD9aEWj5aPGJPH1eDnlc8WRrBysqbuiPiDjzQRntqGArd
         f4ffl4xnYsjA4UbOUFCmnj3BnrhRkYlpx5vyX6EhIEDFae6/VlABuwgIdZ/vdO4SSsh/
         3ZtUlKbK3a0jUz7enR5Usg1Xzhqk+LlxzK57LGan/0DfygnZwcWnEXgc64LpdjDMlfeZ
         iGhb01mPJ4QJMZGJ17dBVOSVAMJblSRrqh4a5BFazpVIqQ7i5C5/m4gPjsy6rCWWp0YH
         XEXw==
X-Gm-Message-State: APjAAAV/BWlr6wLMWgmQLJoZLulo8rSXHqQY/MI6sEllLQBd/Eo/Gteu
        0Qis2z+fxglEqfcYpzjWGxBvMqzkZ0gHs/416SQ=
X-Google-Smtp-Source: APXvYqy+Ohktf48Hgjc+LqovwWi+gDS9TCKQtL4iy1RpfaZLEyRA4hxtvvIrUaK4fP8JnnoOaCX/TAG+3uU0irs2xx4=
X-Received: by 2002:aca:ab56:: with SMTP id u83mr13102034oie.57.1566201554075;
 Mon, 19 Aug 2019 00:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <5997740.FPbUVk04hV@kreacher> <800186a2-e912-3498-f08b-47469bbe8b0d@klausen.dk>
In-Reply-To: <800186a2-e912-3498-f08b-47469bbe8b0d@klausen.dk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Aug 2019 09:59:02 +0200
Message-ID: <CAJZ5v0hfMS6aJP9G=dhZZ+3WTzM8=DzQkdJ7s9W3m5m9Dat5=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] PM / ACPI: sleep: Additional changes related to suspend-to-idle
To:     Kristian Klausen <kristian@klausen.dk>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:26 PM Kristian Klausen <kristian@klausen.dk> wrote:
>
> On 02.08.2019 12.33, Rafael J. Wysocki wrote:
> > Hi All,
> >
> >>> On top of the "Simplify the suspend-to-idle control flow" patch series
> >>> posted previously:
> >>>
> >>> https://lore.kernel.org/lkml/71085220.z6FKkvYQPX@kreacher/
> >>>
> >>> sanitize the suspend-to-idle flow even further.
> >>>
> >>> First off, decouple EC wakeup from the LPS0 _DSM processing (patch 1).
> >>>
> >>> Next, reorder the code to invoke LPS0 _DSM Functions 5 and 6 in the
> >>> specification-compliant order with respect to suspending and resuming
> >>> devices (patch 2).
> >>>
> >>> Finally, rearrange lps0_device_attach() (patch 3) and add a command line
> >>> switch to prevent the LPS0 _DSM from being used.
> >> The v2 is because I found a (minor) bug in patch 1, decided to use a module
> >> parameter instead of a kernel command line option in patch 4.  Also, there
> >> are 4 new patches:
> >>
> >> Patch 5: Switch the EC over to polling during "noirq" suspend and back
> >> during "noirq" resume.
> >>
> >> Patch 6: Eliminate acpi_sleep_no_ec_events().
> >>
> >> Patch 7: Consolidate some EC code depending on PM_SLEEP.
> >>
> >> Patch 8: Add EC GPE dispatching debug message.
> > The v3 is just a rearranged v2 so as to move the post sensitive patch (previous patch 2)
> > to the end of the series.   [After applying the full series the code is the same as before.]
> >
> > For easier testing, the series (along with some previous patches depended on by it)
> > is available in the pm-s2idle-testing branch of the linux-pm.git tree at kernel.org:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-s2idle-testing
> It was just testing this patch series(461fc1caed55), to see if it would
> fix my charging issue
> (https://bugzilla.kernel.org/show_bug.cgi?id=201307), which it didn't.

It is unlikely to help in that case.

> I did however notice that my laptop (ASUS Zenbook UX430UNR/i7-8550U)
> won't wake when opening the lid or pressing a key, the only way to wake
> the laptop is pressing the power button.
>
> I also tested mainline (5.3.0-rc4 b7e7c85dc7b0) and 5.2.8 and the laptop
> wakes without issue when the lid is opened or a key is presed.
> > Please refer to the changelogs for details.

Thanks for your report.

I seem to see a similar issue with respect to the lid on one of my
test machines, looking into it right now.
