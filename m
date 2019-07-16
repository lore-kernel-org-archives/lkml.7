Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E780DC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8CB2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCtz0JYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfGPLL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:11:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45361 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733200AbfGPLL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:11:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so9260716pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tG4oN7QUyXBM9ONfLmraVG6pWQWDU28XTB/o4iOsC64=;
        b=lCtz0JYSz/PN5ckXRERy5AhE//7W2BwCQ5+3jNGJLYSoc6xU4cGFZVKPCTcwZPDPde
         ZMAQNppd4iZ/2+BxXt9OqQAob7W24AQe8KeMnseH7Ix83ZM5Kl9it6WcPSTJLmMErMz/
         jKY4LWMLzCGtGDexq48mmnbjGK1AFtrvOOUoYnTRXteWT+KVoBoCGshkqRYACoPC7D1K
         COyc+MfsbAinmNXL/VXcywePCUgFKvch/hWkefQpW1jj5Q5CbEGGACfPr5Fm+Bsn4/XU
         Er41rmbDvQBW/5uOwpmYCUfFmefUg3m1GGvywEZnR3K0rufXC1kTEVNbp5TeB/DzZcZY
         e6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tG4oN7QUyXBM9ONfLmraVG6pWQWDU28XTB/o4iOsC64=;
        b=Y+nHhxZbmyMEyaHt4EaqluXcsMeG8Ev5uUAYO4q6/lb98OzqV3h41+AKrTkZEfQx33
         nSjHgj+iRF19gy/eib1szMbfrdjtrf6Or+v6be6IZsQqAKbm6UKsBFAXBJweRm45l5ev
         E5lv0Vz+KQOdvm0HJH/MtQ7TdHsag8YRnCEFdJIxSff8rnWycUgdebCo90RVqWr4VGsP
         ywCwheR7hNmiVEEnZ16BbHgXb5Rd0yVJMODDHnnssg7q7MZxreI4ciGRTsSKdUqj0frT
         3fsWqNb0AgKo5/hP0BuiZDn+g3gcaPMw54aT8+tD/JACtr7vARjjLE4SuBWinweCnOeY
         Mw+w==
X-Gm-Message-State: APjAAAVZa839+vFFsIFgtHGqS6NRQmJEQYpKmnBOqCC+Go6bXL5RWsRk
        iOrtisAbKOaTxI2qTrL8bSYnen037it2olqu
X-Google-Smtp-Source: APXvYqwPS+CFG1iax9c+LnijjFVPtOXpIKUde+Ow5kW1GvzLjT6mFfO0E6b+5ySl1KmmSCkZDEJPCQ==
X-Received: by 2002:a17:90a:3401:: with SMTP id o1mr35150615pjb.7.1563275485431;
        Tue, 16 Jul 2019 04:11:25 -0700 (PDT)
Received: from ubuntu ([101.198.192.11])
        by smtp.gmail.com with ESMTPSA id i9sm16978531pjj.2.2019.07.16.04.11.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 04:11:25 -0700 (PDT)
Date:   Tue, 16 Jul 2019 04:11:22 -0700
From:   JingYi Hou <houjingyi647@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix double fetch in
 amdgpu_ras_debugfs_ctrl_parse_data()
Message-ID: <20190716111122.GA35069@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amdgpu_ras_debugfs_ctrl_parse_data(), first fetch str from buf to
get op value, if op == -1 which means no command matched, fetch data
from buf again.

If change buf between two fetches may cause security problems or
unexpected behaivor. amdgpu_ras_debugfs_ctrl_parse_data() was called
by amdgpu_ras_debugfs_ctrl_write() and value of op was used later.

We should check whether data->op == -1 or not after second fetch. if
data->op != -1 means buf changed and should return -EINVAL.

Signed-off-by: JingYi Hou <houjingyi647@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 22bd21efe6b1..845e73e98cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -233,6 +233,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,

 		if (copy_from_user(data, buf, sizeof(*data)))
 			return -EINVAL;
+
+		if(data->op != -1)
+			return -EINVAL;
 	}

 	return 0;
--
2.20.1

