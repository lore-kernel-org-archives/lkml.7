Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A95C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751F9205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WclQk7Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfJGQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:09:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39857 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:09:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so8950614pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aeEaJtarLqJ/0FUJVYNbwn+6HPdzfTKq5CySN2cpkL8=;
        b=WclQk7CqmZhdOvOLCv7bcbzhzQmzjahDqMBGbnnQMbfR+9Qr5Xtu2s4Pq3udBWYK3e
         GoWCLwm019+p9dKJnQT6RlhXwMB+3RrjdnZn6tx2kl/ylqM4mc/PyUyNj+lU7/yQ9NZJ
         KxYS/aSvd4bWsbKruGsMqIUZefM9aluM+5oFIv3S1DJ10bNO52A06lGf57EBsnVJKZ0w
         XMcJ9xAC8U2/pLfmvcFKcJzaUjo3yIi/b5PT2TuOq3N4yoK93MDj3/3JFcpF/FkTgRJz
         KovVEYC9Ir32aKghqE1WmmCNMId/lP6/3CiNDL0nw91hNfed+TIH1o2+/PCmnwpeNlCh
         ZRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aeEaJtarLqJ/0FUJVYNbwn+6HPdzfTKq5CySN2cpkL8=;
        b=Ai5zTJqFpIpgOrSuCj/pE8m6QtrSUw36jGmLgUvNe386oKQ9r9ASfq1x6u1JzeTaOS
         B+UcflxVYItNlVL8XPLgaIAp0NCcRZjEzVQA4tPCepY4yv4QnB9FG+xkTvA+bmP1W/RC
         fbiw1UJPX+zAqPlnawranX79a+4xm0m5Y1e48njgOsBh1gTV6+AfDUnEA9iKHO9i7vxb
         DDr9iepZkAT5j+p4uovb2nTfaiaakUNO24nQcUV/hra7Zj+cyDiXgOGcNWXHOCT15bgT
         pBagwCBFXDHInStJbrXXmpgfcT918wJLx92JlaPotLDE+8xTa42g2AVudK33bB+i5ngR
         8xaA==
X-Gm-Message-State: APjAAAV6GcEkE8/03dU8ZuPGjDIpDAMvpCfyLm2m1F4ucKlYzfwqfcfn
        efgoascMUNS8a0E4Mq7XPWLt3Lq7IHJSMQ==
X-Google-Smtp-Source: APXvYqxOwvzzrjEtteWgmzgIWO6ke9wfqYA06v+6RaJ5Zxl0ufcPdavUTQcVgAmJgyYhl4ADnqIDlA==
X-Received: by 2002:a17:90a:e008:: with SMTP id u8mr81782pjy.46.1570464566766;
        Mon, 07 Oct 2019 09:09:26 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id v13sm17660512pgo.79.2019.10.07.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:09:26 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: filter of trusted xattr results in audit
Date:   Mon,  7 Oct 2019 09:09:16 -0700
Message-Id: <20191007160918.29504-1-salyzyn@android.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When filtering xattr list for reading, presence of trusted xattr
results in a security audit log.  However, if there is other content
no errno will be set, and if there isn't, the errno will be -ENODATA
and not -EPERM as is usually associated with a lack of capability.
The check does not block the request to list the xattrs present.

Switch to has_capability_noaudit to reflect a more appropriate check.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org # v3.18
Fixes: upstream a082c6f680da ("ovl: filter trusted xattr for non-admin")
Fixes: 3.18 4bcc9b4b3a0a ("ovl: filter trusted xattr for non-admin")
---
Replaced ns_capable_noaudit with 3.18.y tree specific
has_capability_noaudit present in original submission to kernel.org
commit 5c2e9f346b815841f9bed6029ebcb06415caf640
("ovl: filter of trusted xattr results in audit")

 fs/overlayfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index a01ec1836a72..1175efa5e956 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -265,7 +265,8 @@ static bool ovl_can_list(const char *s)
 		return true;
 
 	/* Never list trusted.overlay, list other trusted for superuser only */
-	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+	return !ovl_is_private_xattr(s) &&
+	       has_capability_noaudit(current, CAP_SYS_ADMIN);
 }
 
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
-- 
2.23.0.581.g78d2f28ef7-goog

