Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFA3206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0F/9txF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfECUCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 16:02:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfECUCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 16:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hOhvtimHrTh0cr4202vrQ44fuTh2mxDsMXPrjDR7cxk=; b=0F/9txF1f1v4UwBMp+ybhXWZWp
        H3eNKBsdmKBAGJVvsU3/jzw1nG+i4gWmm0yYV2X15J4gWr81/Jp709DjSDB7wBMWsdA4bwPVJuVUN
        9bKmo0P9/ByXb6e7mL5YOttpOiqz1SNW4iwVAvtJBH4/7SwvL3Qe0xNRNTXfJAfja0/xq4SmQwb74
        dq4Gj9va5l7IE5WyKcANUUtd9RbeEaQsm3qmVKmV+Ck0TQndPlZx6n4m3p9ZB4N7FQux9B/p67SdU
        tC2i8z7gJ5aeTv8+hTcccoBFcFSLuyNK5TLXMuxO4/+z4knx2HMim5e2YIFCCJ6J+Q9jFOuyA8k9u
        lJKAxmAg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMeNp-0003ZN-Aa; Fri, 03 May 2019 20:02:13 +0000
Subject: Re: ERROR: "paddr_to_nid" [drivers/md/raid1.ko] undefined!
To:     kbuild test robot <lkp@intel.com>, Ming Lei <ming.lei@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
References: <201905032019.tzlqufi0%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e48dcb2-6e82-4bbe-3920-e1c5fd5c265a@infradead.org>
Date:   Fri, 3 May 2019 13:02:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905032019.tzlqufi0%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/19 5:54 AM, kbuild test robot wrote:
> Hi Ming,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ea9866793d1e925b4d320eaea409263b2a568f38
> commit: 6dc4f100c175dd0511ae8674786e7c9006cdfbfa block: allow bio_for_each_segment_all() to iterate over multi-page bvec
> date:   3 months ago
> config: ia64-bigsur_defconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6dc4f100c175dd0511ae8674786e7c9006cdfbfa
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: "paddr_to_nid" [sound/core/snd-pcm.ko] undefined!
>    ERROR: "paddr_to_nid" [net/sunrpc/sunrpc.ko] undefined!
>    ERROR: "paddr_to_nid" [fs/cifs/cifs.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/video/fbdev/core/fb.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/usb/mon/usbmon.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/usb/core/usbcore.ko] undefined!
>>> ERROR: "paddr_to_nid" [drivers/md/raid1.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/md/dm-mod.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/md/dm-crypt.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/md/dm-bufio.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/ide/ide-core.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/ide/ide-cd_mod.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/gpu/drm/drm.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/char/agp/agpgart.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/block/nbd.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/block/loop.ko] undefined!
>    ERROR: "paddr_to_nid" [drivers/block/brd.ko] undefined!
>    ERROR: "paddr_to_nid" [crypto/ccm.ko] undefined!
> 

---
Exporting paddr_to_nid() in arch/ia64/mm/numa.c fixes all of these build errors.
Is there a problem with doing that?


-- 
~Randy
