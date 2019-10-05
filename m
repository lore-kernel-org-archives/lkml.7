Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A30C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 15:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45751222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 15:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fyC8YOtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfJEPCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 11:02:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJEPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 11:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5rADLYO7eeJAfGALC4YPyOxaJUx0EtborHdGGdhmDlM=; b=fyC8YOtF809gi+tUnvuuqW5LI
        2vDEZq2xRlgOQDj6FqI+kA3yNV4AEsZSMEAYA8jKQwX8tRYpzzRK1KNH2WQ5KeqteJWGHbEfnQtQU
        q8K3HCJ1DvcxCwsbJrHFpQLxJwPrbW9zk9LSjQM0nfC/oPKQFRp8FvnpUYtle9oYV9fEtIqw601y1
        35/W9isd5DzL3f998x/a+uqPVnEPNPN7vQuF1FiDi6ScEdgExuhElr5ukdM+N+Uq0pXcqLfOqzw4n
        tF2d5+r5Fvbz9GhfWKU6+lOonVnTEtH535/r/Tgx6BcDyL5GnjPDw6ZbC3W81y+tJ7WdUkmv77H/p
        1b2b5vFsA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGlZI-0003MA-Mh; Sat, 05 Oct 2019 15:02:00 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Mike Crowe <mcrowe@zipitwireless.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] scripts: setlocalversion: fix a bashism
Message-ID: <f5cb4272-4cb8-4253-77fd-56aaf73a0dbc@infradead.org>
Date:   Sat, 5 Oct 2019 08:01:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix bashism reported by checkbashisms by using only one '=':

possible bashism in scripts/setlocalversion line 96 (should be 'b = a'):
	if [ "`hg log -r . --template '{latesttagdistance}'`" == "1" ]; then

Fixes: 38b3439d84f4 ("setlocalversion: update mercurial tag parsing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Crowe <mcrowe@zipitwireless.com>
---
Does anyone still use hg for kernel development?

 scripts/setlocalversion |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-54-rc1.orig/scripts/setlocalversion
+++ lnx-54-rc1/scripts/setlocalversion
@@ -93,7 +93,7 @@ scm_version()
 	# Check for mercurial and a mercurial repo.
 	if test -d .hg && hgid=`hg id 2>/dev/null`; then
 		# Do we have an tagged version?  If so, latesttagdistance == 1
-		if [ "`hg log -r . --template '{latesttagdistance}'`" == "1" ]; then
+		if [ "`hg log -r . --template '{latesttagdistance}'`" = "1" ]; then
 			id=`hg log -r . --template '{latesttag}'`
 			printf '%s%s' -hg "$id"
 		else

