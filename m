Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E5AC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348B20640
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S36XUueM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfLBRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:42:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40658 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLBRmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:42:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so218049oto.7;
        Mon, 02 Dec 2019 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FDdAMESNSoKcPbZCONgmhHM5q18f0AUazkRyJbkynJw=;
        b=S36XUueMsNHhfRPBF7vD65ggq6JRIGwXgFIsXmW57acexl6IZVMwyVoAMtqg9ZJJVq
         pr/YCVxgWmFH3Afd0cWbL7tmRkTX8xPww2SiYbPnmdNBEkGhdLvZwXqm6ffyXAbaMR8j
         fxPWQ2/bg8rMEJ0TxxyeJFHfW39iGtubRyvMv5T1EbCDAewLkllA2q0JFSiIxRT54eIX
         9dFTACALuBJwSU+/0E3UcGs659zRdzrWtpp0oI1C787LfZwKo4GXooowYhPYDYf6hZQJ
         KKPJrcumgXp4g9QgIGOCwmgKdNcbbvpztlUqa8GbpuUow9gWu/bDB1HeU6HkXjWZtmH6
         4GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FDdAMESNSoKcPbZCONgmhHM5q18f0AUazkRyJbkynJw=;
        b=LHHN/SrTor2ZEu7qheGrUjuW7rDFoH2Wsm9LoD0EXKUXYhLESdzP8ELNqeY+44sIYY
         L9ch40F7TAWB+SJvzf+7uztRcxvY3xtVWnfAPWzp9VHNDU2I6zdrfwmtiwRsUz8Xfko6
         kJ972Tp7Cjb+0PPE/2xHUoYxmPF2QuojIsBA/2okf4aNs71AYIRaqRUbTalOIH/V7AAB
         8uLNQCDfX7TPXMyjV8Wdu2LXJeBkjwnO6oZcdyRuUs/ZVXgSC4aOXiSxesqT1i4Nwd8w
         xYtH7IkHSxhPuENStbGYgWORXlATU4FDDgZAiKyl7w7YvIdo717VXaOvbP2YnMvoc1J9
         FZYw==
X-Gm-Message-State: APjAAAVGgzm9BrZElfhlwk6VEB8CUBhoJnYMFFjzseZbzJMzRCb9JA3J
        6YSDRxTvQ9HZRf+Qu0kpzkM=
X-Google-Smtp-Source: APXvYqzeZKvXjHgBNE0+TbbYOzkZQ3f/eVo7Gq0O0Y+truJZzq0U0EaX2KsGE5HFJ0XzTOpJND7+QQ==
X-Received: by 2002:a05:6830:2109:: with SMTP id i9mr182104otc.334.1575308553618;
        Mon, 02 Dec 2019 09:42:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y24sm13182oix.31.2019.12.02.09.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 09:42:32 -0800 (PST)
Date:   Mon, 2 Dec 2019 09:42:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-sh@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/2] drivers: move the early platform device support
 to arch/sh
Message-ID: <20191202174231.GB29323@roeck-us.net>
References: <20191003092913.10731-1-brgl@bgdev.pl>
 <20191003092912.G3pupKBmyct1r9ScP5Skuw9D-_ALcMVSnfMfHAlwe0Y@z>
 <20191202041440.GA1628@roeck-us.net>
 <CAMpxmJW3i4zmJJ14Xg65+T27kF3sgR1WG0K3FUT6+jeKtiHx=Q@mail.gmail.com>
 <3f8ffe03-98b8-423a-7cba-53961a5600cb@roeck-us.net>
 <CAMpxmJUmTF3FwacjvTrC+Vvzm8MscS9E=ZyWLbJV87LkQhqVow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJUmTF3FwacjvTrC+Vvzm8MscS9E=ZyWLbJV87LkQhqVow@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 06:18:22PM +0100, Bartosz Golaszewski wrote:
> pon., 2 gru 2019 o 14:03 Guenter Roeck <linux@roeck-us.net> napisał(a):
> >
> > On 12/1/19 11:40 PM, Bartosz Golaszewski wrote:
> > > pon., 2 gru 2019 o 05:14 Guenter Roeck <linux@roeck-us.net> napisał(a):
> > >>
> > >> On Thu, Oct 03, 2019 at 11:29:12AM +0200, Bartosz Golaszewski wrote:
> > >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >>>
> > >>> SuperH is the only user of the current implementation of early platform
> > >>> device support. We want to introduce a more robust approach to early
> > >>> probing. As the first step - move all the current early platform code
> > >>> to arch/sh.
> > >>>
> > >>> In order not to export internal drivers/base functions to arch code for
> > >>> this temporary solution - copy the two needed routines for driver
> > >>> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
> > >>>
> > >>> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> > >>> called after all early devices are probed.
> > >>>
> > >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >>
> > >> Wondering ... has anyone tested this patch on affected hardware ?
> > >> All my qemu boot tests (both sh and sheb) fail because of it.
> > >> Bisect log below.
> > >>
> > >> Guenter
> > >>
> > >> ---
> > >> # bad: [72c0870e3a05d9cd5466d08c3d2a3069ed0a2f9f] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> > >> # good: [89d57dddd7d319ded00415790a0bb3c954b7e386] Merge tag 'media/v5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> > >> git bisect start 'HEAD' '89d57dddd7d3'
> > >> # good: [0a6cad5df541108cfd3fbd79eef48eb824c89bdc] Merge branch 'vmwgfx-coherent' of git://people.freedesktop.org/~thomash/linux into drm-next
> > >> git bisect good 0a6cad5df541108cfd3fbd79eef48eb824c89bdc
> > >> # bad: [9a3d7fd275be4559277667228902824165153c80] Merge tag 'driver-core-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> > >> git bisect bad 9a3d7fd275be4559277667228902824165153c80
> > >> # good: [59274c7164807d27b24e6c068dfe734f7bea4623] Merge tag 'usb-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> > >> git bisect good 59274c7164807d27b24e6c068dfe734f7bea4623
> > >> # good: [e71903106721dc53923e90aa484d78bc86c039a9] staging: mt7621-dma: align to match open parenthesis
> > >> git bisect good e71903106721dc53923e90aa484d78bc86c039a9
> > >> # good: [8f56e4ebe05c26c30e167519273843476e39e244] Merge tag 'char-misc-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> > >> git bisect good 8f56e4ebe05c26c30e167519273843476e39e244
> > >> # good: [8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50] Merge tag 'iio-for-5.5c' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
> > >> git bisect good 8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50
> > >> # bad: [0628cda318df6baec439ca6e6e274007492f1ccd] mac80211: Use debugfs_create_xul() helper
> > >> git bisect bad 0628cda318df6baec439ca6e6e274007492f1ccd
> > >> # bad: [03324507e66c7664c754b1ef92c5c3be24c78aa2] driver core: Allow fwnode_operations.add_links to differentiate errors
> > >> git bisect bad 03324507e66c7664c754b1ef92c5c3be24c78aa2
> > >> # bad: [313f5dbba41d905d59c820bb2d91ee6c661aff99] debugfs: remove return value of debugfs_create_u16()
> > >> git bisect bad 313f5dbba41d905d59c820bb2d91ee6c661aff99
> > >> # good: [d4387cd117414ba80230f27a514be5ca4a09cfcc] of: property: Create device links for all child-supplier depencencies
> > >> git bisect good d4387cd117414ba80230f27a514be5ca4a09cfcc
> > >> # bad: [c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1] base: soc: Handle custom soc information sysfs entries
> > >> git bisect bad c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1
> > >> # bad: [201e91091b1d47047f55580b5474e1239f4d17aa] sh: add the sh_ prefix to early platform symbols
> > >> git bisect bad 201e91091b1d47047f55580b5474e1239f4d17aa
> > >> # bad: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
> > >> git bisect bad 507fd01d5333338753a1cc26322dfc9f856c109f
> > >> # first bad commit: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
> > >
> > > Hi Guenter,
> > >
> > > can you post some bootlogs? Is it the same problem everywhere?
> > >
> >
> > I don't have any useful logs. The boot fails too early for that.
> >
> 
> Yeah, it touched "early" devices after all...
> 
> > Sorry, I don't understand "everywhere". It fails in mainline and -next, if that is what you mean.
> 
> I referred to "All my qemu boot tests" when saying everywhere.
> 

Yes, it affects all my sh and sheb qemu boot tests.
See https://kerneltests.org/builders/.

> I don't have any relevant HW - the idea for this patch is to stop
> compiling for everyone a bunch of code that's only used by one largely
> irrelevant architecture and free the namespace for a generic early
> platform drivers implementation.
> 
> How are you creating your SH qemu images? I'm seeing there's something
> in buildroot for superh - maybe I'll be able to build something
> useful.
> 

I use buildroot. Various root file systems and scripts are at
https://github.com/groeck/linux-build-test/tree/master/rootfs/{sh,sheb}

Guenter
