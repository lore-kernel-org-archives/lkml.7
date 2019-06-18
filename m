Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73055C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1BF20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTGBpnGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfFRQJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:09:18 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42729 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfFRQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:09:17 -0400
Received: by mail-pg1-f202.google.com with SMTP id d3so10235844pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6IDFouL/H7+c/7AlvTo7X9/eywwkp4tDYTIp5DP7IoQ=;
        b=RTGBpnGivsxhigxzXCCAyfitf1UP+bR777ZW4X0Ba2SvpIluQba8Nf28uEO6Pd9o5s
         +DdSidPp3cu9c3gNfbjiGWKpQeMTdOmgV0ErJWHNaAe0K7qVk7B+O1OKDTT6ILNlyls+
         pWPCf5BrzJNSRDnYReBKEBGriap1vFXaaeb9PyfTjd3fhJ8mp/Uc7PdAJxBBm/QvZSJp
         knf9G59aFXUt0qSOC5r8zoML2Fg9jW4Trxe1ox6ApyOhgbutcRhBbP6Kjj7oI4W0jSqH
         +qXOzddWWWJgYAjKHtU21bNuYSe64JmBWXkGng+stzLXFms86RDD6dxgTMcJp1ySq/LL
         8KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6IDFouL/H7+c/7AlvTo7X9/eywwkp4tDYTIp5DP7IoQ=;
        b=U/5birzgR+3OgwLldn3LudCy/90xeatmoMhG5KxjPi2UCEjK22WIZ428+Q0LQGAd+c
         wg0PT4TTeFRzey/8EFQSNR8t6WlQYmBpHy5cAQSQw+D3ut4/L99w41vshIALCrypOX2Z
         CbKbMIBcMtmyIeSkaPETozdxd6kGs0YWM2XtetcacIjIvqPqEflebZSRp+pATAzL3xl6
         exv0Y3yQJYXSy0s3hrMFyXqmG88wvc9fBRsdbb+gxiPSzrqe2rm8sbGkdOzHG/Nejlzo
         LE0WJCSKwJMoX+QMip4KT0tAfi4TT81un+3gDPUckkPJ2UogwKVGK9nm2+TV5gr3/tEo
         GkdA==
X-Gm-Message-State: APjAAAWRTXXEYcBjrrTjnrifZmlWrtloXmMpUlxDPaIZOeBctEdTi3kJ
        eHSyjUD2hkP6m36aPrmA6dCo97Xngw==
X-Google-Smtp-Source: APXvYqyo4hLXmSpMPPPSg/4SQs1y7daEnNSSdHXidTKy9+Ir8lzk1kY1I65tbUu+DwL1MAJ839z0DtEdbg==
X-Received: by 2002:a17:902:6902:: with SMTP id j2mr42357327plk.321.1560874156473;
 Tue, 18 Jun 2019 09:09:16 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:09:10 -0700
In-Reply-To: <20190618083900.78eb88bd@bootlin.com>
Message-Id: <20190618160910.62922-1-nhuck@google.com>
Mime-Version: 1.0
References: <20190618083900.78eb88bd@bootlin.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] net: mvpp2: cls: Add pmap to fs dump
From:   Nathan Huckleberry <nhuck@google.com>
To:     davem@davemloft.net, maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was an unused variable 'mvpp2_dbgfs_prs_pmap_fops'
Added a usage consistent with other fops to dump pmap
to userspace.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/529
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 0ee39ea47b6b..55947bc63cfd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -566,6 +566,9 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
 	debugfs_create_file("hits", 0444, prs_entry_dir, entry,
 			    &mvpp2_dbgfs_prs_hits_fops);
 
+	ddebugfs_create_file("pmap", 0444, prs_entry_dir, entry,
+			     &mvpp2_dbgfs_prs_pmap_fops);
+
 	return 0;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

