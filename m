Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487BCC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 01:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F172075E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 01:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPfj5asY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfE1BWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 21:22:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38452 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfE1BV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 21:21:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id b76so10393782pfb.5;
        Mon, 27 May 2019 18:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WyrVEd7Z066n8x3W3p36ZvDVCldsmbGvGU0q2zkOUWY=;
        b=JPfj5asYw7HCuZpjdcUxtFWyEFHcmHBfYWpcQ4cmCmn01QcNRXP91gGo5EDqXK0ebD
         yGi03pUH40J20cuiByrNO5+e2WHsEB1cGlo+knxIfa3kdjvc5aSFrbfY38H09Y9MD/XE
         fDpB+LX6OBDNmaFUxzMNfQaxGSJeTuLYKuaQ/ihD1gRzlWNDwA1g/GKXwk6q7q4PuWGH
         IZSRIHQV+dD2le7wFYYByLBYCm11oAeO5vEAM6i1GN0ndtqDz4qnifhYOMYizJ6iuJDk
         nRDuDJ+0zMOWpVOtpNL4NfZ+FTwbGGSld7XcgS5vRk1TkzoL7CEf3Jxz3aNdPmhCoVAS
         zV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WyrVEd7Z066n8x3W3p36ZvDVCldsmbGvGU0q2zkOUWY=;
        b=foZCkTpH9/ignb7hIeNbTVrINpBRNWUkLuSrzPAZwxUFv3aJip0Y/uzSlqnWpfrxvN
         Np27XY6lMkIOuAMMXMKmOkmXR62XibVgchSjrsf/5TlOW/GfVbm0so1zqKv8oW5eRIuW
         Qxsoj+XP6apVZTIH70+P44IE+AEM13fVVcegcvWlNxdFQCgRIxe5mdDPikW8ViGXa9yc
         A1V2v5HrDZuaOdAgONmnV47fcCYtxrGSDVtin2YhG6SNBjyIiNHKGjJSoS9anKFXuB3L
         TSFWJ26e2tALidB4umt4VsS4LVqXmS1egp8ZYyp6UdihdWI3Bx/AgM+iEsFJwDEnEwxF
         +POQ==
X-Gm-Message-State: APjAAAWNsJZGizINknDxOMEtPA1wFdSUIuomkPvR9eLlB+K4RuzI/s/N
        qOMMHbNMdQ/G5haI6bxVFFM=
X-Google-Smtp-Source: APXvYqyW68YD00mOZxccK/5Hfm2Oq2XQwQPqlkvlJYDNTAxHBRx4vFXkEwopqCBFuWDslX1lqw7MXQ==
X-Received: by 2002:a63:ed09:: with SMTP id d9mr12668611pgi.419.1559006518896;
        Mon, 27 May 2019 18:21:58 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id z125sm15537156pfb.75.2019.05.27.18.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 18:21:57 -0700 (PDT)
Date:   Tue, 28 May 2019 06:51:52 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     ddiss@suse.de, "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v2] target/iscsi: fix possible condition with no effect (if
 == else)
Message-ID: <20190528012151.GA4845@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

drivers/target/iscsi/iscsi_target_nego.c:175:6-8: WARNING: possible
condition with no effect (if == else)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
Changes in v2: treat SRP as unsupported authtype.
               Remove unnecessary else
               return 2 in all unsupported cases

---
---
 drivers/target/iscsi/iscsi_target_nego.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 8a5e8d1..92ce2fd 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -160,22 +160,11 @@ static u32 iscsi_handle_authentication(
 
 	if (strstr("None", authtype))
 		return 1;
-#ifdef CANSRP
-	else if (strstr("SRP", authtype))
-		return srp_main_loop(conn, auth, in_buf, out_buf,
-				&in_length, out_length);
-#endif
 	else if (strstr("CHAP", authtype))
 		return chap_main_loop(conn, auth, in_buf, out_buf,
 				&in_length, out_length);
-	else if (strstr("SPKM1", authtype))
-		return 2;
-	else if (strstr("SPKM2", authtype))
-		return 2;
-	else if (strstr("KRB5", authtype))
-		return 2;
-	else
-		return 2;
+	/* SRP, SPKM1, SPKM2 and KRB5 are unsupported */
+	return 2;
 }
 
 static void iscsi_remove_failed_auth_entry(struct iscsi_conn *conn)
-- 
2.7.4

