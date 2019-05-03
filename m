Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7936EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B22F20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBoQMI8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfECRow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:44:52 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40987 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECRov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:44:51 -0400
Received: by mail-ua1-f65.google.com with SMTP id s30so2296940uas.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Eb7/4hKFWccQPeYAcQ+tBEeG3Xuv86Wr0G2bXfLTgYY=;
        b=WBoQMI8n76XRNG937wz4b3Y8tGCUDWk2dMzx/uAgPRb0VxD4EkI6s8+lIG09Cmi8x5
         31LHkXnacwbV63sA7h5+G8JK5I8Fn4svA6MdYZ34m7zomopY7XVsdLc96dS9/v45yxG+
         14gmaZ2fg8VkuB92sSIVGHMBYNQ4ofDqYMOuOjidm69R75p/p8LvuzzG44CZPI3UXlH4
         YlCoYtK+sYv1VYJAhwoZccPemh4yrM7ZxGYhPkAG1ClhzgiFhC4RL/TneekPWF4rAJ8H
         yXFikcjd36zXS2vUzWqltmwSSG7pjzOI9XrnCjkxK3Devm7LCw6X7ZKroc7M5rKjwASm
         DUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Eb7/4hKFWccQPeYAcQ+tBEeG3Xuv86Wr0G2bXfLTgYY=;
        b=uaChI6fhk9yZFCoQU+YFbMjuo8HYncQvX4HMujBLHMhThwPdoGZYwrq9HmEa02w9Zv
         nMG32Q+sGOCNnzB2zHTxFT5Qa/CKHtjmUPceE0tMEyu4ovNyKhrFd6wk2Vg0z9YYiFCu
         UQjlWgNKBxG5p0QwUcePdREL5YiHqlP4h4UtFl+0z5ALSoSaEd5wj/iH/WeOQK8AY8Ja
         Rp4iQZ6KAlbdiBoMDImbd3jT/retjqvIu0HbhEo+Rs5OO9XsTVgBNFOMEZl1BSWnZ6kF
         HImLl8FzGvRdKkKcceDzH/Ic+A9K09Lmbh0GZX8FXg4P8u/LgY2su5Xa+WSGmNSaNX5D
         grcQ==
X-Gm-Message-State: APjAAAVJ3ZPQrS4nBI+IwoNRetCrepNhkCoHFqke7wQdYZVmRFXEVJp/
        iOGSE12RE4ZYBZuy0VG3HkuxbTGa2PA6pMbnzcA=
X-Google-Smtp-Source: APXvYqy6Umi3GZnui/w256oSDLamokEgeN1ctBgmNjhN0Q/krHayWTf4sb9TeI7LGBIrQklVFLC6neUM0d06yZ+xXtI=
X-Received: by 2002:ab0:1410:: with SMTP id b16mr5072449uae.1.1556905490552;
 Fri, 03 May 2019 10:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo57s_ZxmxjmRrCSwaqQzzO5r0SadzMhseeb9X0t0mOwJZA@mail.gmail.com>
 <11029.1556774479@turing-police>
In-Reply-To: <11029.1556774479@turing-police>
From:   Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date:   Fri, 3 May 2019 23:14:39 +0530
Message-ID: <CACDBo54xXk-68MTsxw2K12gD0eGO0Xpq0rw60E3AX+2OEi3igw@mail.gmail.com>
Subject: Re: Page Allocation Failure and Page allocation stalls
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernelnewbies@kernelnewbies.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, minchan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 10:51 AM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> On Thu, 02 May 2019 04:56:05 +0530, Pankaj Suryawanshi said:
>
> > Please help me to decode the error messages and reason for this errors.
>
> > [ 3205.818891] HwBinder:1894_6: page allocation failure: order:7, mode:=
0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=3D(null)
>
> Order 7 - so it wants 2**7 contiguous pages.  128 4K pages.
>
kmalloc fails to allocate 2**7

> > [ 3205.967748] [<802186cc>] (__alloc_from_contiguous) from [<80218854>]=
 (cma_allocator_alloc+0x44/0x4c)
>
> And that 3205.nnn tells me the system has been running for almost an hour=
. Going
> to be hard finding that much contiguous free memory.
>
> Usually CMA is called right at boot to avoid this problem - why is this
> triggering so late?
>
The use case for late triggering is someone try to play video after an
hour, and video memory from CMA area, maybe its due to fragmentation.
> > [  671.925663] kworker/u8:13: page allocation stalls for 10090ms, order=
:1, mode:0x15080c0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), nodemask=3D(null)
>
> That's.... a *really* long stall.
>
Yes very long any pointers to block this warnings/errors.

> > [  672.031702] [<8021e800>] (copy_process.part.5) from [<802203b0>] (_d=
o_fork+0xd0/0x464)
> > [  672.039617]  r10:00000000 r9:00000000 r8:9d008400 r7:00000000 r6:812=
16588 r5:9b62f840
> > [  672.047441]  r4:00808111
> > [  672.049972] [<802202e0>] (_do_fork) from [<802207a4>] (kernel_thread=
+0x38/0x40)
> > [  672.057281]  r10:00000000 r9:81422554 r8:9d008400 r7:00000000 r6:9d0=
04500 r5:9b62f840
> > [  672.065105]  r4:81216588
> > [  672.067642] [<8022076c>] (kernel_thread) from [<802399b4>] (call_use=
rmodehelper_exec_work+0x44/0xe0)
>
> First possibility that comes to mind is that a usermodehelper got launche=
d, and
> it then tried to fork with a very large active process image.  Do we have=
 any
> clues what was going on?  Did a device get hotplugged?

Yes,The system is android and it tries to allocate memory for video
player from CMA reserved memory using custom octl call for dma apis.

Please let me know how to overcome this issues, or how to reduce
fragmentation of memory so that higher order allocation get suuceed ?

Thanks
