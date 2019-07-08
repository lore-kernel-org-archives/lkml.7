Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004FFC606A1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA68A20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeHVRv3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfGHJ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:57:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35938 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfGHJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:57:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so13988774edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rg3MR+eApkBoKx2MM7FYI4liPQBRkBxidD5AvqBz0OM=;
        b=SeHVRv3HeKJ2PAjjWt5Hmn//1ALTldDmhmUK8On9cmnhLklUIBkOxn/UZt3CYgJ87O
         1KjhqbbSCfiHI9TgxroEsesjNDjgfEl4JD0ZNL3bDOc8WpnpyOYPjKVin8f7Of0H2eR7
         4IASabU0RbxJKTxobQuwn784QEjSwH0r8u2CNMXJ2ECHOvSzJhBDxCyp1CQ+KbFpEubf
         iNHvnFxb2MM/YLEwKEOEYdHNnQlcIEfYACv3HNQy5OH/kA2u2sqjEKwvDSKkHa52bc8G
         WQt0iA5BE685gjJ499tyf2qv60VudAXaJtAdC6P2kEugvxB3blW6BOes/RCXPzR0uegp
         R2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rg3MR+eApkBoKx2MM7FYI4liPQBRkBxidD5AvqBz0OM=;
        b=d2DGeHUN3YZ4G7A2eZfwkV6mFY6Ue5WwtcmCuLYaa6Pv9usr4Q1kL8ICBt/F9Kkwhi
         zeNaLRXvunu8sXkiOECx1DbyRRHYZ4rogvEYH6TzpQFckS/KPDneLJwwDakwoYNNENgD
         3ocSBqmu5GB8ueZhMXZIKJDckcBdRNo09PgeFIsNQND0pmz3kJPp7aoDqG8RSSQ+WT4y
         7gJGs0SJVG2p3Agpbq41fGDkywWFDyzvcRXzLVPUYX1UtBXKi7CNBRI5VUINia5kNVhf
         5uJ2pHFohn0FQRmUWK3up7CLWkZH/H98sH1iCsUd7++OsQAY+dHrSdLJ7+EHJHsPX8dD
         AKgw==
X-Gm-Message-State: APjAAAWLhCsqXN6mpWfN9Lv5dldMTDqPuvGFg+FXiAeSgBPoaXkJzUf/
        30BrRrnoqG+BslErqhF5ekAv+YYFptQgNA==
X-Google-Smtp-Source: APXvYqwEifHSmhjFpE/rRdKK4PwCH5groMB0buQ5s2hi1x5SS7e71wTQ5pHAGzEkO5QxhCQxTiM9jg==
X-Received: by 2002:a17:906:838a:: with SMTP id p10mr15031436ejx.237.1562579835439;
        Mon, 08 Jul 2019 02:57:15 -0700 (PDT)
Received: from puskevit.guest.wlan ([195.142.153.182])
        by smtp.gmail.com with ESMTPSA id p22sm3363012ejm.38.2019.07.08.02.57.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 02:57:14 -0700 (PDT)
From:   Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
Cc:     Fatih ALTINPINAR <fatihaltinpinar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8723bs: hal: rtl8723bs_recv.c: Fix code style
Date:   Mon,  8 Jul 2019 12:56:50 +0300
Message-Id: <20190708095652.18174-1-fatihaltinpinar@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding stlye issue. Removed braces from a single statement if
block.

Signed-off-by: Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index e23b39ab16c5..71a4bcbeada9 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -449,9 +449,8 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 				skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 			}
 
-			if (!precvbuf->pskb) {
+			if (!precvbuf->pskb)
 				DBG_871X("%s: alloc_skb fail!\n", __func__);
-			}
 		}
 
 		list_add_tail(&precvbuf->list, &precvpriv->free_recv_buf_queue.queue);
-- 
2.17.1

