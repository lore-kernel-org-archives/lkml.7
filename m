Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B5CC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0F121D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570058076;
	bh=OZVJeZ22vcNjw/uCU9WIlcSTnKiZymJMTEEQaMbl7TE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Wgr+8KkoGzDr0+gM/jkqQ6iKt2ZYnASeqr4oBEChEfOw0bpAj/7F3OntGhLJ6Vd8O
	 6fMzLghKO/ubKJLIqPXDuOA6XwL/5ouTS5Z3Yu5SAE8WFzb4+gMQDm/w65kcqMSmeF
	 zv6/T5Al3Yf/UfYvnforT9UiNEvRBHQrQN2USnPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfJBXOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:14:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35153 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfJBXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:14:35 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so1292725iop.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvZas5u4F0ANJvTgj3n1e3Kg28XWglgthvIgi7KiUDM=;
        b=OAmzgMLRqJrsm01/oVo0z52yps2KIsjjA0iSxmFhaj0J88TZvinG5qtiC7/sCqrJct
         XrgfqrnXnUfbVHpnU/DQZtmNicYVO9mW/frxnGp5y9Aqp4/NAigNRU873DNLZ4Zvu29D
         LUI0gg2+7ZwzBWUdbPnc7BM6q8a4zpw/xTOws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvZas5u4F0ANJvTgj3n1e3Kg28XWglgthvIgi7KiUDM=;
        b=ndXYh8dWU450xQBW0C3zOvQbbzTYjrTl2u6UUuEtbh6wv2MgeAsUqO46QJhVeFe5iZ
         HLlrKUBWlALy6iV4Ped0TMwOipR1QV2fOF4jWzGuO/NXkQYB9IDQwOPyonl017JneXeu
         0NS8VKnoEGt77zfvTQTCiOxGNKKBeHh7nrJj939tI0Gcoeb2kT3lETWzLDP79xbAWFc8
         RMRqyK4lwBA+aqjnu+Cs3aRuq6vdDt0BSuDLgU/RogzjO9X/Tm9yxWLBZJ51P2Tk5F3F
         zp+p015YSKKh2winuwTt5sb/f0Yl+2poVNarm9J+iATXpcDjUIAjQYFPEAoBcE9id/XC
         YOhg==
X-Gm-Message-State: APjAAAUyxWdW9F4KuHLWSDCg8WhTH5kQLs6Lt/KStrxlFvT4vrmVGKcd
        vSSoisuYd7+aPBF3TgbTjPSwEA==
X-Google-Smtp-Source: APXvYqzuqtspnkYcsNldhwxDFk74uox7GnxjgX02w15feBtduAjf6+BWwfmMwuq7uIhWVVekiK+5hw==
X-Received: by 2002:a92:b752:: with SMTP id c18mr7008975ilm.42.1570058072984;
        Wed, 02 Oct 2019 16:14:32 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m5sm259542ioh.69.2019.10.02.16.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:14:32 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests: kvm: Fix libkvm build error
Date:   Wed,  2 Oct 2019 17:14:30 -0600
Message-Id: <20191002231430.5839-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build error from "make TARGETS=kvm kselftest":

libkvm.a(assert.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIC

This error is seen when build is done from the main Makefile using
kselftest target. In this case KBUILD_CPPFLAGS and CC_OPTION_CFLAGS
are defined.

When build is invoked using:

"make -C tools/testing/selftests/kvm" KBUILD_CPPFLAGS and CC_OPTION_CFLAGS
aren't defined.

There is no need to pass in KBUILD_CPPFLAGS and CC_OPTION_CFLAGS for the
check to determine if --no-pie is necessary, which is the case when these
two aren't defined when "make -C tools/testing/selftests/kvm" runs.

Fix it by simplifying the no-pie-option logic. With this change, both
build variations work.

"make TARGETS=kvm kselftest"
"make -C tools/testing/selftests/kvm"

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v2:
-- Removed extra blank line added by accident.
-- Fixed commit log.

 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 62c591f87dab..7ee097658ef0 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -48,7 +48,7 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
-        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
+        $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
 
 # On s390, build the testcases KVM-enabled
 pgste-option = $(call try-run, echo 'int main() { return 0; }' | \
-- 
2.20.1

