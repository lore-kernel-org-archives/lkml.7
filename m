Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C52EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F398218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610837;
	bh=3IvzrkcnaIhMFPW0+8pwK74d7EmvxBEM4YgOYV0mEFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RjzowejkYmUqAwUWypg412/F3NuP4qGIyd+Mi/4POcOJ+J7woUiMkJx+Xg4gmIdJA
	 eIL5EtOddQZoKxIBdJgJRqEIPFWUAzyNfcrwfkVmNTahGqXMjiXsbn5llvvxmhYz2N
	 XI1IIcKcxivST3DoW/OsqB35cfVCur7howwueeqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbfDRSHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391599AbfDRSHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F6B218FF;
        Thu, 18 Apr 2019 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610831;
        bh=3IvzrkcnaIhMFPW0+8pwK74d7EmvxBEM4YgOYV0mEFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L256HAKvBBt1W1dWjEqLa0wZthtu20ecK+0JDI2TPQKJ7Nno5AkoGFWDKdX+p3Jm4
         z7CuMhKlrXdaPmv0HUhd9rMWFWRFzoLitAYu40UqbtyR5Ok6LgnM6i0yci1/7lSUJo
         dCvo3Msp+N/NN3BhOVRqpQA63i4Y0rw64kJQCLIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pi-Hsun Shih <pihsun@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 70/92] include/linux/swap.h: use offsetof() instead of custom __swapoffset macro
Date:   Thu, 18 Apr 2019 19:57:28 +0200
Message-Id: <20190418160436.318760726@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a4046c06be50a4f01d435aa7fe57514818e6cc82 ]

Use offsetof() to calculate offset of a field to take advantage of
compiler built-in version when possible, and avoid UBSAN warning when
compiling with Clang:

  UBSAN: Undefined behaviour in mm/swapfile.c:3010:38
  member access within null pointer of type 'union swap_header'
  CPU: 6 PID: 1833 Comm: swapon Tainted: G S                4.19.23 #43
  Call trace:
   dump_backtrace+0x0/0x194
   show_stack+0x20/0x2c
   __dump_stack+0x20/0x28
   dump_stack+0x70/0x94
   ubsan_epilogue+0x14/0x44
   ubsan_type_mismatch_common+0xf4/0xfc
   __ubsan_handle_type_mismatch_v1+0x34/0x54
   __se_sys_swapon+0x654/0x1084
   __arm64_sys_swapon+0x1c/0x24
   el0_svc_common+0xa8/0x150
   el0_svc_compat_handler+0x2c/0x38
   el0_svc_compat+0x8/0x18

Link: http://lkml.kernel.org/r/20190312081902.223764-1-pihsun@chromium.org
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/swap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4fd1ab9565ba..e643866912b7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -155,9 +155,9 @@ struct swap_extent {
 /*
  * Max bad pages in the new format..
  */
-#define __swapoffset(x) ((unsigned long)&((union swap_header *)0)->x)
 #define MAX_SWAP_BADPAGES \
-	((__swapoffset(magic.magic) - __swapoffset(info.badpages)) / sizeof(int))
+	((offsetof(union swap_header, magic.magic) - \
+	  offsetof(union swap_header, info.badpages)) / sizeof(int))
 
 enum {
 	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
-- 
2.19.1



