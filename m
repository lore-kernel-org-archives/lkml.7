Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0739C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C666921D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570057427;
	bh=rGgf3M8E8cdrPPfviqTZz+CC5G0oBSB873QG+Zz57Gk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kRmUeM3nxjHJEXuhxVsaqO/KRj8BrYKfHNIEelfSYJpZeCuxkG5ds9vLfFioqcIiI
	 Vm3l5sR5Y5WMAJBiFvr0FyClThoEHv5LbiAqsUhIep4g5AsT1/U2u6EAMvKmW/wmsU
	 47PtrrMhZbdCGhQ6SpTsBubV1HnucMlex9WqWOTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfJBXDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:03:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36432 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfJBXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:03:46 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so1223587iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oV/9b2AKj59V2uwPpS7RJHBFX/8QSHfj0AU6FMbpQCA=;
        b=dK+p1sIqIAJ8RGyefAphtb6lEwlpOLd/UkICw4usv/JjWR6t1kHw7a+p1pq3Qsqkj9
         URSJmGJkWDsHaeuLD2TGa7MWq+2juzA/OirywcxzN3IXLaSzy7LVKAXYH0Q+B54Ejfr4
         6PWic2A87QP2n0FYWCnFub7PPs/KIdmW0Lp+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oV/9b2AKj59V2uwPpS7RJHBFX/8QSHfj0AU6FMbpQCA=;
        b=AA+0pihlEooT9/rD85AeGnKLertLET4Uo8+6fiaiXDe3d1gD74TAA7+vE0onnJ4jFB
         nKhJHBaBp19qKTaphHBR0ADsum7pTnRn44TUkStZKJ424B/UjjhzTI2VSFdvzpxi0aG3
         sWtopCPcU7HNlX6+IKkgINXxs/zRqGoxaKfdyY5BnOe2fC54zR7O9q2+62HTWxNqKxpd
         aFaU0ObY1FdVnz0y8/fmDpdZUq2VAaaYGXLAd7dNj7t5gq5CGwWTf0Euqpo75JMtiQej
         19B5A70E/gmGO60SGb7amQn98NhOWJFV0WPXKptEDF+vQAGNJc49oD+OUNvbrqPCHLMY
         BIzQ==
X-Gm-Message-State: APjAAAXE0gytKTkQhc+4MV7y91+Ost+szZeq+Nn9DP8q876bkswEPQVc
        Wir4XoPJOqL9Tyj1Ci7xkljK7A==
X-Google-Smtp-Source: APXvYqygZWjkzv74/ZqaLQIipRxpUSbpqKXqXE5cRKwBIa0D4JgiRCE/Hg8dKE+sssxzkBGZVNthGA==
X-Received: by 2002:a92:b74f:: with SMTP id c15mr6837193ilm.43.1570057425858;
        Wed, 02 Oct 2019 16:03:45 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 128sm212298iox.35.2019.10.02.16.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:03:45 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: kvm: Fix libkvm build error
Date:   Wed,  2 Oct 2019 17:03:43 -0600
Message-Id: <20191002230343.5243-1-skhan@linuxfoundation.org>
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
are defined. When build is invoked using:

"make -C tools/testing/selftests/kvm" KBUILD_CPPFLAGS and CC_OPTION_CFLAGS
aren't defined.

There is no need to pass in KBUILD_CPPFLAGS and CC_OPTION_CFLAGS for the
check to determine if --no-pie is necessary1s, which is the when these
two aren't defined when "make -C tools/testing/selftests/kvm" runs.

Fix it by simplifying the no-pie-option logic. With this change, bith
build variations work.

"make TARGETS=kvm kselftest"
"make -C tools/testing/selftests/kvm"

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 62c591f87dab..02d20aab9440 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -48,8 +48,9 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
-        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
+        $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
 
+#
 # On s390, build the testcases KVM-enabled
 pgste-option = $(call try-run, echo 'int main() { return 0; }' | \
 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
-- 
2.20.1

