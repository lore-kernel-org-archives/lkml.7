Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79F8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BE12176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8Qyy3Zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfK2T7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 14:59:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59599 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727175AbfK2T7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575057587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FRKI5+6EDUKwn2QzAstv2u6dW0Q8/ilQLcz5atGxuE=;
        b=B8Qyy3ZwqX1aKoo9QY+0r/F4xriA8glP+aBdWc4fGEKWl7zFQP9mtmf1bQ1TCkZaKATqgF
        UG3gBc0yRgdaoXAYJy9C2UigbTFr0MlMjndq11X/gZW+wFDvV0LJoqJqOpidQ23+niT2fZ
        pyed1rdA0fF4UCSBEop9ba9XcK0Qf7A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-ZNstE28SPZ2zzw_VNZM1UA-1; Fri, 29 Nov 2019 14:59:45 -0500
Received: by mail-pg1-f199.google.com with SMTP id i21so199734pgm.21
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 11:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BgAr5VVOQXh1yien5qVgdgmIL5RHbScoYGF2ala0/ak=;
        b=WBZdNTni2HVYZypYjP74+4wd5NCh+Ly86+hXknVbiQv//YUjlXHmvAOB5OGvNCJ3K4
         6/3J4rM1VpHEfnqBlgUBJvLuyxRyA05wbJ4+TGmI3P0AQgOkNTwmQbeDyieIYC2Ibiev
         316wBM8gVBOYvcmOppQg6oadA3IyVl2DCDkHJZjHui7mbKLQVDtKJQB8oFXmP6YfQcx8
         7jC12j7Obu1zenuqVYF/UHfkYDZ8taq3/KuEo3M4zQYyNajjIH+aX3p1dkfQaE1dNJhd
         53SXUgau0LlWUyLkW/iKZBBa9pOKlGrYE3PFCUQ+hT7o5XcYGShI3HKNrtsZwr2tYlLk
         E5BA==
X-Gm-Message-State: APjAAAUT+7zIs9Nu9VuTGLVkV+orp/S8BUAAix8ShUzxecnuW/YbGT+x
        2LCiwWDvhL2mk5qDvpz6KR0aICEozJzzYnVWZWiHPgscUKdcycJV6amZ8ncL8d5cnl47kAsv66V
        X+JDgJEqaXsj49vaQXCgc7KCQ
X-Received: by 2002:a17:90a:fb53:: with SMTP id iq19mr20314624pjb.138.1575057584293;
        Fri, 29 Nov 2019 11:59:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4gnI9c2bYrtjkLwMhPYvWHvZw+YasEX6lAkryf7HpqeVi2n8s5GR/Ai2re8lnbcSS3E4aLw==
X-Received: by 2002:a17:90a:fb53:: with SMTP id iq19mr20314608pjb.138.1575057584113;
        Fri, 29 Nov 2019 11:59:44 -0800 (PST)
Received: from localhost ([122.177.85.74])
        by smtp.gmail.com with ESMTPSA id 67sm15725427pfw.82.2019.11.29.11.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 11:59:43 -0800 (PST)
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
Subject: [RESEND PATCH v5 3/5] Documentation/arm64: Fix a simple typo in memory.rst
Date:   Sat, 30 Nov 2019 01:29:17 +0530
Message-Id: <1575057559-25496-4-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: ZNstE28SPZ2zzw_VNZM1UA-1
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

