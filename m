Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C78C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A392086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582449;
	bh=9dh/LpIQImkGOiSSPA334Ug45jDG30yR00DuGiqymKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=op3V4giNz2PtsKE0YCApVDeZSY6lb/4nKAMHXnu60r8+6lLSkFb2iVMACQJ5Zl8d0
	 nHPcp6RHKx3z/RFZDKl4vwPvCp3abIwEIWAmlmJf5aaInIcSvKZkZf3iOri1idj9gz
	 u9KcYyAZSpntizUZ2DxvLx2xcluWKdco9YjTjSAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbfCZGkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfCZGkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:41 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D9B2070B;
        Tue, 26 Mar 2019 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582440;
        bh=9dh/LpIQImkGOiSSPA334Ug45jDG30yR00DuGiqymKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jw5+GriAl02oseEKCCeahGETSgUR3jhrQeBCFSWgMDj9pI4J/TTp6/yPIqn49fQYV
         w6t3OlOPnSKnf2GAReCRd7KI5KqZ9GXB3I3WAeBPEnaVCU4xEaEalAaeSlCD2YWH99
         5LdA16VEEO/rhZrILbl71rgdb6wXsrkChgLMFU1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeremy Cline <jcline@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.0 40/52] Bluetooth: hci_ldisc: Postpone HCI_UART_PROTO_READY bit set in hci_uart_set_proto()
Date:   Tue, 26 Mar 2019 15:30:27 +0900
Message-Id: <20190326042703.109244206@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kefeng Wang <wangkefeng.wang@huawei.com>

commit 56897b217a1d0a91c9920cb418d6b3fe922f590a upstream.

task A:                                task B:
hci_uart_set_proto                     flush_to_ldisc
 - p->open(hu) -> h5_open  //alloc h5  - receive_buf
 - set_bit HCI_UART_PROTO_READY         - tty_port_default_receive_buf
 - hci_uart_register_dev                 - tty_ldisc_receive_buf
                                          - hci_uart_tty_receive
				           - test_bit HCI_UART_PROTO_READY
				            - h5_recv
 - clear_bit HCI_UART_PROTO_READY             while() {
 - p->open(hu) -> h5_close //free h5
				              - h5_rx_3wire_hdr
				               - h5_reset()  //use-after-free
                                              }

It could use ioctl to set hci uart proto, but there is
a use-after-free issue when hci_uart_register_dev() fail in
hci_uart_set_proto(), see stack above, fix this by setting
HCI_UART_PROTO_READY bit only when hci_uart_register_dev()
return success.

Reported-by: syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_ldisc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -696,14 +696,13 @@ static int hci_uart_set_proto(struct hci
 		return -EPROTONOSUPPORT;
 
 	hu->proto = p;
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
-		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		return err;
 	}
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	return 0;
 }
 


