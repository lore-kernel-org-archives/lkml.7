Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A125AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A4120833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575407426;
	bh=ltNmdxqxIGQe567NNfWixTfumigBYkWFwYoof3pYTG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fp4BOpJKJUNr8QNc9nDQTCWicXhGoQa5TVFhGEXRW8jG0vxH2XffBLRvVf1x50wj5
	 hBMcY/8yyOiOlPHRzZpZuC3DJoFWFSeIm50yDcnFCXCwPrM9QyPxnnf6WBF0Tyix/+
	 to0A5/oj0jSIEgenjLCHxB2FAmBLgtMc4aabDEIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLCVKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfLCVKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:10:25 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A7182080F;
        Tue,  3 Dec 2019 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575407423;
        bh=ltNmdxqxIGQe567NNfWixTfumigBYkWFwYoof3pYTG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kOoCqR6IHK7rRI4mucojzzczxQkwAVJAEtEXvL51ZJUVZm4OSgYVjI5k/+bvvL4E0
         gJtxD/2teSIHv2WU3o5+QAvRuKpblLdOnytNmgvlGbtp9aVjpX+xpT+IXuEvgRtqVT
         7rTHZTGq9jXTyJr1D0KlBaTDQ0Xufxi8ghAEL0Nw=
Received: by mail-qk1-f178.google.com with SMTP id b8so4987263qkk.5;
        Tue, 03 Dec 2019 13:10:23 -0800 (PST)
X-Gm-Message-State: APjAAAW8p2d/Eubpq3ES//DJWwiwBSGJ25xfgobje/NqrdKHiZrAsLZc
        8vMZ5CGXEpZkNldNY5KArFH5JFjW/sqM2JYN/w==
X-Google-Smtp-Source: APXvYqw5cCekrl51lmCvDx3bZf7/WQkwHN4Nu6Wg11wZ3dcrVOu37slUMyUnbyfnyiyLiqi6uJJGahX5n61MjLh6dXg=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr7603140qkg.152.1575407422450;
 Tue, 03 Dec 2019 13:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20191201150015.GC18573@shao2-debian> <CAGETcx9r0u=-WSnQ2ZS1KmZSVQqKwvpnhO-w41=jk8iF6BdALA@mail.gmail.com>
 <7e13b7f9-6c0f-0ab5-a6f9-5fb9b41257c9@gmail.com> <CAGETcx_PeYi-j+=0QOQR9c=_4n4becziS8WKKi77bXuNY1hufQ@mail.gmail.com>
In-Reply-To: <CAGETcx_PeYi-j+=0QOQR9c=_4n4becziS8WKKi77bXuNY1hufQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Dec 2019 15:10:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKBuCfCvFwbUQwTQxYAR1WL5r5Mnm_RBhHgH0b7_Bkg6w@mail.gmail.com>
Message-ID: <CAL_JsqKBuCfCvFwbUQwTQxYAR1WL5r5Mnm_RBhHgH0b7_Bkg6w@mail.gmail.com>
Subject: Re: 5e6669387e ("of/platform: Pause/resume sync state during init
 .."): [ 3.192726] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688 device_links_supplier_sync_state_resume
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LKP <lkp@lists.01.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 2:05 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Dec 3, 2019 at 1:01 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > On 12/2/19 3:19 PM, Saravana Kannan wrote:
> > > On Sun, Dec 1, 2019 at 7:00 AM kernel test robot <lkp@intel.com> wrote:
> > >>
> > >> Greetings,
> > >>
> > >> 0day kernel testing robot got the below dmesg and the first bad commit is
> > >>
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > >>
> > >> commit 5e6669387e2287f25f09fd0abd279dae104cfa7e
> > >> Author:     Saravana Kannan <saravanak@google.com>
> > >> AuthorDate: Wed Sep 4 14:11:24 2019 -0700
> > >> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> CommitDate: Fri Oct 4 17:30:19 2019 +0200
> > >>
> > >>     of/platform: Pause/resume sync state during init and of_platform_populate()
> > >>
> > >>     When all the top level devices are populated from DT during kernel
> > >>     init, the supplier devices could be added and probed before the
> > >>     consumer devices are added and linked to the suppliers. To avoid the
> > >>     sync_state() callback from being called prematurely, pause the
> > >>     sync_state() callbacks before populating the devices and resume them
> > >>     at late_initcall_sync().
> > >>
> > >>     Similarly, when children devices are populated from a module using
> > >>     of_platform_populate(), there could be supplier-consumer dependencies
> > >>     between the children devices that are populated. To avoid the same
> > >>     problem with sync_state() being called prematurely, pause and resume
> > >>     sync_state() callbacks across of_platform_populate().
> > >>
> > >>     Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >>     Link: https://lore.kernel.org/r/20190904211126.47518-6-saravanak@google.com
> > >>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >>
> > >> fc5a251d0f  driver core: Add sync_state driver/bus callback
> > >> 5e6669387e  of/platform: Pause/resume sync state during init and of_platform_populate()
> > >> 81b6b96475  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
> > >> +-------------------------------------------------------------------------+------------+------------+------------+
> > >> |                                                                         | fc5a251d0f | 5e6669387e | 81b6b96475 |
> > >> +-------------------------------------------------------------------------+------------+------------+------------+
> > >> | boot_successes                                                          | 30         | 0          | 0          |
> > >> | boot_failures                                                           | 1          | 11         | 22         |
> > >> | Oops:#[##]                                                              | 1          |            |            |
> > >> | EIP:unmap_vmas                                                          | 1          |            |            |
> > >> | PANIC:double_fault                                                      | 1          |            |            |
> > >> | Kernel_panic-not_syncing:Fatal_exception                                | 1          |            |            |
> > >> | WARNING:at_drivers/base/core.c:#device_links_supplier_sync_state_resume | 0          | 11         | 22         |
> > >> | EIP:device_links_supplier_sync_state_resume                             | 0          | 11         | 22         |
> > >> +-------------------------------------------------------------------------+------------+------------+------------+
> > >>
> > >> If you fix the issue, kindly add following tag
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >>
> > >> [    3.186107] OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
> > >> [    3.188595] platform testcase-data:testcase-device2: IRQ index 0 not found
> > >> [    3.191047] ### dt-test ### end of unittest - 199 passed, 0 failed
> > >> [    3.191932] ------------[ cut here ]------------
> > >> [    3.192571] Unmatched sync_state pause/resume!
> > >> [    3.192726] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688 device_links_supplier_sync_state_resume+0x27/0xc0
> > >> [    3.195084] Modules linked in:
> > >> [    3.195494] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-rc1-00005-g5e6669387e228 #1
> > >> [    3.196674] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > >> [    3.197693] EIP: device_links_supplier_sync_state_resume+0x27/0xc0
> > >> [    3.198680] Code: 00 00 00 3e 8d 74 26 00 57 56 31 d2 53 b8 a0 d0 d9 c1 e8 6c b6 38 00 a1 e4 d0 d9 c1 85 c0 75 13 68 84 ba c4 c1 e8 29 30 b1 ff <0f> 0b 58 eb 7f 8d 74 26 00 83 e8 01 85 c0 a3 e4 d0 d9 c1 75 6f 8b
> > >> [    3.201560] EAX: 00000022 EBX: 00000000 ECX: 00000000 EDX: 00000000
> > >> [    3.202466] ESI: 000001ab EDI: c02c7f80 EBP: c1e87d27 ESP: c02c7f20
> > >> [    3.203301] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
> > >> [    3.204258] CR0: 80050033 CR2: bfa1bf98 CR3: 01f28000 CR4: 00140690
> > >> [    3.205022] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > >> [    3.205919] DR6: fffe0ff0 DR7: 00000400
> > >> [    3.206529] Call Trace:
> > >> [    3.207011]  ? of_platform_sync_state_init+0x13/0x16
> > >> [    3.207719]  ? do_one_initcall+0xda/0x260
> > >> [    3.208247]  ? kernel_init_freeable+0x110/0x197
> > >> [    3.208906]  ? rest_init+0x120/0x120
> > >> [    3.209369]  ? kernel_init+0xa/0x100
> > >> [    3.209775]  ? ret_from_fork+0x19/0x24
> > >> [    3.210283] ---[ end trace 81d0f2d2ee65199b ]---
> > >> [    3.210955] ALSA device list:
> > >
> > > Rob/Frank,
> > >
> > > This seems to be an issue with the unit test code not properly
> > > cleaning up the state after it's done.
> > >
> > > Specifically, unittest_data_add() setting up of_root on systems where
> > > there's no device tree (of_root == NULL). It doesn't clean up of_root
> > > after the tests are done. This affects the of_have_populated_dt() API
> > > that in turn affects calls to
> > > device_links_supplier_sync_state_pause/resume(). I think unittests
> > > shouldn't affect the of_have_populated_dt() API.
> > There are at least a couple of reasons why the unittest devicetree data
> > needs to remain after the point where devicetree unittests currently
> > complete.  So cleaning up (removing the data) is not an option.
> >
> > I depend on the unittest devicetree entries still existing after the system
> > boots and I can log into a shell for some validation of the final result of
> > the devicetree data.
>
> IMHO unittests shouldn't have a residual impact on the system after
> they are done. So, I'll agree to disagree on this one.

They shouldn't be enabled in a production system either. Why would you
want the extra boot time?

> > There is also a desire for the devicetree unittests to be able to be loaded
> > as a module.  That work is not yet scheduled, but I do not want to preclude
> > the possibility.  If unittests are loaded from a module then they will
> > need some devicetree data to exist that is created in early boot.  That
> > data will be in the devicetree when of_platform_sync_state_init() is
> > invoked.
>
> On a normal system, FDT is parsed and of_root is set (or not set) very
> early on during setup_arch() before any of the initcall levels are
> run. The return value of of_have_populated_dt() isn't expected to
> change across initcall levels. But because of the way the unittest is
> written (the of_root is changed at late_initcall() level) the return
> value of of_have_populated_dt() changes across initcall levels. I
> think that's a real problem with the unittest -- it's breaking API
> semantics.

I think what's really desired here is a 'Am I booting using DT' call.

> of_have_populated_dt() is being used to check if DT is present in the
> system and different things are done based on that. We can't have that
> value change across initcall levels.
>
> Couple of thoughts:
> 1. Don't run unit test if there is no live DT in the system?

That's pretty much the only case I do run. I use UML to run the tests.

> 2. If you don't want to do (1), then at least set up the unit test
> data during setup_arch() instead of doing it at some initcall level?

That further breaks making it a module. The plan is also to move to
kunit which probably will preclude some hacky hook into setup_arch().
Side effects may need to be fixed for kunit though.

> 3. Can you use overlays for the unit tests if they are loaded as a module?

That was the idea, yes.


4. Make running the unittests a command line option instead of running
if enabled. Still has side effects, but you have to explicitly run it.

A module would still be my preference. If only there was someone
interested in making everything a module... ;)

> > > I was looking into writing a unittest patch to fix this, but I don't
> > > know enough about the FDT parsing code to make sure I don't leak any
> > > memory or free stuff that's in use. I'm not sure I can simply set
> > > of_root = NULL if it was NULL before the unittest started. Let me know
> > > how I should proceed or if you plan to write up a patch for this.
> >
> > Based on the above, "clean up" of the unittest data is not the solution.
> >
> > I haven't looked at the mechanism in device_links_supplier_sync_state_resume()
> > that leads to the WARN yet.  But is does not seem reasonable for that code
> > to be so sensitive to what valid data is in the devicetree that a WARN results.
>
> Sure, I could easily fix it to work around this. But this seems to be
> a genuine problem with the unittest setup IMO.
>
> -Saravana
