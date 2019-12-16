Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD0FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C264E21739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hrfy1ApX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLPWBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:01:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35829 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPWBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:01:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2487508plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pg208Gbp4fn2PKZAr2bOwBY2qUBOZu7Jr1zInufrXBs=;
        b=hrfy1ApX8xLoQLm4yS29kRMMe5/v9oV7VS0hEMnjGX08S9FQcCX3m2+Vj1Fn6Eah66
         laldmyuREHSLW82S1wA/7uRE89/Dk/tAgcdw+sUExbXYeSqARIBWUWNZ6vLAcHl3myGw
         7tsikcdP89E0zFm9p5Z8DXib3NkeWC3RrnOc9rZhIQkNQQ39obh3GjfFF0z5nHdZDWfo
         AIAcaPHSgtZMrnfjUXuFq4QfMY3W2Omadm+S/RBACQ6udnK3vROLXVGycaa9X2VRJLOW
         XFqEDZc/nsrxfGaEMGKaq+BL0bdqDjvQMGtvRj4CXcDg6dE8lejHaeTOrorIhSY/IkO3
         hizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pg208Gbp4fn2PKZAr2bOwBY2qUBOZu7Jr1zInufrXBs=;
        b=BusijuUS51DInszff/54J01CXgAAYt0kzkfHi9JwsyTobgInxI18w+6S0umtL/3tv/
         5bLG9yHvs/XRZqEXLYbOwwG6fEI2MwFBo4TTzXuNHSld+n2YrOKxcTFkpt71ErdnBWhK
         Bw2TwQx+eDHtgej6qSjKkRZ6kQ/MXPUmGU+nMYIkUoeg8Xt9uXmbgEnKurIkch9ZGWes
         Qx/v6P9RSEqiquYrv2eJtdoA/OLb6Hzpz/AWD4XrcElW40gJ9j1UTyrDF19twiMcA3JG
         Km829piCspkkdJu2rY84UjQmeigjaSI7URe/ZI19uNZBEJKcKoQj7vquDyj0yuhuLMLT
         HE+w==
X-Gm-Message-State: APjAAAW5eWhlV4lHNFeTUL0qXHJWEX5JQQ5zKhCn2Uu3i1Gt2iD7SSSq
        K4yp3XCqVjpA602mVdYePnNtyg==
X-Google-Smtp-Source: APXvYqy59+CReKlQisVLx++KzTKqAnMz72AZMuEwcfkZf0gbQHVgS65xOqkxz8X3QALZWpJFp+5Igw==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr18579009plk.136.1576533694788;
        Mon, 16 Dec 2019 14:01:34 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id y26sm83521pfe.65.2019.12.16.14.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 14:01:33 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] objtool: silence build output
Date:   Mon, 16 Dec 2019 14:01:22 -0800
Message-Id: <20191216220122.22595-1-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20191209180833.2oleipnnzh7btqno@treble>
References: <20191209180833.2oleipnnzh7btqno@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync-check.sh script prints out the path due to a "cd -" at the end
of the script, even on silent builds. This isn't even needed, since the
script is executed in our build instead of sourced (so it won't change
the working directory of the surrounding build anyway).

Just remove the cd to make the build silent.

Fixes: 2ffd84ae973b ("objtool: Update sync-check.sh from perf's check-headers.sh")
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 tools/objtool/sync-check.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 9bd04bbed01e..2a1261bfbb62 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -48,5 +48,3 @@ check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
 check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
-
-cd -
-- 
2.22.GIT

