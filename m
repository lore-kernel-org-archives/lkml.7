Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42324C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113B52168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5hK9LD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEYJQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 05:16:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44706 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfEYJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 05:16:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so6721057pfo.11;
        Sat, 25 May 2019 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0I0iYBrt5xIGBpHNoVr45Rx9KFD668cAF8Ky+1iHTBU=;
        b=R5hK9LD0MMAcb+MZkIyyc2ZzMnF9IvfB8Gu+uXzqBWyu0LntP//SFOsJBCqDPtmCnj
         Eocfg87oPsC8FRZRJES3LSbAhggyAtukai81SEdmPGwzhCtazBG5q+/fWCnwNrb3PHUy
         3eKYGLUnS3ZFvkiFwlMlHN09FDGo2PSS0gdysh96vGCVdabDrwJoV6pMDssm/yUHcrr4
         xJQoBrKh3VcDCn3Gm9bJTJqL3YmxvMAFYfkeupfqNEwrXuFtKY7zKeKmIAbdy3IVcd/Y
         XzIZ3u3taCn3/nGFtNsmMSUPiwEV42kEvfzRc4P3DEILbQeaqiQxR5SnuORdx+jw4usW
         f5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0I0iYBrt5xIGBpHNoVr45Rx9KFD668cAF8Ky+1iHTBU=;
        b=DHsKJJAp3byN+O0Qr2oNlM/Nl09ZcxvAH8IrPNERrBmrT1zaTBHRgzzj4jQ6btLoPt
         Bgh0VY1Ovgky2Oqa61L5WiHFhda/jEq/UA/Si5CzSrit++hvLQygmJFiaJh/NoO6oKb/
         TIfgsqLggrKk5x/FUGs9+Lttrc2SajtymBafjLXqg4kqyzOnN01o5Ztay//3aVx+PZ8m
         KCiyWa7BADPlmB1hjV6YCXFH8XLylmGZzz0bbZTodfT0pNX7J5LN3hou/m/ScXyAVgcd
         nCae9ZMCAammcPH65dE4rAQudowBvNbkD2juH41nIj7btuz3318YqYFy/sqvHg3NTeFE
         pdIA==
X-Gm-Message-State: APjAAAUO5pjeq1wisbGlc8w1u4Mp2Hl75SrsXP+L4+f11W0GY/dj9Oi9
        gRVu9jlFW34TfTonAG5DJ6Q=
X-Google-Smtp-Source: APXvYqwr2jegsAlC7mxUQq/vqN/ul8XZcWvpfWBwR9zBd3VpoSGeO3LjAkfWvLDNIBYXpql8JJDiGg==
X-Received: by 2002:a65:520b:: with SMTP id o11mr56516634pgp.184.1558775764141;
        Sat, 25 May 2019 02:16:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id v66sm11898260pfa.38.2019.05.25.02.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 02:16:03 -0700 (PDT)
Date:   Sat, 25 May 2019 14:45:59 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: fix  warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190525091559.GA14633@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change1: fix below warning  reported by coccicheck

/fs/ceph/export.c:371:33-39: WARNING: PTR_ERR_OR_ZERO can be used

change2: typecasted PTR_ERR_OR_ZERO to long as dout expecting long

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/ceph/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index d3ef7ee42..15ff1b0 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -368,7 +368,7 @@ static struct dentry *ceph_get_parent(struct dentry *child)
 	}
 out:
 	dout("get_parent %p ino %llx.%llx err=%ld\n",
-	     child, ceph_vinop(inode), (IS_ERR(dn) ? PTR_ERR(dn) : 0));
+	     child, ceph_vinop(inode), (long)PTR_ERR_OR_ZERO(dn));
 	return dn;
 }
 
-- 
2.7.4

