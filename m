Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42329C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0898E2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639703;
	bh=Tug76pgDYIbZKlAuIYBUdQn50+xAQzKdh/iY3Kfv408=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tE50xBRDmzJq0rIRh9VjQ+EI5+XBLJuKGnnd+yhenTE1paY1cS5WrthoV4N36JyHx
	 s7N6fe6MAywP4FhGyLl3I7FKci5ALDajvlx9QLmV/fZkHpiVOP+hkQ3RG1PJVdrKAL
	 yu10GrhA90H3JXZzgWvEL99wGNI7V1T5uBgwL2Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391468AbfEWT2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391750AbfEWT2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:28:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885712133D;
        Thu, 23 May 2019 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639694;
        bh=Tug76pgDYIbZKlAuIYBUdQn50+xAQzKdh/iY3Kfv408=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvYlB/MVplMPIwHuKEf9QVWH/pd8sm1E3x4c5mkrXcMlpHAxxz83QYNktVoPjgxHW
         pUDTaTVlnq7gfp21+4o8LK+f6AKAuhtBd8YD+c2XNzU+gKOeqVL0MwdtY4gEWsNzHW
         FxsrbVEDcO69Urwa252W09Vi2lMFRBk49bmrEs8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phong Tran <tranmanphong@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.1 044/122] of: fix clang -Wunsequenced for be32_to_cpu()
Date:   Thu, 23 May 2019 21:06:06 +0200
Message-Id: <20190523181710.537484242@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>

commit 440868661f36071886ed360d91de83bd67c73b4f upstream.

Now, make the loop explicit to avoid clang warning.

./include/linux/of.h:238:37: warning: multiple unsequenced modifications
to 'cell' [-Wunsequenced]
                r = (r << 32) | be32_to_cpu(*(cell++));
                                                  ^~
./include/linux/byteorder/generic.h:95:21: note: expanded from macro
'be32_to_cpu'
                    ^
./include/uapi/linux/byteorder/little_endian.h:40:59: note: expanded
from macro '__be32_to_cpu'
                                                          ^
./include/uapi/linux/swab.h:118:21: note: expanded from macro '__swab32'
        ___constant_swab32(x) :                 \
                           ^
./include/uapi/linux/swab.h:18:12: note: expanded from macro
'___constant_swab32'
        (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
                  ^

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/460
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: stable@vger.kernel.org
[robh: fix up whitespace]
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/of.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -234,8 +234,8 @@ extern struct device_node *of_find_all_n
 static inline u64 of_read_number(const __be32 *cell, int size)
 {
 	u64 r = 0;
-	while (size--)
-		r = (r << 32) | be32_to_cpu(*(cell++));
+	for (; size--; cell++)
+		r = (r << 32) | be32_to_cpu(*cell);
 	return r;
 }
 


