Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED4CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8435921852
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W7E7303t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfDARR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:17:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42899 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbfDARRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so5083836pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sYyB75pDxlY2KmTc4TNMmfz3/8I3psga6G2DFBLiLOU=;
        b=W7E7303t6gMCOq1fQ9vuxc6eSX2OxEw6XUVxXZuwVldo2nNYDgT6HrCgeZG2M12Tqe
         IoObKQblNEF2kMp3+3UcnVClg/e4v34NZ8HFpuImotjimDGW0JAoDjY+4h+zmff5iIUu
         VFv2E+eMOdBb+BNeIjY/hzmC72hEpiMQbLUAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sYyB75pDxlY2KmTc4TNMmfz3/8I3psga6G2DFBLiLOU=;
        b=KWDzKZXnF0HgXMzEComhO/2i6lVLf+EIGB5a7NXTQZDvqei+jW3eRiTt4rn4SmXf4u
         MrCyYE7N1d3+gMou8D5WRKfVFTWWlaE6AH3cC6WQgDQmweW1nR4cP1hcKWLRbhfR6xLc
         MWdqr/OpBoDnnzdmKdntzlCezzL2odD971pA8UbBfwLcqPfN4wGdE4VeD7sEHRiSZpaw
         LqnaJgxkMZU1i8A8cg6WGZkeC+ZPqFlBk8BMFtjMC5GOSSRN+ADvIV4y7ySdsaImK8x1
         RYwE+ejSKd8aUuFu01D7+KQICa6M3zDGclontn7AdQes0R+Y6NwG49bNtJT5HPbNRRZ8
         5HsQ==
X-Gm-Message-State: APjAAAXMbso9ujIxVFyPJlyzFUb7XIfRH/4d1XuQ4u8zg8+pSgUbIfkW
        wmYxB0w9rTPhAFEn1VFyCozRMg==
X-Google-Smtp-Source: APXvYqxmw/tyt2JsPE3Cczq6gWpYprGq+P6YD+QLEkk3HlFVpoRZeHUgYnaJQrE2T1iSdNQosP/1gg==
X-Received: by 2002:a63:7154:: with SMTP id b20mr54517102pgn.359.1554139071880;
        Mon, 01 Apr 2019 10:17:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y12sm31370112pgq.64.2019.04.01.10.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:17:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v5 0/7] drm/panel: simple: Add mode support to devicetree
Date:   Mon,  1 Apr 2019 10:17:17 -0700
Message-Id: <20190401171724.215780-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reviving Sean Paul's old patchset to get mode support in device
tree.  The cover letter for his v3 is at:
https://lists.freedesktop.org/archives/dri-devel/2018-February/165162.html

No code is different between v4 and v5, just commit messages and text
in the bindings.

I've pulled together the patches that didn't land in v3, addressed
outstanding feedback, and reposted.  Atop them I've added patches for
rk3288-veyron-chromebook (used for jaq, jerry, mighty, speedy) and
rk3288-veryon-minnie.

Please let me know how they look.

In general I have added people to the whole series who I think would
like the whole series and then let get_maintainer pick extra people it
thinks are relevant to each individual patch.  If I see you respond to
any of the patches in the series, though, I'll add you to the whole
series Cc list next time.

Changes in v5:
- Removed bit about OS may ignore (Rob/Ezequiel)
- Added Heiko's Tested-by
- It's not just jerry, it's most rk3288 Chromebooks (Heiko)

Changes in v4:
- Simplify desc. for when override should be used (Thierry/Laurent)
- Removed Rob H review since it's been a year and wording changed
- Don't add mode from timing if override was specified (Thierry)
- Add warning if timing and fixed mode was specified (Thierry)
- Don't add fixed mode if timing was specified (Thierry)
- Refactor/rename a bit to avoid extra indentation from "if" tests
- i should be unsigned (Thierry)
- Add annoying WARN_ONs for some cases (Thierry)
- Simplify 'No display_timing found' handling (Thierry)
- Rename to panel_simple_parse_override_mode() (Thierry)
- Rebase to top of Heiko's tree
- Converted changelog to after-the-cut for non-DRM change.
- display_timing for Innolux n116bge new for v4.
- display_timing for AUO b101ean01 new for v4.
- rk3288-veyron-jerry patch new for v4.
- rk3288-veyron-minnie patch new for v4.

Changes in v3:
- Go back to using the timing subnode directly, but rename to
  panel-timing (Rob)
- No longer parse display-timings subnode, use panel-timing (Rob)
- Unwrap the timing from display-timings and rename panel-timing (Rob)

Changes in v2:
- Split out the binding into a new patch (Rob)
- display-timings is a new section (Rob)
- Use the full display-timings subnode instead of picking the timing
  out (Rob/Thierry)
- Parse the full display-timings node (using the native-mode) (Rob)
- Wrap the timing in display-timings node to match binding (Rob/Thierry)

Douglas Anderson (4):
  drm/panel: simple: Use display_timing for Innolux n116bge
  drm/panel: simple: Use display_timing for AUO b101ean01
  ARM: dts: rockchip: Specify rk3288-veyron-chromebook's display timings
  ARM: dts: rockchip: Specify rk3288-veyron-minnie's display timings

Sean Paul (3):
  dt-bindings: Add panel-timing subnode to simple-panel
  drm/panel: simple: Add ability to override typical timing
  arm64: dts: rockchip: Specify override mode for kevin panel

 .../bindings/display/panel/simple-panel.txt   |  22 +++
 .../boot/dts/rk3288-veyron-chromebook.dtsi    |  14 ++
 arch/arm/boot/dts/rk3288-veyron-minnie.dts    |  14 ++
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  14 ++
 drivers/gpu/drm/panel/panel-simple.c          | 171 ++++++++++++++----
 5 files changed, 203 insertions(+), 32 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

