Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3474BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C0A2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXG35cd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgAINRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:17:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50670 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgAINQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:16:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2896654wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BNkQ9Cx0ZoIMZAYMV/rMk6B154SeQhI3flgQ2e176U=;
        b=dXG35cd9I99Oh5YtG0EuFk0Pc4FpB51V8ry3MtyHz969Nx/SmgzUTuV1CZzH3tGfMg
         7CAIkpcho5pguYAE2qGrwtttBQ7Dcv4XEW9jXa1A0Y9Zr3TUElCADaDmlVJMRsnsO4n0
         SPTTKdURg/ApM5eY+oLcU8hIFmgDdzXiISCBi/zihNxpT1bP1tPYNjXzgsHE7359gzf4
         kVKdnBMsLgdMONKMxFXZwIJteaVNP0UC4foTC+9fdq42kZZJeCVWkY7lPfwWzNK3Qh6y
         Iedyve37CeKNcibc8uXS/ysv9r2J9bYqM4cluGHBm+fla8RxKHU0alzvd2Bxw6I4/HdK
         Amjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BNkQ9Cx0ZoIMZAYMV/rMk6B154SeQhI3flgQ2e176U=;
        b=jBwC6XUtLfIu/I3AN5wyHEk34srWy7XV1AQb/jatyZs3uJHD3Vrm8I4u+YvBwuWp4G
         C2D0AKA8epeuull2s/H4kSsWiWhBfQ1ui+5eO30CE/Oh/pg/2Yi8wTRt2ksvgfNSOjbx
         +CosFnSW5mb+uvJoZNew3dAu963trWg3EHcIIh5s1Cx39yq+kQh62MYzN4fJ8EjA4+hZ
         ZlnO9rYolZciNFCeNlMlbXZ5J+UMQ0//WfzZYDbo3y49VUoi7MKewyW4V+jiEdf2q8RX
         q+WZvM6tiW0IagyZ7cPfyujAkWhkJEPau5flpBL9QFlzQqBoVKI4nDh10WR56JK1Jzk8
         Z6mA==
X-Gm-Message-State: APjAAAWdOpwuk9VW/kgQc3/7Ryzm1QXaT2uFtGO0pkSumAknigaFLni2
        +hQacu1KfLtU7vSnor1byyArew==
X-Google-Smtp-Source: APXvYqzk9w+SVe4ryy4vkyIAwk/aDqLaLnzM0ZIlf8Y/XqkEsoSyvY7PLzN4E6rLMbPXfl0huFn9EA==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr4971600wmo.13.1578575817606;
        Thu, 09 Jan 2020 05:16:57 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id u22sm8172989wru.30.2020.01.09.05.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:16:56 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] Fix two NULL pointer dereferences when role-switching
Date:   Thu,  9 Jan 2020 13:17:20 +0000
Message-Id: <20200109131722.4090238-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the f_ncm and f_ecm drivers use setting of [ne]cm->notify_req to NULL
to indicate a request is in-flight. This however can lead to a NULL pointer
dereference in the ubind() path of both drivers.

These two patches fix the error by using an atomic_t as a flag like is done
in the f_rndis driver.

# Setup
  mount -t configfs none /sys/kernel/config/
  cd /sys/kernel/config
  cd usb_gadget/
  mkdir g1
  cd g1/
  echo 0x1209 > idVendor
  echo 0x0001 > idProduct
  mkdir strings/0x409
  echo 0123456789 > strings/0x409/serialnumber
  echo B0D > strings/0x409/manufacturer
  echo B0D-device > strings/0x409/product
  mkdir functions/ncm.usb0
  mkdir configs/c.1
  mkdir configs/c.1/strings/0x409
  echo CDC NCM > configs/c.1/strings/0x409/configuration
  ln -s functions/ncm.usb0 configs/c.1
  echo 7580000.dwc3 > UDC

# Give both ends an IP
  device:
    ifconfig usb0 192.168.8.2
  host:
    ifconfig usbX 192.168.8.1
    ping 192.168.8.2

# Pull out device cable
# Attach a device to the target triggering a role switch and an unbind()

[  115.776303] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  115.776326] Mem abort info:
[  115.784159]   ESR = 0x96000006
[  115.786653]   EC = 0x25: DABT (current EL), IL = 32 bits
[  115.789798]   SET = 0, FnV = 0
[  115.795255]   EA = 0, S1PTW = 0
[  115.798121] Data abort info:
[  115.801157]   ISV = 0, ISS = 0x00000006
[  115.804286]   CM = 0, WnR = 0
[  115.807845] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000083919000
[  115.810962] [0000000000000000] pgd=000000008391f003, pud=0000000083920003, pmd=0000000000000000
[  115.817406] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[  115.825892] Modules linked in:
[  115.831447] CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.5.0-rc3-00075-gb6e9f933acdf #161
[  115.834577] Hardware name: Qualcomm Technologies, Inc. QCS404 EVB 4000 (DT)
[  115.842830] Workqueue: events_freezable __dwc3_set_mode
[  115.849764] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  115.854973] pc : ncm_unbind+0x58/0x78
[  115.859832] lr : ncm_unbind+0x54/0x78
[  115.863562] sp : ffff80001014bc70
[  115.867208] x29: ffff80001014bc70 x28: 0000000000000000 
[  115.870510] x27: ffffce10ed07a510 x26: ffffce10ecf959b8 
[  115.875891] x25: ffff00003daa9000 x24: ffff00003daa9490 
[  115.881186] x23: ffff00003da8f200 x22: ffff00003da8f168 
[  115.886482] x21: ffff00003da8f0b8 x20: ffff00003da8f120 
[  115.891776] x19: ffff00003d05fa00 x18: ffffffffffffffff 
[  115.897072] x17: 0000000000000000 x16: 0000000000000000 
[  115.902366] x15: ffffce10ed6ae000 x14: 00000000fffffff0 
[  115.907662] x13: ffffce10ed883fb0 x12: ffffce10ed6ae000 
[  115.912957] x11: 0000000000000000 x10: 0000000000000000 
[  115.918252] x9 : 0000000000000007 x8 : 0000000040000000 
[  115.923546] x7 : 0000000000000000 x6 : 000000008010000d 
[  115.928842] x5 : ffffce10ec793638 x4 : ffff000039772600 
[  115.934137] x3 : 000000008010000d x2 : fffffe0000c5dca0 
[  115.939433] x1 : 4625c8679f119400 x0 : 0000000000000000 
[  115.944729] Call trace:
[  115.950021]  ncm_unbind+0x58/0x78
[  115.952193]  purge_configs_funcs+0x130/0x138
[  115.955666]  configfs_composite_unbind+0x58/0x98
[  115.960007]  usb_gadget_remove_driver+0x54/0x88
[  115.964607]  usb_del_gadget_udc+0x8c/0xf8
[  115.968860]  dwc3_gadget_exit+0x18/0x68
[  115.973026]  __dwc3_set_mode+0x138/0x258
[  115.976675]  process_one_work+0x1e0/0x358
[  115.980839]  worker_thread+0x40/0x488
[  115.984746]  kthread+0x118/0x120
[  115.988391]  ret_from_fork+0x10/0x18
[  115.991691] Code: aa1303e0 391e603f 97ffb836 f940a260 (f9400000) 
[  115.995253] ---[ end trace ab25b53d409d0cf3 ]---

Bryan O'Donoghue (2):
  usb: gadget: f_ncm: Use atomic_t to track in-flight request
  usb: gadget: f_ecm: Use atomic_t to track in-flight request

 drivers/usb/gadget/function/f_ecm.c | 16 ++++++++++++----
 drivers/usb/gadget/function/f_ncm.c | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.24.0

