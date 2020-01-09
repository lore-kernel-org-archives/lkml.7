Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9DCC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF01620661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="2HAoL1j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbgAIQR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:17:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42204 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbgAIQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:17:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so7976534wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2Twc/4NGWAktor1LtRx/8ZfV8fNdobSeF8VACd7NtQ=;
        b=2HAoL1j70ejT1gsCA47ItX4L13c+Lekgn7PQbHRsc3wvFSvbceA78tijG7wyydNu/v
         7E1eeoe+xN52OGGz3u8G2lJOHwdB6m35cn5erVnDgAd6DbUsSAoXZ0yG3S5aOYNxx2aR
         knPuvKahtwohE/TdnBKi1Imvjt+SLfTd+z5MvA3cUEw+dTrHyM0oQxMJ84FwNLuDkLAA
         qMOWe+/y3qLPXRd3VwoD2oKr9V5lLWCe3/WjnfTXDFSNEY+fXXAqKIHHSevM6wXVi15q
         U1ApapyPufoAOKqkoPqmQLKd7s4/Lw6+77uvwHEnNcuOzuEo+zXEv9oc8VU2b2/MKkT6
         SvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2Twc/4NGWAktor1LtRx/8ZfV8fNdobSeF8VACd7NtQ=;
        b=k+UBmGi6MiZ4U1zXW7SJ6oKfwupe4hrg6amT22tL16e5wxaaMuqwysVINtw5zMpuaS
         +zXb+rf+2v3/Lt5wM4lyFl2bfTTe1XNlWfQqr9P6tlC7REBauGvck2HNlva6+mfmbN/B
         yZpf+T/wy6vqwQeGhuhbXW1gp1tx7hpOvCkx53mAC1sTIkKMxQLYHHkbQnSmFAUwKoNv
         BaNEzcXoZPFwRZnq3sf35Q3v2UdCOeE24P+7/tY8uOEHWQ8bUB6lKQDZIDEy86SMeZPp
         cDR7ypI1y05N9jHbzPQ94ZP8iPekaRJEUQTX6FxpwTrjkQA182K2SEnnpI0rcPsIoWV9
         u28w==
X-Gm-Message-State: APjAAAWRokfKIcICb64IEAcSjtP+8s3lV6oJ+hEm+XEPrmZR/B1mnNcG
        xYdpNRRHLpwF7VeWKYh1oPc8TA==
X-Google-Smtp-Source: APXvYqyPbGB4LHfHSMgYlyKMfT1GnPO5HFRg6dAa1V/RyHOBmdlI4zTb5yC8nxMYCgtgWfzpA/AziQ==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr11402659wro.51.1578586646632;
        Thu, 09 Jan 2020 08:17:26 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-53-230.w109-210.abo.wanadoo.fr. [109.210.44.230])
        by smtp.gmail.com with ESMTPSA id f207sm3805207wme.9.2020.01.09.08.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:17:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] kconfig: ignore temporary generated files
Date:   Thu,  9 Jan 2020 17:17:24 +0100
Message-Id: <20200109161724.9546-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

If building gconfig fails, a temporary gtk config file is left in the
kconfig directory and is not ignored by git. Add an appropriate pattern
to .gitignore.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 scripts/kconfig/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index b5bf92f66d11..d22e6753397d 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -3,6 +3,7 @@
 #
 *.moc
 *conf-cfg
+*conf-cfg.tmp
 
 #
 # configuration programs
-- 
2.23.0

