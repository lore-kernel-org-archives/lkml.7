Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C73C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598A20870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495483;
	bh=RwIlGsY5UpAFUdjUsjZdVdMjzCqIzdQG2xcWQDnjdI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J87SxIDPo5IWZakk2yrySNPTBFCqy7szA/kYEunybttMTD4YdT6GOCIMq8xsF66pF
	 K0KJdDj+MBNsKLT5Y24rKvaPVpDelvQb3O4ljfgXRXpYkgXgSNLDFFKePZVWQEdEHg
	 VPOHLbMfaKDpuiz/RMrBSdkzwygN9FlsVEFh+VXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392973AbfHVRiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404235AbfHVRYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:33 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F067423407;
        Thu, 22 Aug 2019 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494673;
        bh=RwIlGsY5UpAFUdjUsjZdVdMjzCqIzdQG2xcWQDnjdI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8qwaF1pshMoaQqUumy8ucItXoQvSw3oq8y+a3a/ZCd9obHenBjpO/IoP0gtQ+4Aq
         pILcsgiDhD8JMft7Rym6VAWvx/zs0KdcvueMAaepUsJUN+2CiPqZAEZZwXnKwcurmV
         BeQ/g4uHNYPFtyekMJes65qr5PE+zDQxhy7u1ZLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+62a1e04fd3ec2abf099e@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Hillf Danton <hdanton@sina.com>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 16/71] HID: hiddev: do cleanup in failure of opening a device
Date:   Thu, 22 Aug 2019 10:18:51 -0700
Message-Id: <20190822171728.038996613@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

commit 6d4472d7bec39917b54e4e80245784ea5d60ce49 upstream.

Undo what we did for opening before releasing the memory slice.

Reported-by: syzbot <syzbot+62a1e04fd3ec2abf099e@syzkaller.appspotmail.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/usbhid/hiddev.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -321,6 +321,10 @@ bail_normal_power:
 	hid_hw_power(hid, PM_HINT_NORMAL);
 bail_unlock:
 	mutex_unlock(&hiddev->existancelock);
+
+	spin_lock_irq(&list->hiddev->list_lock);
+	list_del(&list->node);
+	spin_unlock_irq(&list->hiddev->list_lock);
 bail:
 	file->private_data = NULL;
 	vfree(list);


