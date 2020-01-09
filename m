Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9134DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6735E2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ez4XReiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbgAIQJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30447 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387437AbgAIQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODS9WlTRJORgY55Us9ipxq26EI7DMMwmFDGmBIaDtSs=;
        b=Ez4XReiVfenlaWwONAay4Lrjr1Gqz95v42E0R6fCkLamsAx4M+kj3D7L5V4MYLc8/6JAFF
        RguHsodLuy9uxh/HVBhpi512gYzODbF8rf2f3CUdHHwnFstqlcSTh5L0RBMhIP1OLiDTI4
        NcDzh5gdMmp9CtLNULcDyU7twkL4zAw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-YKllxR5iOFuxOscCZYYY-A-1; Thu, 09 Jan 2020 11:09:38 -0500
X-MC-Unique: YKllxR5iOFuxOscCZYYY-A-1
Received: by mail-wm1-f70.google.com with SMTP id 18so1110070wmp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODS9WlTRJORgY55Us9ipxq26EI7DMMwmFDGmBIaDtSs=;
        b=ZdeMchTAh7Uh5ULSCqT9VaBIUG7SspgvY6Mdh/fWCkGkQ3jU6i0fTw8VM2XHr08aD6
         KpqXRiw53d3ntLeRMBDJCpi32P/64eU1RT/XztaIw5Wnqze5OcmJ2lWPjXM6RYxHDZFo
         FBqaLs+g5boLqhp7+tIp1W1KW03eAampTpSLM4ht2UeIyulUQZoKahDrrSdinazzAilY
         93ZL1wN6UtZ/g0NtdXko8IjfP7X9B3eu0kCTMzS//swlygwIbRstoYNhPOp26fu08JFu
         ba4BJxycC2bYpQKr4BKDI30Ntyv0W6Vi/GqyABznMDYTfTfsyT8ILZ3wA/ak6ctBejTf
         mmJw==
X-Gm-Message-State: APjAAAVWiYuy32Mr3yenssD4EW+ACvvggLBvGX/3Qu4KPnkz6S0HuBw2
        IDUF4JiUuZgsHHDV751u4LmV5MGm4PkANSVsnoMvrXALNmzmvcemFGWmPzQ95pvnxYnkW2/siEq
        +ZWEhfwZdmbuk2n3Fabwy2MvW
X-Received: by 2002:a1c:a78c:: with SMTP id q134mr5391857wme.98.1578586176749;
        Thu, 09 Jan 2020 08:09:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxEWwuCOkJR5Ut8BjsE0zeZF0JVq4HT7AdNp/Reici8OM453wT+4LqvjkdS8rpxKybepscTA==
X-Received: by 2002:a1c:a78c:: with SMTP id q134mr5391844wme.98.1578586176598;
        Thu, 09 Jan 2020 08:09:36 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e8sm8517707wrt.7.2020.01.09.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:09:35 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 53/57] arm64: Generate no-ops to pad executable section
Date:   Thu,  9 Jan 2020 16:02:56 +0000
Message-Id: <20200109160300.26150-54-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directive .org fills the gap left to get to the new location with bytes
of value 0.

Having an executable section contain invalid opcodes confuses objtool,
so use .balign to fill the gap with nop instructions instead.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/kernel/relocate_kernel.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index c1d7db71a726..5e08845f701a 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -118,6 +118,8 @@ ENDPROC(arm64_relocate_new_kernel)
 .align 3	/* To keep the 64-bit values below naturally aligned. */
 
 .Lcopy_end:
+.balign	KEXEC_CONTROL_PAGE_SIZE
+/* Ensure we didn't go past the limit */
 .org	KEXEC_CONTROL_PAGE_SIZE
 
 /*
-- 
2.21.0

