Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6609EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EE920863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582183;
	bh=F7QG8U0hDVhU+9rhPE5ZHaZBNpVgKFWWVey3o0urf6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WBAiM+pQc3fA9DIXrTO6HNTWP+GD3yw4Z4urmeQgP/IoGJJ86OhIWXHql2QD4yhZz
	 uf4/2+gOW1GeIKb9CiH7kaqo44oIAH7CcOSXisR9DngB84B2Nwe3Ur5kvFunYJX7bW
	 tlIKEVd+R+uJ4rjcfFRTgL/OupidBkr9P6MrLJ9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbfCZGgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732194AbfCZGgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:20 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2F320863;
        Tue, 26 Mar 2019 06:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582179;
        bh=F7QG8U0hDVhU+9rhPE5ZHaZBNpVgKFWWVey3o0urf6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAi/SzJ/6GfIwGu7VmsMa/oVffN4qb73e9xA0uuBnRi3t3Qy5JkkDxMc/vqDl0wAC
         f9I/UxhY26va2DXLZ//ZF+W9H/bX2Tfyz8VduGOVLueoBYq8FoDp+qgPWBg/T9QK8J
         ABon3RzYGyrlmLU0Ov+lBgdM7NwHyiasLKArztPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 25/45] ALSA: ac97: Fix of-node refcount unbalance
Date:   Tue, 26 Mar 2019 15:30:08 +0900
Message-Id: <20190326042704.004583670@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 31d2350d602511efc9ef626b848fe521233b0387 upstream.

ac97_of_get_child_device() take the refcount of the node explicitly
via of_node_get(), but this leads to an unbalance.  The
for_each_child_of_node() loop itself takes the refcount for each
iteration node, hence you don't need to take the extra refcount
again.

Fixes: 2225a3e6af78 ("ALSA: ac97: add codecs devicetree binding")
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/ac97/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -84,7 +84,7 @@ ac97_of_get_child_device(struct ac97_con
 		if ((idx != of_property_read_u32(node, "reg", &reg)) ||
 		    !of_device_is_compatible(node, compat))
 			continue;
-		return of_node_get(node);
+		return node;
 	}
 
 	return NULL;


