Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09D3C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1A921911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfGVO6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:58:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGVO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:58:45 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M72Xn-1hmYIL10oB-008bY6; Mon, 22 Jul 2019 16:58:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH net-next] rxrpc: shut up -Wframe-larger-than= warnings
Date:   Mon, 22 Jul 2019 16:58:12 +0200
Message-Id: <20190722145828.1156135-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lfUDGrLpfiXr0926+j2P2OlmuIJ9NeSW7hz8xpL9W9/lJWhLyxr
 nvy0gDbgeppmwx5SNKpsWc+kRWqKjri7P6sr1ev6Ni6JpuD6b9lOpGqjq9c/mOazV/kZO89
 BhM/bodFV621uaH+Om47Oer2s95AQ9aOLPAg0UMDON68IcCMVTiV5llJknLtQnVDEQeonSM
 Bne5lVBalJEvcLsf+iUrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FSBaxuTAGN0=:DC1HwUKvN32xA+BmgiSi7p
 5BlOr7hXovf7a2nSPKJT9fKI5oL3ewkotHvT7gChJ58N3ObJta+RX2z95PAIKvWuk7rnMGsfv
 cCC5dupWpKlz2umtRlihopD5G69vxMzetqMDiZCvHq3kBhQNS+CLBqKtsCXTKR7/xkA5g2V2F
 sJkqK8fwkMUGbflM593akcchF3u3g8FFRGvFxcoBmSH9uVlV3P8vtSezwQXtZwKmXsh2bpl+B
 DhPEkEp+2Jye5oLjpcUDWpARuAbNbTI05mMFS+MKlYffblU0nOEYCgnywnccztSdw1MlSy2o4
 P/VHWgYnRuNAkRyWUp4UYrBlEfvotJd4jrQpoCWebMCvOXEOu/7veqN4SdMc5VMllvJwBC/R8
 d+JrNMSHEVbp6bYuZmmwXLVwl+PRXk3nxqRwgYLfyWHxEFJr+iOY1qaANkZ348iljRePrR1+F
 5mRdXtq/oGsDbALMLO8EITVqnD5HaGfPnSMxlP4XfUxjmOMW3Eu9e9WBXebZT8OsfB7o4wu1Q
 06+w6tVTGHhapGjBtibEN/LsZ5uz9UkR5X7oMNSfoD1RsrKPThoDR52oQYf6pCNYwfsqhMFXq
 +8tAm1nyxr+xYaDzaDuSKYLL+8oY+KT/EbYd2ymalbQbVWKrp8YlSQgaeAwVBiD9Yn/1JlDYf
 gliInbSQrx/vFOIz80D0jUg2N4k4D/zzJkm+km1/nqoV3eM+eNUib1KVsxXmzUKgpJG//rndn
 T+Irze9420UQg0b97RVKHAZ1dKwPJuYld3rpxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxkad sometimes triggers a warning about oversized stack frames
when building with clang for a 32-bit architecture:

net/rxrpc/rxkad.c:243:12: error: stack frame size of 1088 bytes in function 'rxkad_secure_packet' [-Werror,-Wframe-larger-than=]
net/rxrpc/rxkad.c:501:12: error: stack frame size of 1088 bytes in function 'rxkad_verify_packet' [-Werror,-Wframe-larger-than=]

The problem is the combination of SYNC_SKCIPHER_REQUEST_ON_STACK()
in rxkad_verify_packet()/rxkad_secure_packet() with the relatively
large scatterlist in rxkad_verify_packet_1()/rxkad_secure_packet_encrypt().

The warning does not show up when using gcc, which does not inline
the functions as aggressively, but the problem is still the same.

Marking the inner functions as 'noinline_for_stack' makes clang
behave the same way as gcc and avoids the warning.
This may not be ideal as it leaves the underlying problem
unchanged. If we want to actually reduce the stack usage here,
the skcipher_request and scatterlist objects need to be moved
off the stack.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/rxrpc/rxkad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index ae8cd8926456..788e40a1679c 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -139,7 +139,7 @@ static int rxkad_prime_packet_security(struct rxrpc_connection *conn)
 /*
  * partially encrypt a packet (level 1 security)
  */
-static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
+static noinline_for_stack int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 				    struct sk_buff *skb,
 				    u32 data_size,
 				    void *sechdr,
@@ -176,7 +176,7 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 /*
  * wholly encrypt a packet (level 2 security)
  */
-static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
+static noinline_for_stack int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 				       struct sk_buff *skb,
 				       u32 data_size,
 				       void *sechdr,
@@ -311,7 +311,7 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
 /*
  * decrypt partial encryption on a packet (level 1 security)
  */
-static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
+static noinline_for_stack int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
 				 unsigned int offset, unsigned int len,
 				 rxrpc_seq_t seq,
 				 struct skcipher_request *req)
@@ -397,7 +397,7 @@ static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
 /*
  * wholly decrypt a packet (level 2 security)
  */
-static int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
+static noinline_for_stack int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
 				 unsigned int offset, unsigned int len,
 				 rxrpc_seq_t seq,
 				 struct skcipher_request *req)
-- 
2.20.0

