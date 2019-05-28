Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F2BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4243E208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEickYCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfE1Pc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:32:57 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:50958 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfE1Pc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:32:56 -0400
Received: by mail-yw1-f73.google.com with SMTP id x3so3090294ywd.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gfjeve/Jsw5lOi8JMAQQxMghnHhlj8GnAzUWdfIEwD4=;
        b=MEickYCOmg/vqRSyekS1D+0uAv2rRtP/GiT+iGHTYeeAYVwvz2sZEGrmL6FlvRGuIW
         9KcQGEuYnP4h34p/RDPaIbQqbuIFCOVdhgYWk+da2achzLGGIJqboEdCAiMic3s+m897
         HOF0nfz0zjPc/6EHUrW4NWgocinps9cnHCN/WkPojHEKIZANi1yKQKCZ5IFXhy8rpH1D
         JHLA+r7gvZDWJzDayK8poYJ+pByRsDuNWqGpFxrJR9wpG5EqamRZebocTZXfd1G03TFO
         1Qn6H6KLNTi0EgxuhbW5S2ylD04MD5N4OOgcG3IU2fnEf404r0rFKtZsKkIqP3gQmM/2
         mHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gfjeve/Jsw5lOi8JMAQQxMghnHhlj8GnAzUWdfIEwD4=;
        b=lKDXsQkSaOgFKWn2ho4HGjJg1UlabQuozK3wTJA5u1kxVHtlGT5qt0dYN2W1zEWs2D
         tTRuaJlrV+nUROwVvskb83aa1QUw0pVUHtoSY/NSwzSQi/WAtsX4H/2t7DvfNUPX9ALJ
         FziUGpQCtg5OvYalTjtJC1CzOHZ8pdVaAMVcscHFkbpMTGqO964oAMHRXKj8eVCJc5mF
         xH0sW1nXojXNBbhJIOMjbFOzt4H7u5GZOx3NIqncke26IZdgg20X0mrEY5SKMr1prDIK
         mc3+br7YV6hjTjbe7ek8LpkTIfa3D1Ey/+Xpz6yhR6zz1ExynT9PWK0LakmhqPIrGUSb
         5Mdg==
X-Gm-Message-State: APjAAAX8mRvBJCBboRGCAzhLdRCXLNsjpiMIxkE8suP1jmFIbgdOm2Aw
        94q/jhpCG5YoToAwWCUNE1+5+jfyqg==
X-Google-Smtp-Source: APXvYqy6G0sfGSdIfiMCVO4pDitrvgwqY8Z7QBE48lga4WLBMjK7M7si6BFhvixoZR3mn4nJc6CrOUVKFA==
X-Received: by 2002:a81:55c9:: with SMTP id j192mr6615282ywb.161.1559057575350;
 Tue, 28 May 2019 08:32:55 -0700 (PDT)
Date:   Tue, 28 May 2019 17:32:26 +0200
Message-Id: <20190528153226.248785-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] apparmor: enforce nullbyte at end of tag string
From:   Jann Horn <jannh@google.com>
To:     John Johansen <john.johansen@canonical.com>, jannh@google.com
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A packed AppArmor policy contains null-terminated tag strings that are read
by unpack_nameX(). However, unpack_nameX() uses string functions on them
without ensuring that they are actually null-terminated, potentially
leading to out-of-bounds accesses.

Make sure that the tag string is null-terminated before passing it to
strcmp().

Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Warning: The existence of this bug has not been verified at runtime, and
the patch is compile-tested only. I noticed this while browsing through
the code, but didn't want to spend the time necessary to figure out how
to actually test this at runtime.


 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index f6c2bcb2ab14..33041c4fb69f 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -276,7 +276,7 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
 		char *tag = NULL;
 		size_t size = unpack_u16_chunk(e, &tag);
 		/* if a name is specified it must match. otherwise skip tag */
-		if (name && (!size || strcmp(name, tag)))
+		if (name && (!size || tag[size-1] != '\0' || strcmp(name, tag)))
 			goto fail;
 	} else if (name) {
 		/* if a name is specified and there is no name tag fail */
-- 
2.22.0.rc1.257.g3120a18244-goog

