Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A1CCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55021871
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ37QCMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfJZU3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:29:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42434 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfJZU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:29:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so2028062qts.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FGfKeWR+ALU6IXEki/hlm0ra+LCsfescC58IXZqU9BQ=;
        b=YJ37QCMQgHMTqJAun4vVrI47EtM20IcTFGm46ChOUP03jgjfH91x8WmfzWHsJPWBhF
         mkNCdtrMzH7m4xIL4TkvcgLxYL4gGkAmxLHPaGeu1YR/SXesEo4sP/8JqCOo9lmyVf/a
         hJLeNA2XHWiVO1J7P61zR1jjewDbQdGqSemBuScWmbHhJjoQ6lpH4pAkQB1iY/jEClTT
         vY/PBcTi4y0OcCZH7Ew/WrJ1YJcj7GpDNCZFmVMm4KrX4sKk/T3fCdsqF9YYnZczv9I2
         Pzh42uO4oZ+R2IzQ3yo0tjwFXOIcCmczhuFdpr+nGQ0MSIc7SmJ0trDlRevVe0Lk4Vw6
         H1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGfKeWR+ALU6IXEki/hlm0ra+LCsfescC58IXZqU9BQ=;
        b=aI1GeWGDyURlZ6nETgrjxdKKXyvboF44T2cCG9pAGdMrQLhzErY4ypCG5ndDKlKWdv
         LtNpEhvw5Fs+qm0sjxfQpwYxRw36aNZR/BQ1U3yCQTdzSnrNVXNdzno6xXYYqNRz8nnh
         TL0KCZ0RmeLnwGeQSN+qjIHcOxQpuIAyU8Uz/I6Hs1Wl4FzfCWcw0UynRdTBiPXxe86r
         KeIkP69eEduYIW5ssCP7bYTkIfhrY+wbj9tiPO4YCHi4t3vqEtt8C10UrjO+VFkSrDEy
         czYwU8I0bHb4I4/V6rBWblcIWkxyq/JrtWkzUlBd/ya3ZUMcLEpQF5M3sZnKv9h+JHXR
         JbvA==
X-Gm-Message-State: APjAAAWE5RhfSl3A51baDfdKHiZk3siXXLcjAC/daP16NJdWFUEsQDwq
        WEbb0AWCf4X29dExDBNjYVk=
X-Google-Smtp-Source: APXvYqy5ebdVEeXMnYdjN6QimAFw34BwfQ3/73U6Ou0aK1pCKaH3LpJxuvUPaw55oITndNI/x78Paw==
X-Received: by 2002:ac8:2dda:: with SMTP id q26mr10316772qta.100.1572121788550;
        Sat, 26 Oct 2019 13:29:48 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id x7sm3474432qkj.74.2019.10.26.13.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 13:29:48 -0700 (PDT)
Date:   Sat, 26 Oct 2019 17:29:42 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: rtl8712: Remove unnecessary parentheses.
Message-ID: <2257cfa5359d82207bf17cf652e48cd79c6092ab.1572121059.git.cristianenavescardoso09@gmail.com>
References: <cover.1572121059.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572121059.git.cristianenavescardoso09@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses. Issue suggested by Joe Perches
<joe@perches.com>.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 12a3c64..c567a16 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -61,7 +61,7 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
 		precvbuf->ref_cnt = 0;
 		precvbuf->adapter = padapter;
 		list_add_tail(&precvbuf->list,
-			      &(precvpriv->free_recv_buf_queue.queue));
+			      &precvpriv->free_recv_buf_queue.queue);
 		precvbuf++;
 	}
 	precvpriv->free_recv_buf_queue_cnt = NR_RECVBUFF;
-- 
2.7.4

