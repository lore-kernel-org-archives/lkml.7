Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3768C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 12:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE38E21537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 12:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfFHMue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 08:50:34 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51612 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfFHMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 08:50:34 -0400
Received: by mail-wm1-f42.google.com with SMTP id f10so4508478wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 05:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlCih0Ql28i40uIzvi3GAm97kcm7Flw3X0DygvueNwc=;
        b=lt3Cw1x523E6P15KRxMC59qXbMCKgew8T8CvPQKj3Pj1jQRuA4/2HdJHK7zNsnwPpP
         Hg65dml4eKyOY2W+E9LFKhDWJrlRs9C8SxpHZfUcCWzbpZgLIpLeP7MuxVv1DYBxbvlG
         cuMHTVpa9iWs18LkoMz56q3/r0t2W5m8EIu+8vXUCyfR8i1GU63tyFaDN2khPHyNwnSN
         mRvt7kHI6cKL4lUfjtl4HCQNIBDVfxVuB6mkQ0F/1J+gyvShtcRKYUW9604C1EfT4x+G
         JhXx3qH8l/gyr3HMzMt+fkb3/bBhl746DH343YKcn3D4zc03L6xkpSqC8wDLBI9D4rZw
         Jq6Q==
X-Gm-Message-State: APjAAAWy4qcTFAZhDL9Uvygb2DmVta/IveOemZn5B2l5jiXo0j1BLUo7
        RLW+1cutWKdesn/2aj6MGO9RUw==
X-Google-Smtp-Source: APXvYqzpIby80Tewbtpb2LGh2fqIUOiyhotWBXo6dVznPVGxAbl/PSIblNHC6QHSlLTqyykJn5SDgg==
X-Received: by 2002:a7b:cc0d:: with SMTP id f13mr7694208wmh.1.1559998232908;
        Sat, 08 Jun 2019 05:50:32 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.vodafonedsl.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id d10sm7916279wrh.91.2019.06.08.05.50.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 05:50:31 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        akpm@linux-foundation.org, Randy Dunlap <rdunlap@infradead.org>,
        David Ahern <dsahern@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH net] mpls: fix af_mpls dependencies
Date:   Sat,  8 Jun 2019 14:50:19 +0200
Message-Id: <20190608125019.417-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPLS routing code relies on sysctl to work, so let it select PROC_SYSCTL.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 net/mpls/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mpls/Kconfig b/net/mpls/Kconfig
index d9391beea980..2b802a48d5a6 100644
--- a/net/mpls/Kconfig
+++ b/net/mpls/Kconfig
@@ -26,6 +26,7 @@ config NET_MPLS_GSO
 config MPLS_ROUTING
 	tristate "MPLS: routing support"
 	depends on NET_IP_TUNNEL || NET_IP_TUNNEL=n
+	select PROC_SYSCTL
 	---help---
 	 Add support for forwarding of mpls packets.
 
-- 
2.21.0

