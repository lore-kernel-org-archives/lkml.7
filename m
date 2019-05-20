Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3644C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16EB2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b8eSPbV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfETIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:23:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43033 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbfETIXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:23:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so22506412edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUAcB3sU0dD3E/MUylEVVwC2GTKxo8rk41HcMoWy7Z0=;
        b=b8eSPbV0e6t58Jw8xSWXzI4Toz82FXOp3S4ZAblJvOrs+Gt0Ux6e3YwhDesaVOOpkg
         quvfmJTaiU4sOLD2LY4AM7vikeJ5E/6iGKfh9/1ZXhc3ogcMwk4kajLiDJsyzcQzVsde
         C/uOpN0XDilKwuLuB6fz8bZNEgU6tboLD/HoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUAcB3sU0dD3E/MUylEVVwC2GTKxo8rk41HcMoWy7Z0=;
        b=apt/NHhtYTl+metkmADryhVmIFEWBETw9et01ezVibl8SAz/I7gFTtxIWJfBztN432
         y7CioUbQ2eLf1h0BvQJO9jA9mZp72lwMXt84cKp260V+SQjEfSrn3AAunuoSSX5KQvbW
         4yuUuL4rV7MaYnPR7FlfhGyzQG+VUMAnfGmOyI/tC7EQycoQCMq7gATGKSvwv3Nl7T+A
         LkHGFmCjLtQmkAU6S6tN2Y1aUnjAscHsZbwPW96Fk22apvkWzb580OjXdTKtO9qA63BT
         eM7AErDFXw8YTq59hFBM8jSS4FCtwsAf22/UIVLMzU8Xk40n148zpwYmOMTSqaZ1plpx
         IvZw==
X-Gm-Message-State: APjAAAUvFCb3OV2eLOZ/CXQ8Ta0ZzCDyUNLWpMeJA5SiInQylEtijZq9
        ch52pqINJnD4TiOnjfOFcKo5RQ==
X-Google-Smtp-Source: APXvYqwmDqP5epoI370U4Hdjtba1pl90gO7hr4GVxPoRMkSWHnkec3B3NKvvhM8UDRNXGWDhP6Dyrg==
X-Received: by 2002:a17:906:640b:: with SMTP id d11mr9277783ejm.58.1558340580671;
        Mon, 20 May 2019 01:23:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:23:00 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: [PATCH 33/33] staging/olpc_dcon: Add drm conversion to TODO
Date:   Mon, 20 May 2019 10:22:16 +0200
Message-Id: <20190520082216.26273-34-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this driver is pretty horrible from a design pov, and needs a complete
overhaul. Concrete thing that annoys me is that it looks at
registered_fb, which is an internal thing to fbmem.c and fbcon.c. And
ofc it gets the lifetime rules all wrong (it should at least use
get/put_fb_info).

Looking at the history, there's been an attempt at dropping this from
staging in 2016, but that had to be reverted. Since then not real
effort except the usual stream of trivial patches, and fbdev has been
formally closed for any new hw support. Time to try again and drop
this?

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
---
 drivers/staging/olpc_dcon/TODO | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/olpc_dcon/TODO b/drivers/staging/olpc_dcon/TODO
index 665a0b061719..fe09efbc7f77 100644
--- a/drivers/staging/olpc_dcon/TODO
+++ b/drivers/staging/olpc_dcon/TODO
@@ -1,4 +1,11 @@
 TODO:
+	- complete rewrite:
+	  1. The underlying fbdev drivers need to be converted into drm kernel
+	     modesetting drivers.
+	  2. The dcon low-power display mode can then be integrated using the
+	     drm damage tracking and self-refresh helpers.
+	  This bolted-on self-refresh support that digs around in fbdev
+	  internals, but isn't properly integrated, is not the correct solution.
 	- see if vx855 gpio API can be made similar enough to cs5535 so we can
 	  share more code
 	- convert all uses of the old GPIO API from <linux/gpio.h> to the
-- 
2.20.1

