Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1CDC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA52E206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfHOOgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:36:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36224 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfHOOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:36:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so2432040wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YlmjJPeojzjGuL2iKbKBDyzRelOOlVV+qdVb0SrG38=;
        b=Sip7EW3rJHDQ73FcPLjOeBLe0inVnsf4vOTYp007NTTrNyhLHRK85tJObOi9j4lHJe
         VlOEYLtqclH+URpeO0Dz1SaYUCXQU6hHftBD7KwkexPyfDbSQa9lT+yjBCSzFOXPxPOu
         K8Hsl5znAb98XzqvGLeyxTzz/WmSyTnv89+iBEK0Y8xl/BRZBBExG6wWNC06yc131yvJ
         Lb4MZUhwtUyMnN39aRrl/SScUs5sHVKrCy0SGoTAO6pqL3aJMMb2Gb6u5EgWmINlH6FK
         wZ70opp6jHY6CYU3Mhtf/YdBaA+norDpO8OXKb0E0OK5VuEdKcipAjYP9aJemrLUUKcg
         oQxw==
X-Gm-Message-State: APjAAAUMv1DQknCrPRWmwTXinHQYaUDRN0Af1jLI1/ozpXXJfoVveNI4
        UhVQI5VhU43g+7wFiqTREmz4Q6xqgGE=
X-Google-Smtp-Source: APXvYqwuDXbUGVL63z6asyFGv+G1v8IT0KvY9aerWRkjDh6nAUGeN643DxE+O1zkdw0zXQg11Jbu4w==
X-Received: by 2002:a5d:6383:: with SMTP id p3mr6144082wru.34.1565879767470;
        Thu, 15 Aug 2019 07:36:07 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a17sm1708199wmm.47.2019.08.15.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:36:06 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Stefan Bader <stefan.bader@canonical.com>,
        Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Brad Figg <brad.figg@canonical.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH 1/1] shiftfs-5.2: use copy_from_user() correctly
Date:   Thu, 15 Aug 2019 16:36:03 +0200
Message-Id: <20190815143603.17127-2-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190815143603.17127-1-oleksandr@redhat.com>
References: <20190815143603.17127-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 fs/shiftfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/shiftfs.c b/fs/shiftfs.c
index 49f6714e9f95..14f3764577d8 100644
--- a/fs/shiftfs.c
+++ b/fs/shiftfs.c
@@ -1526,7 +1526,7 @@ static bool in_ioctl_whitelist(int flag, unsigned long arg)
 	case BTRFS_IOC_SUBVOL_GETFLAGS:
 		return true;
 	case BTRFS_IOC_SUBVOL_SETFLAGS:
-		if (copy_from_user(&flags, arg, sizeof(flags)))
+		if (copy_from_user(&flags, argp, sizeof(flags)))
 			return false;
 
 		if (flags & ~BTRFS_SUBVOL_RDONLY)
-- 
2.22.1

