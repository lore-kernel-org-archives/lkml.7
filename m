Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7CACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38D320869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHz/KuqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfKDQeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:34:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32782 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:34:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id s1so17895527wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFkDbKsSeI6+K0jBeMW0GZTEnXuZ3ZSW0WVBKac1tL0=;
        b=fHz/KuqTSjH1izmh/ecYcpUWqeTHp/VgGOXvyKCgSKmsswFECT92U4eKMGjaGAy+OT
         /tc9SGYjnxdtRNm2HJWQRlncZ1OC6fiIgewfXPUui7RtjX7JdHFlyAD49OXwpUZpHQOk
         oKzQl6uS7XOdjODe5L1F5F9IHfev2jx7af3Vk2RLk9GwAz8NpLOBOvT5cU/FFdGPDXRX
         JXxx1+3IFgsEbv0SddcXvfxU9PQVT1dNWZvjPUXMZ4c79QFCTVmYA8Zj13B0EZHSgDd9
         i+TUaElLH7kHRSALqMTdd8huDBv6X6bZvajsUFWdxsdpD+qhETk3e8xofis9JSLksRoG
         bQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFkDbKsSeI6+K0jBeMW0GZTEnXuZ3ZSW0WVBKac1tL0=;
        b=eODpNaDvCw2og6OHzeASpDUzBQpIq3EaTyZFAy+PG1nwUyWkFEk1x9H2SZbA1olAWN
         5Zwe/aBkAXfIhLJ7VrEb/o+A34jS4MDdgSpIMR7hEnPMJuUstAOTwH1CpL/oKNjioHTF
         NyTfkGaT8yboc22BZg6BTGgh/zIUG6BZJzK0ET69MVNp+vnbXREOeDsnZA55MIDpEFDc
         Z01+gm4kt7XmqHNJQPspIlbNZa7Gj1c55LCTVFUWuAmf/rtmAFjD8U3O+7fXMbexKjnd
         3RMLBLQTEG/E0aFP+r/JouHNr+W4gkBVr7IkeCJensiCTx5GhYmcN6J2XfyU7GLzOdJU
         xl3Q==
X-Gm-Message-State: APjAAAUFU+pZPP6Gz+Ul+MSYvzCR4KXcIDmMsqDgmXBEq+a50DRbX+87
        PUMKRZzAju8cyOTIvHNQX/kW1ZSVmOSng7A=
X-Google-Smtp-Source: APXvYqwER7eASKzqK/tmsjOMIJJXcnS/K0BnACQLnfZ/F7fsD/zr+ZXQ8+brh4pdwMcZEMoVpzdIBQ==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr19343427wrp.354.1572885262526;
        Mon, 04 Nov 2019 08:34:22 -0800 (PST)
Received: from ninjahub.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.googlemail.com with ESMTPSA id h124sm18573509wmf.30.2019.11.04.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:34:22 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hsweeten@visionengravers.com,
        abbotti@mev.co.uk, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v2] staging: comedi: rewrite macro function with GNU extension typeof
Date:   Mon,  4 Nov 2019 16:33:31 +0000
Message-Id: <20191104163331.68173-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite macro function with the GNU extension typeof
to remove a possible side-effects of MACRO argument reuse "x".
 - Problem could rise if arguments have different types
and different use though.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
v1 - had no full commit log message, with changes not intended to be in the patch 
v2 - remove some changes not intended to be in this driver
     include note of a potential problem
 drivers/staging/comedi/comedi.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index 09a940066c0e..a57691a2e8d8 100644
--- a/drivers/staging/comedi/comedi.h
+++ b/drivers/staging/comedi/comedi.h
@@ -1103,8 +1103,10 @@ enum ni_common_signal_names {
 
 /* *** END GLOBALLY-NAMED NI TERMINALS/SIGNALS *** */
 
-#define NI_USUAL_PFI_SELECT(x)	(((x) < 10) ? (0x1 + (x)) : (0xb + (x)))
-#define NI_USUAL_RTSI_SELECT(x)	(((x) < 7) ? (0xb + (x)) : 0x1b)
+#define NI_USUAL_PFI_SELECT(x)\
+	({typeof(x) x_ = (x); (x_ < 10) ? (0x1 + x_) : (0xb + x_); })
+#define NI_USUAL_RTSI_SELECT(x)\
+	({typeof(x) x_ = (x); (x_ < 7) ? (0xb + x_) : 0x1b; })
 
 /*
  * mode bits for NI general-purpose counters, set with
-- 
2.23.0

