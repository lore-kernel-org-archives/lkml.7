Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81141C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5644E206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHseEWVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLFT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:28:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37664 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLFT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:28:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id x195so807731oix.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 11:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6ImKGNZ1WdXdwRME2pWLvZKP6sFxaF/8SkdPWDWldw=;
        b=FHseEWVQ1eaDwIVa34R3zMaMK6G8S1hO14c7dWXmraqcMk4Kf87WSexLo3JEAm4wE6
         XL7dJPzUdBtVmYoEM3GuqW4+XeDHocelb4/vHmnGxST8Id6NmPXaOiJFaSfD8KM01diD
         jqaS3LxhWYTcmw3V0svZq08GIhznIptGj4F40lqVniBl9a6vM/BSa+hkHd/sckWFhZPu
         4Szo6pPcGbxZ8XIePyuidJKJXwYsImJSorb6E8aAxUhiJCbAyKMBwkTlQGtkjbf9jS++
         oM6sGtgn87vObhVxFlqAfyqOaE/h3iHH5CSJwH/66y6jhx7h/bAmPYR8nkP/PGHiDa6b
         kWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6ImKGNZ1WdXdwRME2pWLvZKP6sFxaF/8SkdPWDWldw=;
        b=NaLW7tPX9pvB2slbxDXzWlT7HBiWAA5RMTSOA7noxaDmqhctA68R5uL+rXNmnA7ioY
         JYUmQ+SE/z2O0eOBe6821UDnpWkLb8+WWJd4i1TZ0lMlaWB+Lo6+S9dFaw+TlpaX00HH
         zWWNCMnkijrTCVm6XG1jTvpfk4rq4IjzrYblpKUIZMqfLqIIRkpVvvxBXfuu+nJx4Dbw
         wO99ObQoegLqhTL57aWzd3uho5bJ3bpniYr/TaM7OJ2Z01QQgivVZ3wR1XLS8uXVJYsn
         guDz01G62ZYE9Ubdev5XFa2JsdTL3YGWCQIcEPpyyh1nVYv4QHHDg3v9Fu6Oj5RarKlp
         +9GQ==
X-Gm-Message-State: APjAAAXehKQtO1VuKf05gUSYOGWQZY+H49efxjswOUO8vBzUpyyIT4DS
        wEGVkTrlKvZvGgr6FW7rYClXAs4/BG2j1Rxa/aUEQQ==
X-Google-Smtp-Source: APXvYqwMwp/OeEaYuuKWB5/aXyo1P/vb2mAAjbdiQn1TGnFW4S0XTjdiB53Hjzm7gJ3dKee55gLZMNMomFI9GywXlUw=
X-Received: by 2002:aca:3b89:: with SMTP id i131mr7834546oia.43.1575660486726;
 Fri, 06 Dec 2019 11:28:06 -0800 (PST)
MIME-Version: 1.0
References: <7cb0ca10-8fb2-0cc8-224b-f5f908984998@huawei.com>
In-Reply-To: <7cb0ca10-8fb2-0cc8-224b-f5f908984998@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 6 Dec 2019 11:27:30 -0800
Message-ID: <CAGETcx9nfvVhAbvH1X_joPFCrmLFo_ktEqeCfnBZSHCz6hUp6Q@mail.gmail.com>
Subject: Re: warning from device_links_supplier_sync_state_resume()
To:     John Garry <john.garry@huawei.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 9:42 AM John Garry <john.garry@huawei.com> wrote:
>
> Hi,
>
> I'm testing my arm64 system on Linus' master branch at recent commit
> b0d4beaa5a4b.
>
> This system is ACPI based, but I notice that when CONFIG_OF_UNITTEST=y
> (don't ask why...), I get this:
>
> [   18.344208] ------------[ cut here ]------------
> [   18.348813] Unmatched sync_state pause/resume!
> [   18.348833] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:786
> device_links_supplier_sync_state_resume+0xf8/0x108
> [   18.363419] Modules linked in:
> [   18.366461] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 5.4.0-12941-gb0d4beaa5a4b-dirty #683
> [   18.374710] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
> D05 IT21 Nemo 2.0 RC0 04/18/2018
> [   18.383828] pstate: 60000005 (nZCv daif -PAN -UAO)
> [   18.388606] pc : device_links_supplier_sync_state_resume+0xf8/0x108
> [   18.394858] lr : device_links_supplier_sync_state_resume+0xf8/0x108
> [   18.401110] sp : ffff800011c7bd40
> [   18.404411] x29: ffff800011c7bd40 x28: 0000000000000008
> [   18.409709] x27: ffff80001140e070 x26: ffff80001133b7e8
> [   18.415007] x25: ffff800011a56000 x24: ffff800011a56000
> [   18.420305] x23: ffff041fa7798000 x22: ffff8000119f0000
> [   18.425603] x21: ffff800011879000 x20: ffff800011c7bd88
> [   18.430900] x19: ffff8000119f06b0 x18: ffffffffffffffff
> [   18.436198] x17: fffffdfffe608a5b x16: 0000000000001400
> [   18.441496] x15: ffff8000118798c8 x14: ffff800091c7b9e7
> [   18.446793] x13: ffff800011c7b9f5 x12: ffff800011891000
> [   18.452091] x11: 0000000005f5e0ff x10: ffff80001187a120
> [   18.457389] x9 : ffff800011c7bd40 x8 : 7561702065746174
> [   18.462687] x7 : 735f636e79732064 x6 : ffff800011a616b2
> [   18.467985] x5 : 0000000000000000 x4 : 0000000000000000
> [   18.473283] x3 : 00000000ffffffff x2 : ffff801feaa06000
> [   18.478581] x1 : 51ddef120d2f0500 x0 : 0000000000000000
> [   18.483880] Call trace:
> [   18.486313]  device_links_supplier_sync_state_resume+0xf8/0x108
> [   18.492221]  of_platform_sync_state_init+0x18/0x2c
> [   18.497000]  do_one_initcall+0x5c/0x1b0
> [   18.500824]  kernel_init_freeable+0x1a0/0x248
> [   18.505168]  kernel_init+0x10/0x108
> [   18.508644]  ret_from_fork+0x10/0x18
> [   18.512205] ---[ end trace b280eee6dfb144c3 ]---
>
> It seems the check of_have_populated_dt() is not always the best test
> for this device links state resume call.

Yeah, one of the bots reported it a few days ago. I'll send out a fix
soon. It's a trivial fix.

-Saravana
