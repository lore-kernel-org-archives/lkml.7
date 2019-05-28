Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37563C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109E0208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CFU413T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfE1JEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:04:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37330 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfE1JD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so30611458edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ke/GY+csAQwGtKfSDgwB4In+ezGB+Eqia0Ds1dJ9YhI=;
        b=CFU413T3RVZAG0aMmPcjs3AON0A2oxThmIVGBKOyHKD0ptGSsUcZS2vKN6Qch3X0/5
         u2hNoqtA/7YbPThjei/M2sqXZ0vMaO32NgE/qFmWbVW5wghOYRWParZNL6d+KJdt1aI1
         1hf/zAPtOYsk7o3PXzm1GIN4mR3dg0Ufxc6Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ke/GY+csAQwGtKfSDgwB4In+ezGB+Eqia0Ds1dJ9YhI=;
        b=ZcEdGUJzBzW6BGZd0RvspIA29NJu/ObYLXO5FbnKtiEsHaVwzEJQ20EXY8xrGjOso0
         KDGH1OiCRJP4iayMBCH+yz2GHV4cVVPBAoFGSq39ivisBpyyNTpFy7nnOsc2X4lY0Q7s
         IsO5DKXX2abOz7Ev6/ueuGR/svoJSSpIIVeLx3xoukRZedSY6ltpblR0N1gzrr4okigq
         XyP3eAbxZJ4n8UGHnTPvhXdOXki7Mnxci65H4L1tlGTAxX6FIcYrudTZP/cSHRJ10MvH
         +4ALhlDASn2AoLU9Ojgh4IVb7KZImfwz1RCjjNQAJMw2EiBi6jAKEr/iprry0YGtuhz9
         nWyQ==
X-Gm-Message-State: APjAAAWMZzn5Lp1OUIMFxGqPm+0Q+3zAycmCHGpXJWR9c6FNF9Mcg/LY
        A7dbdeHOQok7OyDlPnkeAdySq5RRYt8=
X-Google-Smtp-Source: APXvYqyIT1ztzcC6zHzmIxYYspUIOonVQpRlZvfSL5l9bmuKi+qnlo7uboLkAwKXA1zf88XtJiIcsw==
X-Received: by 2002:a50:a4f7:: with SMTP id x52mr128123059edb.86.1559034237342;
        Tue, 28 May 2019 02:03:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:56 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: [PATCH 32/33] staging/olpc_dcon: Add drm conversion to TODO
Date:   Tue, 28 May 2019 11:03:03 +0200
Message-Id: <20190528090304.9388-33-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

