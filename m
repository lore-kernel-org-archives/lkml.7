Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A45CC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64ABB20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aXsWgQ9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389932AbfFJVSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:18:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46832 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfFJVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:18:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so5987229pfy.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0QdMbKNLVs0T8bKlIwsAC6CTJBWav9NlL0ckO7DwlA=;
        b=aXsWgQ9MISu7GVEUvnuqIx+fsqGjVQgLb+MZC1mkE1EKEL+Yw+ZR7o/wgZr5NWOk4A
         rFulQA7GH29PRBa/ecTRG3Ylp+faYI3nHqeOr5anX/cH/RqXZ+YLWjGA9z9XBIcv2mjy
         W2vI8mfwM7dgPo9C1Xs9WYcMsCWOWMGOU8GJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0QdMbKNLVs0T8bKlIwsAC6CTJBWav9NlL0ckO7DwlA=;
        b=SfCiaHycdIXAg5/sxEqPBONv8JHMxkceAouYxDBcfJ4V6Gr6U6p5lC1zyd/4b3PqNu
         H1de0rZBHnuWd98URbW8CedHMW6fA0a0//8TmjLwlevxRR2H1j4wTq4YQnWDJZHkFjg5
         8cqD/Z8PDZM04hMEuJyJkUXcFNiqKKjPBHjTIRY2RlfFQeAHwagWvi+4YRnOODKXCJs1
         z0ksSaABC1WBbOH0xTZZIvUUAlHjiLO8bk6ui5bbuxsW2EPL/rS2ou1U2n7DnbHndmzP
         ZrfWZ/NbXdN4HoqaUofoXQHAyoupHXb8J6OG+GHiMG/UwUNh839U7d7ylc8QwOfcMR/E
         uA1g==
X-Gm-Message-State: APjAAAUELmdLFvmFaEgPuD0YF/wC9p5vH26U3Qn+XUS+be9sfLrcJAII
        KdVNBRZjZKDjl/KdB2Fqts0n2w==
X-Google-Smtp-Source: APXvYqwnWc4Rkv1HzFVoZjhnGWJK4oUgbCaO10e5+E+NJPsLfANZDbIWyiAzXN7RiRLG8EjciU0zmg==
X-Received: by 2002:a62:5c84:: with SMTP id q126mr50065148pfb.247.1560201497375;
        Mon, 10 Jun 2019 14:18:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id p43sm427645pjp.4.2019.06.10.14.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:18:16 -0700 (PDT)
From:   davidriley@chromium.org
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v2 0/4] drm/virtio: Ensure cached capset entries are valid before copying.
Date:   Mon, 10 Jun 2019 14:18:06 -0700
Message-Id: <20190610211810.253227-1-davidriley@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190605234423.11348-1-davidriley@chromium.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Riley <davidriley@chromium.org>


v2: Updated barriers.

David Riley (4):
  drm/virtio: Ensure cached capset entries are valid before copying.
  drm/virtio: Wake up all waiters when capset response comes in.
  drm/virtio: Fix cache entry creation race.
  drm/virtio: Add memory barriers for capset cache.

 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 26 ++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

