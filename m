Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1EDC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3465821855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fbIm4ODg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfDTL5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:57:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51804 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDTL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:57:25 -0400
Received: from zn.tnic (p200300EC2F112E00718873C84F24A365.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:7188:73c8:4f24:a365])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 126B51EC082D;
        Sat, 20 Apr 2019 13:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555761444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IEjw5oQf38kcfHyHqIkf/KoAl+9see8ZlQ6OAsAH0+g=;
        b=fbIm4ODgUQ3WCxvgxciPGGPjQuBE6rw3WxFGN6Ldadqxzo5GDKJvrxkRgrRLDjQETislTi
        DU+zbpLnRWMQltJ8XbxHywVRjvEu73vBkLUODF8iKHUP2bnGNdbCMFWtYLIU6VQ6e1jyYe
        EEOp1QuhEsRyXBp60n3tH0pJ+V24Pqs=
Date:   Sat, 20 Apr 2019 13:57:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     WANG Chao <chao.wang@ucloud.cn>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 3/3] RAS/CEC: immediate soft-offline page when
 count_threshold == 1
Message-ID: <20190420115719.GD29704@zn.tnic>
References: <20190418034115.75954-1-chao.wang@ucloud.cn>
 <20190418034115.75954-3-chao.wang@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418034115.75954-3-chao.wang@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:41:15AM +0800, WANG Chao wrote:
> count_threshol == 1 isn't working as expected. CEC only does soft
> offline the second time the same pfn is hit by a correctable error.

So this?

---
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index b3c377ddf340..750a427e1a73 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -333,6 +333,7 @@ int cec_add_elem(u64 pfn)
 
 	mutex_lock(&ce_mutex);
 
+	/* Array full, free the LRU slot. */
 	if (ca->n == MAX_ELEMS)
 		WARN_ON(!del_lru_elem_unlocked(ca));
 
@@ -346,14 +347,9 @@ int cec_add_elem(u64 pfn)
 			(void *)&ca->array[to],
 			(ca->n - to) * sizeof(u64));
 
-		ca->array[to] = (pfn << PAGE_SHIFT) |
-				(DECAY_MASK << COUNT_BITS) | 1;
+		ca->array[to] = (pfn << PAGE_SHIFT) | 1;
 
 		ca->n++;
-
-		ret = 0;
-
-		goto decay;
 	}
 
 	count = COUNT(ca->array[to]);
@@ -386,7 +382,6 @@ int cec_add_elem(u64 pfn)
 		goto unlock;
 	}
 
-decay:
 	ca->decay_count++;
 
 	if (ca->decay_count >= CLEAN_ELEMS)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
