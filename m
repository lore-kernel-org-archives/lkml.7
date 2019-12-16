Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF32C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ABA206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519523;
	bh=tQnQ7eGrRB4decAAN2WbhDaaCkvZX5ZKgulZVP1wGHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MJ/y8RVOwBwLXEhXFd6T1n1dVdkhl0Izf5lbmjdYmlmtgJBaHG4wLBS0e4HR8p5V7
	 aNvd/a29mpWcdqEPqQq0ExVn4LYuwUBcF5+qDradnuEr6fpupPgZGX0peePhUnTatr
	 xmr+ZGP05VY3ngIKzb5XoPlfoINpYvM7Zba5CiUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfLPSFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbfLPSFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:05:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E5E206EC;
        Mon, 16 Dec 2019 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519519;
        bh=tQnQ7eGrRB4decAAN2WbhDaaCkvZX5ZKgulZVP1wGHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxeSRn3MHK3PPKSghVvkDgEC0Ce1yCdxrciTYQr3WHW+fSj7Y/Fcddgc4KxtH72M2
         ISDRLcM+MQpqusRpAPUq2y6UYbAZVTyyJSsVkKEbQ7VHoR80PFlCiRlGglVmcFXiA1
         sjTWWrz3maSBpPhc5pUx2SQDnnMVcF9L/Km+oNPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.19 092/140] ext2: check err when partial != NULL
Date:   Mon, 16 Dec 2019 18:49:20 +0100
Message-Id: <20191216174811.515507769@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@mykernel.net>

commit e705f4b8aa27a59f8933e8f384e9752f052c469c upstream.

Check err when partial == NULL is meaningless because
partial == NULL means getting branch successfully without
error.

CC: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191105045100.7104-1-cgxu519@mykernel.net
Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/inode.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -699,10 +699,13 @@ static int ext2_get_blocks(struct inode
 		if (!partial) {
 			count++;
 			mutex_unlock(&ei->truncate_mutex);
-			if (err)
-				goto cleanup;
 			goto got_it;
 		}
+
+		if (err) {
+			mutex_unlock(&ei->truncate_mutex);
+			goto cleanup;
+		}
 	}
 
 	/*


