Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155DEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1FB217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053591;
	bh=bEjoequiyTWxjev/YaWlKL+HKVq8yFnmIxSjk/Nmmf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UMzn3V6Qa2j5A43fTS4MLLV+zR4qoViA3/fg9rS/TNjKpiL7hRkxMrt1wKTS4WhXL
	 L4YPTPj7ZfyMZiFI2J+NwTi2ESo/ZWLQgu+jnMbvpXBEK9tUCUF7QkMB5FMmp2ISpU
	 xymCs12HPQQRBZx5jYaqOJX1qnMN6yaO0eZZwf1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFTR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfFTR7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:59:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF0A21530;
        Thu, 20 Jun 2019 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053586;
        bh=bEjoequiyTWxjev/YaWlKL+HKVq8yFnmIxSjk/Nmmf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2JvUseUD0qTLM1GihIUlyatk9V1a3qKS4i99/lv/nY3nx6/DMd33h5GpmL00jdw2
         LsGzH6ideORbGmnObTtVFAri3Itt0lKdEXiGe6LpqbdpbvSqgnwvf//9g2/YvcJOi5
         7ec0IlfoNFpZuShUdcjUpWSakD1GFpzbYH/qv6Mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Brauner <christian@brauner.io>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 02/84] sysctl: return -EINVAL if val violates minmax
Date:   Thu, 20 Jun 2019 19:55:59 +0200
Message-Id: <20190620174337.856536005@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e260ad01f0aa9e96b5386d5cd7184afd949dc457 ]

Currently when userspace gives us a values that overflow e.g.  file-max
and other callers of __do_proc_doulongvec_minmax() we simply ignore the
new value and leave the current value untouched.

This can be problematic as it gives the illusion that the limit has
indeed be bumped when in fact it failed.  This commit makes sure to
return EINVAL when an overflow is detected.  Please note that this is a
userspace facing change.

Link: http://lkml.kernel.org/r/20190210203943.8227-4-christian@brauner.io
Signed-off-by: Christian Brauner <christian@brauner.io>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sysctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c140659db669..24c7fe8608d0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2461,8 +2461,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 			if (neg)
 				continue;
 			val = convmul * val / convdiv;
-			if ((min && val < *min) || (max && val > *max))
-				continue;
+			if ((min && val < *min) || (max && val > *max)) {
+				err = -EINVAL;
+				break;
+			}
 			*i = val;
 		} else {
 			val = convdiv * (*i) / convmul;
-- 
2.20.1



