Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA530C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7052173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="H+HISbVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394861AbfHWMvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:51:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38711 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388720AbfHWMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:51:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so13324017edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=cxGB3E3Dpp1yDP4jAkeEWM2QENDtyV5kXzP97Ck1UME=;
        b=H+HISbVXO5Ou2+ULlynRYFvCVacwi2wTGQNmdqqSg6GhjE3K6x2NU05g+ANqkaS2Tg
         v/Y/wWLvYdzSigN1Dx+2+6J/0c3kGjgxcL0hU65MmQj1Nl7cqvupAhZthRfyWWb/aiYt
         OeYjMOU2x/pYq0Gf/iBlrpnfSP9+XlYEqhqFQCu2g3BOuG0WXy7kBf3SnIDW0/mRc/87
         +PZXRxI9bf8O0SVZ5XChRzyMtDdvliTnIxEkp3jFieYLLePpSN/WlwxOv02P3lF8LwoO
         i9jmnLgP9UuO9ijtGUVdoUrvgXiAJE/UeCNvQp8gaCgqzUtwuCJHXqHXnL8kq0mSjtIu
         49kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=cxGB3E3Dpp1yDP4jAkeEWM2QENDtyV5kXzP97Ck1UME=;
        b=iE+oCUSeoc1kHYfkFkOgoRQ1puer2xOoya8U5tCqeD7I1cWnhzuid6D0oKOqh5N2b1
         046/e9RU7EE6XM86hASf+iUaage074nnAJtSRqlVQhefxrYQYwvDxKOxAvU3s1CIqRzK
         qLCgW72/G9DRBmN+mpG9E0K1XrlcxIjz69bs+uwgm5pXQjn7yqL2iURW46zV8DMNFz6G
         tOyktvv1cXGqVr/bDsbrwfvsgair+y4rqo6V3F04IpjPaJLM+wIi0ku6pvQ1I2Ehr5cW
         zkCgIJnfjCHFuGUIpmqUqd96hEwmaxZRRdsXtnvji/juScwinAFAf6ZZAkEhloP7aXFv
         i3zw==
X-Gm-Message-State: APjAAAW0c3z+NauQUTkpw8m5IX20KQ2FaX3G4iPnxaOidEyfzi4Nq3zW
        mrg1irMR7WaC2YYiB94TPc56uE0qrbBaKNTWVrgEiMOfbBeWCUzEmPV6se0BI3h5nGdIuZayEY1
        42jx3+g+/wnDG2kG2IA==
X-Google-Smtp-Source: APXvYqx7Il3cbcuBGS0G4Gf/ngHSYZN6BaS1ImaXZTzj2fEr2FKhpsLrihFvWPoO9NeVA7yAmcfrSg==
X-Received: by 2002:a17:906:191b:: with SMTP id a27mr4104873eje.84.1566564673555;
        Fri, 23 Aug 2019 05:51:13 -0700 (PDT)
Received: from localhost.localdomain (hag0-main.tessares.net. [87.98.252.165])
        by smtp.gmail.com with ESMTPSA id l9sm509233eds.96.2019.08.23.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 05:51:12 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     matthieu.baerts@tessares.net
Cc:     aprout@ll.mit.edu, cpaasch@apple.com, davem@davemloft.net,
        edumazet@google.com, gregkh@linuxfoundation.org,
        jonathan.lemon@gmail.com, jtl@netflix.com,
        linux-kernel@vger.kernel.org, mkubecek@suse.cz,
        ncardwell@google.com, sashal@kernel.org, stable@vger.kernel.org,
        tim.froidcoeur@tessares.net, ycheng@google.com
Subject: [PATCH] tcp: fix tcp_rtx_queue_tail in case of empty retransmit queue
Date:   Fri, 23 Aug 2019 14:50:54 +0200
Message-Id: <20190823125054.30070-1-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <529376a4-cf63-f225-ce7c-4747e9966938@tessares.net>
References: <529376a4-cf63-f225-ce7c-4747e9966938@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c3088f895a0 ("tcp: be more careful in tcp_fragment()")
triggers following stack trace:

[25244.848046] kernel BUG at ./include/linux/skbuff.h:1406!
[25244.859335] RIP: 0010:skb_queue_prev+0x9/0xc
[25244.888167] Call Trace:
[25244.889182]  <IRQ>
[25244.890001]  tcp_fragment+0x9c/0x2cf
[25244.891295]  tcp_write_xmit+0x68f/0x988
[25244.892732]  __tcp_push_pending_frames+0x3b/0xa0
[25244.894347]  tcp_data_snd_check+0x2a/0xc8
[25244.895775]  tcp_rcv_established+0x2a8/0x30d
[25244.897282]  tcp_v4_do_rcv+0xb2/0x158
[25244.898666]  tcp_v4_rcv+0x692/0x956
[25244.899959]  ip_local_deliver_finish+0xeb/0x169
[25244.901547]  __netif_receive_skb_core+0x51c/0x582
[25244.903193]  ? inet_gro_receive+0x239/0x247
[25244.904756]  netif_receive_skb_internal+0xab/0xc6
[25244.906395]  napi_gro_receive+0x8a/0xc0
[25244.907760]  receive_buf+0x9a1/0x9cd
[25244.909160]  ? load_balance+0x17a/0x7b7
[25244.910536]  ? vring_unmap_one+0x18/0x61
[25244.911932]  ? detach_buf+0x60/0xfa
[25244.913234]  virtnet_poll+0x128/0x1e1
[25244.914607]  net_rx_action+0x12a/0x2b1
[25244.915953]  __do_softirq+0x11c/0x26b
[25244.917269]  ? handle_irq_event+0x44/0x56
[25244.918695]  irq_exit+0x61/0xa0
[25244.919947]  do_IRQ+0x9d/0xbb
[25244.921065]  common_interrupt+0x85/0x85
[25244.922479]  </IRQ>

tcp_rtx_queue_tail() (called by tcp_fragment()) can call
tcp_write_queue_prev() on the first packet in the queue, which will trigger
the BUG in tcp_write_queue_prev(), because there is no previous packet.

This happens when the retransmit queue is empty, for example in case of a
zero window.

Patch is needed for 4.4, 4.9 and 4.14 stable branches.

Fixes: 8c3088f895a0 ("tcp: be more careful in tcp_fragment()")
Signed-off-by: Tim Froidcoeur <tim.froidcoeur@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/net/tcp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9de2c8cdcc51..1e70ca75c8bf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1705,6 +1705,10 @@ static inline struct sk_buff *tcp_rtx_queue_tail(const struct sock *sk)
 {
 	struct sk_buff *skb = tcp_send_head(sk);
 
+	/* empty retransmit queue, for example due to zero window */
+	if (skb == tcp_write_queue_head(sk))
+		return NULL;
+
 	return skb ? tcp_write_queue_prev(sk, skb) : tcp_write_queue_tail(sk);
 }
 
-- 
2.23.0


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


