Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A95C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4E821D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uss1/B4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392917AbfIYUL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:11:29 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:44926 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfIYUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:11:28 -0400
Received: by mail-lf1-f46.google.com with SMTP id q11so5175264lfc.11;
        Wed, 25 Sep 2019 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHcbuntDnsVUfFhGW0BGHBxzBHdnDjeNwAIplYLCMj8=;
        b=Uss1/B4KqOaSpr6tQBBN9sky6FM3tYRCnNj9bWQS+INaaGSFUR56mpbIV9kPbRtKEa
         HVaPOnrEnv+FhGW4tuZ0oL9ZkvI49KYNbpWcRR1Q6HCdjt5t+e7wo7mwCNvqQ+urNa4/
         3Xs4nYzRtcECBZLv3x43dVjXAfsc9ZFUpjsrNCWnqnA3NAtZuwh0AH2u/yH9jn2mejDj
         tcgbRJXWMU6dwoUgdpC5C9/UHoaYrcedM8Q/PVWfPZ08NwYIYrpqA2xVaYiZ7dytabZ8
         D4McVZRUaX5/xxVqYgyYuuxOvJiJBeTdQdjKGB/46Q1y/yF2YUd4/U+Nr5Q7OpbrtXgz
         9Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHcbuntDnsVUfFhGW0BGHBxzBHdnDjeNwAIplYLCMj8=;
        b=V3ZkwRMZztH5J87VAYXYZbeNkwl3trPgH7g0HgmbCGoaTg3gtELe89ag/g7FD9kso9
         tArApylNTriNW6MzHZneM7f019dInI8W2PN+kE8K1LM6I8av85UQrzL/WGKXzX7kvqaI
         jjRYBMo9h4jd8UtzBnrOHMJVEiw9LhLW1AF8bBoI/cE2STcazFWy3k0IorjBr42g5k5k
         vZiMHVbKRI73qMYXJq5/1QZrco+zUPM4d7aQfCPeFnhA/j009XFRD4Ajz35+9FaxqiJ1
         wgrp5TLJI2Pu4tByECY1OdqTrM9kPRrRExXKBpYvdqVVR0vUtaAPfeCQdYyqlzpKxCcU
         nOrA==
X-Gm-Message-State: APjAAAVsokjf6/U5BeNmh/W0N/fgow2AS3e2nqf+F9jR7QOEuWO6Dkux
        0w1E7El+M4dFjxSIK6n86h0+da+sZcXDstuGDA==
X-Google-Smtp-Source: APXvYqyUa5mOxCbWHyMUANxQpJWZJP05Ll7wzsQwf53oYLkkBF4IGhidOXK9OzhRS1TAAEqz+TI8qaFtvbKaGb42ako=
X-Received: by 2002:ac2:554e:: with SMTP id l14mr7688848lfk.32.1569442286852;
 Wed, 25 Sep 2019 13:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgjSes-4bSKbyfbNhXfcQwdEMzp8X4f72_SS=NpBoBtWmQ@mail.gmail.com>
 <20190925075026.GY3878@linux-l9pv.suse>
In-Reply-To: <20190925075026.GY3878@linux-l9pv.suse>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Wed, 25 Sep 2019 22:10:55 +0200
Message-ID: <CAEJqkgiZo6jyrpRnUYGUXY_hdtPQ1nmCXFkUQ0uyG4RKvV+W+w@mail.gmail.com>
Subject: Re: acer_wmi: Unknown function(s) on Acer Nitro 5 (AN515-43-R8BF)
To:     Joey Lee <JLee@suse.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 25. Sept. 2019 um 09:53 Uhr schrieb Joey Lee <JLee@suse.com>:
>
> Hi Gabriel,
>
> On Mon, Sep 23, 2019 at 09:45:05PM +0200, Gabriel C wrote:
> > Hi guys,
> >
> > I noticed some warning in dmesg on this Laptop.
> >
> > Fn+right, Fn+left is BrightnessDown/Up and produce the following warning:
> >
> > acer_wmi: Unknown function number - 4 - 0
> >
> > The brightness has some other issue on this Laptop but not sure
> > who to blame on this. Probably amdgpu.?
> >
> > /sys/class/backlight/amdgpu_bl1/brightness <-> actual_brightness
> > seems to mismatch.  EG: when brightness is 0 actual_brightness is still 5140.
> >
>
> Base on _BCM and _BQC in your DSDT. The backlight control is handled by EC.
> But, in some Acer machines that the _BCM is broken. You can try to modify
> brighess by echo to sys/class/backlight/acpi_video0/brightness

Unfortunately, the only thing in /sys/class/backlight is amdgpu_bl1.
Basically I should have 2 , acpi_video0 & acpi_video1 however none there.

>
> > Unplugging the AC gives the following warning:
> >
> > acer_wmi: Unknown function number - 8 - 0
> >
> > When plugging the AC back I see;
> >
> > acer_wmi: Unknown function number - 8 - 1.
> >
> > I uploaded a dump of the acpi tables and dmidecode of the box.
> >
> > https://www.frugalware.org/~crazy/nitro5/ACPI
> > https://www.frugalware.org/~crazy/nitro5/DMI
> >
> > Please let me know if you need any other informations.
> >
>
> Thanks for your report the behavior for the function 4 and function 8.
> Maybe we can use the platform event to do something. e.g. expose key code
> to userland. Unfortunately my working list is too long that I do not have
> time for it currently.
>

Is fine, no worry. Take your time. Things are working more or less so no rush.

Just one thing. While it is fine to report the Unknow functions/keys by default
once reported upstream the user may want to silence these until implemented.
In my case using the keys for the brightness floods the dmesg with
these messages.

Would be  maybe is possible to have some 'do_not_bug_me' module
parameter to silence the
Unknow functions/keys messages?

> Thanks a lot!
> Joey Lee

BR,

Gabriel C
