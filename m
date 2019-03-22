Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5E6218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfCVOTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:19:14 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbfCVOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:19:14 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHG4c-1hBiji3hVQ-00DHSO; Fri, 22 Mar 2019 15:18:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc: avoid clang -Wuninitialized warning
Date:   Fri, 22 Mar 2019 15:18:43 +0100
Message-Id: <20190322141848.659387-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TZm7rVj2j+bbMs9vH9SaW+4juFRIu0geiZSgLKt1E6Ol8L9GsR0
 QODIlSgsI+mR8neza+DikcX0Q5FTXQIlW6c/WkMa06/PJ+U0McvNlLwXTimWzYh89Aq0EHR
 FBlGseNHtOIekDVYhGUScRFegfkIMgcSvsFanQsrz9HiMbiuBXinw0F2Nb+pYH8pyDDosSp
 9mcdV8jBQ3tcQBhSA73DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ijt0N/z4PRk=:KkW9g1FXHbkjrAvfG+QEuu
 rMMDwFXoK2jklbzXZaRGEZzQEwYUFVCvffXBQdMCWITGdVhxdLnKjrALKUwG/dhJJn5trVQjq
 LHuoIaeVNO/+mnif5ON+Tw0BkgNoMGNgaZhfQIUVxEpHEMSeZmNfUasQQfVB1q5CadUpvvlCC
 QBaBJWxTquWvO0KFMQUDSCj4YqqL2pQQNhCUcYveGX3FkB4S4bMErPYNFspfP1hZmK1H04zDc
 cqWIerVos4o1XupTRZ2obmtozCbZorXnQcpppCx34pGLoxyXEQ8q6u4G+phl29D7TkHH0luK+
 SYkxYr6tAE1eJf526X4q4W+T+WnE/mBO6AK6brPhGAjTKk1mrOoL6ao/aUt7WshecsN1PeUW7
 ThHKQykEv/Gsq7wRF3xbqz3jp0jOeO+slg3WqbVaP1dPp0JACc8Jwnt/ZVqRRjywc8NevQqUK
 lMYF2UKOgt3LtXO/amFX4ZxQ7HYIGxfHT6rqdeApxPB2iBUQVlI5q+86I2Xz4MASwuqtGL1QO
 Im6y/REskZgdlDqHjGOyPnd/fo8ljA1J/CCVUJrJ780I3L+9gy6zBCym2SPmoicboO3TdPoPi
 Cz1tds6XIInK8hWtFBntIoBuj6pyMbxALh3FQFQAWwEWLX8ziP/HkrxJES3zON4eHzTYDimJA
 JiQc1wrHitYM0sCUVkFBX8qzRKoMkqZjEpfZ3ZYDFArRlHDeYsX/Z/Fcmm35WRrD8voBiVx8E
 XldoraWyNx/7F0VnerpzSE7BI1MLQu0X+lz5Jg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang produces a false-positive warning as it fails to notice
that "lost = true" implies that "ret" is initialized:

net/rxrpc/output.c:402:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (lost)
            ^~~~
net/rxrpc/output.c:437:6: note: uninitialized use occurs here
        if (ret >= 0) {
            ^~~
net/rxrpc/output.c:402:2: note: remove the 'if' if its condition is always false
        if (lost)
        ^~~~~~~~~
net/rxrpc/output.c:339:9: note: initialize the variable 'ret' to silence this warning
        int ret, opt;
               ^
                = 0

Rearrange the code to make that more obvious and avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/rxrpc/output.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 736aa9281100..004c762c2e8d 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -335,7 +335,6 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	struct kvec iov[2];
 	rxrpc_serial_t serial;
 	size_t len;
-	bool lost = false;
 	int ret, opt;
 
 	_enter(",{%d}", skb->len);
@@ -393,14 +392,14 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 		static int lose;
 		if ((lose++ & 7) == 7) {
 			ret = 0;
-			lost = true;
+			trace_rxrpc_tx_data(call, sp->hdr.seq, serial,
+					    whdr.flags, retrans, true);
+			goto done;
 		}
 	}
 
-	trace_rxrpc_tx_data(call, sp->hdr.seq, serial, whdr.flags,
-			    retrans, lost);
-	if (lost)
-		goto done;
+	trace_rxrpc_tx_data(call, sp->hdr.seq, serial, whdr.flags, retrans,
+			    false);
 
 	/* send the packet with the don't fragment bit set if we currently
 	 * think it's small enough */
-- 
2.20.0

