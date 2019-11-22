Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A0BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B04020708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418908;
	bh=youHC11LHjAs4CWKcmpmT/pWr3+p84Nsi0dY0gcXfR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1G6nkZWw/4n7zyeAzWcOVjRqDtiob7N2HSsO6en79bJryLYDs5KklmS8OoW4g8ON
	 4sZD9IOLQlcWRr8/rK2/l98qSdikuszKcQN/s8ZVN+nW6T284o7FVOSmpnm36o+HoJ
	 NJ+GhC9xdfGIxmLi7Rq2TFp6Aj/QgGokK4aVoeos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfKVKfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbfKVKfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:35:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739E920656;
        Fri, 22 Nov 2019 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418903;
        bh=youHC11LHjAs4CWKcmpmT/pWr3+p84Nsi0dY0gcXfR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoU7WGjH17D45ooH8DLm04fTYQHUfddQ86bi7+wOFZNiyk7Jdaf0AQs/ZALwI3iqe
         JmbjtKXFx5+cJAgxmzDkZyxp3D2ziUn+ElTQ6FZZAXu1ZFqvmI54FnOuGC94kdIBhM
         G4k8zNQkpoM05vEZkhEUFVgdEDdTdqVxi9mv7SGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Justin Ernst <justin.ernst@hpe.com>,
        Borislav Petkov <bp@suse.de>,
        Russ Anderson <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 092/159] EDAC: Raise the maximum number of memory controllers
Date:   Fri, 22 Nov 2019 11:28:03 +0100
Message-Id: <20191122100813.313867059@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Ernst <justin.ernst@hpe.com>

[ Upstream commit 6b58859419554fb824e09cfdd73151a195473cbc ]

We observe an oops in the skx_edac module during boot:

  EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0
  EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
  EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
  ...
  EDAC MC13: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
  EDAC MC14: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
  EDAC MC15: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1
  Too many memory controllers: 16
  EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0

We observe there are two memory controllers per socket, with a limit
of 16. Raise the maximum number of memory controllers from 16 to 2 *
MAX_NUMNODES (1024).

[ bp: This is just a band-aid fix until we've sorted out the whole issue
  with the bus_type association and handling in EDAC and can get rid of
  this arbitrary limit. ]

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Russ Anderson <russ.anderson@hpe.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac@vger.kernel.org
Link: https://lkml.kernel.org/r/20180925143449.284634-1-justin.ernst@hpe.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/edac.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/edac.h b/include/linux/edac.h
index 4fe67b853de04..9bb4f3311e137 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -17,6 +17,7 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
+#include <linux/numa.h>
 
 struct device;
 
@@ -778,6 +779,6 @@ struct mem_ctl_info {
 /*
  * Maximum number of memory controllers in the coherent fabric.
  */
-#define EDAC_MAX_MCS	16
+#define EDAC_MAX_MCS	2 * MAX_NUMNODES
 
 #endif
-- 
2.20.1



