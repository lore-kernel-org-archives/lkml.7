Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D748BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A40920855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEcwXf5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfDDMis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:38:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45962 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDMir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:38:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so1636392lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MO+WUQgyk0fGmGUrJApa0TjmmOpQ1GmsMp7oVHESJt0=;
        b=KEcwXf5AwoxEg+WP2ECs6tpQqfMS1CZGTW9KcffY9kFcfTBSAn7HDdPg+bFa1UQ7e5
         tfIgxAS6b9yWkiihNYHyuwD3FJhWvX/xjHf7vDzdxkRvEd03R/yxJ6Btpbxf6F+cCIAm
         lFjlL+uA/HP6YCe1JVcRPAeWj8e6y4fJEpHfMQI7OgtllapzITVv07uIRhpNMg+i7g2S
         p5oaZdte6XBJwGl29ncdJL5MZTEO2yXxDNZ/4SLh0PEX4wbmknyRqiF2VY0sMot+UWXR
         rjkE34vMtSwALmt4cjM+KNvjs6pvBrrrvggfgo++3ANbE3f26TYiTpVdxSQvNa4Ia26m
         umLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MO+WUQgyk0fGmGUrJApa0TjmmOpQ1GmsMp7oVHESJt0=;
        b=OcmA3DogRXBOckKmE1bJfVMg3CgX3pKeAomiHJr1+9ze9JgNGcGFS0p2BEezNecLhj
         ANIIm0K+LxmEfN+NwuFu3ejm09Qeakja8RvEb5PIv2Ou63qv/ETEIlhjhqP8C578u8W9
         Z3tdydxEFIqm3TeSVFxpdezX0/4C/exoYd3uquLzKvTQ7GwAUg1LwhfIoI7azIRhtIWm
         7uBaf1tFl8lyOf5r1HpoZ++zcIyFzklRuUH8z5Z8sV9idbFRFF+9RpOR6Aqy893aQQ+A
         6naK/cmabOrCQn1Y0uJvIQmLPcBLdDh2OfBhBkbeverekklp+1q0nAufvSAhyOpKx74o
         jEFg==
X-Gm-Message-State: APjAAAWYvu5ClV8DkljTtPhS5iDgmXk5xXnHq62WsXVMgSB83cWcOPdo
        Ra8HeTgUK6ccqnwYqVhRI3FIhQ1E
X-Google-Smtp-Source: APXvYqwlOkPlsds7eyVgoKCz67wdxsMg0Mn4/isBTakGnJao/BoG+JoQlJz5dZ8MGKbduHS+GQxTSw==
X-Received: by 2002:ac2:4ad1:: with SMTP id m17mr3186202lfp.129.1554381525503;
        Thu, 04 Apr 2019 05:38:45 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id w1sm3617299lfn.79.2019.04.04.05.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 05:38:44 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        tiwai@suse.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [Xen-devel][PATCH] ALSA: xen-front: Do not use stream buffer size before it is set
Date:   Thu,  4 Apr 2019 15:38:38 +0300
Message-Id: <20190404123838.22162-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This fixes the regression introduced while moving to Xen shared
buffer implementation.

Fixes: 58f9d806d16a ("ALSA: xen-front: Use Xen common shared buffer implementation")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 sound/xen/xen_snd_front_alsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index a7f413cb704d..b14ab512c2ce 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -441,7 +441,7 @@ static int shbuf_setup_backstore(struct xen_snd_front_pcm_stream_info *stream,
 {
 	int i;
 
-	stream->buffer = alloc_pages_exact(stream->buffer_sz, GFP_KERNEL);
+	stream->buffer = alloc_pages_exact(buffer_sz, GFP_KERNEL);
 	if (!stream->buffer)
 		return -ENOMEM;
 
-- 
2.21.0

