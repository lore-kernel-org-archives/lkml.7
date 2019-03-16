Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B41C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDE82077B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlxjA1n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfCPKJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 06:09:15 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41700 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfCPKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 06:09:14 -0400
Received: by mail-wr1-f51.google.com with SMTP id p1so12007515wrs.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPsDvrDtu4szncseR5DAGowpci3NsvWp3U5rIhy1hNM=;
        b=NlxjA1n9zcFnidE3ROn6B/y5ym57kKQ0w3zkeaHW+4Vi3GONXr297asv0D9yI+Q9HG
         zrdc6DU+rC2bdhw3BrZ5ViJ0/XYJ4lbbXxUPwnOc/7wexYqRAlktyI6XmgOjwDIDB5bP
         DtPAqJK2OwexzY6lgEN/IlViepZEYJy0zlyQngp2Z2M/vd7J/02b7drJ/f4y2vAu+Jan
         nj1EQJKnD+VnkSmU3GS/SfhGMxqZey60UuqF6J9ZzBExivFJHi26ti7FXBlM6YMwL+7r
         i9C7fLzrrtzv2vyGSGE5QPT36rgdstB7vVrtso6R4xlsV//7fuy0oGMbQd4AUgTm7EbQ
         Q8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPsDvrDtu4szncseR5DAGowpci3NsvWp3U5rIhy1hNM=;
        b=DuXKiLSkUAZrcO0JnDT4Olx2qQ2B//xZnpn4rCAEr1aWjxMiFrmKV8yOAmwhKw/Pbx
         OIykVIH5E6jH7VTeYn5nYZQxGvd+MdL97p7dueWK++rqiRZ6nxKRNHFkHG2xEgGW2Jnr
         8c8DiWAjzUzNO2vFHVeUqTqRG5vV3vI/rZfiPC+ZaNiehvbWBLZnQNoMIW0hAQEs1s++
         98CrNYkrvqCogXngjCVnh5gEzeFAvbnasR9igsbh8L8FIZH7+nRkM+ObINpqNuEmHBDR
         pueoWWtRUbWmslhf6NYlAoAfT+OIa+j92i+//32iOdxlCh94zjg3u675XETV3hvNq5oh
         7u/w==
X-Gm-Message-State: APjAAAXa9hmaaHLi8RsCTd2PXthZBq+eUN6WDI7nDvvNQi0NlAeX5CUE
        tIOlawfw4sosraSLKA+zBKpNvUpYuQc=
X-Google-Smtp-Source: APXvYqzai81I5CX/es7/pU1k7x9ktT+32f7icxnbNURtQCG2mFRlL7WP4f144Gxyj3Dlz0svdaQbCA==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr4512748wrq.266.1552730952935;
        Sat, 16 Mar 2019 03:09:12 -0700 (PDT)
Received: from narunkot ([94.11.212.65])
        by smtp.gmail.com with ESMTPSA id z12sm6143030wmf.31.2019.03.16.03.09.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 03:09:12 -0700 (PDT)
Date:   Sat, 16 Mar 2019 10:09:10 +0000
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
Message-ID: <20190316100910.2c467960@narunkot>
In-Reply-To: <20190316031831.GA2499@kroah.com>
References: <20190315130035.6a8f16e9@narunkot>
        <20190316031831.GA2499@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 20:18:31 -0700
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 15, 2019 at 01:01:27PM +0000, Okash Khawaja wrote:
> > Hi,
> > 
> > We have made progress on the items in TODO file of speakup driver in
> > staging directory and wanted to get some clarity on the remaining
> > items. Below is a summary of status of each item along with the
> > quotes from TODO file.
> > 
> > 1. "The first issue has to do with the way speakup communicates
> > with serial ports.  Currently, we communicate directly with the
> > hardware ports. This however conflicts with the standard serial
> > port drivers, which poses various problems. This is also not
> > working for modern hardware such as PCI-based serial ports.  Also,
> > there is not a way we can communicate with USB devices.  The
> > current serial port handling code is in serialio.c in this
> > directory."
> > 
> > Drivers for all external synths now use TTY to communcate with the
> > devices. Only ones still using direct communication with hardware
> > ports are internal synths: acntpc, decpc, dtlk and keypc. These are
> > typically ISA cards and generally hardware which is difficult to
> > make work. We can leave these in staging.  
> 
> Ok, that's fine.
> 
> > 2. "Some places are currently using in_atomic() because speakup
> > functions are called in various contexts, and a couple of things
> > can't happen in these cases. Pushing work to some worker thread
> > would probably help, as was already done for the serial port
> > driving part."
> > 
> > There aren't any uses of in_atomic anymore. Commit d7500135802c
> > "Staging: speakup: Move pasting into a work item" was the last one
> > that removed such uses.  
> 
> Great, let's remove that todo item then.
> 
> > 3. "There is a duplication of the selection functions in
> > selections.c. These functions should get exported from
> > drivers/char/selection.c (clear_selection notably) and used from
> > there instead."
> > 
> > This is yet to be done. I guess drivers/char/selection.c is now
> > under drivers/tty/vt/selection.c.  
> 
> Yes, someone should update the todo item :)
> 
> > 4. "The kobjects may have to move to a more proper place in /sys.The
> > discussion on lkml resulted to putting speech synthesizers in the
> > "speech" class, and the speakup screen reader itself
> > into /sys/class/vtconsole/vtcon0/speakup, the nasty path being
> > handled by userland tools."
> > 
> > Although this makes logical sense, the change will mean changing
> > interface with userspace and hence the user space tools. I tried to
> > search the lkml discussion but couldn't find it. It will be good to
> > know your thoughts on this.  
> 
> I don't remember, sorry.  I can review the kobject/sysfs usage if you
> think it is "good enough" now and see if I find anything
> objectionable.
> 
> > Finally there is an issue where text in output buffer sometimes gets
> > garbled on SMP systems, but we can continue working on it after the
> > driver is moved out of staging, if that's okay. Basically we need a
> > reproducer of this issue.
> > 
> > In addition to above, there are likely code style issues which will
> > need to be fixed.
> > 
> > We are very keen to get speakup out of staging both, for settling
> > the driver but also for getting included in distros which build
> > only the mainline drivers.  
> 
> That's great, I am glad to see this happen.  How about work on the
> selection thing and then I can review the kobject stuff in a few
> weeks, and then we can start moving things for 5.2?

Perfect. I'll start looking into selection refactor now.

Thanks very much!

Okash
