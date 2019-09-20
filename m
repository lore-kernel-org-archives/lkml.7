Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FF9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01192070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITs/Lbtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406467AbfITSZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:25:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43177 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406453AbfITSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:25:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so7729494wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2IvBkcFFLDM4Sv2EJOVAIMkcvQXSkoTzEC52Jp4wqas=;
        b=ITs/LbtqZCt33JewS1V3/tlfllDe2r7AQDZ2/uf40kDn4b1OiDjNjiwJepogz6TWYM
         nX2v6YALyhDi4zs+Rnyc5YoH3uQG7Zp9ZHwS9DNyd76gndkH6CxKCZb4WY8dsGSoNPhQ
         6S+MvVkEHR/PfppGbQ5382sLxwNsc86l7GHcuz1EIfAHZFfIRpr52kej9/Smn0FdS2ZT
         AGdD1ndu3gfI5Rcvomu+7G+Oopfdvf8fBcTh2ZIcOjKREZ0zsRC2tydXCk5ZNGqI9GPj
         rJ41W0MNtlgC6ydFCaiEnoFBdoGA0y5PxXJHsyo8z1/BNGD0E8VnH3ERIANPhG84XOmV
         g/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2IvBkcFFLDM4Sv2EJOVAIMkcvQXSkoTzEC52Jp4wqas=;
        b=dc76cgvNKJL+8ZzdYQAIwo265lkxQ1GHmW2aQSNHpPu6nRe0unEexLyCu4f9hxJ5Wr
         YKzQl560mNcIaQn1hdZjUxXd6qxULP9ktY3Lk1jxkdSUgCT8LFu0gIIQetKOxcIA5jlk
         0uFYMl15yTO6CHc3SLOZuT9TU/m8ZW9VrQkQvGfB9xLJLJAAAxhXL1b4TLlQrXT5Tc+6
         G6rWrXuUpiKURkBICCTX50MiipjW46cFUhrScQoFlZL+rDAiXTO/o2++8Mw9rlBv0j0h
         L5mCVIijMlZitPYnIUmFO5VnAVleq22FoCNaksFVjJWEX23CUXZGKGQqq9YFRc+aN72+
         Iiww==
X-Gm-Message-State: APjAAAV67o+OyiKiN9saakTLgEtWmR7sEQIrT55DFTMfrsiQZvaOF3Oq
        3xuXGn3qWtJAOLfCdncYTQ==
X-Google-Smtp-Source: APXvYqyW7/nF1FQ9RTcLn0gHvKRvgdXVj+9WNxnhUmxVxCLUIsmg3CavNtkGBZahkGXGxVnL1zfq+w==
X-Received: by 2002:adf:d1a4:: with SMTP id w4mr8238429wrc.331.1569003906523;
        Fri, 20 Sep 2019 11:25:06 -0700 (PDT)
Received: from avx2 ([46.53.250.203])
        by smtp.gmail.com with ESMTPSA id c6sm3517471wrb.60.2019.09.20.11.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:25:05 -0700 (PDT)
Date:   Fri, 20 Sep 2019 21:25:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     jpoimboe@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: bump function name limit to 256 characters
Message-ID: <20190920182503.GA15073@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

net/core/devlink.o: warning: objtool: _ZL31devlink_nl_sb_tc_pool_bind_fillP7sk_buffP7devlinkP12devlink_portP10devlink_sbt20devlink_sb_pool_type15devlink_commandjji.constprop.0.cold(): parent function name exceeds maximum length of 128 characters

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/objtool/elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -19,7 +19,7 @@
 #include "elf.h"
 #include "warn.h"
 
-#define MAX_NAME_LEN 128
+#define MAX_NAME_LEN 256
 
 struct section *find_section_by_name(struct elf *elf, const char *name)
 {
