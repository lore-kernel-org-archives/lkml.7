Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E69120856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139606;
	bh=bXYFpGS07iV4rHMz2s3AeJQouTiKYqQm43TsOmQd/Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J7Hz0zoydVuBT2iN8mBWYUsYXLX98ZGCxVjHecHAyZlfoi0OB+iI48DXHVzROrD9Z
	 d1NJQubc0rhZkxDedxQaZemkIsp1RzFtpWLTfmEzakKy47Ox+hahWrS2AWqwxBTeLm
	 7HNECJNqxE4aZMdYazholABAvA2Q0R5aYyO3qUhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbfDAR0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731559AbfDAR0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:26:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B88B20830;
        Mon,  1 Apr 2019 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139600;
        bh=bXYFpGS07iV4rHMz2s3AeJQouTiKYqQm43TsOmQd/Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vVmzdhumAq+7pIBEdG7FVo1g9Flk+DOIYjWpK46xcyI7NIOxjIz1FC1oANwpeL/Ld
         gcHmme/vZ7P1tASHjtLfNn9b2eLeIQs4rzdNEKkoLd0S667YnIkompB2xz6Roroytz
         hkMJm/e4mXVGM81OAh9OJSI3cmBzX72qJEJ31IX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 16/56] tun: add a missing rcu_read_unlock() in error path
Date:   Mon,  1 Apr 2019 19:02:32 +0200
Message-Id: <20190401170104.755009478@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 9180bb4f046064dfa4541488102703b402bb04e1 upstream.

In my latest patch I missed one rcu_read_unlock(), in case
device is down.

Fixes: 4477138fa0ae ("tun: properly test for IFF_UP")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/tun.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1330,6 +1330,7 @@ drop:
 	rcu_read_lock();
 	if (unlikely(!(tun->dev->flags & IFF_UP))) {
 		err = -EIO;
+		rcu_read_unlock();
 		goto drop;
 	}
 


