Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC2BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2096208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yfe6M3Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfDAPZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:25:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55597 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:25:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190401152533euoutp0213d0d8e8f0187707fc9b345395851639~RYx_J6QE83099430994euoutp02w
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 15:25:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190401152533euoutp0213d0d8e8f0187707fc9b345395851639~RYx_J6QE83099430994euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554132333;
        bh=IF35WPx7Dp4IdfhClZRBZU08VrO+emKaalRA5S32UNo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Yfe6M3DpFyHoM9V5CeLT1SE6CbTrK1/8Y5pqccatcXFDbqdY0wnUk2gwSQseLyfWT
         h1YJS8s/u5uYvS0XEHb6f9y9Z86Q90+NlrTc+ZGedA1HD5OuUmrko9S7/OQ56r32zi
         MirVZkxoZ6s6juyZhj+vK9zdL/HBP/b4fX86jVag=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401152532eucas1p24d7c74ff47e8221650163522d8097c4a~RYx9iL19h0943509435eucas1p2I;
        Mon,  1 Apr 2019 15:25:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FF.C1.04325.C6D22AC5; Mon,  1
        Apr 2019 16:25:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190401152531eucas1p1ea4cb542e57094aba701cc5b77210f16~RYx8jSuwo0239502395eucas1p1u;
        Mon,  1 Apr 2019 15:25:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401152531eusmtrp21e83afa8882c19b69710adc827d86432~RYx8VSfMc0674106741eusmtrp2d;
        Mon,  1 Apr 2019 15:25:31 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-8d-5ca22d6c0b55
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4F.A7.04146.B6D22AC5; Mon,  1
        Apr 2019 16:25:31 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190401152531eusmtip1c0b677572c6f62830371bd032dcee158~RYx79K0hM0978109781eusmtip1L;
        Mon,  1 Apr 2019 15:25:31 +0000 (GMT)
Subject: Re: [PATCH] fbdev: fix divide error in fb_var_to_videomode
To:     Mukesh Ojha <mojha@codeaurora.org>, shile.zhang@linux.alibaba.com
Cc:     Fredrik Noring <noring@nocrew.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <1c83bcd9-11e5-660e-d9d6-93f50c33d194@samsung.com>
Date:   Mon, 1 Apr 2019 17:25:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <a3eedb3a-bd70-a33c-a0d1-d111ed11d7de@codeaurora.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7o5uotiDFquyVssfHiX2eLK1/ds
        Fif6PrBaXN41h83iyf4ZzBY3WoUttq+XcWD3uNzXy+Sx99sCFo+dDy097ncfZ/L4fuIIm8fn
        TXIBbFFcNimpOZllqUX6dglcGetmLWcraBKraG75ztLAeEegi5GTQ0LAROLJrbmMXYxcHEIC
        KxglZs65C+V8YZS48XIuG4TzmVHiQ9t5VpiWH62HWSESyxklLj5dClX1llHiwJWbzCBVwgLO
        ErNOTGQEsUUEXCVuXP8GVsQssI5Rov3dW7BRbAJWEhPbV4EV8QrYSWx6cogJxGYRUJHoPdYE
        VMPBISoQIdF/Rh2iRFDi5MwnLCA2p4CTxP/5TewgNrOAvMT2t3OYQeZLCKxil7g4G6JIQsBF
        ou/ganYIW1ji1fEtULaMxP+d85kgGoAO+tvxAqp7O6PE8sn/2CCqrCUOH78IdgWzgKbE+l36
        EGFHiTOTz7CAhCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auRKqxEPi2Rzj
        CYyKs5B8NgvJN7MQ1i5gZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmHBO/zv+dQfj
        vj9JhxgFOBiVeHg5xBfFCLEmlhVX5h5ilOBgVhLhPdO/IEaINyWxsiq1KD++qDQntfgQozQH
        i5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QDY0ot0yXdVax3tyzV+P9229IoqQt7U8yfffaR
        jj66ITjsQtwL/8/vxQM6VXkW9XCoihX0/HP5bmM5uXu6wf1dCbsyfNdePvfl8DflRo8f6yfI
        PvSv3Krlr+drmnfpkYjdnq6/hUvLBWe2HvB1zopg2Ku1/mBfK8OfIumirvIXovdX3V3Mtf3h
        GSWW4oxEQy3mouJEABO8oDE0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7rZuotiDJ5ekLNY+PAus8WVr+/Z
        LE70fWC1uLxrDpvFk/0zmC1utApbbF8v48Ducbmvl8lj77cFLB47H1p63O8+zuTx/cQRNo/P
        m+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
        MtbNWs5W0CRW0dzynaWB8Y5AFyMnh4SAicSP1sOsXYxcHEICSxklDq3oYe9i5ABKyEgcX18G
        USMs8edaFxtEzWtGie4TB9lBEsICzhKzTkxkBLFFBFwlblz/BlV0i1Hi6tRFYA6zwDpGibYr
        l1lAqtgErCQmtq8C6+AVsJPY9OQQE4jNIqAi0XusiRXEFhWIkLj1sIMFokZQ4uTMJ2A2p4CT
        xP/5TWCbmQXUJf7Mu8QMYctLbH87h3kCo+AsJC2zkJTNQlK2gJF5FaNIamlxbnpusaFecWJu
        cWleul5yfu4mRmAsbTv2c/MOxksbgw8xCnAwKvHwRggtihFiTSwrrsw9xCjBwawkwnumf0GM
        EG9KYmVValF+fFFpTmrxIUZToCcmMkuJJucD4zyvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBA
        emJJanZqakFqEUwfEwenVAMj48X8Th+RX/Fnb6fvvuXB4frYcYOu5fo5jJffb7Pr2vGG7Q8r
        h8jzT6VuwUbW9Sud2ywEY/sPpYc/zzNZMN//wtSQBBeXjaKXruwq/bs0wGJPjKAYw2nNakGX
        SZPWr6mcNT/KzHmDVnRELG/O4skCpYnXYrInndyWd3vGWZfQGedFP0x1WpOgxFKckWioxVxU
        nAgAqf6HHLsCAAA=
X-CMS-MailID: 20190401152531eucas1p1ea4cb542e57094aba701cc5b77210f16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190329204639epcas4p4baaa2d4b9fd90c911a4aba6c10a200bb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190329204639epcas4p4baaa2d4b9fd90c911a4aba6c10a200bb
References: <1552998003-237288-1-git-send-email-shile.zhang@linux.alibaba.com>
        <CGME20190329204639epcas4p4baaa2d4b9fd90c911a4aba6c10a200bb@epcas4p4.samsung.com>
        <a3eedb3a-bd70-a33c-a0d1-d111ed11d7de@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/29/2019 09:46 PM, Mukesh Ojha wrote:
> 
> On 3/19/2019 5:50 PM, shile.zhang@linux.alibaba.com wrote:
>> From: Shile Zhang <shile.zhang@linux.alibaba.com>
>>
>> To fix following divide-by-zero error found by Syzkaller:
>>
>>    divide error: 0000 [#1] SMP PTI
>>    CPU: 7 PID: 8447 Comm: test Kdump: loaded Not tainted 4.19.24-8.al7.x86_64 #1
>>    Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>>    RIP: 0010:fb_var_to_videomode+0xae/0xc0
>>    Code: 04 44 03 46 78 03 4e 7c 44 03 46 68 03 4e 70 89 ce d1 ee 69 c0 e8 03 00 00 f6 c2 01 0f 45 ce 83 e2 02 8d 34 09 0f 45 ce 31 d2 <41> f7 f0 31 d2 f7 f1 89 47 08 f3 c3 66 0f 1f 44 00 00 0f 1f 44 00
>>    RSP: 0018:ffffb7e189347bf0 EFLAGS: 00010246
>>    RAX: 00000000e1692410 RBX: ffffb7e189347d60 RCX: 0000000000000000
>>    RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb7e189347c10
>>    RBP: ffff99972a091c00 R08: 0000000000000000 R09: 0000000000000000
>>    R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000100
>>    R13: 0000000000010000 R14: 00007ffd66baf6d0 R15: 0000000000000000
>>    FS:  00007f2054d11740(0000) GS:ffff99972fbc0000(0000) knlGS:0000000000000000
>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    CR2: 00007f205481fd20 CR3: 00000004288a0001 CR4: 00000000001606a0
>>    Call Trace:
>>     fb_set_var+0x257/0x390
>>     ? lookup_fast+0xbb/0x2b0
>>     ? fb_open+0xc0/0x140
>>     ? chrdev_open+0xa6/0x1a0
>>     do_fb_ioctl+0x445/0x5a0
>>     do_vfs_ioctl+0x92/0x5f0
>>     ? __alloc_fd+0x3d/0x160
>>     ksys_ioctl+0x60/0x90
>>     __x64_sys_ioctl+0x16/0x20
>>     do_syscall_64+0x5b/0x190
>>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>    RIP: 0033:0x7f20548258d7
>>    Code: 44 00 00 48 8b 05 b9 15 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 15 2d 00 f7 d8 64 89 01 48
>>
>> It can be triggered easily with following test code:
>>
>>    #include <linux/fb.h>
>>    #include <fcntl.h>
>>    #include <sys/ioctl.h>
>>    int main(void)
>>    {
>>            struct fb_var_screeninfo var = {.activate = 0x100, .pixclock = 60};
>>            int fd = open("/dev/fb0", O_RDWR);
>>            if (fd < 0)
>>                    return 1;
>>
>>            if (ioctl(fd, FBIOPUT_VSCREENINFO, &var))
>>                    return 1;
>>
>>            return 0;
>>    }
>>
>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> 
> To avoid any exception we should include the check.
> Looks fine to me.
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
