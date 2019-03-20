Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55010C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F23E218D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120938;
	bh=7EZgmwtuEsvwVHPQ/07GZzDLcHSqmF8xNnJg/Uj8n9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ivNB4P17bRzluaq+k2FIafQWRtT28xydpJ+9X1LXm4MMZ9YCWBYp7a5Jr+BaMAGJB
	 SwM4ZLJQjdjaSoFPREW6SZwjtw+MnJusb9P555nrH0Tf3uSK5/lqK2JA0hzHR82A4B
	 MxyeQDjwC8OCoU09Thew6cLVMjNppbPLmPq4hX08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfCTW24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:28:56 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33432 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfCTW2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:28:54 -0400
Received: by mail-yw1-f67.google.com with SMTP id a199so3375556ywa.0;
        Wed, 20 Mar 2019 15:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bx9EJikvDMDGUCNAwxp4SdiC4KEOqeo4PV+oxcc7bOY=;
        b=IasSFqtBfIra77EMpkfxc+vdxCG82hYuduGtDF/TNWQ0ZJXOQkWGcnipX9QvepY8RW
         MNFb/PVGRWtnZ7NASrbvA6jNXSazF3IYKhHeIjSnJgtD8ZVMWOfhHHjxanWO26vaRdis
         WmLjNGtooFwrcBIcosIuh0DAoL6H3XPoUvTw7yqccvFIioo1bk2AKvZLPrgjx97Dh6GU
         XMUAydm3dzL/CoIdTepa1lzwxZ2kkGFGokAFnzhxlQRhdOzALMclPvbiqx613g0/CNV9
         8lxNd0WgkmT5h/m7bp9di3185ve0rRclBhJxgEwm5E8GRHxEyZtscesh2eYBJVoKvhgY
         m7Pw==
X-Gm-Message-State: APjAAAV908AyDKKe+cFaATdxk6+QywxiTlDnduIOpftEZzJqOLaBRT+s
        FXN6BvLQ+JinvKbTQlvjffg=
X-Google-Smtp-Source: APXvYqwB1B3dKfMqnsDAG+nmoEINKciwiZmKc32r/lIlls0no3VQOd2mh4fBVo4UDYofa2t3eVLq9g==
X-Received: by 2002:a25:65d4:: with SMTP id z203mr345117ybb.370.1553120933151;
        Wed, 20 Mar 2019 15:28:53 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p1sm1067327ywg.12.2019.03.20.15.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:28:52 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Wed, 20 Mar 2019 22:28:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     sandeen@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/6] test_sysctl: ignore diff output on verify_diff_w()
Date:   Wed, 20 Mar 2019 22:28:28 +0000
Message-Id: <20190320222831.8243-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320222831.8243-1-mcgrof@kernel.org>
References: <20190320222831.8243-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When verify_diff_w() is used we care about the result, not
the verbose output, and although we use -q, that still
gives us a chatty message about if the files differ or not.
Since verify_diff_w() uses stdinput the chatty message says
whether or not "-" matches the target file, and this just
seems rather odd. Better to just ignore that messsage all
together, what we really care about i sthe results, the
return value and we check for that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index e0c8404da6b0..f51987d0d32d 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -179,7 +179,7 @@ verify()
 
 verify_diff_w()
 {
-	echo "$TEST_STR" | diff -q -w -u - $1
+	echo "$TEST_STR" | diff -q -w -u - $1 > /dev/null
 	return $?
 }
 
-- 
2.18.0

