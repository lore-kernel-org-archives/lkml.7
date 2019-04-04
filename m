Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CD0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DDC20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgjsw7Ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfDDSe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:34:57 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:46351 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfDDSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:34:57 -0400
Received: by mail-yb1-f171.google.com with SMTP id u15so1390662ybj.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AEF8idl1k/6CbtTHbpa/B4FiEnoFupc+OZz98Gp/k0I=;
        b=Pgjsw7CkJTN19rp00qcfdU+43yN9vsD/xYSRYa1A/8uXCqj1t4/0XsrG6ZV+15qgfA
         Si9r2fmwFDm93Osqr2/ea3fQf76OM7OzZQo21UWHwdK4U7JhcPiB2CpC5B5hCoq9yobL
         r1Y5zTunUmTgafRhf6Sg8ho77+49kIc576gGU+IqxtlTxWwxextrQWhA6yf5HT4njlhl
         uBC3R9GpNXCYyi+nBkXk9zrVGIvi0F8kdi2X5HEQ9W/8gy1zjShZ9cGhtMO93vakXnBW
         0+aUtlPs9oj95zxEUfoGVejujJv/fBMelQ9soIat7MoJLZ4GYEerUD4TuMQEZ/n8ITwm
         m/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AEF8idl1k/6CbtTHbpa/B4FiEnoFupc+OZz98Gp/k0I=;
        b=ATYOu0OlPi7TFu+rny6jfELWO951/JYu7YmGkqbMm8dejug+gouL4QcyCzwZNqlCnC
         LnKHEgaYzfp/8SWbWZBxfS8j7jKeqJh6ySBL9WukSuFWQti4pJD0/u4lV4yiglwSXx9L
         2KZWIfHMyHWtjLLDFwWhNXbCUI/+FheshJ+rq1IZEks4tjBwxReC8zyWE2NW3ApyaB/T
         5Dc2Jb2fhb+KZt16awkQlvTXp4H8xmD7sasD5p1osErXdVPe1kXcMXVkAVYBaZMOil2M
         SBTpGsyUZSFnT6/LQqAcxVg78TajPMeCwUvdx/6Ovw8BqgIj6B9irlr8Dmta00JCNmIc
         b9Cg==
X-Gm-Message-State: APjAAAX4+DyGc3D7XljyM9cvUX3yaq5xjnfgdilQI7QOzQ/5Pr1flLjd
        0aj9/VBwySIvNvfCLHgK823AAdilRhhc80N/abgXAytEXs0=
X-Google-Smtp-Source: APXvYqz4pEmZyGugESV1VO3yirMl11rHwempLQRJ/1T1Rhz3P73kEySfi3Dyl+Yo/Hx3lsUWYXJ/vV28OHR5Ouxfbwk=
X-Received: by 2002:a25:4e89:: with SMTP id c131mr6774713ybb.430.1554402896346;
 Thu, 04 Apr 2019 11:34:56 -0700 (PDT)
MIME-Version: 1.0
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 4 Apr 2019 11:34:45 -0700
Message-ID: <CAMo8BfLhD8nobFF9bo-=ZoXbG_ZGRPs5AEF2pSCEXWsmS7n8DA@mail.gmail.com>
Subject: 'sleeping function called from invalid context' in virtio_gpu_cmd_get_edid_cb
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get the following warning during v5.1-rc3 bootup on QEMU with virtio-gpu-pci

BUG: sleeping function called from invalid context at mm/slab.h:418
in_atomic(): 1, irqs_disabled(): 0, pid: 14, name: kworker/0:1
Preemption disabled at:
 virtio_gpu_cmd_get_edid_cb+0x4c/0x9c
CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 5.1.0-rc3-00007-g2c6e21bcbbae #6
Workqueue: events virtio_gpu_dequeue_ctrl_func
Call Trace:
 ___might_sleep+0xfc/0x11c
 __might_sleep+0x42/0x64
 __kmalloc+0x66/0x1f0
 kvmalloc_node+0x66/0x7c
 drm_property_create_blob$part$0+0x14/0x8c
 drm_property_replace_global_blob+0x40/0xdc
 drm_connector_update_edid_property+0x58/0x74
 virtio_gpu_cmd_get_edid_cb+0x62/0x9c
 virtio_gpu_dequeue_ctrl_func+0xd1/0x188
 process_one_work+0x1a0/0x388
 worker_thread+0x1e8/0x3b4
 kthread+0xe8/0x100
 ret_from_kernel_thread+0xc/0x18

Looks like virtio_gpu_cmd_get_edid_cb calls
drm_connector_update_edid_property under the spinlock and the
latter function may sleep.
-- 
Thanks.
-- Max
