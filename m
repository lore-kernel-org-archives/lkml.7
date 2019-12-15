Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC29C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 03:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC972073D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 03:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTcdmZlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfLODRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 22:17:20 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40976 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfLODRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 22:17:19 -0500
Received: by mail-qv1-f68.google.com with SMTP id x1so18045qvr.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 19:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=/dXw9e16vwl8LpxK98yuq5eDs/kqmpne1VxegZwo9tU=;
        b=vTcdmZlKxf6Ut2mCo3MRUIykmRVOIPR2SVz/XMIIfmlf/CcR506FaZII7DWsRM3CHr
         75t2eanICwi/fUz5NNcTcLldWv0vqC/gj/g40ABeMzqbMJ/FmaHIIUFdlVfthXI2Sw1v
         Hh1U26lmbHakoyOqgN8XPmHJDBaGLmyqvia0gvl5LRV74J/Nff/hsv1lzqO+80XT4wKW
         1hCHVfvRXrh9jcpQ6c1k3mb1scR3m8Z3IjsivBU208msc8JVqlo+3kqOgjbFerQSJCW7
         T59YDUW02RVo6sAw/GlY15kwdIlEpUXY2GaKej0Ra0+h4nR2FBUSEGlQQ5Q0CjlpKLOk
         BQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=/dXw9e16vwl8LpxK98yuq5eDs/kqmpne1VxegZwo9tU=;
        b=UF94Twmr2UtwqogQEeBG3gzbDWCvwLFpoJcD+P6dckoBl5j5gYkD5taI97L9Zjidl9
         fvkE2TjXrCzdMEvghDW8bgYYp6B8ScZ0LVP6BbQbjGvbMPTl7AxzPWQFll7ftiuMsfa5
         ebpqtCkuRXWvm0pxojMW4slFj4INF/+S/2FmHOiVX6JKRLrvs3cPmEzpzpjs5IL7KisT
         H+kFrYGy2f8Kne4e4cUFn/fXEwnRAxl28FN8nNrblO/Hdsqk5+dFek0GD/5j5wMsVjJ1
         c9fItuCVk2gczFYfCeQT3QpwH3L+9Jajp+tqHPD+Zhs3a2LpyvGPIxwdYX/lJymwYN6B
         i7vA==
X-Gm-Message-State: APjAAAVI21lVmrZb4JcUZK0RYTEWLav6KCeUpKGQKxk4Hk3eTxQ/HNqj
        O9/l52BBECqcHD73faLpXQ==
X-Google-Smtp-Source: APXvYqzBXdaiKTf32Px9Udixmb+daFEYrWp8FC6bTC09CpUnoxtDzvVcUtp18RU54sNJ609QMeCjIA==
X-Received: by 2002:a05:6214:7cc:: with SMTP id bb12mr5862753qvb.207.1576379838584;
        Sat, 14 Dec 2019 19:17:18 -0800 (PST)
Received: from [120.7.1.38] ([184.175.21.212])
        by smtp.gmail.com with ESMTPSA id c84sm4567540qkg.78.2019.12.14.19.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2019 19:17:17 -0800 (PST)
To:     hch@lst.de, DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pavel Machek <pavel@ucw.cz>
From:   Woody Suwalski <terraluna977@gmail.com>
Subject: Regression in 5.4 kernel on 32-bit Radeon IBM T40
Message-ID: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
Date:   Sat, 14 Dec 2019 22:17:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression in 5.4 kernel on 32-bit Radeon IBM T40
triggered by
commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Aug 15 09:27:00 2019 +0200

Howdy,
The above patch has triggered a display problem on IBM Thinkpad T40, 
where the screen is covered with a lots of random short black horizontal 
lines, or distorted letters in X terms.

The culprit seems to be that the dma_get_required_mask() is returning a 
value 0x3fffffff
which is smaller than dma_get_mask()0xffffffff.That results in 
dma_addressing_limited()==0 in ttm_bo_device(), and using 40-bits dma 
instead of 32-bits.

If I hardcode "1" as the last parameter to ttm_bo_device_init() in place 
of a call to dma_addressing_limited(),the problem goes away.

I have added the debug lines starting with "wms:" to the start of 
radeon_ttm_init() and of radeon_device_init()printing the interesting 
variables.
/....
[    2.091692] Linux agpgart interface v0.103
[    2.092380] agpgart-intel 0000:00:00.0: Intel 855PM Chipset
[    2.107706] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    2.108111] [drm] radeon kernel modesetting enabled.
[    2.108200] radeon 0000:01:00.0: vgaarb: deactivate vga console
[    2.109365] Console: switching to colour dummy device 80x25
******* radeon_device_init()
[    2.110712] wms: radeon_init flags = 0x90003
[    2.110718] [drm] initializing kernel modesetting (RV200 
0x1002:0x4C57 0x1014:0x0530 0x00).
[    2.111220] agpgart-intel 0000:00:00.0: AGP 2.0 bridge
[    2.111233] agpgart-intel 0000:00:00.0: putting AGP V2 device into 1x 
mode
[    2.111265] radeon 0000:01:00.0: putting AGP V2 device into 1x mode
[    2.111286] radeon 0000:01:00.0: GTT: 256M 0xD0000000 - 0xDFFFFFFF
[    2.111295] radeon 0000:01:00.0: VRAM: 128M 0x00000000E0000000 - 
0x00000000E7FFFFFF (32M used)
[    2.111701] [drm] Detected VRAM RAM=128M, BAR=128M
[    2.111704] [drm] RAM width 64bits DDR
******* radeon_ttm_init()
[    2.111706] wms: dma_addressing_limited=0x0
[    2.111709] wms: dma_get_mask=0xffffffff, bus_dma_limit=0x0, 
dma_get_required_mask=0x3fffffff
[    2.115971] [TTM] Zone  kernel: Available graphics memory: 437028 KiB
[    2.115973] [TTM] Zone highmem: Available graphics memory: 510440 KiB

What should be the proper value of these dma variables on the 32-bit system?
How to fix that issue correctly (patches welcomed :-) )Or is the 
platform fubar?

Thanks, Woody


