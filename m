Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD43CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9A21783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuNp+E9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbfJ1PjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:39:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41801 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ1PjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:39:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id m125so4938345qkd.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jGuqyUAqHlQaOIqeuq1FvB8I+0XN2CCaqS3R8KrwwS8=;
        b=kuNp+E9V5EDjkD+hU886wEFlkGJAKlDHlN5v0LpjyEmVmh6lYG9qlpOSHnCAlaAL4a
         7Oi5hpSouapmuPH/xYHZfByCc++JM3+dNrOXhWDexUWiASrFLlkfNlvpDuAWygVxtHU1
         d159ttqrVywPDhJdaxyeHcAxEQVWidnEquJZUCRK9gfkxw5jgnvsmSp2SCPC4KSn32YY
         Dd0PotfFt78OCZht5zwpXgK9XKRUtfzcSaB4g23eZlyjj/iGDKc1p4EjuyfmTm0dw+zv
         Xyf+0hEwQbZl49EHPWIbTDPOCT1V9cHvE6PMiFE/Wp/V9c/leeX+/B3yPJLFlIbD3E12
         YEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jGuqyUAqHlQaOIqeuq1FvB8I+0XN2CCaqS3R8KrwwS8=;
        b=gaNoicLbVOa4VdNnRmOpkrpj2pJBUClr7ln8E2e+Im7JRRzWLmK3aTNrj1hhQUF1Up
         P7xSEArRP8IE94iGAo06HRQzlVhNTuXEvODDue1Kin6crqqQu1BO34UNoT6jlHFl11xa
         BL8xOxm61zGCBDqdnIwTw6HFNH1yAE0tchDq+281eEseMknwRzKFbyDzVCCx+ROPJ5D5
         AL6SuZgPmtJQOkqW7vgGO0EjlT1VaskikjFGnvTOsxURGm5XyzTLGdIQZihBpjFdFXm9
         aHm8QXGW/x1y7ktKTh9JxVAQRmN8pqbcmfB0/aqlvcp4mR9Z5gMHS0xhjpZ/tYv1rKXS
         CZFQ==
X-Gm-Message-State: APjAAAU5bpWkO8skvduzdnA7wEV39kYYLO8e5tij5oEw3A+hC4A0WAl7
        3ft6Yu0yucXdqjIYP+td8JM=
X-Google-Smtp-Source: APXvYqxJfPqkRNE6nLG0uTd8GbGyxXNP23v2Q6IHQcq5s6plJCZTv2CBpYxDL6WznxYSsYu8k+df/Q==
X-Received: by 2002:a05:620a:15cc:: with SMTP id o12mr2537160qkm.252.1572277153869;
        Mon, 28 Oct 2019 08:39:13 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id g126sm6668657qkb.133.2019.10.28.08.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 08:39:13 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:39:08 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] staging: rtl8712: Remove lines before a close brace
Message-ID: <359179720fcf90dd7aa35faab5d074bc829fa192.1572276208.git.cristianenavescardoso09@gmail.com>
References: <cover.1572276208.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572276208.git.cristianenavescardoso09@gmail.com>
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
index 36d5d2c..06de031 100644
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

