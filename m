Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A730C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FD922C97
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033240;
	bh=3m0kIVAo0a4Cwf2ZyU0jA3cau05f5QZwp+Wg8fOZyDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QQCgnOkX7ulwWrkZCYrkCuj6ZGSHapuWXtE9Dy7sQkoTG1Pi2/yKbuBt8zHUqA02h
	 A0JrVcbpey7JXdgVpxiZRyrKuQ9egRvSJK7d7AnLXtL3CADVMpe7+WkUiYKyOhIEhO
	 fnr8Ro/V+o4JgF2SrC1LmjC/B2j+RbBUwENBokwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404440AbfGYFki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404427AbfGYFkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:40:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030AA22BEB;
        Thu, 25 Jul 2019 05:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033235;
        bh=3m0kIVAo0a4Cwf2ZyU0jA3cau05f5QZwp+Wg8fOZyDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVGJDd+/9ujyaeURGzi6AVX/hdvhlHFfSNQ2VNSO1Wq+/0CwOnEWclQ3bw7v2gszy
         GjYnkLUXfzKCvdlLSGmcxZLsAtTfDK++4bK5Dpq2tJs0dZI5nW7juqu6El6PTqrk2t
         d/e9eHomDe/igUJ9JLikQD8AQIqqHgeRf8KEhJ24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/271] rxrpc: Fix oops in tracepoint
Date:   Wed, 24 Jul 2019 21:20:09 +0200
Message-Id: <20190724191707.195644223@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 99f0eae653b2db64917d0b58099eb51e300b311d ]

If the rxrpc_eproto tracepoint is enabled, an oops will be cause by the
trace line that rxrpc_extract_header() tries to emit when a protocol error
occurs (typically because the packet is short) because the call argument is
NULL.

Fix this by using ?: to assume 0 as the debug_id if call is NULL.

This can then be induced by:

	echo -e '\0\0\0\0\0\0\0\0' | ncat -4u --send-only <addr> 20001

where addr has the following program running on it:

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <unistd.h>
	#include <sys/socket.h>
	#include <arpa/inet.h>
	#include <linux/rxrpc.h>
	int main(void)
	{
		struct sockaddr_rxrpc srx;
		int fd;
		memset(&srx, 0, sizeof(srx));
		srx.srx_family			= AF_RXRPC;
		srx.srx_service			= 0;
		srx.transport_type		= AF_INET;
		srx.transport_len		= sizeof(srx.transport.sin);
		srx.transport.sin.sin_family	= AF_INET;
		srx.transport.sin.sin_port	= htons(0x4e21);
		fd = socket(AF_RXRPC, SOCK_DGRAM, AF_INET6);
		bind(fd, (struct sockaddr *)&srx, sizeof(srx));
		sleep(20);
		return 0;
	}

It results in the following oops.

	BUG: kernel NULL pointer dereference, address: 0000000000000340
	#PF: supervisor read access in kernel mode
	#PF: error_code(0x0000) - not-present page
	...
	RIP: 0010:trace_event_raw_event_rxrpc_rx_eproto+0x47/0xac
	...
	Call Trace:
	 <IRQ>
	 rxrpc_extract_header+0x86/0x171
	 ? rcu_read_lock_sched_held+0x5d/0x63
	 ? rxrpc_new_skb+0xd4/0x109
	 rxrpc_input_packet+0xef/0x14fc
	 ? rxrpc_input_data+0x986/0x986
	 udp_queue_rcv_one_skb+0xbf/0x3d0
	 udp_unicast_rcv_skb.isra.8+0x64/0x71
	 ip_protocol_deliver_rcu+0xe4/0x1b4
	 ip_local_deliver+0xf0/0x154
	 __netif_receive_skb_one_core+0x50/0x6c
	 netif_receive_skb_internal+0x26b/0x2e9
	 napi_gro_receive+0xf8/0x1da
	 rtl8169_poll+0x303/0x4c4
	 net_rx_action+0x10e/0x333
	 __do_softirq+0x1a5/0x38f
	 irq_exit+0x54/0xc4
	 do_IRQ+0xda/0xf8
	 common_interrupt+0xf/0xf
	 </IRQ>
	 ...
	 ? cpuidle_enter_state+0x23c/0x34d
	 cpuidle_enter+0x2a/0x36
	 do_idle+0x163/0x1ea
	 cpu_startup_entry+0x1d/0x1f
	 start_secondary+0x157/0x172
	 secondary_startup_64+0xa4/0xb0

Fixes: a25e21f0bcd2 ("rxrpc, afs: Use debug_ids rather than pointers in traces")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 6d182746afab..147546e0c11b 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1381,7 +1381,7 @@ TRACE_EVENT(rxrpc_rx_eproto,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call->debug_id;
+		    __entry->call = call ? call->debug_id : 0;
 		    __entry->serial = serial;
 		    __entry->why = why;
 			   ),
-- 
2.20.1



