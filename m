Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DADAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27361213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCVFYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:24:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45634 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726909AbfCVFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-000165-Tt; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001pB-OR; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.334881140@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 13/16] KVM: use after free in kvm_ioctl_create_device()
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit a0f1d21c1ccb1da66629627a74059dd7f5ac9c61 upstream.

We should move the ops->destroy(dev) after the list_del(&dev->vm_node)
so that we don't use "dev" after freeing it.

Fixes: a28ebea2adc4 ("KVM: Protect device ops->create and list_add with kvm->lock")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2342,10 +2342,10 @@ static int kvm_ioctl_create_device(struc
 
 	ret = anon_inode_getfd(ops->name, &kvm_device_fops, dev, O_RDWR | O_CLOEXEC);
 	if (ret < 0) {
-		ops->destroy(dev);
 		mutex_lock(&kvm->lock);
 		list_del(&dev->vm_node);
 		mutex_unlock(&kvm->lock);
+		ops->destroy(dev);
 		return ret;
 	}
 

