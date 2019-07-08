Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD87C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405BB214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562598965;
	bh=z4YLawLAL+RAstkCPjuuCG8qe90luDJo+9TJD4mvhqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uy6yv1MwYNS+lvXDol6wg1LP8oEkSCMEDkplTcRGr0l527y+FIxDBmqy3BgCkPf1Z
	 Itb4nJkOih3io6U0+guHDDQWbh5pJo+6zpj1EJ7A0yGxEyfqojG4AsTmVqyzJPQT9a
	 UIJXy/KCFmmqET9IGpg9uu1jkCRgbL/bIVn66LF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfGHPQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732451AbfGHPQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:16:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E88C214C6;
        Mon,  8 Jul 2019 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562598961;
        bh=z4YLawLAL+RAstkCPjuuCG8qe90luDJo+9TJD4mvhqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZYivm0RiNqde184k6nntFS4ySq3YllIYs9GFv10aLF9Z2cXa0r18pinYV26nNaZB
         aWTLKZ51GishUOkFUfGHuB0iipWYGfwhJtR15hZpfBMg3+mYRurO1tWdeQmP/k9rVu
         Mpc4byhTVIvA0QQCq4LE9G87IDWoOERgvQtT8ssI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.4 08/73] apparmor: enforce nullbyte at end of tag string
Date:   Mon,  8 Jul 2019 17:12:18 +0200
Message-Id: <20190708150518.683545067@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 8404d7a674c49278607d19726e0acc0cae299357 upstream.

A packed AppArmor policy contains null-terminated tag strings that are read
by unpack_nameX(). However, unpack_nameX() uses string functions on them
without ensuring that they are actually null-terminated, potentially
leading to out-of-bounds accesses.

Make sure that the tag string is null-terminated before passing it to
strcmp().

Cc: stable@vger.kernel.org
Fixes: 736ec752d95e ("AppArmor: policy routines for loading and unpacking policy")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/policy_unpack.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -177,7 +177,7 @@ static bool unpack_nameX(struct aa_ext *
 		char *tag = NULL;
 		size_t size = unpack_u16_chunk(e, &tag);
 		/* if a name is specified it must match. otherwise skip tag */
-		if (name && (!size || strcmp(name, tag)))
+		if (name && (!size || tag[size-1] != '\0' || strcmp(name, tag)))
 			goto fail;
 	} else if (name) {
 		/* if a name is specified and there is no name tag fail */


