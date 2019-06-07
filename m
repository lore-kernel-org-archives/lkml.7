Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D5AC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B51208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V8Kl7gi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfFGKH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:07:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53657 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfFGKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:07:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607100756euoutp013df4becb04f201b8efae996ffd0bcb48~l4qyTYlxf2396723967euoutp01u
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 10:07:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607100756euoutp013df4becb04f201b8efae996ffd0bcb48~l4qyTYlxf2396723967euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559902076;
        bh=Jm+WXiB4pRNu75lZwvc4eHiRWK6FoRbAtle9p7lr/9U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V8Kl7gi0L7NI1YuPcwD0xQsTqP9ycUlo4Ist74A/NRjBOw4OOEMEPrVsgEEEJcyuq
         w8azdtYlGxrBAhgQ0OeIWPCis56DaOk6r9rvCBn6WL8HTElQ2MqVccYHl63+HoWiNQ
         rKzx7eBSLzINnHFzjEir0jODjJeunA3gY1WOoD1Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607100756eucas1p2b2b52fae66bc27d3625ff4481583a076~l4qxwxLrw2370823708eucas1p2p;
        Fri,  7 Jun 2019 10:07:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 25.15.04298.B773AFC5; Fri,  7
        Jun 2019 11:07:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607100755eucas1p2e7cac58e2454d0c1d1583dc51dc0feaf~l4qw9qcjE2370823708eucas1p2m;
        Fri,  7 Jun 2019 10:07:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607100755eusmtrp26d103e4a46e3c8c7973982e6b1e4b514~l4qwuFvwk2390223902eusmtrp2s;
        Fri,  7 Jun 2019 10:07:55 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-8a-5cfa377bfd15
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.A2.04140.A773AFC5; Fri,  7
        Jun 2019 11:07:55 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607100754eusmtip109b5a8db00aca06a5f8a7b46197490c5~l4qwW8jiQ0681706817eusmtip1w;
        Fri,  7 Jun 2019 10:07:54 +0000 (GMT)
Subject: Re: [PATCH 00/33] fbcon notifier begone v3!
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f848b4de-abab-116f-ad68-23348f1a4b76@samsung.com>
Date:   Fri, 7 Jun 2019 12:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHneUFYPiRr10X9xfWTkGtaoQBB=niDMGkAgJ-fgo5=mA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7rV5r9iDP5uM7Y48+Yuu8XCh3eZ
        Lf5vm8hsceXrezaL2RM2M1mc6PvAanF51xw2B3aPvd8WsHjcubaHzeN+93Emj8+b5AJYorhs
        UlJzMstSi/TtErgy+g9sYCr4rV9x49MX9gbGXSpdjBwcEgImEtvamLoYuTiEBFYwSpyb2swK
        4XxhlPjy/ikzhPOZUeJs1262LkZOsI6La4+yQySWM0rMnjgdLCEk8JZRouGTPYgtDFT06ddt
        JhBbREBZon/zHLCxzAKbmCR2ts9gB0mwCVhJTGxfxQhi8wrYSSyf9hOsgUVAReLyvF1gtqhA
        hMT9YxtYIWoEJU7OfMICYnMKBEq0f/zPDGIzC4hL3HoynwnClpfY/nYO2NkSAuvYJZ7/3Qp1
        tovE9HN7WSBsYYlXx7ewQ9gyEv93zmeCamCU+NvxAqp7O6PE8sn/oLqtJQ4fv8gKCjJmAU2J
        9bv0IcKOEp++HGSHhCSfxI23ghBH8ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF
        5LVZSN6ZheSdWQh7FzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMPaf/Hf+0g/Hr
        paRDjAIcjEo8vB7sP2OEWBPLiitzDzFKcDArifCWXfgRI8SbklhZlVqUH19UmpNafIhRmoNF
        SZy3muFBtJBAemJJanZqakFqEUyWiYNTqoGR00ElykJvh4lS0N/vczdPVRNtSWYvtQ6Iup9u
        9m5C2/nUnI8rFfttlQPS32l0nUr/w6QgZjFl+1rjgsfHty0xubm18NPDh3YuV+PZt1x9EHPx
        Y+OiH7l307uaUx1OnT+7Y/eHAoZo7rM75S+yrjF7v9fyY5FtsUvs1PP3NszX3RMe/fSAoJGZ
        EktxRqKhFnNRcSIAgq1OGDkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xu7rV5r9iDNYdYbQ48+Yuu8XCh3eZ
        Lf5vm8hsceXrezaL2RM2M1mc6PvAanF51xw2B3aPvd8WsHjcubaHzeN+93Emj8+b5AJYovRs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy+g9sYCr4
        rV9x49MX9gbGXSpdjJwcEgImEhfXHmXvYuTiEBJYyiixZm0vkMMBlJCROL6+DKJGWOLPtS42
        iJrXjBIflhxnBEkIAzV/+nWbCcQWEVCW6N88hxWkiFlgC5PE/VMvWCE6rjJK7F84GayKTcBK
        YmL7KrBuXgE7ieXTfoLFWQRUJC7P2wVmiwpESJx5v4IFokZQ4uTMJ2A2p0CgRPvH/8wgNrOA
        usSfeZegbHGJW0/mM0HY8hLb385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5x
        Ym5xaV66XnJ+7iZGYLRtO/Zzyw7GrnfBhxgFOBiVeHhnMP2MEWJNLCuuzD3EKMHBrCTCW3bh
        R4wQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wMTQV5JvKGpobmFpaG5sbmxmYWSOG+HwMEY
        IYH0xJLU7NTUgtQimD4mDk6pBkbjmzqcG3dOWPnbIO+9j8q6YqFZYiUiPTe3PBHMqj9jxr/v
        a+faqWHqyd5aswx+MJjcnfT6/eOHr3d0cr6xmqlepegQslY3ZF7Jjkazyqa1uyT/C9yeEvlr
        Y/Muu32N6SGP4o4tUL23zC+wb+nW3zfzjWc+lue4Knd7/b2IfxEKb2fLfgl6YaOoxFKckWio
        xVxUnAgAS/8/GcwCAAA=
X-CMS-MailID: 20190607100755eucas1p2e7cac58e2454d0c1d1583dc51dc0feaf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190606073852epcas2p27b586b93869a30e4658581c290960fee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190606073852epcas2p27b586b93869a30e4658581c290960fee
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
        <CGME20190606073852epcas2p27b586b93869a30e4658581c290960fee@epcas2p2.samsung.com>
        <CAKMK7uHneUFYPiRr10X9xfWTkGtaoQBB=niDMGkAgJ-fgo5=mA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/19 9:38 AM, Daniel Vetter wrote:
> Hi Bart,

Hi Daniel,

> On Tue, May 28, 2019 at 11:02:31AM +0200, Daniel Vetter wrote:
>> Hi all,
>>
>> I think we're slowly getting there. Previous cover letters with more
>> context:
>>
>> https://lists.freedesktop.org/archives/dri-devel/2019-May/218362.html
>>
>> tldr; I have a multi-year plan to improve fbcon locking, because the
>> current thing is a bit a mess.
>>
>> Cover letter of this version, where I detail a bit more the details
>> fixed in this one here:
>>
>> https://lists.freedesktop.org/archives/dri-devel/2019-May/218984.html
>>
>> Note that the locking plan in this one is already outdated, I overlooked a
>> few fun issues around any printk() going back to console_lock.
>>
>> I think remaining bits:
>>
>> - Ack from Daniel Thompson for the backlight bits, he wanted to check the
>>   big picture.
> 
> I think Daniel is still on vacation until next week or so.
> 
>> - Hash out actual merge plan.
> 
> I'd like to stuff this into drm.git somehow, I guess topic branch works
> too.

I would like to have topic branch for this patchset.

> Long term I think we need to reconsider how we handle fbdev, at least the
> core/fbcon pieces. Since a few years all the work in that area has been
> motivated by drm, and pushed by drm contributors. Having that maintained
> in a separate tree that doesn't regularly integrate imo doesn't make much
> sense, and we ended up merging almost everything through some drm tree.
> That one time we didn't (for some panel rotation stuff) it resulted in
> some good suprises.
> 
> I think best solution is if we put the core and fbcon bits into drm-misc,
> as group maintained infrastructure piece. All the other gfx infra pieces
> are maintained in there already too. You'd obviously get commit rights.
> I think that would include
> - drivers/video/fbdev
> - drivers/video/*c
> - drivers/video/console

Sounds fine to me.

> I don't really care about what happens with the actual fbdev drivers
> (aside from the drm one in drm_fb_helper.c, but that's already maintained
> as part of drm). I guess we could also put those into drm-misc, or as a
> separate tree, depending what you want.
> 
> Thoughts?

I would like to handle fbdev changes for v5.3 merge window using fbdev
tree but after that everything (including changes to fbdev drivers) can go
through drm-misc tree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Cheers, Daniel
> 
> 
>>
>> I'm also cc'ing the entire pile to a lot more people on request.
>>
>> Thanks, Daniel
>>
>> Daniel Vetter (33):
>>   dummycon: Sprinkle locking checks
>>   fbdev: locking check for fb_set_suspend
>>   vt: might_sleep() annotation for do_blank_screen
>>   vt: More locking checks
>>   fbdev/sa1100fb: Remove dead code
>>   fbdev/cyber2000: Remove struct display
>>   fbdev/aty128fb: Remove dead code
>>   fbcon: s/struct display/struct fbcon_display/
>>   fbcon: Remove fbcon_has_exited
>>   fbcon: call fbcon_fb_(un)registered directly
>>   fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
>>   fbdev/omap: sysfs files can't disappear before the device is gone
>>   fbdev: sysfs files can't disappear before the device is gone
>>   staging/olpc: lock_fb_info can't fail
>>   fbdev/atyfb: lock_fb_info can't fail
>>   fbdev: lock_fb_info cannot fail
>>   fbcon: call fbcon_fb_bind directly
>>   fbdev: make unregister/unlink functions not fail
>>   fbdev: unify unlink_framebuffer paths
>>   fbdev/sh_mob: Remove fb notifier callback
>>   fbdev: directly call fbcon_suspended/resumed
>>   fbcon: Call fbcon_mode_deleted/new_modelist directly
>>   fbdev: Call fbcon_get_requirement directly
>>   Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
>>   fbmem: pull fbcon_fb_blanked out of fb_blank
>>   fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
>>   fb: Flatten control flow in fb_set_var
>>   fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
>>   vgaswitcheroo: call fbcon_remap_all directly
>>   fbcon: Call con2fb_map functions directly
>>   fbcon: Document what I learned about fbcon locking
>>   staging/olpc_dcon: Add drm conversion to TODO
>>   backlight: simplify lcd notifier
>>
>>  arch/arm/mach-pxa/am200epd.c                  |  13 +-
>>  drivers/gpu/vga/vga_switcheroo.c              |  11 +-
>>  drivers/media/pci/ivtv/ivtvfb.c               |   6 +-
>>  drivers/staging/fbtft/fbtft-core.c            |   4 +-
>>  drivers/staging/olpc_dcon/TODO                |   7 +
>>  drivers/staging/olpc_dcon/olpc_dcon.c         |   6 +-
>>  drivers/tty/vt/vt.c                           |  18 +
>>  drivers/video/backlight/backlight.c           |   2 +-
>>  drivers/video/backlight/lcd.c                 |  12 -
>>  drivers/video/console/dummycon.c              |   6 +
>>  drivers/video/fbdev/aty/aty128fb.c            |  64 ---
>>  drivers/video/fbdev/aty/atyfb_base.c          |   3 +-
>>  drivers/video/fbdev/core/fbcmap.c             |   6 +-
>>  drivers/video/fbdev/core/fbcon.c              | 313 ++++++--------
>>  drivers/video/fbdev/core/fbcon.h              |   6 +-
>>  drivers/video/fbdev/core/fbmem.c              | 399 +++++++-----------
>>  drivers/video/fbdev/core/fbsysfs.c            |  20 +-
>>  drivers/video/fbdev/cyber2000fb.c             |   1 -
>>  drivers/video/fbdev/neofb.c                   |   9 +-
>>  .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   |  21 +-
>>  drivers/video/fbdev/sa1100fb.c                |  25 --
>>  drivers/video/fbdev/savage/savagefb_driver.c  |   9 +-
>>  drivers/video/fbdev/sh_mobile_lcdcfb.c        | 132 +-----
>>  drivers/video/fbdev/sh_mobile_lcdcfb.h        |   5 -
>>  include/linux/console_struct.h                |   5 +-
>>  include/linux/fb.h                            |  45 +-
>>  include/linux/fbcon.h                         |  30 ++
>>  27 files changed, 396 insertions(+), 782 deletions(-)
>>
>> --
>> 2.20.1
>>
> 
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
