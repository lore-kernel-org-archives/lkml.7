Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF402075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzL85NUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKIFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:05:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34583 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbfKKIE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573459498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FRKI5+6EDUKwn2QzAstv2u6dW0Q8/ilQLcz5atGxuE=;
        b=YzL85NUQPYbV3CULNH5NR1+PPEfYPyWQXAfwXEWi7yJ4neLhUp3MBpFGLWQvSwW1Yt7B9g
        VUy7ympG6dTWDPJTp6P+yrE+12NDnAw8y0nE9FtTv8nVJo6GIkgpFsCJrb4wcJVidE2Cth
        hrAOj52Q7eHBahdg26Njs7XtWVGjEAU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-JW9kdmpjPPSVpnsocb4fbw-1; Mon, 11 Nov 2019 03:04:57 -0500
Received: by mail-pg1-f200.google.com with SMTP id v10so11374209pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BgAr5VVOQXh1yien5qVgdgmIL5RHbScoYGF2ala0/ak=;
        b=suVhn0n6oZAqJsr6Ujsht2zO9YSmc8qRlgc/kXcuBhG19zufJ+JLozfqFk5rKJCZCk
         Xc4AZqT1wv7f8pFfdZ5JQSjr8uAhh/HI5bZMJEPMMR9KuLusEC1Rm4BtFD0oNH6lhgQG
         XEOTTmVFpJUOhKLFunyXBRQKGrz4qgCaFkFE2Cjpkt8AsM1nz79kBz914uqs4LX5csgE
         J6aObXsiIy4EcbigO4VGm0ZBz7JSOC/72jzdj0Eqg0jCtcFbFAoBNrKG69ECiTEJG1DE
         rrbRiitQb1tTMGQucLRvMEY+wtE/ylGaEfV7CEV+pNsweDwOgmC0DnAh3mayVIhvbxsL
         FncQ==
X-Gm-Message-State: APjAAAVLwuUW2ztJs1fCOWAqAHFXrxjKH44QLmzH1KlV8xteFpSIccRD
        XnfeJtMEOvlSpZs7NR9+oBjapYMrGp4MJLZUys7rEn0mb1BsL0WW8dySKrCPUTgQGRQPI3n+SKt
        YtSyPFVcnOB6LQ7G2O/xG+f4j
X-Received: by 2002:a63:cc17:: with SMTP id x23mr27009239pgf.446.1573459496120;
        Mon, 11 Nov 2019 00:04:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJWpQcBQvquc5dbnGBM6G4yNAtHiqFdXD409t0Q0+sK5yPSXKJEhVQvzS4/XbjlsLJyg9EHQ==
X-Received: by 2002:a63:cc17:: with SMTP id x23mr27009207pgf.446.1573459495818;
        Mon, 11 Nov 2019 00:04:55 -0800 (PST)
Received: from localhost ([122.177.0.15])
        by smtp.gmail.com with ESMTPSA id m123sm15397699pfb.133.2019.11.11.00.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 00:04:54 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] Documentation/arm64: Fix a simple typo in memory.rst
Date:   Mon, 11 Nov 2019 13:34:45 +0530
Message-Id: <1573459485-27219-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573459485-27219-1-git-send-email-bhsharma@redhat.com>
References: <1573459485-27219-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: JW9kdmpjPPSVpnsocb4fbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

