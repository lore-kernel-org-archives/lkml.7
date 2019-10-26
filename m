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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94BCCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB65720867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPEceSXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfJZUbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:31:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35163 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfJZUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:31:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15so8714564qtq.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tbkGc2uRqrthDU52A0rFG/A+QNzAVuHvzOb7BZHUvFs=;
        b=FPEceSXX6wgU/NanFgTWiGokgDNZA26a5uaDlEegOo9p6WdNYTbE7qRfAr7Cs0uCzy
         odeeOOiu2sm+g/A1k0BHkjyBp8CU3YORbKZZoWBw4R4eVKbpKs6slO5gm0cfOdSODB8S
         e/4EuH5jaV1TVyLY50H4lZPKxEndESM1XYpE33S/6jQa/lZh9iuKexzOZvM3hsgl7mWu
         kx1NRaq7oUsIK1BRE1zKARyZ7h3KfDcsRLiQ8OlzJmgDvX4EEm0eYWx/RquhSZcgv060
         up5PwLMxdkIDa4/R7xr+BEoKT+N0dGL7VJBnBMx528WuSVfDiwg96Xf5bEEaFAduK+U7
         By0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbkGc2uRqrthDU52A0rFG/A+QNzAVuHvzOb7BZHUvFs=;
        b=NcH5gfGOeFuMb6Q9/lvpYjMomQcmJXGUCMR71TK61FLQVYpshSTdAWlrYPFrl1hDmT
         sB3jtoIbV6m3sDefqT3EERBZNoKac4u6n0II1bWHovztNRPF9JoH81NC5Ym3hHwBW68y
         GNGZdDBWEGbZNid8L6zCqlm2/I1DD6c7tb7CYT+JKjXNc4xF6YjhMaqNqbnMaXu1mm2g
         s94Nt6sVLv+Nykw1UoabLaZRvxskYJIeu1ON9vT/PLDdagFcSprhNguUl3/WlxhyErNi
         41VYf/cbxMUMiWbrCva6l5oe/taVKJDkdixgdmDXUVjPpiyMwpc6AuVcPgSN3CBi67az
         AuwA==
X-Gm-Message-State: APjAAAXq2l3NUaq0qt92KKL6qyCAe66wZkCuOk0OXzKcn3Mf/bryr/zp
        GqGz+ey+7EJfV3SlMmjrjbqC8xw0WL7UtQ==
X-Google-Smtp-Source: APXvYqz7jqOCtXqsT9HFmNMh60AyYfg1jikh2WYxaCHn+x63icBTzbcjSVd/DHZBKPvSweIbUxiiYA==
X-Received: by 2002:aed:3ee4:: with SMTP id o33mr10073460qtf.267.1572121891187;
        Sat, 26 Oct 2019 13:31:31 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id z8sm2939529qkf.37.2019.10.26.13.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 13:31:30 -0700 (PDT)
Date:   Sat, 26 Oct 2019 17:31:26 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: rtl8712: Remove lines before a close brace
Message-ID: <8c74dcd9afaa528a80804081f582792045bb7a7a.1572121059.git.cristianenavescardoso09@gmail.com>
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

Fix Blank lines aren't necessary before a close brace '}'. Issue found
by checkpatch.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index c567a16..b7d0ea0 100644
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

