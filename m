Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B228C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015EB20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUL0vCJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbgAIQJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47872 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729201AbgAIQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOQjJaPeQ6AkeMaBkCNADMS/kyh8erzQiBDqDRYV0Ec=;
        b=EUL0vCJ8ZrnWjvsaczDdGHnKKVKoNO7Bdnqk53iDOGWRBr+ILjB8qsqBbEmx3MlTNdea2Y
        vcIDXFIp9JvqsbnWKYgEtcvmghYEi1+PsUMuilTtBBeeL3wULQJwND4U02q9IpJeaoSXSp
        uAAbKFjVhDSz3BLOcZykcO1vlzddjXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-s1m8si7nP72QKk9XVYs6DA-1; Thu, 09 Jan 2020 11:08:57 -0500
X-MC-Unique: s1m8si7nP72QKk9XVYs6DA-1
Received: by mail-wm1-f70.google.com with SMTP id g26so622299wmk.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SOQjJaPeQ6AkeMaBkCNADMS/kyh8erzQiBDqDRYV0Ec=;
        b=XiznIvTvpSGPFlX9Ozz34tEoBJMRgjZLKVXSloBX+C0hr54xAB/2We2cP59yzQlrDe
         rO0+3lZCwj7oGOtnRPKUQMFK9Yy+MP9J6Lc6FMkXiQ0RBORk5HVHgUkNnlOsnVIhk5i8
         sW/RB2364qeO1PDVQxHT93CwljkP6xuEhk2W/OCQ+hM1xRcdm5ZmgPHhY0ZFbXgbx04Q
         +DWHscBkzDhh5s1fFKta7S5aPwhxjwcFVKlmf8ywHV4OELRPn6TfnftV4is/E77V76bA
         nGE3ptLKnY9oqIjfITtXNA1uahMnqiimu8YnhfVj9FIPoF76QQwqjFol+H/SaDAhvdq+
         VZ5A==
X-Gm-Message-State: APjAAAWU0cuCB3WZrI8Oq7GDNKxPDeLD+AIIOqumvcQtTDSPZg871npg
        kzwWC2AISLTPEK0A30z9MNk97r7qgrUE/6QmsCM3yxQMY9iEDnM9oyQnE9Z4biVScwGYaTCcRfE
        o4DhHcbXVTQD8tAuxiXiQa7Aw
X-Received: by 2002:a1c:8095:: with SMTP id b143mr5978376wmd.7.1578586135883;
        Thu, 09 Jan 2020 08:08:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEszMufKupL2p3ncLrB7YUBRc575U8Mr//L6Fw6AnOA6p/ZOQdu3ZNuVMIx6ccyJ0DT1HBiQ==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr5978353wmd.7.1578586135722;
        Thu, 09 Jan 2020 08:08:55 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id v8sm8403505wrw.2.2020.01.09.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:55 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 46/57] arm64: alternative: Mark .altinstr_replacement as containing executable instructions
Date:   Thu,  9 Jan 2020 16:02:49 +0000
Message-Id: <20200109160300.26150-47-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Until now, the section .altinstr_replacement wasn't marked as containing
executable instructions on arm64. This patch changes that so that it is
coherent with what is done on x86.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index b9f8d787eea9..e9e6b81e3eb4 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -71,7 +71,7 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	ALTINSTR_ENTRY(feature,cb)					\
 	".popsection\n"							\
 	" .if " __stringify(cb) " == 0\n"				\
-	".pushsection .altinstr_replacement, \"a\"\n"			\
+	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	"663:\n\t"							\
 	newinstr "\n"							\
 	"664:\n\t"							\
--
2.21.0

