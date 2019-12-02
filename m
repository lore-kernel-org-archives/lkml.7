Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE63C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 04:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EDA20725
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 04:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyPB0suN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLBEOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 23:14:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41943 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfLBEOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 23:14:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id e9so31203747oif.8;
        Sun, 01 Dec 2019 20:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f/5KDWwc/xKNxHsiDOtb26jMc/teIu2y72BKQlD6HUw=;
        b=PyPB0suN3Ac/0YBN/GdG8mMtlpX+Q2k15I84EAq6fyg6P3jVxHJ+pL9vSwl/+B+8q4
         PWU3EUC+3u7/7UkoBdF9NI8morrmDlADs397ZTs6x/CLy3KRHnBCSu7jf0NpWKJWbtK0
         OS9SNvWEjeRkbN5l/YTF7NK1uWGN7UXFD0tmWlOH505dDMXvfWWIRgLCgbLFhkoFHcho
         tRbUvog+kYJmqI9IQlg6//ZjWVpwEAUy674rkBNd4ySL5ywzMlA1ncNQk3XpJw/BIibJ
         VVn1hTFhHjahdJyg/TDKWziZHhJvo6NBn2Nist5N+J2skFel2VqMuSZZ0jvw/GzuCTzZ
         zmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/5KDWwc/xKNxHsiDOtb26jMc/teIu2y72BKQlD6HUw=;
        b=hVuPOt9diZ1HC6AjblSd9TeXYCdW7doIUYBduUhgRF4op3maFHU7EgAoa1vKPn2H1a
         WNdLn9DzGbWFl1vleWiJn/FvmZ+pVcRShKLDIrmAHeW/dZ5Fp4DjzR3rrjmkZNreh3Qd
         qL4roykSAmdIm3NzrmNxEXQAVDwmg1CTxaUc7CfmlPcQV1pozPIU7fJ9wtru3e0qMxbS
         JW3M40up882bs+gkEy+/yP0+FEqGvZImp9fWdGRzqwFpqXMcBd5XwS/h9iidKS1G/FB5
         +eX3vAKd+HTemF252PXFDpv9lwFRagyEwS7WR1x51FSZvVae2MVKOuBNQVqnWh/xF+Yo
         9FeQ==
X-Gm-Message-State: APjAAAX48oVcz1Xq6/iMFDl23WExDJuFuiHI7cnvKvZyFOQBp5KSq0/j
        G9Y44OQ+o4RrWrSycwcL+yfpnOoT
X-Google-Smtp-Source: APXvYqzsOVbpb/beefEZE/OzfdaH+fj4ZJmh7Tyh+FkhBzgVvyUJ1tZU7N7psT2RXkxa29/o1rZ46Q==
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr22524637oig.172.1575260083692;
        Sun, 01 Dec 2019 20:14:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y23sm10176414oih.17.2019.12.01.20.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Dec 2019 20:14:42 -0800 (PST)
Date:   Sun, 1 Dec 2019 20:14:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 1/2] drivers: move the early platform device support
 to arch/sh
Message-ID: <20191202041440.GA1628@roeck-us.net>
References: <20191003092913.10731-1-brgl@bgdev.pl>
 <20191003092912.G3pupKBmyct1r9ScP5Skuw9D-_ALcMVSnfMfHAlwe0Y@z>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003092912.G3pupKBmyct1r9ScP5Skuw9D-_ALcMVSnfMfHAlwe0Y@z>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 11:29:12AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> SuperH is the only user of the current implementation of early platform
> device support. We want to introduce a more robust approach to early
> probing. As the first step - move all the current early platform code
> to arch/sh.
> 
> In order not to export internal drivers/base functions to arch code for
> this temporary solution - copy the two needed routines for driver
> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
> 
> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> called after all early devices are probed.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Wondering ... has anyone tested this patch on affected hardware ?
All my qemu boot tests (both sh and sheb) fail because of it.
Bisect log below.

Guenter

---
# bad: [72c0870e3a05d9cd5466d08c3d2a3069ed0a2f9f] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
# good: [89d57dddd7d319ded00415790a0bb3c954b7e386] Merge tag 'media/v5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect start 'HEAD' '89d57dddd7d3'
# good: [0a6cad5df541108cfd3fbd79eef48eb824c89bdc] Merge branch 'vmwgfx-coherent' of git://people.freedesktop.org/~thomash/linux into drm-next
git bisect good 0a6cad5df541108cfd3fbd79eef48eb824c89bdc
# bad: [9a3d7fd275be4559277667228902824165153c80] Merge tag 'driver-core-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect bad 9a3d7fd275be4559277667228902824165153c80
# good: [59274c7164807d27b24e6c068dfe734f7bea4623] Merge tag 'usb-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good 59274c7164807d27b24e6c068dfe734f7bea4623
# good: [e71903106721dc53923e90aa484d78bc86c039a9] staging: mt7621-dma: align to match open parenthesis
git bisect good e71903106721dc53923e90aa484d78bc86c039a9
# good: [8f56e4ebe05c26c30e167519273843476e39e244] Merge tag 'char-misc-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 8f56e4ebe05c26c30e167519273843476e39e244
# good: [8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50] Merge tag 'iio-for-5.5c' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
git bisect good 8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50
# bad: [0628cda318df6baec439ca6e6e274007492f1ccd] mac80211: Use debugfs_create_xul() helper
git bisect bad 0628cda318df6baec439ca6e6e274007492f1ccd
# bad: [03324507e66c7664c754b1ef92c5c3be24c78aa2] driver core: Allow fwnode_operations.add_links to differentiate errors
git bisect bad 03324507e66c7664c754b1ef92c5c3be24c78aa2
# bad: [313f5dbba41d905d59c820bb2d91ee6c661aff99] debugfs: remove return value of debugfs_create_u16()
git bisect bad 313f5dbba41d905d59c820bb2d91ee6c661aff99
# good: [d4387cd117414ba80230f27a514be5ca4a09cfcc] of: property: Create device links for all child-supplier depencencies
git bisect good d4387cd117414ba80230f27a514be5ca4a09cfcc
# bad: [c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1] base: soc: Handle custom soc information sysfs entries
git bisect bad c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1
# bad: [201e91091b1d47047f55580b5474e1239f4d17aa] sh: add the sh_ prefix to early platform symbols
git bisect bad 201e91091b1d47047f55580b5474e1239f4d17aa
# bad: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
git bisect bad 507fd01d5333338753a1cc26322dfc9f856c109f
# first bad commit: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
