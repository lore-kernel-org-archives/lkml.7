Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3EC20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfCGIxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:53:06 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:46513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:53:05 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M3VAI-1h2MjY0k5K-000fik; Thu, 07 Mar 2019 09:52:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] dma-mapping: work around clang bug
Date:   Thu,  7 Mar 2019 09:52:37 +0100
Message-Id: <20190307085246.1477426-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1IG7sJztCRmdMYLAxD1DRCX9ygMUlZqxJER9m/CQjvO3kayExA1
 QQg2Vh4VFd634KQk/V7DgsPvCs5qrZiWWSMDWjw8My+OondYUhbyZnjxPdRm4FtLUwo4oWo
 geWLoW/IK2SvGlieteCB9EQsi/XSRmOtOsbtvQFXti2cnSf23BM03z4pH8HNrMGzChO/zAN
 3nI6JGHOwUD6YAgqzH0zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Aq9vowMyGQw=:4/EhYBlD7VTqK2bmmic/Fs
 d9xdO8N99/JRa0yvSA1l6Cofge09LQKa/9pR+6a46WluxBgCgVkWGhclKlBBXTwBaOZXBlZow
 qC3LLv3/thjWbYfNFxe1tCkMkWqTn8BzOAUFIcgS3No1STcaIXg7O0buOYT0NOkOBlYUxB6Q9
 esaBM8sZQ0nXSbIBpNhTnnuATBdb9QXzGumP08usZYXq2MrxIJMyLFfwqPLiYyXONSnv6Zssf
 9VnFNMBVP1AleGFISeak7WLTNloWpPjrnJhQYbNQkFMU98K+FUOm2zuKKpB/eadwo4zWNRtLX
 MVcWiNnWdF5Uopoi5tzi5vqpoQEHsF+qq52lpvbu/7tebSz5O1uu4kjJ6arpAO37xv63rRkEy
 +G1tQQY559DgcaTkLf+W3OCDoN9yPyCXDbTurDkY055nO6BOv3vQOcHwSb7nLB6fiEucRSb+F
 uzbpfm55kqaFUuuNbkzCGmLX4eLnfpHRbmVmSwkipkofWJnKIxMV5PUfkHa3CJ0Y+1sHkm4S/
 rFoi6coLhPR3LJflUo7xtbItWofe3Ju9elCebKITe0tRjHPuyPpOHIdBRsQov0GUCS+JWIKhD
 J5evYD4cR34dYcnlVbqHgaND1dBq7raA6XK6lKS3kkVYpy0bPyI8LPnIsg+Z70aRfaYVSiRKd
 3FLB9Zv1BYuuaLBt9mk6E3egd88OOlZs3fPeZksiM0MZP2hIuJT7gDhWMikGLR9tg5j3rA3U7
 iyRVNQ3UDTw6hKgzbBDelREYrf67KRhuI9M7TA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang has a rather annoying behavior of checking for integer
arithmetic problems in code paths that are discarded by gcc
before that perfoms the same checks.

For DMA_BIT_MASK(64), this leads to a warning despite the
result of the macro being completely sensible:

arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
                .coherent_dma_mask = DMA_BIT_MASK(64),

The best workaround I could come up with is to shift the
value twice, which makes the macro way less readable but
always has the same result.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix off-by-one error
---
 include/linux/dma-mapping.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..9e438fe6b130 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,7 +138,8 @@ struct dma_map_ops {
 extern const struct dma_map_ops dma_virt_ops;
 extern const struct dma_map_ops dma_dummy_ops;
 
-#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
+#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<((n)-1))<<1)-1)
 
 #define DMA_MASK_NONE	0x0ULL
 
-- 
2.20.0

