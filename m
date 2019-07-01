Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7C7C06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB0F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJYrL6KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfGADXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 23:23:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37221 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfGADXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:23:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so13163245qtk.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 20:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=bafLLGxzRxByJVBG7vRwFnpyj42fKM5Pnwg7VF4Oo5w=;
        b=IJYrL6KMhAQ2gTf/9x/jTlmgJjybilb869TBwxd0iHT+NRLtXc2D4xPunWEcJJ2XW9
         OcMUXGJ+3f3kxQa2WvKVwksvG0b49rj0MxaMoWelQPRxPjqXg/IX350QMd6LInDy+XUe
         hAucj63HrKLgbauP88cm6ONVzQ/WYLQH+5xiDPvZ0vKd4oWKMrxCzCgbdaTTeCM2i3ss
         6mOX9Zn4zxwJAxqMrl4s9tCYyoRapU3WoVzHP9FyLWVY0VcMx9jV8WEcAEoUk6N50+g0
         CGrSoz1CKGiPVwP6YvDgjZj769YIsrvzjAW9iv5cLW0e3xnQeUfuJtf0/EjAvARnrMFd
         pAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=bafLLGxzRxByJVBG7vRwFnpyj42fKM5Pnwg7VF4Oo5w=;
        b=ro8dAhPp76sBunNILM0+aeOdgt9E4Vk6DCyShmoF5/zSf5otVJAMMuwwpMbQsvMA4s
         XkwSTYJ8JcjWvtep5wbsvxGBX1wWZUi0Dg1LQSGZ0UjhocZYTe8niCN0OaY+LHw3Ljo1
         plc7H95Z88MrpfTBHspYkD7oh4hneiAIxoBJxoTTATL1OWG3CEm8xtluC79RgcQmwJvw
         kI2Ix6Yx6zsmigxrtmJCZ8GFCQa5RRIMWtD31a5FE21U/RnG0mtBWWQIL/wxluzzCoW9
         GuoDyn+dEdAClKEVYwQi11Uy012/q+l7DKrBwgGmxvbGy+Wo7w8YOG2r2NzBn/7+fyLM
         vFMg==
X-Gm-Message-State: APjAAAWcF5aY7UShqacEq/fJFP34EUQEcxOvb8YTrHIzVwGWa8ZglKI0
        bBeRBk1Tb/lRVUGgy6kYzrQ=
X-Google-Smtp-Source: APXvYqxb4rpzh/Ir0dSJsyxBuujq9tbJs+bFK+AgE1Zha9YKieMGjOF9pP0kARj9zJyeg8uWeVNbPA==
X-Received: by 2002:a0c:f9c1:: with SMTP id j1mr19298673qvo.235.1561951423846;
        Sun, 30 Jun 2019 20:23:43 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id l4sm4611434qtd.25.2019.06.30.20.23.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 20:23:43 -0700 (PDT)
Date:   Mon, 1 Jul 2019 00:23:39 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/vkms: Introduce basic support for configfs
Message-ID: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces the support for configfs in vkms by adding a
primary structure for handling the vkms subsystem and exposing
connectors as a use case.  This series allows enabling/disabling virtual
and writeback connectors on the fly. The first patch of this series
reworks the initialization and cleanup code of each type of connector,
with this change, the second patch adds the configfs support for vkms.
It is important to highlight that this patchset depends on
https://patchwork.freedesktop.org/series/61738/.

After applying this series, the user can utilize these features with the
following steps:

1. Load vkms without parameter

  modprobe vkms

2. Mount a configfs filesystem

  mount -t configfs none /mnt/

After that, the vkms subsystem will look like this:

vkms/
 |__connectors
    |__Virtual
        |__ enable

The connectors directories have information related to connectors, and
as can be seen, the virtual connector is enabled by default. Inside a
connector directory (e.g., Virtual) has an attribute named ‘enable’
which is used to enable and disable the target connector. For example,
the Virtual connector has the enable attribute set to 1. If the user
wants to enable the writeback connector it is required to use the mkdir
command, as follows:

  cd /mnt/vkms/connectors
  mkdir Writeback

After the above command, the writeback connector will be enabled, and
the user could see the following tree:

vkms/
 |__connectors
    |__Virtual
    |   |__ enable
    |__Writeback
        |__ enable

If the user wants to remove the writeback connector, it is required to
use the command rmdir, for example

  rmdir Writeback

Another way to enable and disable a connector it is by using the enable
attribute, for example, we can disable the Virtual connector with:

  echo 0 > /mnt/vkms/connectors/Virtual/enable

And enable it again with:

  echo 1 > /mnt/vkms/connectors/Virtual/enable

It is important to highlight that configfs 'obey' the parameters used
during the vkms load and does not allow users to remove a connector
directory if it was load via module parameter. For example:

  modprobe vkms enable_writeback=1

vkms/
 |__connectors
    |__Virtual
    |   |__ enable
    |__Writeback
        |__ enable

If the user tries to remove the Writeback connector with “rmdir
Writeback”, the operation will be not permitted because the Writeback
connector was loaded with the modules. However, the user may disable the
writeback connector with:

  echo 0 > /mnt/vkms/connectors/Writeback/enable


Rodrigo Siqueira (2):
  drm/vkms: Add enable/disable functions per connector
  drm/vkms: Introduce configfs for enabling/disabling connectors

 drivers/gpu/drm/vkms/Makefile         |   3 +-
 drivers/gpu/drm/vkms/vkms_configfs.c  | 229 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.c       |   6 +
 drivers/gpu/drm/vkms/vkms_drv.h       |  17 ++
 drivers/gpu/drm/vkms/vkms_output.c    |  84 ++++++----
 drivers/gpu/drm/vkms/vkms_writeback.c |  31 +++-
 6 files changed, 332 insertions(+), 38 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c

-- 
2.21.0


-- 
Rodrigo Siqueira
https://siqueira.tech
