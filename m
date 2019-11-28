Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC93C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 20:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A9D21787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 20:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7X91QbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfK1UZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 15:25:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726569AbfK1UZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 15:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574972736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FRKI5+6EDUKwn2QzAstv2u6dW0Q8/ilQLcz5atGxuE=;
        b=J7X91QbVadkgvT4zo5d7j6HP3NcO1WFQYGmogATwcnINpNAOaDzxqbQLWIxh6pYFOCfwO3
        +5ijEcM1+7jAVaPvCj1AxZ/+Gw/j382BLoTLtOkK/A3FlnESDeNyEDNlK7kNU5f+e4VLzc
        ZGyFz85ValuBB0gbUHyHTHQa/9ZSrqA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-4SMOtb2DNv-pvultRlNfGA-1; Thu, 28 Nov 2019 15:25:35 -0500
Received: by mail-pf1-f197.google.com with SMTP id o71so5421815pfg.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 12:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BgAr5VVOQXh1yien5qVgdgmIL5RHbScoYGF2ala0/ak=;
        b=jPslLmwr3WsPu95s1T1ZdIgwe61zn0G2G7xCTnsXJfqrxhHv7HoopaeXMV8GRPWw6E
         8MlGEerJlJj4bA8wl37a7+ZFmh7yLbuqXRfvZ4XIkytidwvi7JpXxZTKDVj/R4WHi4p2
         N5DuZkaq69adijYtBvdq/vB+C4dhMiebbq/SQcOgd2M5cnVpIt9oF87Zyc4eCZSZgkNl
         mvSxhSgiA4DKFcy1C+Q22V+Gw7q2PSSBYNHplkhnv6lI5136yq1UkRPiwRtF/AvDyoB9
         VNM9MYwPoAQ5t89fax8lDu8Kg8dtTOe1hDiEKiRG18iNxSFm4IsNkAEdwiGXGRGbQfom
         G9eQ==
X-Gm-Message-State: APjAAAUgGQ2Xroo0XHjgrJIXmgyam4H6mh35IiMfdzoZTOCp57Qxy5j5
        adDCD9mjf7dLE8PGNPoW+8NWC51REYcbsaJz8xyjEAYVQ4ANceB9eRN6huY/8aFikrA3eaK2m5f
        lgBgm7ToiuSE0je5GRal6Pk4g
X-Received: by 2002:a17:90a:9bc7:: with SMTP id b7mr2779321pjw.72.1574972734227;
        Thu, 28 Nov 2019 12:25:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGw9W2BseetWuCKGjOOk2X1gZmHcotzHkh3qc0nDt9y8frA3vEMk0c5zDGq7c6I7jA3cnCbg==
X-Received: by 2002:a17:90a:9bc7:: with SMTP id b7mr2779308pjw.72.1574972734045;
        Thu, 28 Nov 2019 12:25:34 -0800 (PST)
Received: from localhost ([122.177.85.74])
        by smtp.gmail.com with ESMTPSA id hi2sm11225511pjb.22.2019.11.28.12.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 12:25:33 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 3/5] Documentation/arm64: Fix a simple typo in memory.rst
Date:   Fri, 29 Nov 2019 01:55:14 +0530
Message-Id: <1574972716-25858-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574972716-25858-1-git-send-email-bhsharma@redhat.com>
References: <1574972716-25858-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: 4SMOtb2DNv-pvultRlNfGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a simple typo in arm64/memory.rst

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/arm64/memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rs=
t
index 02e02175e6f5..cf03b3290800 100644
--- a/Documentation/arm64/memory.rst
+++ b/Documentation/arm64/memory.rst
@@ -129,7 +129,7 @@ this logic.
=20
 As a single binary will need to support both 48-bit and 52-bit VA
 spaces, the VMEMMAP must be sized large enough for 52-bit VAs and
-also must be sized large enought to accommodate a fixed PAGE_OFFSET.
+also must be sized large enough to accommodate a fixed PAGE_OFFSET.
=20
 Most code in the kernel should not need to consider the VA_BITS, for
 code that does need to know the VA size the variables are
--=20
2.7.4

