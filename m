Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF64C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06BB2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtvEoFNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDLPsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:48:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40448 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDLPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:48:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so12560243wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bm56YX1+doSSym9tGK/xMDFFz0EJrJ/YaZtcVtN8glU=;
        b=gtvEoFNY+BJl/GUvFWqv4WTz3EfqWoIy9DXyHr6bPgiMKjlLcfHqroAs+lpJKmVATh
         9bfrwze51MxVT+DyPBq9Mdlm8+xWS9X7V+jNlBQzIM0m7HR+Cp+/FM450WbMM/v2vgpZ
         cr2AddzIlfpttMp1UpA2GYTGLiXoPp69TuOl75pS5UQgQIm2ticrgmJgDzxU4YLdLaBH
         Ry4Vl8t5Sxv7KOIGmi44oSFHVHMHyOV1dt+6IC5RIwG7t3KCfo9mSiLP0ya6Faj4/bnv
         mG3+qp3sR/v/H9VCfmVeAyxjWW1yj7M0Qy4BZHrMT8NfMxtqW1ox+7S5sG8KcvCgskLQ
         CHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bm56YX1+doSSym9tGK/xMDFFz0EJrJ/YaZtcVtN8glU=;
        b=BropZJU4vpsV/WY3ljE/2rSVd/K6jRfnLvtTHYLCM5J2Kx09O0y3GRZQTjaY6U0G2I
         lnd4vc0ylYWAHSY04p4YpylEOMaW2Ap9ULjgeL9HwF7HNXmCGT5d7P9mttp6iquuNDpA
         6o//4yheR7JL8m0FXYQfiqhv4zrhBhK/1+6pHEw90xPOkAtTtxSmpBLNoun3D2BoWLSR
         o/xeohZt0kcaDwPiGKb9+X8mncKfyovsK3NtuQ5grmfDrbcMViTIqQ8y7/+LE5MJ41P3
         yVA4pcCn05+WCLdLXhV1JVT9qAJRa+Mq4Yb60hVrQpFhoGI/IStjD/it4bA58uDnvnbl
         BeIQ==
X-Gm-Message-State: APjAAAVq6oLS7dCtIPSNAOVAMlYrx18EFRqO6lrx15NhLz4grkMZXCtl
        /0lixJpuPxtEb8c6EPu5Zxk=
X-Google-Smtp-Source: APXvYqxKgJawoAwgbpiKhP+pQLt7POqh5yEuX2eiYWWnbEQ6LtGSMtCsaD0kT8cD9rspk2wqeeuJdA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr35393902wrx.80.1555084101119;
        Fri, 12 Apr 2019 08:48:21 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id a11sm7161228wmm.35.2019.04.12.08.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:48:20 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:48:20 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] driver core: fix statics initilisation
Message-ID: <20190412154819.oiztq2uf4teuxewn@macpro-scc.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perl scripts/checkpatch.pl -f drivers/base/dd.c got red here:

ERROR: do not initialise statics to false
+static bool driver_deferred_probe_enable = false;

Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1bc4557a0f49..38480a01d074 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -140,7 +140,7 @@ void driver_deferred_probe_del(struct device *dev)
 	mutex_unlock(&deferred_probe_mutex);
 }
 
-static bool driver_deferred_probe_enable = false;
+static bool driver_deferred_probe_enable;
 /**
  * driver_deferred_probe_trigger() - Kick off re-probing deferred devices
  *
-- 
2.11.0

