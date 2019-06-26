Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E112C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AB3208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AxObSdEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFZVWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:22:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33825 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZVWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:22:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so40999plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ij4y5UDfEbG2jo5JYyvAwzXVxT7kJpB2+6FE5/HNPYw=;
        b=AxObSdEA5QIyp/BHvcsUBVQDhF9QON4UnumA5yV/WsAbRMHm19Cbi9O/ddxhZKwrLa
         VC/rG0o3A6HrcSOJkJZW3gaqzTLNMaxZk0ItDnArCuNTT0UhYrQF4IX0OpjGvgMuWHro
         SbE7n5O3FQV3LK5Ye8V7EoZrh/Iylzxd8wRwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ij4y5UDfEbG2jo5JYyvAwzXVxT7kJpB2+6FE5/HNPYw=;
        b=ruoSO9jo77zJbFOHatmXEZaACDKN2XoiRqloU/nbHMH46HBAZzSrhlKDi98K62Zo1I
         Om9xFttFojBZkATfeT0eTTKJuUbsNq/Grn3xI7L+YrFrrzrAg4a91o1CVAT8ZpThyf+9
         TmhD/JQ1NW6IeXQlR4zekL8h/HznvI06I+aLcD9EL6Q0io3lD3ll2m8oybpYA0ITCmv4
         VrIfF0fcO4DtP/7UWxPaP1s5wR5MWvBNHyAiYKfB4785mYp02ZlB4R1WPSk2MsZfBVE2
         b5+/db9z54V4Iws/yICdH4Q7POk+W7U/dhMT1syUVquWHrHD/WBLBDfHq8ANyq7XFyv8
         GkSQ==
X-Gm-Message-State: APjAAAU84qekUaW165Qq8+ld4GUk5FsHPqV0xNMU/E3O6o3uCUBiGLTN
        7dBldd5Pv9QGtE6XJsjtfakoSQ==
X-Google-Smtp-Source: APXvYqyQMLLaw2qO9OPg0J5QL+TcHGSSxLFnpN4KkIk93CubD3Dw4953ZpgAbVu9v74l3nBfiMJ7+g==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr190931plt.289.1561584163195;
        Wed, 26 Jun 2019 14:22:43 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id h6sm170323pfn.79.2019.06.26.14.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 14:22:42 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/2] ALSA: hda: Widget memory fixes
Date:   Wed, 26 Jun 2019 14:22:18 -0700
Message-Id: <20190626212220.239897-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series fixes concurrency issues with the sysfs widget array. The first
function patches up the locking that was introduced recently to protect more
of the data structure. The second patch fixes a race between a reinit and the
initial population of the array which could result in a length and array
getting out of sync.


Changes in v2:
- Introduced widget_mutex relocation

Evan Green (2):
  ALSA: hda: Fix widget_mutex incomplete protection
  ALSA: hda: Use correct start/count for sysfs init

 sound/hda/hdac_device.c | 21 ++++++++++++++-------
 sound/hda/hdac_sysfs.c  | 18 ++++++++++--------
 sound/hda/local.h       |  3 ++-
 3 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.20.1

