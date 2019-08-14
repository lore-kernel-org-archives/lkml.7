Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1626EC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E6C208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SO9w2qWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfHNKpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:45:32 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:33578 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNKpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:45:31 -0400
Received: by mail-qk1-f201.google.com with SMTP id f22so18003495qkg.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GWyXBGwmHFcGXlg8sYWmi9ISwiX/TjDTxXNJrsxIlo0=;
        b=SO9w2qWfA9s7es8tmXD3wqbpTBgbgE1DHH1ERM7v7ptLx8iAJ95y8N4Tw+xRfTgVDo
         13xnwEMU6xzG5TpnrwEkbvb8IB4VVAMk6MolT2ZOkf2TYbkpgela2WK1udMqSYuSSak5
         Q8LdwxwSdNmbsCfPqW/1A50L/ApA7o7dCxHQL6Y2ilUQe/pD/9Nn91c3LpVJIKbuVG3f
         htMPgcJTD+HpBw3QVSvs7B1iIa/DvtlWekME6zM0+MAhwABxQrewkKFJVJq3adx9qDVe
         C1f+Ddir0Bz1vfsh4GwublcxERGy6vsW5i3k2OyP6w/YcY/Yuy9icYHfcvFqq2wGVRrR
         +BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GWyXBGwmHFcGXlg8sYWmi9ISwiX/TjDTxXNJrsxIlo0=;
        b=Tq6JcbvfrHi/JVfsVSwgIiDLnVczXw8ED1WXhOVjamDuLCOaxmNlBpNEonFXX37vfE
         OrqTcQ79x4NZyZjyOkR5Cmb3mnduoUtSNI3SdmB8X1xs7NCMnmFjEzVeM4dyngcvm1vI
         iQYP1V3rkNZn4vWJsdVyvTuDXhRKssioxrCUYx/OpEUexSbz3zRA+ATBcqM7XWSCnsHZ
         ph+Wfwog+aVfKTzqmv0U7LXVq99PI4P3ZjGK4ugcTltz7DV+bO35bvIoRX14r9J/sBIm
         /u8BOAU6Up+xo+Xhm5KRa+sd1w+gIw7Dy8Ma3Z0h4E7qMFuCGeO1n8dlMlUJqP9gV+e/
         yoJA==
X-Gm-Message-State: APjAAAWbarXW2DlroKgtclJ4bC2uUu8wS04P02npzXkW3PyLj9WaF+Ao
        G5b3Pfe/pqsnikG1mvGY533PuASme3E=
X-Google-Smtp-Source: APXvYqwhM4JMovHg2xzCJqqYJ3hsrqpakcRk8IC6SFMlsdE9qbu+1Sj05yHDBXOw9hQhCX71VwS62n5KfcM=
X-Received: by 2002:ac8:748a:: with SMTP id v10mr16346695qtq.386.1565779530315;
 Wed, 14 Aug 2019 03:45:30 -0700 (PDT)
Date:   Wed, 14 Aug 2019 12:44:58 +0200
Message-Id: <20190814104520.6001-1-darekm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v7 0/9] drm: cec: convert DRM drivers to the new notifier API
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     Dariusz Marcinkiewicz <darekm@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Allison Randal <allison@lohutok.net>,
        amd-gfx@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Francis <David.Francis@amd.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Harry Wentland <harry.wentland@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Leo Li <sunpeng.li@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        nouveau@lists.freedesktop.org,
        Ramalingam C <ramalingam.c@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sean Paul <seanpaul@chromium.org>,
        Shashank Sharma <shashank.sharma@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lim <Thomas.Lim@amd.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates DRM drivers to use new CEC notifier API.

Changes since v6:
	Made CEC notifiers' registration and de-registration symmetric
	in tda998x and dw-hdmi drivers. Also, accidentally dropped one
	patch in v6 (change to drm_dp_cec), brought it back now.
Changes since v5:
        Fixed a warning about a missing comment for a new member of
	drm_dp_aux_cec struct. Sending to a wider audience,
	including maintainers of respective drivers.
Changes since v4:
	Addressing review comments.
Changes since v3:
        Updated adapter flags in dw-hdmi-cec.
Changes since v2:
	Include all DRM patches from "cec: improve notifier support,
	add connector info connector info" series.
Changes since v1:
	Those patches delay creation of notifiers until respective
	connectors are constructed. It seems that those patches, for a
	couple of drivers, by adding the delay, introduce a race between
	notifiers' creation and the IRQs handling threads - at least I
	don't see anything obvious in there that would explicitly forbid
	such races to occur. v2 adds a write barrier to make sure IRQ
	threads see the notifier once it is created (replacing the
	WRITE_ONCE I put in v1). The best thing to do here, I believe,
	would be not to have any synchronization and make sure that an IRQ
	only gets enabled after the notifier is created.
Dariusz Marcinkiewicz (9):
  drm_dp_cec: add connector info support.
  drm/i915/intel_hdmi: use cec_notifier_conn_(un)register
  dw-hdmi-cec: use cec_notifier_cec_adap_(un)register
  tda9950: use cec_notifier_cec_adap_(un)register
  drm: tda998x: use cec_notifier_conn_(un)register
  drm: sti: use cec_notifier_conn_(un)register
  drm: tegra: use cec_notifier_conn_(un)register
  drm: dw-hdmi: use cec_notifier_conn_(un)register
  drm: exynos: exynos_hdmi: use cec_notifier_conn_(un)register

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 13 +++---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 46 +++++++++++++------
 drivers/gpu/drm/drm_dp_cec.c                  | 25 ++++++----
 drivers/gpu/drm/exynos/exynos_hdmi.c          | 31 +++++++------
 drivers/gpu/drm/i2c/tda9950.c                 | 12 ++---
 drivers/gpu/drm/i2c/tda998x_drv.c             | 36 ++++++++++-----
 drivers/gpu/drm/i915/display/intel_dp.c       |  4 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 13 ++++--
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  3 +-
 drivers/gpu/drm/sti/sti_hdmi.c                | 19 +++++---
 drivers/gpu/drm/tegra/output.c                | 28 ++++++++---
 include/drm/drm_dp_helper.h                   | 17 ++++---
 13 files changed, 155 insertions(+), 94 deletions(-)

-- 
2.23.0.rc1.153.gdeed80330f-goog

