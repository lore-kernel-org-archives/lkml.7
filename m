Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5187C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DDF21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw9B1HpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbfISNjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:39:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46978 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389222AbfISNjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:39:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id e17so3585355ljf.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ljddPlLbugzgQnvA3trD4zHMH/BICWFfII8G370j0MY=;
        b=Fw9B1HpSbGNYHCU5OzIy+QofrJE+uWtt0F4VJpA/g+9lujIV60Wy+x8sKiCtgFnu1w
         8hxaOb4w5415jl9aMpEHjHCtlOPBN5EzhBwfXTNBv+NJBZfDGamcSpfT3g9Q4qkqy1Gh
         LJWmlw9DJqn2iHiF0gEO8E65RR9VWobwdDK9fsaq0vbCI4XItUuHVLDQo28HFHzR20wS
         CrvER5n/oa5TcIyVjFMsblbzeiPmPtW+9w+i10PHK7Ukxd3AcXWi1FvRNLTtPP235w8/
         9cC/t+NOSgQZwHfgnFSVurSvd5mPy+4pfwzYgTKVCNoCz/fhNMXsrLk0cVbzXdYVvzLm
         gFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ljddPlLbugzgQnvA3trD4zHMH/BICWFfII8G370j0MY=;
        b=kp9QNOJ8Rw6CQdd+3DsrsIDYkCo+LlFSuJrysDmVES8U0Ud5tfLgSaTQSo/FpE0DJh
         Z8BaPWwNZO2OACY6Vb5dK8PD5UkJUgH3XmNkh0HC5zKZ9917qVxBawcKQ14LwTw4OCVI
         H9+YBxnQGxl/pHCbh+6yRMbZD290YMsc74rViqO0HOrtn5FRacrQuF6Zlq/CWaNsas57
         dMF2Revhp13uGOc1dhkRL88mrYTY9R4B6QpCFTQe0bAw38+9bvPgnfGg/mMKkKsSBFsV
         nVGBzuYtZXuNqTHlN9LR729wVTTzlnvOBdheh399XwGwwhYDIVEtGluI4/y4/dUwMLhT
         NR6Q==
X-Gm-Message-State: APjAAAUGUqAh+dyXcpqJFdhHJHsyFxCU3fgXHjXDXK0jqZPiA9zoAvuk
        jF+g9OwpZlf2ru8x3uTbHJM=
X-Google-Smtp-Source: APXvYqxqDzTP+yc5q65qxkOlEx+r7EGFXQaNg56YX5BKSVlxvdU9OZnVvEnylS7QvcDTCc7YmM6l9w==
X-Received: by 2002:a2e:b0c2:: with SMTP id g2mr5324803ljl.217.1568900386154;
        Thu, 19 Sep 2019 06:39:46 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id 81sm1669121lje.70.2019.09.19.06.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 06:39:44 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 599274614AD; Thu, 19 Sep 2019 16:39:44 +0300 (MSK)
Date:   Thu, 19 Sep 2019 16:39:44 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH -tip] x86/boot: Reserve enough space for any cpu level string
Message-ID: <20190919133944.GB2507@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when we're validating cpu on boot stage we assume that cpu level
won't ever be greater than two digits. In particular the check_cpu() helper
ensures to be so. Still the cpu_name() helper is a way too far from
check_cpu() routine internals so I think better to be on a safe side
and prevent any possible overrun errors when printing cpu name.
For this sake just increase the buffer up to be able to keep any level.

CC: Ingo Molnar <mingo@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 arch/x86/boot/cpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-tip.git/arch/x86/boot/cpu.c
===================================================================
--- linux-tip.git.orig/arch/x86/boot/cpu.c
+++ linux-tip.git/arch/x86/boot/cpu.c
@@ -20,7 +20,7 @@
 
 static char *cpu_name(int level)
 {
-	static char buf[6];
+	static char buf[16];
 
 	if (level == 64) {
 		return "x86-64";
