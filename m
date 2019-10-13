Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4C1C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437EA207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfJMLm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 07:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfJMLm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 07:42:28 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF13885546
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:42:27 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id j5so14850279qtn.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 04:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LyPdJiu+Pv3Ms2s+9K7y5cFNFk6/oEkuyO+dRyVq8dg=;
        b=RLPtuZTP3SeCl2VVZGZ6YtUzNB7kyWESxYeJh2biClRMLZkgyE+ayztrtlk3IJvzc6
         4puqF76gdzL/IXs3CDM2sJWr9j36Fz3UBE2vs/IvojkcKKzQ17G2+a44R1dCM8i+VzIQ
         1RJCwuC6ZaqfPYkbRmCZR+6vnTEGBhvobiLODWhtFN4Bgljh+zwVM77RSg6ihBxSC2w+
         375Z2OtB0X3J6Jkf9K6SyC7VhvekdmytRaEjNBGULxnDRdiSh3MUUtI8WMq4N1DASvTb
         fMjB6paV37IQJXvQEp00NP082Tm8G0bmrCm/46PdWmUJ5MT3XHNCMlfNs3nLELVnPlTI
         iFkw==
X-Gm-Message-State: APjAAAXBqu6EJDlYge+b37fN2wEDfxJOd3HIm4GX8kQUS8X5Tg9sF85h
        cZ8pJdbsnxNX3tbpJ/X1+zSVB3W3ZUY6mN9t2EzH9N0bxdUDbl0OFYJBhMGgQdtzg87yLuBTQ+B
        UyZx0AZn+or0RFZk67QYBAS+d
X-Received: by 2002:a0c:c792:: with SMTP id k18mr25297615qvj.154.1570966946779;
        Sun, 13 Oct 2019 04:42:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhx3XLFozvF0Fexkmjc2uJBOUXPVXIPjvAKX3RiiVhxNpPC56P8T4wN2MQG4g59b9OLo3Gdg==
X-Received: by 2002:a0c:c792:: with SMTP id k18mr25297597qvj.154.1570966946584;
        Sun, 13 Oct 2019 04:42:26 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id z5sm7213125qtb.49.2019.10.13.04.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 04:42:25 -0700 (PDT)
Date:   Sun, 13 Oct 2019 07:42:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC v4 5/5] vhost: last descriptor must have NEXT clear
Message-ID: <20191013113940.2863-6-mst@redhat.com>
References: <20191013113940.2863-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013113940.2863-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fetch_buf already guarantees we exit on a descriptor without a NEXT
flag.  Add a BUG_ON statement to make sure we don't overflow the buffer
in case of a bug.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d46c28149f6f..09f594bb069a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2656,6 +2656,8 @@ int vhost_get_vq_desc_batch(struct vhost_virtqueue *vq,
 			break;
 	}
 
+	BUG_ON(i >= vq->ndescs);
+
 	vq->first_desc = i + 1;
 
 	return ret;
-- 
MST

