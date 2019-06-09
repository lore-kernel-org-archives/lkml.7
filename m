Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C4AC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D71206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100807;
	bh=8oduMf+dBgb6kaS66Ozv83moSLTyUNtaMe1r0s2XBq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNgHp30QfwCfSSxSQifQrfK9e4SxHo+r7WWyJQstfi7voHfyFPTzp0biMK1dIiYST
	 iSjGxxdTAz3J3h09e9dGwU1v0wHdAuM0mh7BhFdFq7xIn3nae4IzfHUH3GUJ7y/YKi
	 8CDG2jVOFNg1i3ptlPnzSOi1kV0+C5osPhpsX1is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfFIRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbfFIQr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:47:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD7F206C3;
        Sun,  9 Jun 2019 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098877;
        bh=8oduMf+dBgb6kaS66Ozv83moSLTyUNtaMe1r0s2XBq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLDef88fAT4mCrbTVMNwyYD85x8x1sFKowrK3SspdHg546euUNTU4SygxRWdV0jzc
         fRbzZ6l3uQ+1HkGRMKPlBKiAyhk6QLsYLIcySN62JzxT7ygIzMdOE87egoA5Z35XSF
         IZZwBBNXBjD7u50VwTHdhHbuJ1HshNu7RRWCW9Po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 04/51] ipv6: fix the check before getting the cookie in rt6_get_cookie
Date:   Sun,  9 Jun 2019 18:41:45 +0200
Message-Id: <20190609164127.386795598@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit b7999b07726c16974ba9ca3bb9fe98ecbec5f81c ]

In Jianlin's testing, netperf was broken with 'Connection reset by peer',
as the cookie check failed in rt6_check() and ip6_dst_check() always
returned NULL.

It's caused by Commit 93531c674315 ("net/ipv6: separate handling of FIB
entries from dst based routes"), where the cookie can be got only when
'c1'(see below) for setting dst_cookie whereas rt6_check() is called
when !'c1' for checking dst_cookie, as we can see in ip6_dst_check().

Since in ip6_dst_check() both rt6_dst_from_check() (c1) and rt6_check()
(!c1) will check the 'from' cookie, this patch is to remove the c1 check
in rt6_get_cookie(), so that the dst_cookie can always be set properly.

c1:
  (rt->rt6i_flags & RTF_PCPU || unlikely(!list_empty(&rt->rt6i_uncached)))

Fixes: 93531c674315 ("net/ipv6: separate handling of FIB entries from dst based routes")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ip6_fib.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -260,8 +260,7 @@ static inline u32 rt6_get_cookie(const s
 	rcu_read_lock();
 
 	from = rcu_dereference(rt->from);
-	if (from && (rt->rt6i_flags & RTF_PCPU ||
-	    unlikely(!list_empty(&rt->rt6i_uncached))))
+	if (from)
 		fib6_get_cookie_safe(from, &cookie);
 
 	rcu_read_unlock();


