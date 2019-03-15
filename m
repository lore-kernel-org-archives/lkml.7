Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22119C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC8A218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Ez6aOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfCONBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:01:32 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50611 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfCONBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:01:32 -0400
Received: by mail-wm1-f49.google.com with SMTP id x7so6436088wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=kVWux8sJUWjRuF5YPrNItUBODrbpzPljVS14p+7m8no=;
        b=D6Ez6aOFN2Hd6fSRdkgprENoeF98Gd6Bux6MrUrYjsQ7oeW1jSAHEkWo42f9mbJW2W
         EUTBoyR+iI/2poef59P5FU8uP5E14OBByf/fR6+wBxpt91fUYvC9isCD/wRsTO49ek5G
         s9uTWogqzS3KxQngM84twGE4lcK0Bgd6wdndeYU4jTQR5beSh3MfJYNBqaGa8jGy8rwC
         5fp4gGqqpHnwgUwnE3BtQFSBaOj2FHh5NMGYjGx+gi3ONLYKpRksrX5Rrg83kvHnZ9+s
         Gv8Khau8pExgOi/AAvgbqEW19V4MTWzyMwGMUJk+yMo4IZDnI7zE6xlN1+MK2A1/YDM8
         QLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=kVWux8sJUWjRuF5YPrNItUBODrbpzPljVS14p+7m8no=;
        b=bW+yliMwOmvVy3WQh0AaCNJKXnAjOrt5BkosR++oAHQjD6NnMS65hJAB4aqdTq+7b+
         H12NtoI6C9f3rEMDWTbbKNpqrKQ0qLzrg0VALJAnaopr/G75mTYMcgqRQGcard3vnzst
         6FJPr7nUXbumcPF9qTefK5SkwwcMj+6XAWyWv+dyvmzsM9nNkJtX9XPfnN9W0DwKvZaO
         r6Y2pq973aR7GwBwUhELcUfPwINkRx3ZySJQr4bBoVJiE4DBwyJptSktHtz9e6Wg/Cna
         eSFPaJP3JpzDx6/BWaxAxdt9RyqLrsAFLO4sxcHB9wU+ZWSbRi4riBlqO55GqCkTmMfr
         fl3Q==
X-Gm-Message-State: APjAAAWysXS4fPL2vlOerTma4bFqO3O47qTG8KQnwP7iHKv4Lle0z7w2
        JzrewrExj5zlw6lKkEtWVYA=
X-Google-Smtp-Source: APXvYqwhu2+qcNM8hZlABOfr2Dwuxp8F3MvmIc2D0b42AzDJJ6hBgA/i+E0gf6K8/BhblugXme1cXg==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr2148556wmj.150.1552654889818;
        Fri, 15 Mar 2019 06:01:29 -0700 (PDT)
Received: from narunkot ([94.11.212.65])
        by smtp.gmail.com with ESMTPSA id 132sm2780716wmd.30.2019.03.15.06.01.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 06:01:29 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:01:27 +0000
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
Cc:     "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
        "William Hubbs" <w.d.hubbs@gmail.com>,
        "Christopher Brannon" <chris@the-brannons.com>,
        "Kirk Reiser" <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Staging status of speakup
Message-ID: <20190315130035.6a8f16e9@narunkot>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have made progress on the items in TODO file of speakup driver in
staging directory and wanted to get some clarity on the remaining
items. Below is a summary of status of each item along with the quotes
from TODO file.

1. "The first issue has to do with the way speakup communicates
with serial ports.  Currently, we communicate directly with the hardware
ports. This however conflicts with the standard serial port drivers,
which poses various problems. This is also not working for modern
hardware such as PCI-based serial ports.  Also, there is not a way we
can communicate with USB devices.  The current serial port handling
code is in serialio.c in this directory."

Drivers for all external synths now use TTY to communcate with the
devices. Only ones still using direct communication with hardware ports
are internal synths: acntpc, decpc, dtlk and keypc. These are typically
ISA cards and generally hardware which is difficult to make work. We
can leave these in staging.

2. "Some places are currently using in_atomic() because speakup
functions are called in various contexts, and a couple of things can't
happen in these cases. Pushing work to some worker thread would
probably help, as was already done for the serial port driving part."

There aren't any uses of in_atomic anymore. Commit d7500135802c
"Staging: speakup: Move pasting into a work item" was the last one that
removed such uses.

3. "There is a duplication of the selection functions in selections.c.
These functions should get exported from drivers/char/selection.c
(clear_selection notably) and used from there instead."

This is yet to be done. I guess drivers/char/selection.c is now under
drivers/tty/vt/selection.c.

4. "The kobjects may have to move to a more proper place in /sys.The
discussion on lkml resulted to putting speech synthesizers in the
"speech" class, and the speakup screen reader itself
into /sys/class/vtconsole/vtcon0/speakup, the nasty path being handled
by userland tools."

Although this makes logical sense, the change will mean changing
interface with userspace and hence the user space tools. I tried to
search the lkml discussion but couldn't find it. It will be good to
know your thoughts on this.

Finally there is an issue where text in output buffer sometimes gets
garbled on SMP systems, but we can continue working on it after the
driver is moved out of staging, if that's okay. Basically we need a
reproducer of this issue.

In addition to above, there are likely code style issues which will
need to be fixed.

We are very keen to get speakup out of staging both, for settling the
driver but also for getting included in distros which build only the
mainline drivers.

Thank you,
Okash
