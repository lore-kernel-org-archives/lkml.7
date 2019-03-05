Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D235C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05097206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCEI0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:26:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38584 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfCEI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:26:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id s1so8145973qte.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 00:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWO4T5xEogVMCs06EOCx8kJZPJBaHObz/kRqw0tOs0c=;
        b=JLwU4U6g3PPufWZJTuXYGzK9D13ldZ8LA7HJIZzwc/3IDDTDo4hFJRqUupu6GFqmCk
         +depQ7EsmYb3Rv3owEquiC6wZOgMcmZ1uAszTA03YtToSTDYtORPcxRIPK+08OXfSHKB
         nuUYU2oWPhMT6bexejfyWklk6KHlIvXafZXHYAdhevePiynkc+HGdoUvTDP/E9PFWeu+
         FuJuUXhn72uEMitBPpP97ETGlavbYUvkphhYnvKW+apeochgRhSAM1/S9qYAsMjXa4xC
         77ZSC8jJMIixv739DWw/TJN3XDqUpsNVo50Bb9cfBLFYx26l61gMqGV7kLPvz1S3yFVf
         fHbg==
X-Gm-Message-State: APjAAAXKVh3GYUQ2XkCPCYaHrp/21jN7x9TKQ2IRhRTSMZNJJssAiQJq
        KS0NaCIn/mjAF14Y0DBMhKHpcBW5IfVAcow4rP0=
X-Google-Smtp-Source: APXvYqxxcPtMF+ymGyffTaHbdvLrSiu+2yh8oTb8PjvJlPF18YZMxX7fT6QxhOUMXN8r8ErFqqrzc8LLztuS/4XUSks=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr1133112qve.180.1551774410231;
 Tue, 05 Mar 2019 00:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20190304200719.1382717-1-arnd@arndb.de> <CAHX4x842P-V7VGTqRwuVfxk-zBOwMWGh5yLx6tnxEamj-Wt5SA@mail.gmail.com>
In-Reply-To: <CAHX4x842P-V7VGTqRwuVfxk-zBOwMWGh5yLx6tnxEamj-Wt5SA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 09:26:33 +0100
Message-ID: <CAK8P3a0gCV7CNYzJfMa4FvL_Dck_zYjhaFU7JP9Qu38VBxqrgw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: fix wilco-ec dependencies
To:     Nick Crews <ncrews@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Duncan Laurie <dlaurie@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:53 AM Nick Crews <ncrews@chromium.org> wrote:
>
> On Mon, Mar 4, 2019 at 1:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > When CROS_EC_LPC is set to =m, we get a link failure for a
> > builtin wilco-ec module:
> >
> > drivers/platform/chrome/wilco_ec/core.o: In function `wilco_ec_remove':
> > core.c:(.text+0x26): undefined reference to `cros_ec_lpc_mec_destroy'
> > drivers/platform/chrome/wilco_ec/core.o: In function `wilco_ec_probe':
> > core.c:(.text+0x18c): undefined reference to `cros_ec_lpc_mec_init'
> > core.c:(.text+0x224): undefined reference to `cros_ec_lpc_mec_destroy'
> > drivers/platform/chrome/wilco_ec/mailbox.o: In function `wilco_ec_mailbox':
> > mailbox.c:(.text+0x104): undefined reference to `cros_ec_lpc_io_bytes_mec'
> >
> > The problem with the existing CROS_EC_LPC_MEC dependency is that this
> > is only for a 'bool' symbol, so the information about the exported
> > functions being in a module is lost on the way, and we actually have
> > to depend on both CROS_EC_LPC and CROS_EC_LPC_MEC.
>
> Thanks for the catch Arnd. This looks like a workable solution, although it
> brings up a different question to me: Is it weird for a bool option
> (such as CROS_EC_LPC_MEC)
> to depend upon a tristate option (such as CROS_EC_LPC)?

No, not weird at all.

> It seems like
> CROS_EC_LPC_MEC
> should be tristate as well. Would changing this be a better solution?

No, that would actually break the code in a different way, since you
have:

drivers/platform/chrome/Makefile:cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)
+= cros_ec_lpc_mec.o
drivers/platform/chrome/cros_ec_lpc_reg.c:#ifdef CONFIG_CROS_EC_LPC_MEC
drivers/platform/chrome/cros_ec_lpc_reg.c:#else /* CONFIG_CROS_EC_LPC_MEC */
drivers/platform/chrome/cros_ec_lpc_reg.c:#endif /* CONFIG_CROS_EC_LPC_MEC */

With CONFIG_CROS_EC_LPC_MEC=m, it would not get used
(CONFIG_CROS_EC_LPC_MEC ends up not defined in C code),
and it makes no sense to include a .o file in a loadable module
based on a tristate option.

       Arnd
