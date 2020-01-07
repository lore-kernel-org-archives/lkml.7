Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A000FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702C32080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432187;
	bh=pyPPGbPS6/EVbtjWM4DRd9D9gio7DbqyD2xvnAM4syU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YvDfXTbp4hMYvKXQZGruh1peMHQv1CUmRHSOPDl479WHaZw5442w6/D/rd+/oJXuA
	 Zdta0JYUWyAA4hHIcTXmbROWzFrg2CQ2uxcBM/CtHScERU6KNCKPgPscuYKI7QRwfu
	 eV1qf8DWM9wmDJGhsYlS3A35VSgNDywpZHeF22J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAGVXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgAGVBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:01:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B41CD20678;
        Tue,  7 Jan 2020 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430894;
        bh=pyPPGbPS6/EVbtjWM4DRd9D9gio7DbqyD2xvnAM4syU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0I4+JKrgn74KkaF2vc6tmQ6LH6hCuik3iHw4WJLN0w+n6Q7+xzdJyFHMhGL4gWdx
         0JcwGtgnwc83Rvp9N+TsOhN9BSbwArtB7kqVr914cCeqNjKACmS04C2cp5HXep+5cQ
         u968fWH3EdvKABhFPaQYVbxpa5zvUafIn/JPEcgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 5.4 141/191] kernel/module.c: wakeup processes in module_wq on module unload
Date:   Tue,  7 Jan 2020 21:54:21 +0100
Message-Id: <20200107205340.524070101@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khorenko <khorenko@virtuozzo.com>

commit 5d603311615f612320bb77bd2a82553ef1ced5b7 upstream.

Fix the race between load and unload a kernel module.

sys_delete_module()
 try_stop_module()
  mod->state = _GOING
					add_unformed_module()
					 old = find_module_all()
					 (old->state == _GOING =>
					  wait_event_interruptible())

					 During pre-condition
					 finished_loading() rets 0
					 schedule()
					 (never gets waken up later)
 free_module()
  mod->state = _UNFORMED
   list_del_rcu(&mod->list)
   (dels mod from "modules" list)

return

The race above leads to modprobe hanging forever on loading
a module.

Error paths on loading module call wake_up_all(&module_wq) after
freeing module, so let's do the same on straight module unload.

Fixes: 6e6de3dee51a ("kernel/module.c: Only return -EEXIST for modules that have finished loading")
Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/module.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1033,6 +1033,8 @@ SYSCALL_DEFINE2(delete_module, const cha
 	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
 
 	free_module(mod);
+	/* someone could wait for the module in add_unformed_module() */
+	wake_up_all(&module_wq);
 	return 0;
 out:
 	mutex_unlock(&module_mutex);


