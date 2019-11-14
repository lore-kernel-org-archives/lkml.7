Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4710920729
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpr0h/OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKNNYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:24:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54774 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:24:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id z26so5651442wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mH8gSNIgKvgPetxbf7rz5MC4m16Vu7th8OeEJ1GZ3WA=;
        b=Bpr0h/OXlj7EmeJlqKo5Wxz48vyUoDHAdh0gSAeyCXdohmi5MPgIVj/TyCBuekAhF3
         gFp1ZwAyxRa3FeV7WaFB4OKxsHBcczf9n3bWeyGQocy/bQpENfSzWnxjFeLPkLUP7jZh
         oXApnfs7K0AeY1U4I6hYhIp5y1GAq+mMdoRjK7tzUcYNP0BghxA71HMGPkO9ouzmzmOk
         UgAOfc4VFrmZUladOiDb+8iL6BPdGlzmcCH2CRPNVHF5OY/2EoZBPhJRAaJWei+bhj1j
         Q25DDOekDlNrc0KXWe7VfOidfEK0JbYFGucPhFe/0fHohJAUZ/Sz5oOEHXwPXmvYmEMc
         +Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mH8gSNIgKvgPetxbf7rz5MC4m16Vu7th8OeEJ1GZ3WA=;
        b=LRyAXNfximTpfcr1ge335mfLPe/c6sYxXfSMER3mEwMta6nUN36EQDLkSwOxNpmI0Q
         N8s8DAi9iYafzLrPCzZxuqcPqxegalmN7yd/ea/HonjJY+4tueKS9E65KVIXVSsaeC4a
         74yJg41Ef57UdduO6wOYvdCjcvA+SIK6nuqGGp2RwqyFspxopCDKCXEKys1xYA8nStD9
         VvpspdlRCucIWRJ0nlj3OMWXrMJWNljGotKX3zlEUT1B2uT9WM1c1aR+XDRDJzodGvvO
         1L8MfTBP8TG3v7yv4FZrTvwqT19GFYa2/zqi1BWew3sjwjVua+50VxL1O55jkMRsxG44
         2jug==
X-Gm-Message-State: APjAAAVGUqaWO+AfERMqfC9wj90n4Jf0bhZtwFYknFN59qcLqjJKNS3N
        +3ursKisFhTMZf+23zv2cBk=
X-Google-Smtp-Source: APXvYqy0OzeEgjEqEz2o9WYlfcRhLzpSJymbbl4yemx7SJZX9xmA8PesRQtNcL6r6/RyfFNg5SDURQ==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr8347004wmb.142.1573737887726;
        Thu, 14 Nov 2019 05:24:47 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id a8sm5838054wme.11.2019.11.14.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 05:24:46 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        hjc@rock-chips.com
Cc:     heiko@sntech.de, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] add new DRM_DEV_WARN macro
Date:   Thu, 14 Nov 2019 16:24:34 +0300
Message-Id: <20191114132436.7232-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new DRM_DEV_WARN helper macro for warnings log output that include
device pointers. It also includes the use of the DRM_DEV_WARN macro in
drm/rockchip to replace dev_warn.

Wambui Karuga (2):
  drm/print: add DRM_DEV_WARN macro
  drm/rockchip: use DRM_DEV_WARN macro in debug output

 drivers/gpu/drm/rockchip/inno_hdmi.c | 3 ++-
 include/drm/drm_print.h              | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1

