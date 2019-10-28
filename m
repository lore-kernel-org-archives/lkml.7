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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D7CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2271D218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+2v4TtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390698AbfJ1PR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:17:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36932 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbfJ1PR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:17:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so8821173qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KjRmkuQ5Rd7UqVsdzxjQjRVAZKTs3MyGlH/p0of+zKk=;
        b=m+2v4TtZB3PS8FHefv4LsC4OS2nCvR/f7LU9VXFQKgdj24LFjjmQMv48mLUGoj/tRY
         we9qTd2RqU1EsBFXUeqeYkeBlMamG88e5PpCahItKyJsm0sAAhBT+9dZLg3d4Ua5eTxR
         zlmjlcYfD+WwjXoNd7BY2LDZBx4g8WG5Gx7GQCIQfDkV8BSi9hExbz4tp3kAK7mthViC
         x8RlS+msMI/46a14dA9F3NF4IkKNwtSnPc9N1FaWMsJNsZyRMkGWLkFnPeydlIlSziKS
         KJyCBI0R/EamztDeHfcMzXohtr2gtr0QxBm8SU7E8j8mLPEI2Q1sRolyywscPgdhMxP7
         R6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjRmkuQ5Rd7UqVsdzxjQjRVAZKTs3MyGlH/p0of+zKk=;
        b=VLFSkKB/Tuny9nhMQbU63IgT7fsVMs8PFzAocN7++VMhN+4ZvwvFTmrOvcVsqYvQF1
         Jl0wrX/3PjYuvuhia1OIbpRL3WzhkgMCcSY94ElVP3xYJAqRwmVuVY/O2zA+rJBoPCyE
         NtqAl5a/aRCdQXBevHjqnVirqOOlbTnZ0MwEnwhqIiTVXXCNT0uiASHp512pwmim7KMe
         1P2OgjY0FksBxmAk8l2W9I5cjyKCdkAskav5YOZpXmFsg6EkVXmSiHfnQcFk0zzQ6CKO
         M1DJOCnRC3S43nHB5DzVOkzEtil6R71+LkDo8RrfYrHf6YCYRhmJRQHkkn81VxitQRor
         9efA==
X-Gm-Message-State: APjAAAVfyTtXmqf/HwOHd/WnliRTx5EnXnjPz1x5LvEVaa9+XvuFiOKE
        4y2REOnSuBKWPqX4rZZBjF8=
X-Google-Smtp-Source: APXvYqwDiAs6XfOESTx0ouZtOtPNuT0dJAWOJ9+v8l1T0qL35EvPmKNXKvSRzqOSUqaT20OPTZWEGQ==
X-Received: by 2002:a37:648d:: with SMTP id y135mr13161260qkb.65.1572275874107;
        Mon, 28 Oct 2019 08:17:54 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id o3sm3582797qkf.97.2019.10.28.08.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 08:17:53 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:17:49 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] staging: rtl8712: Remove lines before a close brace
Message-ID: <b7eb43f61d3856ad3a3fce6fcf4caad6eebffe79.1572273794.git.cristianenavescardoso09@gmail.com>
References: <cover.1572273794.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572273794.git.cristianenavescardoso09@gmail.com>
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
index 304d031..1e3e49f 100644
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

