Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E95C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3AE214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355524;
	bh=rmffEHAhueVbENrjSXU8HS106ZhLz6ZVTjAObWH7Cp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0PXKmMsHpMf4oP/xR6JAZ1UAxrp+A4LJ5Ph8VtKC4AtbeNTkB/4r0nGB5YQ4d4Q/F
	 l7aMV2vg815rC+0uFd+tLYi85cYPQG6rIJuMSfMpnb6ayXxzHsiNNHHBFcligqVCCj
	 /Pk0/5EwKesNyJSW96RsmcGe8w3ErQZixzl00Srg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390488AbfETMcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732867AbfETMb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:31:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA4D214DA;
        Mon, 20 May 2019 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355519;
        bh=rmffEHAhueVbENrjSXU8HS106ZhLz6ZVTjAObWH7Cp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azTcyF2xlYWpZLyWlEW/mO/WvKyhovf6sema9BO/a7nwcGpwa5esbDpnE2WCWLyla
         rdyAv5T6VFGIk16JQJ9SnZtcHdutT7taoJHpdkW5hwWQ/0LtHZKuto0IcINibTGw/a
         AmCAhckDykoKQSstUs+3y8UIHNKDdqKorT2aUDIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.1 025/128] crypto: salsa20 - dont access already-freed walk.iv
Date:   Mon, 20 May 2019 14:13:32 +0200
Message-Id: <20190520115251.271406658@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit edaf28e996af69222b2cb40455dbb5459c2b875a upstream.

If the user-provided IV needs to be aligned to the algorithm's
alignmask, then skcipher_walk_virt() copies the IV into a new aligned
buffer walk.iv.  But skcipher_walk_virt() can fail afterwards, and then
if the caller unconditionally accesses walk.iv, it's a use-after-free.

salsa20-generic doesn't set an alignmask, so currently it isn't affected
by this despite unconditionally accessing walk.iv.  However this is more
subtle than desired, and it was actually broken prior to the alignmask
being removed by commit b62b3db76f73 ("crypto: salsa20-generic - cleanup
and convert to skcipher API").

Since salsa20-generic does not update the IV and does not need any IV
alignment, update it to use req->iv instead of walk.iv.

Fixes: 2407d60872dd ("[CRYPTO] salsa20: Salsa20 stream cipher")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/salsa20_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/salsa20_generic.c
+++ b/crypto/salsa20_generic.c
@@ -161,7 +161,7 @@ static int salsa20_crypt(struct skcipher
 
 	err = skcipher_walk_virt(&walk, req, false);
 
-	salsa20_init(state, ctx, walk.iv);
+	salsa20_init(state, ctx, req->iv);
 
 	while (walk.nbytes > 0) {
 		unsigned int nbytes = walk.nbytes;


