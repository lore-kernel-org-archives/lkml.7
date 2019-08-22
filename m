Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6261FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2286623402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495822;
	bh=Mh1/bHNMSZxjSXWuCew94BhzmXBwks+dNsCioYr3Aqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oxnQ8AAqyVU7eYYqsTfT9ik30O77qQ1EvrujBfgSht0yy5XBmpTj1go7mLrurzRYf
	 yYjSeEjkH3+55B0dmtF6vVvBitjb+QJYnGojdaHgzWm/2JM5k/cNe5vC2JFiZzkg1h
	 egvwxijzE9llMV5+IJczuaOH+mG7WUWJmnE99Peo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405383AbfHVRnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403952AbfHVRX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:27 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23D823402;
        Thu, 22 Aug 2019 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494606;
        bh=Mh1/bHNMSZxjSXWuCew94BhzmXBwks+dNsCioYr3Aqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p45DeVPgnsbK1OL3M7JfnGKVXjNHe1Utfs9CqAuyoYoaHSKc+fh6sCeg4STvr+lqO
         FCNDEEN1DnSSqhcBGt+epB0ok4gHXOx+MwL3iikmCgCUgVWG0PRLnZxrqktTYQbcTJ
         5paCWfm2dzIUSNoy1bzvAzz169dtICCgfF/v11+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 003/103] sound: fix a memory leak bug
Date:   Thu, 22 Aug 2019 10:17:51 -0700
Message-Id: <20190822171728.674067039@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

commit c7cd7c748a3250ca33509f9235efab9c803aca09 upstream.

In sound_insert_unit(), the controlling structure 's' is allocated through
kmalloc(). Then it is added to the sound driver list by invoking
__sound_insert_unit(). Later on, if __register_chrdev() fails, 's' is
removed from the list through __sound_remove_unit(). If 'index' is not less
than 0, -EBUSY is returned to indicate the error. However, 's' is not
deallocated on this execution path, leading to a memory leak bug.

To fix the above issue, free 's' before -EBUSY is returned.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/sound_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -287,7 +287,8 @@ retry:
 				goto retry;
 			}
 			spin_unlock(&sound_loader_lock);
-			return -EBUSY;
+			r = -EBUSY;
+			goto fail;
 		}
 	}
 


