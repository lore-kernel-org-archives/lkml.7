Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69511C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3490D206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZfWrTkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEPJqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:46:00 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42681 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEPJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:45:59 -0400
Received: by mail-wr1-f50.google.com with SMTP id l2so2593440wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aZ9bkwLjwgYofHPQHgcBu3CBvGQFImDSbHO1WQz0mYY=;
        b=rZfWrTkTck+lVapdMq7o6+lJhC3egiRrRwDcUJXql8roZ8bvlWlZ7OqDie4Xdv/FLt
         4Nf8iXWXd0ommmp1X6jmrgCNn9lJypjE/w4Wj4HYn2qO8TCdUWfpCjrDGjHqd3QEFKS3
         u9YhHrSsGbaHX9LzN+GHL+9hAARLNvw6357jpwPqiz1JeI5v5sWFmV5ebT25B0Aem+W9
         l8BHRwPDDYHZq+0DWgqwnUH9O/JiLlV97lCYxhvow/D27s6Wlyv8ZckIqmcwrRtGzym9
         tnEYkB63UrwTZZjJDqmo/sPBgP9i3zCZMEg3yG+IViiohgOM7HWyXuDMt6tvnzDG530d
         7jeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aZ9bkwLjwgYofHPQHgcBu3CBvGQFImDSbHO1WQz0mYY=;
        b=ok+ZPo/KnNxaaahGzhWND0wRFQEm9bJDUqg+i6dEbiJb0rwrQN7L7E6Qh7CBGf7gs7
         bzjMns5r3hqHhffdc2SH+sxOzm6glsePFkZmLpA46OWbl+lMkZYdPsPeNf70+EeKdqPP
         ammQo64IF0PxDd/o4NxVqIT6NZf/5z7qSbPN7uXH83Vp/AjJvPLho/nhrsSL3aA8c/Vk
         zgm51IfWTW+FBA+1DFJ7WSMxvlalltMXa9/qgh3QH57lNXUFqSRKDaTVoPNoeIRAX4I/
         K/B+51J4h6Q7d9hf7/5SIz1YlaQEpaMRJ2Sgdg0n8R/26IhTykaWDD3pNZyMv8puzsTJ
         jW4A==
X-Gm-Message-State: APjAAAW7lsd2Id72N0whtM/6jzmY0GZ9xnzrWmyF9DUFbnijGGehQ0Xa
        PkL3NZKvEl3cetICmzwHzf/Q8pNV
X-Google-Smtp-Source: APXvYqwFV+ytb+BzHJu+Jch7u4hZGa/rsqwHurysMjlxlhg3WyCIcfxA8PA2aGgS9XInLLu1U4/xhw==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr27614793wrv.221.1557999957592;
        Thu, 16 May 2019 02:45:57 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id i17sm5175786wrr.46.2019.05.16.02.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 02:45:56 -0700 (PDT)
Date:   Thu, 16 May 2019 11:45:54 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     maxime.ripard@bootlin.com, airlied@linux.ie, daniel@ffwll.ch,
        wens@csie.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: drm: sun4i: segmentation fault with rmmod sun4i_drm
Message-ID: <20190516094554.GA7178@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When I rmmod sun4i_drm I got
[  546.417886] Internal error: Oops: 17 [#1] SMP ARM
[  547.024731] CPU: 0 PID: 18811 Comm: rmmod Not tainted 5.1.0-next-20190515-00100-gf33d93f7d2a0 #39
[  547.033588] Hardware name: Allwinner sun7i (A20) Family
[  547.038816] PC is at drm_connector_cleanup+0x48/0x210
[  547.043874] LR is at sun4i_hdmi_unbind+0x18/0x5c [sun4i_drm_hdmi]
[  547.049959] pc : [<c08d313c>]    lr : [<bf051344>]    psr: a0000013
[  547.056217] sp : c46e1e90  ip : 00000000  fp : 00000000
[  547.061435] r10: 00000081  r9 : c46e0000  r8 : c0301204
[  547.066653] r7 : 00000000  r6 : c4b918a0  r5 : c4b91840  r4 : 00000000
[  547.073171] r3 : 00000000  r2 : 00000000  r1 : ee900210  r0 : c4b91840
[  547.079691] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  547.086817] Control: 10c5387d  Table: 446d406a  DAC: 00000051
[  547.092559] Process rmmod (pid: 18811, stack limit = 0x566ffc72)
[  547.098559] Stack: (0xc46e1e90 to 0xc46e2000)
[  547.102915] 1e80:                                     c4b91840 c4df5d80 00000018 00000000
[  547.111086] 1ea0: c0301204 c46e0000 00000081 bf051344 c4db7200 c4df5d80 00000018 c0974360
[  547.119256] 1ec0: 00000000 21c0d377 c46e1ec8 0000000e c4df5d80 c0974430 c4dc9800 ee900210
[  547.127426] 1ee0: bf02003c 00000081 c0301204 bf01f054 c4df5d80 ee900210 bf02003c c0974680
[  547.135596] 1f00: c4df5d80 c0974728 ee900210 ee900210 bf022104 bf01f014 ee900210 c097c648
[  547.143767] 1f20: ee900210 c1845388 bf022104 c097ae98 ee900210 bf022104 bed8eb98 c097afd4
[  547.151937] 1f40: bf022104 bf022180 bed8eb98 c0979c8c c46e0000 c03d4ea0 346e7573 72645f69
[  547.160107] 1f60: b6fa006d c170ae04 00000017 c031659c b6f048cc c46e1fb0 bed8ee14 000a2060
[  547.168278] 1f80: bed8eb7c c0316a74 ffffffff 21c0d377 00d8ed28 21c0d377 000278d4 346e7573
[  547.176448] 1fa0: 72645f69 c0301000 000278d4 346e7573 bed8eb98 00000880 00000000 bed8ee18
[  547.184618] 1fc0: 000278d4 346e7573 72645f69 00000081 00000000 00000000 b6fa2000 00000000
[  547.192788] 1fe0: bed8eb90 bed8eb80 000277b8 b6ea8420 60000010 bed8eb98 00000000 00000000
[  547.200979] [<c08d313c>] (drm_connector_cleanup) from [<bf051344>] (sun4i_hdmi_unbind+0x18/0x5c [sun4i_drm_hdmi])
[  547.211244] [<bf051344>] (sun4i_hdmi_unbind [sun4i_drm_hdmi]) from [<c0974360>] (component_unbind+0x30/0x68)
[  547.221063] [<c0974360>] (component_unbind) from [<c0974430>] (component_unbind_all+0x98/0xbc)
[  547.229670] [<c0974430>] (component_unbind_all) from [<bf01f054>] (sun4i_drv_unbind+0x38/0x4c [sun4i_drm])
[  547.239317] [<bf01f054>] (sun4i_drv_unbind [sun4i_drm]) from [<c0974680>] (take_down_master.part.0+0x18/0x30)
[  547.249221] [<c0974680>] (take_down_master.part.0) from [<c0974728>] (component_master_del+0x90/0x94)
[  547.258433] [<c0974728>] (component_master_del) from [<bf01f014>] (sun4i_drv_remove+0x14/0x1c [sun4i_drm])
[  547.268080] [<bf01f014>] (sun4i_drv_remove [sun4i_drm]) from [<c097c648>] (platform_drv_remove+0x24/0x3c)
[  547.277641] [<c097c648>] (platform_drv_remove) from [<c097ae98>] (device_release_driver_internal+0xdc/0x1ac)
[  547.287462] [<c097ae98>] (device_release_driver_internal) from [<c097afd4>] (driver_detach+0x54/0xa0)
[  547.296675] [<c097afd4>] (driver_detach) from [<c0979c8c>] (bus_remove_driver+0x4c/0xa0)
[  547.304762] [<c0979c8c>] (bus_remove_driver) from [<c03d4ea0>] (sys_delete_module+0x178/0x1f4)
[  547.313370] [<c03d4ea0>] (sys_delete_module) from [<c0301000>] (ret_fast_syscall+0x0/0x54)
[  547.321622] Exception stack(0xc46e1fa8 to 0xc46e1ff0)
[  547.326671] 1fa0:                   000278d4 346e7573 bed8eb98 00000880 00000000 bed8ee18
[  547.334841] 1fc0: 000278d4 346e7573 72645f69 00000081 00000000 00000000 b6fa2000 00000000
[  547.343008] 1fe0: bed8eb90 bed8eb80 000277b8 b6ea8420
[  547.348061] Code: e5853310 e1a06005 e5b63060 e1560003 (e5934000) 
[  547.354336] ---[ end trace 8bd87feb5ea08d7d ]---
Segmentation fault

This occurs both on qemu-cubieboard and cubieboard2

Regards
