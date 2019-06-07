Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23553C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DD020840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922607;
	bh=DnNeCLQx4HO+1hlXeb/DClw5HFQxojEBibonIOcjEjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwF7Qps4JYG8P8Aljq3rNvbPYyqu4E6OAPIQfUVqU11hNAb0JQemjm48tbHLFOs6P
	 VFU4HnNnDdCyxMdBpGT5RTudiotAZ5FMToBNtXz9q2Lc7Rf/pxKpLzj+nGFuwrlfSQ
	 hsHTQYPgZUV08qQ8qxLVEfMI4wKiKMEhVE74oG/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfFGPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbfFGPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:50:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738CF2146E;
        Fri,  7 Jun 2019 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922604;
        bh=DnNeCLQx4HO+1hlXeb/DClw5HFQxojEBibonIOcjEjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVGlYuOC572qdy/ZQ33jufeubRMIAO4HYFzy2fZcqqk9lR4k21LwN+bJl06M99QQW
         6YDo9uED81jb3JU4hzw0mbMBY6j7T1T87w0QnUFsxCusBJMvxvPasQaxwCbrHZwHkO
         IQ4vNVpV5VVMXKa0q3iyXv6KpToJGSli1gl+x2VI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>
Subject: [PATCH 5.1 73/85] drm/vmwgfx: Fix compat mode shader operation
Date:   Fri,  7 Jun 2019 17:39:58 +0200
Message-Id: <20190607153857.196916937@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

commit e41c20cf50a8a7d0dfa337a7530590aacef4193b upstream.

In compat mode, we allowed host-backed user-space with guest-backed
kernel / device. In this mode, set shader commands was broken since
no relocations were emitted. Fix this.

Cc: <stable@vger.kernel.org>
Fixes: e8c66efbfe3a ("drm/vmwgfx: Make user resource lookups reference-free during validation")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2129,6 +2129,11 @@ static int vmw_cmd_set_shader(struct vmw
 		return 0;
 
 	if (cmd->body.shid != SVGA3D_INVALID_ID) {
+		/*
+		 * This is the compat shader path - Per device guest-backed
+		 * shaders, but user-space thinks it's per context host-
+		 * backed shaders.
+		 */
 		res = vmw_shader_lookup(vmw_context_res_man(ctx),
 					cmd->body.shid,
 					cmd->body.type);
@@ -2137,6 +2142,14 @@ static int vmw_cmd_set_shader(struct vmw
 			ret = vmw_execbuf_res_noctx_val_add(sw_context, res);
 			if (unlikely(ret != 0))
 				return ret;
+
+			ret = vmw_resource_relocation_add
+				(sw_context, res,
+				 vmw_ptr_diff(sw_context->buf_start,
+					      &cmd->body.shid),
+				 vmw_res_rel_normal);
+			if (unlikely(ret != 0))
+				return ret;
 		}
 	}
 


