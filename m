Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111BCC04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0421707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624495;
	bh=H3DFlUfLXaoZvOYd7ajIC+uXD9+xmxHAYRCDfN0nouw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qmb/uZlRTJE2wey+fcJSH9Kfs/1XvasDIWCLXy45HEXoGdtVemhHhn/jKQmUj92mV
	 ss3tBihjpt8OWMP5yS8qU/E+JJPHicnjfphw9Rn1F+ZTP+NHhoLjl4BjtO8Ug9ps31
	 jN546QxP8ajeY77POyDXiBf0HGA23dDSZlWTFVp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfD3Lld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbfD3Lla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:41:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85B721670;
        Tue, 30 Apr 2019 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624489;
        bh=H3DFlUfLXaoZvOYd7ajIC+uXD9+xmxHAYRCDfN0nouw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcRSGqk9PJ6VN8kEht4L/z2Tc2sYVDxs9FNBNvo6bRNVZ1pcKuLJQq8cv1chRySpl
         lme9HNJb0wcjKGBm5rpU3wL7Qn8Z6IXvRnDewbdVTGxQqfrKo96mO15sHsfHB8K7qG
         R3yjUZqXQELtj//1ZIpC/lda0J1SKUZBfMGoe9eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 4.14 13/53] ceph: fix ci->i_head_snapc leak
Date:   Tue, 30 Apr 2019 13:38:20 +0200
Message-Id: <20190430113552.790188489@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113549.400132183@linuxfoundation.org>
References: <20190430113549.400132183@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan, Zheng <zyan@redhat.com>

commit 37659182bff1eeaaeadcfc8f853c6d2b6dbc3f47 upstream.

We missed two places that i_wrbuffer_ref_head, i_wr_ref, i_dirty_caps
and i_flushing_caps may change. When they are all zeros, we should free
i_head_snapc.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/38224
Reported-and-tested-by: Luis Henriques <lhenriques@suse.com>
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/mds_client.c |    9 +++++++++
 fs/ceph/snap.c       |    7 ++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1219,6 +1219,15 @@ static int remove_session_caps_cb(struct
 			list_add(&ci->i_prealloc_cap_flush->i_list, &to_remove);
 			ci->i_prealloc_cap_flush = NULL;
 		}
+
+               if (drop &&
+                  ci->i_wrbuffer_ref_head == 0 &&
+                  ci->i_wr_ref == 0 &&
+                  ci->i_dirty_caps == 0 &&
+                  ci->i_flushing_caps == 0) {
+                      ceph_put_snap_context(ci->i_head_snapc);
+                      ci->i_head_snapc = NULL;
+               }
 	}
 	spin_unlock(&ci->i_ceph_lock);
 	while (!list_empty(&to_remove)) {
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -568,7 +568,12 @@ void ceph_queue_cap_snap(struct ceph_ino
 	old_snapc = NULL;
 
 update_snapc:
-	if (ci->i_head_snapc) {
+       if (ci->i_wrbuffer_ref_head == 0 &&
+           ci->i_wr_ref == 0 &&
+           ci->i_dirty_caps == 0 &&
+           ci->i_flushing_caps == 0) {
+               ci->i_head_snapc = NULL;
+       } else {
 		ci->i_head_snapc = ceph_get_snap_context(new_snapc);
 		dout(" new snapc is %p\n", new_snapc);
 	}


