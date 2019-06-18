Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B3C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D9D2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyNS/Ggo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfFRCmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:42:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34715 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFRCmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:42:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id m29so13498036qtu.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IVz6BAknW6t/cZoUe0OsXuR9J6By+25KR1QWnphRfwQ=;
        b=uyNS/GgoiPmcE5pagyeBrTmsGE9qnYmNPJTsBX8mwc/tslW/kqrSuhBYGFUSP776cf
         7RcDrg+2k+HBRegVEYZg9OEcra+jV5ZBehCwxdonN5aKo+n5Rw8ygsCRkFLQDbsJXncZ
         h9hcfuP0L/BQVpvAN8bYNyj9AcpsDpI3jrVjdb9lbJdI+OYCzSqm8FQIAyNKHEU5v2qT
         59rJVJKWtZO0CubKK0FgtYUR1iBN/rCLZgU9DVvH1709zbnf/fKH9l7+jd2v3M04REqW
         DF8X0emOJktfBVF6ui9grAPjVfcHhrfHAzJn10KGAAAQ8jRWHid8ONlGrl3UWN9T4XMe
         r3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IVz6BAknW6t/cZoUe0OsXuR9J6By+25KR1QWnphRfwQ=;
        b=aRJGYQFFQRCLrq3ZJr1YcoRkOZnTZksqOzRMTFMAQcfopuDTMKRsDaRiO1G+Mhzz8U
         QFdVJXAJ6CwDhZe+IWJ9nOM6mmJDc1bMqGkutfrRjScq7WfW9gPoxoCDZWtDquHdlLar
         A1Rf9U4C1iDtJ9ZaEKU1PKxLsCUXq01w2tBF5L3knOlZYCIhtDYmkyJ6RiWam8QXq0Dz
         1lG5zmyVIBdoVS4lI0iwmKnZ3yBVLytpbMlV3TopzY2do/8i4dPJ+a8TJs3f0YQBypsB
         uP2eA5rP1U7PnVvGE8Glkvdr1wKDjWzzQKJKnF0omJx+nTWfOJAbCMhJzVVpEXzpm9yf
         IbAA==
X-Gm-Message-State: APjAAAWrD8siesUzwomF6W+tgsuO3TeaJgqR+qR2Wk2/XRJF5SqpB0uG
        O3bbVnrqVUf6HA/cwqNnIS4=
X-Google-Smtp-Source: APXvYqxmov6aRqBgVgEHQVi8PRdHCcaCQsKljpg1j8I85jrk0Kp3f23uBl6FNdvQ3E04Jdsdhxi0sA==
X-Received: by 2002:ac8:3345:: with SMTP id u5mr99447735qta.219.1560825720545;
        Mon, 17 Jun 2019 19:42:00 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id j184sm7209111qkc.65.2019.06.17.19.41.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:42:00 -0700 (PDT)
Date:   Mon, 17 Jun 2019 23:41:55 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] drm/vkms: Introduces writeback support
Message-ID: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces the writeback support to vkms. As a pre-work,
the first set of patches separates part of the code inside vkms_crc to a
new file named vkms_composer; this change allows that other parts of the
vkms take advantage of composing functions. Next, there's a patch that
enables the virtual encoder to be compatible with the crtc when we have
multiple encoders. The final patch adds the required implementation to
enable writeback in the vkms. With this patchset, vkms can successfully
pass all the kms_writeback tests from IGT.

Note: This patchset depends on Daniel's rework of CRC, see it at
https://patchwork.freedesktop.org/series/61737/

Rodrigo Siqueira (5):
  drm/vkms: Move functions from vkms_crc to vkms_composer
  drm/vkms: Rename crc_enabled to composer_enabled
  drm/vkms: Rename vkms_crc_data to vkms_data
  drm/vkms: Use index instead of 0 in possible crtc
  drm/vkms: Add support for writeback

 drivers/gpu/drm/vkms/Makefile         |  10 +-
 drivers/gpu/drm/vkms/vkms_composer.c  |  69 +++++++++++
 drivers/gpu/drm/vkms/vkms_composer.h  |  12 ++
 drivers/gpu/drm/vkms/vkms_crc.c       |  81 ++-----------
 drivers/gpu/drm/vkms/vkms_crtc.c      |   2 +-
 drivers/gpu/drm/vkms/vkms_drv.c       |   9 +-
 drivers/gpu/drm/vkms/vkms_drv.h       |  18 ++-
 drivers/gpu/drm/vkms/vkms_output.c    |  12 +-
 drivers/gpu/drm/vkms/vkms_plane.c     |  40 +++----
 drivers/gpu/drm/vkms/vkms_writeback.c | 166 ++++++++++++++++++++++++++
 10 files changed, 315 insertions(+), 104 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_composer.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_composer.h
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c

-- 
2.21.0
