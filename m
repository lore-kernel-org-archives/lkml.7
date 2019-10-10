Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A449C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEABC2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696947;
	bh=wD994kTRdn4+4NVQk6oHG8B0XzrmSLQfF/qLv50TiRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0bSzsq4GVQ0Bi7dopMXqxB7ZxQgOs0OjYj9HJ13TJ4zzE7xLJ4wZK9HW+6KvLDAQO
	 vkYKLzZxo/5hQA4b7cEyf5v1LiMsYj6rsnx5+9tkhSUbcJp3I7fgBN3yFnmgCrDqIf
	 /qN1ggs8jJvzIXinzPd2salo4It3L9fJP5KA4jig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbfJJImZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388540AbfJJImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:42:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9150F2054F;
        Thu, 10 Oct 2019 08:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696942;
        bh=wD994kTRdn4+4NVQk6oHG8B0XzrmSLQfF/qLv50TiRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6X7MUIu4TqJ7L1ZRt3A6iLXdbQNXy4Iu2golCDBEU8TP4zyD1GSM5a93nWekGmOD
         UHIQbgy36qr8UoxhwXsNXuueeCbd8we8nkuZ4ioo8ADhjkIbIEDUe57B7udoHHFzds
         NdFt4lsqfVt7yB8cB3lx1xrePaFH5OmLVlCBoYU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 5.3 082/148] xen/balloon: Set pages PageOffline() in balloon_add_region()
Date:   Thu, 10 Oct 2019 10:35:43 +0200
Message-Id: <20191010083616.308363319@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

commit c5ad81eb029570c5ca5859539b0679f07a776d25 upstream.

We are missing a __SetPageOffline(), which is why we can get
!PageOffline() pages onto the balloon list, where
alloc_xenballooned_pages() will complain:

page:ffffea0003e7ffc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xffffe00001000(reserved)
raw: 000ffffe00001000 dead000000000100 dead000000000200 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(!PageOffline(page))
------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:744!
invalid opcode: 0000 [#1] SMP NOPTI

Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Fixes: 77c4adf6a6df ("xen/balloon: mark inflated pages PG_offline")
Cc: stable@vger.kernel.org # v5.1+
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/balloon.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -688,6 +688,7 @@ static void __init balloon_add_region(un
 		/* totalram_pages and totalhigh_pages do not
 		   include the boot-time balloon extension, so
 		   don't subtract from it. */
+		__SetPageOffline(page);
 		__balloon_append(page);
 	}
 


