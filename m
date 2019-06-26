Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85114C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9920883
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwx6E+6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfFZBfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:35:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36396 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfFZBfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:35:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so677419qtl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 18:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0LRAWyCoMm6qSJUgjbP8auCw69o7m+ZLWJtl7bdpb+w=;
        b=Xwx6E+6qHDSLrgkTZG71QymmraL414RSn1b4jzWwNp/EQoGWChZXZCJ56w78XccijD
         1E+OOkSvvoDBM1ir+vgbxhq1ETv2ASxey+QcHAk0RffvDLUpCIiMwzBDcvl8aTWrspM9
         XsG2jdiayltXMWwNwSfszrKu3xxh8g/1rb9sEJ658YI+L7cYh87PrcXSNwTT8FBCTQh0
         jSpvEBID8+gwLbrQXSN0vNMY/mZg9v5On4L2zmP6Dojuz9QVukaYW9nzhWxNcmYSyX9u
         KMQdnGm0JDSZRi1Aq5eGZ92rrFhJldEE9SjhMRf9na6KrjyWi0nw0bZg+A6eNEhBrwkL
         U09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0LRAWyCoMm6qSJUgjbP8auCw69o7m+ZLWJtl7bdpb+w=;
        b=o/e25BRC6FL1Obji4GYkqmfaPfpWktRWevuGwL/T49mw7FYp8B+gU+FDUN5meKXJUG
         PCvndAbW9wbYMEQ8paD8LTDFG/jtR1E/uhqJy9Dw+qUhtVl+gaFhkc0iEV6dhTZ/ii+a
         5aosRHtNlcenClZnGJhiqptoeb/ENi/gqUBB54NvYPxMIp4tR5N4jcG+kIR2eKsdj7uP
         1pD5MwUI67/Z0JnKuKKTnKGC2mD/FD22tVM9pfgspV8q5EtkFNc/WBH77XC3QFods7PU
         CofUH/kjSoa1sqqo7+7D4OTWzz+BoasWov4aFzfUd02CnHYc70lnsXUhIvp58Zp0M/6D
         oSrg==
X-Gm-Message-State: APjAAAVdbhV1ywwsRxjR0fJo4w+v5aVc5An3fa3PBpDN473yt8iS1n8q
        cP2QEiXQYTAoMaaDrJLeMo0=
X-Google-Smtp-Source: APXvYqxpXDznfBJclCVx7xXV0zdyxRpLK69Oa2CuicRUspRtYvD+5giOq5ZovANyg2wCLBplsqvwMQ==
X-Received: by 2002:ac8:17a5:: with SMTP id o34mr1385680qtj.232.1561512937655;
        Tue, 25 Jun 2019 18:35:37 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id 123sm7343770qkh.113.2019.06.25.18.35.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 18:35:36 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:35:30 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/5] drm/vkms: Introduces writeback support
Message-ID: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the V3 version of a series that introduces the writeback support
to vkms. As a result of the previous review, this patchset can be seen
in three parts: make vkms able to support multiple connector, pre-work
for vkms, and the vkms implementation. Follows the details:

* First part: The first patch of this series is a fix that enables vkms to
accept new connectors, such as writeback connector.

* Second part: The second part of this patchset starts on patch 02 and
finish on patch 04; basically it is a pre-work that aims to make vkms
composer operations a little bit more generic. These patches update the
CRC files and function to make it work as a composer; it also
centralizes the vkms framebuffer operations. Additionally, these changes
enable the composer to use the writeback framebuffer instead of creating
a copy.

* Third part: The final patch enables the support for writeback in vkms.

With this patchset, vkms can successfully pass all the kms_writeback
tests from IGT.

Note: Most of the changes in the V3 was suggested by Daniel Vetter as
can be seen at the link
https://patchwork.freedesktop.org/patch/311844/?series=61738&rev=2

Note: This patchset depends on Daniel's rework of CRC, see it at
https://patchwork.freedesktop.org/series/61737/

Rodrigo Siqueira (5):
  drm/vkms: Avoid assigning 0 for possible_crtc
  drm/vkms: Rename vkms_crc.c into vkms_composer.c
  drm/vkms: Decouple crc operations from composer
  drm/vkms: Compute CRC without change input data
  drm/vkms: Add support for writeback

 drivers/gpu/drm/vkms/Makefile                 |   9 +-
 .../drm/vkms/{vkms_crc.c => vkms_composer.c}  | 174 ++++++++++--------
 drivers/gpu/drm/vkms/vkms_crtc.c              |  30 +--
 drivers/gpu/drm/vkms/vkms_drv.c               |  10 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |  40 ++--
 drivers/gpu/drm/vkms/vkms_output.c            |  16 +-
 drivers/gpu/drm/vkms/vkms_plane.c             |  40 ++--
 drivers/gpu/drm/vkms/vkms_writeback.c         | 141 ++++++++++++++
 8 files changed, 331 insertions(+), 129 deletions(-)
 rename drivers/gpu/drm/vkms/{vkms_crc.c => vkms_composer.c} (51%)
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c

-- 
2.21.0


-- 
Rodrigo Siqueira
https://siqueira.tech
