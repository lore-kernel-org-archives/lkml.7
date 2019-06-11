Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F7C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C520E21783
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikB+Tbsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407028AbfFKSWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:22:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44113 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405802AbfFKSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:22:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so7408956pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w+GPyWgwq3wF+11wmpSdhR0x5M0TH4NOB3dASP/5Dsg=;
        b=ikB+TbszFd5cHriyURqfCSWha/XGtBim8PTf54Xf8gjs96SRXBJMuvScmE9MFo0TU3
         CF1B8EXexxNak9xh7uZCFX0KTgZZzfLqhIG5OG8X54q5b3xS4m7u8cv3ot1u/JG3vroW
         ytxSgcFcQOJ6p96vJvdTioonTYXFBoZ4kld0wI302Yj1kBL8xKosbID8ItSl0p1NRAcD
         9l92MEmQ/E86J18Z8QE7IuwPlULVnonH+UvnCNRIamHzSX2bagxfuyvgEIid7LumCGG7
         qKm9luewGU0cBfibDOoOuByxSO/GQvOqBX4U+R37QehV5DW93Y1mYv+zTWnfrPbmd/BL
         cURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w+GPyWgwq3wF+11wmpSdhR0x5M0TH4NOB3dASP/5Dsg=;
        b=ET5zfYGebb6MRrpZdj2o4nV56HT8UTc0MlRLgvFM4IFQBxEdPAUjZAQPXwvnbs0nId
         BlV2GrJrvY/UdppYOQb6fPYbc9RP/l2CBHDWC4rEhDiPNchABZjpI64G3ayM4KvoB647
         /PfirrI1zh7jSrLvZA+Jh5vBkeI1U9xnpYTVKB4yWR4kIXq/61Z+NratGucy9KTIac+o
         z2DmZB7UyZlic1Ett8ifZAow9hNKL+wYWTqwB+P5un08clLpLDSYedlG1W7FtjdwyI1Y
         EDDBfeHoAprRDmxlTeB7GbKRYxtrZIfChcbqlZeui6cDc9kOEfJRvc2ok4CBWpXhyats
         82yQ==
X-Gm-Message-State: APjAAAU5ulZqcsKHvbV8oxwNlVlW+dcDz1SO2bZTagI4JBiyTCnBKs7y
        AO5kNSY+01bx5obwLqxup8A=
X-Google-Smtp-Source: APXvYqzImy7uI7u3pw2kZ89UjO65/t3il5lfJt2Xgh+DiOPSquUiPqxr0vcouaXn33dXG6RKTgW4dA==
X-Received: by 2002:a63:6948:: with SMTP id e69mr10629493pgc.441.1560277332016;
        Tue, 11 Jun 2019 11:22:12 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id e16sm2984256pga.11.2019.06.11.11.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 11:22:11 -0700 (PDT)
Date:   Tue, 11 Jun 2019 23:52:06 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8723bs: hal: sdio_ops: fix spaces preferred
 around unary operator
Message-ID: <20190611182206.GA7187@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHECK: spaces preferred around that '+' (ctx:VxV)
CHECK: spaces preferred around that '+' (ctx:VxV)
CHECK: spaces preferred around that '+' (ctx:VxV)
CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index baeffbb..ebd2ab8 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -214,7 +214,7 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 
 		ftaddr &= ~(u16)0x3;
 		sd_read(intfhdl, ftaddr, 8, tmpbuf);
-		memcpy(&le_tmp, tmpbuf+shift, 4);
+		memcpy(&le_tmp, tmpbuf + shift, 4);
 		val = le32_to_cpu(le_tmp);
 
 		kfree(tmpbuf);
@@ -261,7 +261,7 @@ static s32 sdio_readN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf)
 
 		err = sd_read(intfhdl, ftaddr, n, tmpbuf);
 		if (!err)
-			memcpy(buf, tmpbuf+shift, cnt);
+			memcpy(buf, tmpbuf + shift, cnt);
 		kfree(tmpbuf);
 	}
 	return err;
@@ -366,7 +366,7 @@ static s32 sdio_writeN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf)
 			kfree(tmpbuf);
 			return err;
 		}
-		memcpy(tmpbuf+shift, buf, cnt);
+		memcpy(tmpbuf + shift, buf, cnt);
 		err = sd_write(intfhdl, ftaddr, n, tmpbuf);
 		kfree(tmpbuf);
 	}
@@ -727,8 +727,8 @@ static s32 ReadInterrupt8723BSdio(struct adapter *adapter, u32 *phisr)
 	hisr = 0;
 	while (hisr_len != 0) {
 		hisr_len--;
-		val8 = SdioLocalCmd52Read1Byte(adapter, SDIO_REG_HISR+hisr_len);
-		hisr |= (val8 << (8*hisr_len));
+		val8 = SdioLocalCmd52Read1Byte(adapter, SDIO_REG_HISR + hisr_len);
+		hisr |= (val8 << (8 * hisr_len));
 	}
 
 	*phisr = hisr;
@@ -952,7 +952,7 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 			recvbuf->pskb->dev = adapter->pnetdev;
 
 			tmpaddr = (SIZE_PTR)recvbuf->pskb->data;
-			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
+			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
 			skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 		}
 
-- 
2.7.4

