Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD50EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E1520645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355473;
	bh=OEMSFr3H+6JQcGa5ItokfuXRFJqlplNirzzud/kCOMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FC/vIfkI5+G7SFog5C7xtVpIXB+oii2nYO1BkOkBHhzMZTY/ngHcolzl7dwIkBWd1
	 fO7MQ9JjmBfJeEHDb/EZdOIaMg1cVrzJpxhafDdZhUroIGH6ysZdtvmdAQbSE2Ry+i
	 HoTBFAY5c63UFvbNVhAHCHPvunYtSKVTBC1dvQEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbfETMbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389607AbfETMbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:31:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F7E20675;
        Mon, 20 May 2019 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355469;
        bh=OEMSFr3H+6JQcGa5ItokfuXRFJqlplNirzzud/kCOMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfxUl7zB6MDtan+lB5oc267NLHjZNKz/9MOTDxkNpYhImcwI6oV1QbwaY2hqRVVCy
         Y1I/OrtkasDnEnEOlAblTyKgQicKREJwGYaCpEhl3dtYB3mdAsW4KRYnxqdGefsXou
         JGEH9CmoEtIduKD8ZDg2y/TFia3fF9OErddF7dQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 110/123] KVM: Fix the bitmap range to copy during clear dirty
Date:   Mon, 20 May 2019 14:14:50 +0200
Message-Id: <20190520115252.409038239@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

commit 4ddc9204572c33f2eb91fbdb1d99d8078388b67d upstream.

kvm_dirty_bitmap_bytes() will return the size of the dirty bitmap of
the memslot rather than the size of bitmap passed over from the ioctl.
Here for KVM_CLEAR_DIRTY_LOG we should only copy exactly the size of
bitmap that covers kvm_clear_dirty_log.num_pages.

Signed-off-by: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 2a31b9db153530df4aa02dac8c32837bf5f47019
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/kvm_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1251,7 +1251,7 @@ int kvm_clear_dirty_log_protect(struct k
 	if (!dirty_bitmap)
 		return -ENOENT;
 
-	n = kvm_dirty_bitmap_bytes(memslot);
+	n = ALIGN(log->num_pages, BITS_PER_LONG) / 8;
 
 	if (log->first_page > memslot->npages ||
 	    log->num_pages > memslot->npages - log->first_page)


