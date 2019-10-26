Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BFECA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C0C20679
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MREXsrE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfJZBKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 21:10:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40588 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfJZBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:10:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id o49so6049335qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dp9VEiEAucRbcNWDDMXkM2Mcfldcw5lUeaorfPQjnfs=;
        b=MREXsrE5nPyO+vke/p/zBd8AFyJGLo7wOjrZCig9R0YwNNXfFGAqyJOO2ywvg00lK8
         lTd+M8efshpro1SFyqYKBRmXNP/GpStpF6jLUwP4pBRH1J6Qgs4iNGtK8RuW0o7kRvc6
         PGC3IXXisYHQJ4AYk829Q9E1nXxneatjFakmejD+L6qO2Z7ZOJCWcTKexZZp84SAJJyW
         FLTC0loQ0phF+UG2Ec+tU03RV2ODcnmY9FBLtsCNjcJlRpopl7Byi67BVGsm8RxKaMku
         tiBSNrLLgHxg8QgBDVZJ70PCBbP4xWu6cC4+R9hLP3CDgc8acoGagOrI3vjhHTavk6hs
         Pw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dp9VEiEAucRbcNWDDMXkM2Mcfldcw5lUeaorfPQjnfs=;
        b=ivs87H0SDXYdG+lzYhbcz3y7PI5OwB/oSvIFaX1oGHMf4KaJH60LpU+tsyurV6oCxQ
         mC6BbqLSZMfPrslCr9He20/UoUO6OiS/og3D3rWF6k0l7+oFH4mnNxR6A9UQFcriTOVy
         F7V5Z7+uopeB+x8A3fNP7eg6ih35xwrCN5Hk0NhaFb/fqksMHKEx+Pa5W18xZ0pvx7Om
         a/FQEmsNXSqP9N9A7MXG8Tp6lAEwZFlPSDxWS2yQwlf8A6vUtWs7ib7BmK5fgdFWOpNa
         hpeSPjKpFxj9R8q74b1H4nv8UNTCsI8iKl/m+RKw8cBxUqXuQ9xf+7ki3iXizDMAmC1a
         kWnw==
X-Gm-Message-State: APjAAAXH+x3tuXPJILUbkbHt6Xp1mMz/Z5CMD4szl7z17Dibrh/l7jbB
        nVeWvQK3piLfm+0Dq9LTHK0=
X-Google-Smtp-Source: APXvYqytVxiRdo72TUn20/ChpM/MfBp9VIee/UBo/TYCi3RcuuQolwkzeKGazBEYn4tTmReSPKfH4Q==
X-Received: by 2002:aed:3908:: with SMTP id l8mr6240757qte.383.1572052209133;
        Fri, 25 Oct 2019 18:10:09 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id g10sm2113853qki.41.2019.10.25.18.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 18:10:08 -0700 (PDT)
Date:   Fri, 25 Oct 2019 22:10:04 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] staging: rtl8712: Remove lines before a close
 brace
Message-ID: <0bd6b897a5af322cf54d53bb68752d3667a7acb6.1572051351.git.cristianenavescardoso09@gmail.com>
References: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Blank lines aren't necessary before a close brace '}'. Issue found
by checkpatch.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 12a3c64..09b461c 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -289,7 +289,6 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 			r8712_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
 		}
-
 	}
 	if ((ismfrag == 0) && (fragnum != 0)) {
 		/* the last fragment frame
@@ -438,7 +437,6 @@ void r8712_rxcmd_event_hdl(struct _adapter *padapter, void *prxcmdbuf)
 		r8712_event_handle(padapter, (__le32 *)poffset);
 		poffset += (cmd_len + 8);/*8 bytes alignment*/
 	} while (le32_to_cpu(voffset) & BIT(31));
-
 }
 
 static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl,
-- 
2.7.4

