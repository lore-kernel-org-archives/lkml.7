Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD4CC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389AB2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0Sjecpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfIKSOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:14:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35569 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfIKSOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:14:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so14214740pfw.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QeCkq8O6sVKFyd/945VFVyHWjibGiHNZAw/pssnAllE=;
        b=I0SjecpohOXAuX41i+C8/iUqI2Ta/6iJL/5++KgCgax3VgHtodgZSCGi7o9EreJyrD
         XN0LgK6zJ5+788K+EAIjt5svypU/Lzsd2QUfTjt+P+eZTKhp+EFx4sOxnOi/RLxhKSNl
         kPHqBgZR/n6Pnn3u/zAydjw5VQM4t4SSuZetI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QeCkq8O6sVKFyd/945VFVyHWjibGiHNZAw/pssnAllE=;
        b=Z3A6mc9QEsN6GwMmkmsBJ/jTF1fffJq0a0VQO6oZKwoem3mVw/LoQkzx1YXlp0wDXv
         tmY+Rjy0cmp9W1rQAXULZtMxShndZc6bHiFClZaGVF4BlNTmG1v4G4/GQPlmYF6sj826
         rcxnXNs2AkOA6AHiyCBe4NO3ZzPrIHww6vnSz7dqDIIoc891ZHVzLC8IVdhnJ7WxewBP
         KVwgnMmMlKBeSCbSIAyD3Z2rig94uEQx+EOjNujjk8JtXH1TFbd8oVnWvOqvTIdeYT4w
         ozSXrJ3wzam1G7uMJDjs5WxbuCFowTnrvPNVdx59Z8aXp993RGIE+3S7Wx8R+WoOMjsb
         NN9A==
X-Gm-Message-State: APjAAAWnBuwi28ciuEQrCm8asxn4X9Li3VIBdKrSR2CUxRbXxgzawNyS
        5ykND5GgqdJpQu5boOUYs8Fs+Q==
X-Google-Smtp-Source: APXvYqw2YMboZHNEz3lO+hmTQMf8RZ0yNwApdiKl8X00zTdruij3p8IG09Q5F3leuHLIUyGCjDM6/A==
X-Received: by 2002:a62:1c16:: with SMTP id c22mr45606019pfc.10.1568225650053;
        Wed, 11 Sep 2019 11:14:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id a13sm31056059pfg.10.2019.09.11.11.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:14:08 -0700 (PDT)
From:   David Riley <davidriley@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v4 0/2] drm/virtio: Use vmalloc for command buffer alllocations.
Date:   Wed, 11 Sep 2019 11:14:01 -0700
Message-Id: <20190911181403.40909-1-davidriley@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
In-Reply-To: <20190829212417.257397-1-davidriley@chromium.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace requested command buffer allocations could be too large
to make as a contiguous allocation.  Use vmalloc if necessary to
satisfy those allocations.

v1: Initial version.
v2: Properly account for number of free descriptors required.
v3: Remove offset handling for vmalloc'd buffers.
v4: Rebase onto drm-misc-next.

David Riley (2):
  drm/virtio: Rewrite virtio_gpu_queue_ctrl_buffer using fenced version.
  drm/virtio: Use vmalloc for command buffer allocations.

 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  4 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 98 ++++++++++++++++++++------
 2 files changed, 79 insertions(+), 23 deletions(-)

-- 
2.23.0.162.g0b9fbb3734-goog

