Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6EC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F20622CBD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033479;
	bh=hpH3G4a7G/KVsYa4id/3HXxZbpYaTdI/T6rleRNvGhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxIwGz+kievmrrX45hYLf/LfP7zohXjmZh+Uk59GvC9EQUdfuxdU9Jm8qPs2+H+i3
	 53i8tGlI+Pl8LqfI6F5Sp50JJLXdA4qF0hXvQ7XUo6o+uYwJxZzWaGAQe0kM6fGt7u
	 EAZKZlpbWR6ThYqzuQVXvKMW346CJigvlz/6b2Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404981AbfGYFoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404959AbfGYFoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:44:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B0022BF5;
        Thu, 25 Jul 2019 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033473;
        bh=hpH3G4a7G/KVsYa4id/3HXxZbpYaTdI/T6rleRNvGhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxLBgHrbxCeS7ot2v9/QZvXhi5N08jHUF/bGmUoSmVLeCC3i/s2OkKJ0D2v/0khja
         lQosvZQluercq/Pr9OpTn9OKyu4CUA8rAppQC09qOr5TDsAoLQx/zsSdjVBJCX/8FA
         dw8WyBYitIovpott1IbjNxqg0Hzn0v0H95To8TL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4.19 221/271] 9p/xen: Add cleanup path in p9_trans_xen_init
Date:   Wed, 24 Jul 2019 21:21:30 +0200
Message-Id: <20190724191714.072527248@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 80a316ff16276b36d0392a8f8b2f63259857ae98 upstream.

If xenbus_register_frontend() fails in p9_trans_xen_init,
we should call v9fs_unregister_trans() to do cleanup.

Link: http://lkml.kernel.org/r/20190430143933.19368-1-yuehaibing@huawei.com
Cc: stable@vger.kernel.org
Fixes: 868eb122739a ("xen/9pfs: introduce Xen 9pfs transport driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/trans_xen.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -530,13 +530,19 @@ static struct xenbus_driver xen_9pfs_fro
 
 static int p9_trans_xen_init(void)
 {
+	int rc;
+
 	if (!xen_domain())
 		return -ENODEV;
 
 	pr_info("Initialising Xen transport for 9pfs\n");
 
 	v9fs_register_trans(&p9_xen_trans);
-	return xenbus_register_frontend(&xen_9pfs_front_driver);
+	rc = xenbus_register_frontend(&xen_9pfs_front_driver);
+	if (rc)
+		v9fs_unregister_trans(&p9_xen_trans);
+
+	return rc;
 }
 module_init(p9_trans_xen_init);
 


