Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7A020673
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384540;
	bh=bDeYkcfrCcYDblr5V5cTyF4lXsdHjxrarOQYWZLL9S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tb/uz2zADls/66wOdhxvhuUjRLff8zB/rIR/WonIf+c1Pxit1/e4oNVgOMJur7Idk
	 eJlpWw56sFgWD4d426j2m+QBeQ5QJt8iJiRvmXMMMm7CCmHPoLS/FmWF04ORfWo7DL
	 WYL+LCH8a7OCuty05vxoVASpANbHEtawtUeOcKqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJFRzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbfJFRya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:54:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989622246F;
        Sun,  6 Oct 2019 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383979;
        bh=bDeYkcfrCcYDblr5V5cTyF4lXsdHjxrarOQYWZLL9S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNO9bKJ0rFlbDnxliCl1NzI/YcigZu1XLEN6Avr9YmoCMtDCkJbHn+rdQ/ctz14SH
         TZR4J+VPTjC0knYioZsEOoUf4KTPTCLIXAGh+Eezmvxd+QlBZHBJDcMfxoDUrU81If
         T+7T8rjksOfgNrmGH943xrKCUhdqWWvtVL7zYyeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 5.3 165/166] 9p/cache.c: Fix memory leak in v9fs_cache_session_get_cookie
Date:   Sun,  6 Oct 2019 19:22:11 +0200
Message-Id: <20191006171226.753077885@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharath Vedartham <linux.bhar@gmail.com>

commit 962a991c5de18452d6c429d99f3039387cf5cbb0 upstream.

v9fs_cache_session_get_cookie assigns a random cachetag to v9ses->cachetag,
if the cachetag is not assigned previously.

v9fs_random_cachetag allocates memory to v9ses->cachetag with kmalloc and uses
scnprintf to fill it up with a cachetag.

But if scnprintf fails, v9ses->cachetag is not freed in the current
code causing a memory leak.

Fix this by freeing v9ses->cachetag it v9fs_random_cachetag fails.

This was reported by syzbot, the link to the report is below:
https://syzkaller.appspot.com/bug?id=f012bdf297a7a4c860c38a88b44fbee43fd9bbf3

Link: http://lkml.kernel.org/r/20190522194519.GA5313@bharath12345-Inspiron-5559
Reported-by: syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/9p/cache.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -51,6 +51,8 @@ void v9fs_cache_session_get_cookie(struc
 	if (!v9ses->cachetag) {
 		if (v9fs_random_cachetag(v9ses) < 0) {
 			v9ses->fscache = NULL;
+			kfree(v9ses->cachetag);
+			v9ses->cachetag = NULL;
 			return;
 		}
 	}


