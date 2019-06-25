Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0DBC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9E92085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="ItHyKFJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfFYTnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:43:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37814 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfFYTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:42:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so63682wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85UmCqjB/2q4FemAi0uqOHeKcTywLVBMQcPg1IVAqAM=;
        b=ItHyKFJ4XKYckCqhHyWodBeiPoSVP0SJx+jL3mIeXqtPEFRqoYIQTpI9yaJjhvDtfN
         BQl3rcGcAlTg36sUZLiD3au1iPVGbO7p9kY/FIwWRVv9Dfq9i2rWLxoGu1Do0wyYHoYK
         iUQFdMcGCoqYvRLgIqdjeSvfS4xwLoaBpenmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85UmCqjB/2q4FemAi0uqOHeKcTywLVBMQcPg1IVAqAM=;
        b=jcjWjN4KVSeN2ZtxsYyniNFWVNmwQmXa+9tuJNenIayCs+iUUqmu0gHxPq38Joa1k9
         z4rx+o1w/APSIqNFog4C3Di3J7td0YYOr1huSqOgBEySEHqx3ncO8aNM2Tb/Tq6N3IcA
         dULPCdE+Tzyyj8JApV1G4erUHsCKDgRiA19Djj89rbNRdFiSYfuaNqwLsmTjfAqFK9df
         CStH7PjF2RdQuGiG02Gdb+6aOoLxYqb/aBHpeKON3WBVQdmNVdkuBBXnM0VLdWD1Lf0A
         E154pNqPWlLuDY5PH7ydcRHCkgRa5muHXHbF2lTh1JAGZOc7UDX2053PmQzFef+BmddP
         /P1A==
X-Gm-Message-State: APjAAAUStrX4LvEdQmEBv6E47LS5YpqF4hbnKvptNP6y+RiJ7kxMfS3A
        7nW7Vly4jaPf01Tp8+jDOqSHEw==
X-Google-Smtp-Source: APXvYqzIMxgXlOTdo4m8VF3Ksi0pmsLJDIqlKPFVSelHYIH0PbCG3pg3PScZRGP+zhtfti6ZKyzEKQ==
X-Received: by 2002:a05:600c:2388:: with SMTP id m8mr85591wma.23.1561491771995;
        Tue, 25 Jun 2019 12:42:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedb6.dynamic.kabel-deutschland.de. [95.90.237.182])
        by smtp.gmail.com with ESMTPSA id q193sm84991wme.8.2019.06.25.12.42.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 12:42:51 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     netdev@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v2 07/10] tools headers: sync struct bpf_perf_event_data
Date:   Tue, 25 Jun 2019 21:42:12 +0200
Message-Id: <20190625194215.14927-8-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625194215.14927-1-krzesimir@kinvolk.io>
References: <20190625194215.14927-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct bpf_perf_event_data in kernel headers has the addr field, which
is missing in the tools version of the struct. This will be important
for the bpf prog test run implementation for perf events as it will
expect data to be an instance of struct bpf_perf_event_data, so the
size of the data needs to match sizeof(bpf_perf_event_data).

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/include/uapi/linux/bpf_perf_event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/bpf_perf_event.h b/tools/include/uapi/linux/bpf_perf_event.h
index 8f95303f9d80..eb1b9d21250c 100644
--- a/tools/include/uapi/linux/bpf_perf_event.h
+++ b/tools/include/uapi/linux/bpf_perf_event.h
@@ -13,6 +13,7 @@
 struct bpf_perf_event_data {
 	bpf_user_pt_regs_t regs;
 	__u64 sample_period;
+	__u64 addr;
 };
 
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
-- 
2.20.1

