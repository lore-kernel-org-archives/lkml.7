Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE2C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF31B2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9FXdPU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfDERsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:48:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33640 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbfDERri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so3681972pfd.0;
        Fri, 05 Apr 2019 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXXdq7GrYAICjYexP9jF/A5d/mueQ96ws92MW4tT5O4=;
        b=D9FXdPU3FrBxpfBcKxuAiUB8kd8j7EkUWOcqeDcN4SowzFad52D5gymbw8NlxnSwZq
         msjE5171qmG3t4cyS9joJZIITqiOy0ruHX+6t6Rg8zjqMvY77HWbxmqDv0QfAC6LYE/z
         LCHPY3Et4q+VRGf6L6XnBoe5cEqZW7IuuSVU3JQwfRHUYVD+j0Mg+BT84tQxqjmdMnEV
         ECXp/EmFAKVB8awDaKJlfHgehczpONI+0HtRQTRgaxkSAXPoqKvmDEO/mcSUm2PD8Xmi
         RHV/oRyYm7sH/4E6/d44/TSpY/wKIjQL9JWPXfsBfF/Edr9vGgfZTjr7oJsFSFM0NMcY
         gL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXXdq7GrYAICjYexP9jF/A5d/mueQ96ws92MW4tT5O4=;
        b=pT3TpkaMTJUvpU5lKSKEhyDrQnQeT6RtEDYxAkm7Xr7xzSdTVGU+GrECjV1rdxSf/y
         Iw299NDy7OBITwwKHOvBVTTeWd1s/zo5NN1yercRvMuI/OJODWH9Jf1UhUdt872yVA5U
         gdoZLMRo14uW0iu6D60G4WNYjXgJ1EPogyFTtSXq0an63SPGWIb9H4EUOW00kLzw1H6f
         c7NkBxjY8Eb83OB76OBFmNnXQcKM7WfpTxH7n1YjAeuACTRV9qhdgapq3VyIfzbAqeLp
         TkW3kQySPVb+ZxoXJgXw8UQykm37QEXRv90ZfgRXx9yKXBoKpyyzbfX6VoEHxT9K2Nsh
         4mFA==
X-Gm-Message-State: APjAAAUj+FELE98YUhaO/zcTxGlhYXmbXGSCSl9d1W05aP5mbU0tyuEf
        eKzRoXbtgRP9DNPakcKt6Zs=
X-Google-Smtp-Source: APXvYqzfSsCY8RIY+Fr5S0H2NV31nrUqV2DGVBWfQV2jYu1S8usujXhiWe9iz5Be888hKPrjMd3Alw==
X-Received: by 2002:a63:c23:: with SMTP id b35mr13226675pgl.298.1554486458098;
        Fri, 05 Apr 2019 10:47:38 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:ad20])
        by smtp.gmail.com with ESMTPSA id m2sm33169135pgr.74.2019.04.05.10.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:47:36 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v10 5/9] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Fri,  5 Apr 2019 10:47:04 -0700
Message-Id: <20190405174708.1010-6-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405174708.1010-1-guro@fb.com>
References: <20190405174708.1010-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cgroup destruction races with an exit() of a belonging
process(es), cg_kill_all() may fail. It's not a good reason to make
cg_destroy() fail and leave the cgroup in place, potentially causing
next test runs to fail.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/cgroup/cgroup_util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 14c9fe284806..eba06f94433b 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -227,9 +227,7 @@ int cg_destroy(const char *cgroup)
 retry:
 	ret = rmdir(cgroup);
 	if (ret && errno == EBUSY) {
-		ret = cg_killall(cgroup);
-		if (ret)
-			return ret;
+		cg_killall(cgroup);
 		usleep(100);
 		goto retry;
 	}
-- 
2.20.1

