Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB98C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B260520640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MODdFeoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440113AbfIYUCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:02:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37155 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387787AbfIYUCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:02:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so56539pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qVaZZ43ja/qcq7x9zxG+MY20SnpBFpxdeCeslhLULM=;
        b=MODdFeoDS/EYzK9PjUumV7cHcAyNtzaIuHoa6fKFH60bbpt6z++ueOKM2j+RF4dH1o
         UxrQz9DCdQUlSL6SXHyc0WsToHouKzlYiyB1MDtZrTWCbJOo8gshngC9g7JdD6HmEMqR
         vcKlMBLGJGsDck0cZhZMJ0mabAUCaEmDCD3O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qVaZZ43ja/qcq7x9zxG+MY20SnpBFpxdeCeslhLULM=;
        b=ubWWrfW/1Q47X6LUvA1a89Smn7SUW02r2qkULSkIh8Gb1tzuQoSMkq2v1f6Zg5OPf8
         i2wWZ5J1TtOsxexoiZGugizC3em9Vy/16UYALbUGO52arQD0Al7aElZ34vdPk9mlDrt6
         9EZ3MysZWXpgXzFc0fNX+3IsvHTLPdxsMkFaBi4LJVX0tvyvV6eeXwnTk8LdWQgkZjLC
         ISoz/E1020274BYof52KervXQldWWCFvFr8hhNWJW32T08fb+WlPZfw2VN65tfYYpR0F
         4LWHogVoN24q6VInPBNFAtsiBesJMtQJqZeBtR06/bhynUwJTR6gpKgq4aNEeIwsEqdP
         naLA==
X-Gm-Message-State: APjAAAVi1owNFf5RKcfdrNdw5TrEqqNK2uBsPbbyk+3fR1BJC6bIo27w
        pfalblzk5Yg4pzFSaSW/I9uMeg==
X-Google-Smtp-Source: APXvYqwDJr7Hf4yBf20t8MGHRDdahOqDxk/sPU6nBYELJqmRR8em/Icc12fFJKqGcK5gz+2JTu2Xrg==
X-Received: by 2002:aa7:9a48:: with SMTP id x8mr300666pfj.201.1569441769803;
        Wed, 25 Sep 2019 13:02:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d76sm458113pga.80.2019.09.25.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:02:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] kgdb: Remove unused DCPU_SSTEP definition
Date:   Wed, 25 Sep 2019 13:02:17 -0700
Message-Id: <20190925125811.v3.1.I31ab239a765022d9402c38f8a12d9f7bae76b770@changeid>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190925200220.157670-1-dianders@chromium.org>
References: <20190925200220.157670-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From doing a 'git log --patch kernel/debug', it looks as if DCPU_SSTEP
has never been used.  Presumably it used to be used back when kgdb was
out of tree and nobody thought to delete the definition when the usage
went away.  Delete.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Patch ("Remove unused DCPU_SSTEP definition") new for v3.

Changes in v2: None

 kernel/debug/debug_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/debug/debug_core.h b/kernel/debug/debug_core.h
index b4a7c326d546..804b0fe5a0ba 100644
--- a/kernel/debug/debug_core.h
+++ b/kernel/debug/debug_core.h
@@ -33,7 +33,6 @@ struct kgdb_state {
 #define DCPU_WANT_MASTER 0x1 /* Waiting to become a master kgdb cpu */
 #define DCPU_NEXT_MASTER 0x2 /* Transition from one master cpu to another */
 #define DCPU_IS_SLAVE    0x4 /* Slave cpu enter exception */
-#define DCPU_SSTEP       0x8 /* CPU is single stepping */
 
 struct debuggerinfo_struct {
 	void			*debuggerinfo;
-- 
2.23.0.351.gc4317032e6-goog

