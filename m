Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDDBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1CA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582213;
	bh=UcyVKUup6zLBaDatE9NsBWSlI8KbNbHcWneqUhIMxZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=baNr6ei1TYHjots5opB/m8azyzwSS3Vj4dfgFL2KWA+4XMWwm3n79cTVX4ShnMU5x
	 odAj1IcwKjUZHZ6cBXYeGzYq/FWECXYWkGh//j5xqasaVrVSiDhHTzr58tBqu8/sE6
	 pcB1yp2VClJrg+Sny6dBqD5aOEpA29fMcQA7ZTUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfCZGgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732264AbfCZGgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:48 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395092070B;
        Tue, 26 Mar 2019 06:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582207;
        bh=UcyVKUup6zLBaDatE9NsBWSlI8KbNbHcWneqUhIMxZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R7AvcghnxRJ+CUMUNC+XBkzgIA92E2641jGheiWyIP88MkhSegV9Lvbw2cY5E4n7I
         ZMKIW/V+szM/8fgVN9am8K5/uaSYDGdp0UnxTR+lzlqj5m3+1BtgL1z1J3vqpQlv8U
         hTy5InZb6kkUPebCCGCpz4J85U4CI2S+yePDE+D0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeremy Cline <jcline@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.19 33/45] Bluetooth: hci_ldisc: Postpone HCI_UART_PROTO_READY bit set in hci_uart_set_proto()
Date:   Tue, 26 Mar 2019 15:30:16 +0900
Message-Id: <20190326042704.404278904@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 


