Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1532064A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoUfz+I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfCHUxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:53:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40925 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCHUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:53:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so3547907wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 12:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5buEy7sWNfSO6Eg66r3Pl8PE4qJXkyiNUZUd+wttyS4=;
        b=AoUfz+I8kLLrdn+XivS4Z1E4YzdZu3Ngdbn62ECVwA9STwFDOf3drPpp5gprm5WrV0
         KudBJn5lCVCnslZyN5qdk9EE7Az4bwCe9xI67zaVgR2gOQZf5NNa8ENba4K+rHN6I2N4
         fTUteu82FUiR7uiw3GxczIOzdz9Uj5D90TFNo1vTPm0GdGf4sv6jgnVhinoDGccbXRP9
         PjznXddd0wITkXCQH55RstIYMCS1rvRQyugYI0KOM3t9+S8dWPYxibxuKbO+U1SoCbp8
         SkfkbB0SfV5ieF1jpopvYDe/08XxCaI+E6tyz84wqtul6EFvxd8CFNOYPFZWSEmq43MI
         8O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5buEy7sWNfSO6Eg66r3Pl8PE4qJXkyiNUZUd+wttyS4=;
        b=S3UPFaBA53BDQnAVPxeaNirIzQQIPCrSbYsDBB6JtxPlXfR9RQRRjfX1ISeY4VQX+D
         ACMU3oNLKCK+9DEFttZG1pGzMHbMuMWcNEPtzbFWUjcCwtojF3sRHffSFhE4DuX4uE3w
         XSy1AhjwMJMM37ALJjplnIb8nFr75UoxVn+Alx7A8Fgnk95R83o2XE96yuVdq6NWf9KI
         B5XHza7Cl6Hz7AP5drqHlH5+NPhrBSozulE4pE7omIhUcFqQyOAs3OxI2qKEAZre5xUk
         uWPe+2xBcJCtLkjd32Enl7AquuocJrEOXILi7G+3WozG4Wp0MQbkQH1+iIDPvjUmj8hN
         W6zQ==
X-Gm-Message-State: APjAAAWnq520zI2lP4+cmbXgdN2wR4LBwWzVvf78jJ5NSsHnOMO6UjdW
        +O1CN/ZEhZrOJiYxX/yPZ7RHf7DVd3ghts7fVtbCKw==
X-Google-Smtp-Source: APXvYqzMXn10Rk698zn3QU/7TE8XU1N9MwhYN1jOIEu6MgyR6qKipH8IBxE/8f5SwX2iSuSFMx/c0M8P1lZQJ30hMGY=
X-Received: by 2002:a5d:5506:: with SMTP id b6mr11896507wrv.33.1552078407880;
 Fri, 08 Mar 2019 12:53:27 -0800 (PST)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 8 Mar 2019 12:53:16 -0800
Message-ID: <CALAqxLUZKinhCasO4rXBJuip3bOo+JCovWLrHYPBPTopf6d7Vw@mail.gmail.com>
Subject: REGRESSION: dwc2: gadget: Add scatter-gather mode
To:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Gall <tom.gall@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrzej,
  I just wanted to let you know, trying to boot linus/master on the
hikey board today, I've been seeing lots of errors on boot (which
sometimes crash the board, and sometimes doesn't). See the example
below.

I've bisected the issue down to 10209abe87f5 ("usb: dwc2: gadget: Add
scatter-gather mode"), and if I revert that change the issue goes
away.

Looking at the patch, I can't see anything obviously sticking out, but
let me know if you have anything suggestions you'd like me to test.

thanks
-john


[   13.088934] functionfs read size 512 > requested size 24, splitting
request into multiple reads.
[   13.089029] ------------[ cut here ]------------
[   13.102665] Trying to vfree() bad address (00000000ecf3404f)
[   13.108436] WARNING: CPU: 0 PID: 2014 at mm/vmalloc.c:1516 __vunmap+0xe0/0xe8
[   13.115587] CPU: 0 PID: 2014 Comm: adbd Not tainted
5.0.0-08291-ga032141-dirty #897
[   13.123244] Hardware name: HiKey Development Board (DT)
[   13.128469] pstate: 80400005 (Nzcv daif +PAN -UAO)
[   13.133266] pc : __vunmap+0xe0/0xe8
[   13.136757] lr : __vunmap+0xe0/0xe8
[   13.140243] sp : ffffff80114d3b40
[   13.143555] x29: ffffff80114d3b40 x28: ffffffc07333d280
[   13.148868] x27: ffffffc071b67a38 x26: 00000000000001e8
[   13.154180] x25: ffffff80114d3ca8 x24: ffffffc07190e400
[   13.159492] x23: ffffffc0748bca00 x22: ffffff8010ffd000
[   13.164803] x21: 0000000000000001 x20: ffffff80114d3c98
[   13.170113] x19: ffffff8010414e74 x18: ffffff8010ffda48
[   13.175423] x17: 0000000000000000 x16: 0000000000000000
[   13.180734] x15: ffffff80914d3867 x14: 0000000000000006
[   13.186044] x13: ffffff80114d3875 x12: ffffff801101c898
[   13.191371] x11: ffffff801101c000 x10: 0000000005f5e0ff
[   13.191416] type=1400 audit(16.743:79): avc: denied { read } for
comm="drmserver" name="enabled" dev="sysfs" ino=5492
scontext=u:r:drmserver:s0 tcont0
[   13.196698] x9 : ffffff80114d3800 x8 : 2966343034336663
[   13.196707] x7 : 6530303030303030 x6 : 0000000000000424
[   13.196713] x5 : 0000000000000000 x4 : 0000000000000000
[   13.196718] x3 : 0000000000000001 x2 : 0000000000000001
[   13.196724] x1 : b357113b3815f700 x0 : 0000000000000000
[   13.214445] type=1400 audit(17.075:84): avc: denied { read } for
comm="audioserver" name="enabled" dev="sysfs" ino=5492
scontext=u:r:audioserver:s0 t0
[   13.219604] Call trace:
[   13.219616]  __vunmap+0xe0/0xe8
[   13.219623]  __vfree+0x24/0x70
[   13.219635]  vfree+0x20/0x38
[   13.270258]  ffs_epfile_io.isra.12+0x190/0x6b0
[   13.274707]  ffs_epfile_read_iter+0xa0/0x168
[   13.278982]  __vfs_read+0x10c/0x168
[   13.282471]  vfs_read+0x8c/0x148
[   13.285700]  ksys_read+0x5c/0xc8
[   13.288930]  __arm64_sys_read+0x14/0x20
[   13.292773]  el0_svc_common.constprop.0+0xb0/0x110
[   13.297461] type=1400 audit(17.075:84): avc: denied { read } for
comm="audioserver" name="enabled" dev="sysfs" ino=5492
scontext=u:r:audioserver:s0 t0
[   13.297570]  el0_svc_handler+0x28/0x78
[   13.315592] type=1400 audit(17.179:85): avc: denied { read } for
comm="bootanimation" name="enabled" dev="sysfs" ino=5492
scontext=u:r:bootanim:s0 tc0
[   13.319239]  el0_svc+0x8/0xc
[   13.319245] ---[ end trace 729ab9edfbdb0764 ]---
