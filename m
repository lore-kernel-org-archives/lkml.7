Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A44FECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D299421D80
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gR2NJ1g0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfJIVT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:19:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36500 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfJIVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:19:29 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so8715611iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEvMf+0kr2/VtI7iR8vJad63M42yhFV0Lj4bFqwB+U8=;
        b=gR2NJ1g0seeDBWLfQzU17h5OCt5i8vfnZuYN9HUzSU6DKZRuB20ul/IdUfUw78OUpx
         n6FN40EHj5ynUBThXPa0SQivE454fmBvG6Gsj7Z25mhy8BCkEgAP8BhqVhD+BKKadhYz
         xsLdjWmAkgCxie2voD4ABfh28sQCHon/638Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEvMf+0kr2/VtI7iR8vJad63M42yhFV0Lj4bFqwB+U8=;
        b=ZM+lBwAtkT5yvPhYktUkdTfCO0u7OsUGN8Mjx9QqNXV66vwRTqTplYvwSqpEH7csFn
         Ebm0nKAqrb8BdOZzKGFHI4GUWPWyKA9VYfNbviBfG2ho2fseOb3NuSDVe6l3l5ZD8jXT
         2wjeL5AmTw79PSnL06urwvB34KKLiKrI3LXkJnUUFdu/8PqW1s5uyvtGLGISNcygcPbZ
         BxMGn6VH55ytzbp613GSm/oAB9sbiIdl/4etvsbGCcEHqqBDTkKfVPIVWTkGlgSp5jgj
         ZgkT0ogVQTlxOqKpvXkawbCU8i8KyYTzo6nW4cDeD2hidCkwUjbFglqZP6lUaF2N0WCY
         hPLQ==
X-Gm-Message-State: APjAAAWcGD9fNpnCVLYiARtCDKsT2rtpMLrflRaGK1n+AMeH/hAmssko
        q9x2j9FjCzmsTuA6/6wIhCBZ7N0yDgRSr2oQUXApbQ==
X-Google-Smtp-Source: APXvYqyitaxgWG/aTAXjYNlE4Tnqpxaj6ZObio/L+bScivdIkv+8t37EFBnbH7eX6Vcl0ai6QXKYdfVz7E0q1pt1ZZQ=
X-Received: by 2002:a6b:ee18:: with SMTP id i24mr5938245ioh.163.1570655966954;
 Wed, 09 Oct 2019 14:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191008115342.28483-1-patrick.rudolph@9elements.com>
 <20191008115342.28483-2-patrick.rudolph@9elements.com> <5d9d120b.1c69fb81.b6201.1477@mx.google.com>
In-Reply-To: <5d9d120b.1c69fb81.b6201.1477@mx.google.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 9 Oct 2019 14:19:15 -0700
Message-ID: <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Filipe Brandenburger <filbranden@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Somehow we've gotten /sys/firmware/log to be the coreboot log, and quite
> frankly that blows my mind that this path was accepted upstream.
> Userspace has to know it's running on coreboot firmware to know that
> /sys/firmware/log is actually the coreboot log.

Not really sure I understand your concern here? That's the generic
node for the log from the mainboard firmware, whatever it is. It was
originally added for non-coreboot firmware and that use is still
supported. If some other non-coreboot firmware wants to join in, it's
welcome to do so -- the interface is separated out enough to make it
easy to add more backends.

I do agree that if we want to add other, more coreboot-specific nodes,
they should be explicitly namespaced.

> But I also wonder why this is being exposed by the kernel at all?

I share Stephen's concern that I'm not sure this belongs in the kernel
at all. There are existing ways for userspace to access this
information like the cbmem utility does... if you want it accessible
from fwupd, it could chain-call into cbmem or we could factor that
functionality out into a library. If you want to get away from using
/dev/mem for this, we could maybe add a driver that exports CBMEM or
coreboot table areas via sysfs... but then I think that should be a
generic driver which makes them all accessible in one go, rather than
having to add yet another driver whenever someone needs to parse
another coreboot table blob for some reason. We could design an
interface like /sys/firmware/coreboot/table/<tag> where every entry in
the table gets exported as a binary file.

I think a specific sysfs driver only makes sense for things that are
human readable and that you'd actually expect a human to want to go
read directly, like the log. Maybe exporting FMAP entries one by one
like Stephen suggests could be such a case, but I doubt that there's a
common enough need for that since there are plenty of existing ways to
show FMAP entries from userspace (and if there was a generic interface
like /sys/firmware/coreboot/table/37 to access it, we could just add a
new flag to the dump_fmap utility to read it from there).
