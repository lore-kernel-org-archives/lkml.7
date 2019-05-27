Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D092C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313DF206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGT0Lhf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfE0D0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 23:26:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33398 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfE0D0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 23:26:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so8737482pfk.0;
        Sun, 26 May 2019 20:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PC1WfumcDjGU0yD+5JvFLw/e1vzZYICqxOgcNlrLZLs=;
        b=iGT0Lhf82tkOR0uL7MRwcf0CzjJORpAsCRhCyyWwSSd5Y1XhrH4d6DEIHwxwwiQyP3
         0PSPRwQ0fJqZGarkbG4+dRf9wcHMmER9+U/0Xi4fHuA5nUJTtY/lUqaN7JsvZUOrKI2E
         45sL0QNvmFjWdyGui0iEnY8OhaNwENMDfiSm77WOUcABN4YEi7/pP5lisBljweRw4s+n
         X3btav1ZZBkakGx53gH09scHmrfp+rcZwNUyL+TnlevQrT0CKzz4hk6hxkCIk0L/9Tp6
         5OGV0J6C9RIHVil1EgD9ThD9QP0+tKbRtVneUEjksN9knO85zC5GZdohARX9ggWatFfP
         Dncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PC1WfumcDjGU0yD+5JvFLw/e1vzZYICqxOgcNlrLZLs=;
        b=oLnEsePW1zLgGqQ0EBQIx0sKtpWkjWkynt/p96vggk8h2x5TjdgByaOkDQRDjUOZh+
         maDT1Y6tI+y55fxyNrvyjbmGjzx5Ma9Qa3SpjkA1TWgO0k6uHr2fgEOGLX850HPzzi6/
         tHxFy174d217Vs56NtQMxa0ySzrdgbFuTlgRtTXqqwOG7n1TaqA7OpwD3b12e4yR5cHU
         e/v4Ssmy7LDdEsZJ9IdJZH0Prp4osTy1t3ZVwoV9z08H38yeazTxHJ5ofzGnyGpzepSW
         Wn7AAXvPjtCS5zvx2GDMW9uw+Mw2xVCFPPQvDnhjoupmzSQbMeepJQ6nPMKkYcr2j3lB
         z8nQ==
X-Gm-Message-State: APjAAAXjDCHNQX+caDQG5Mx7QULe1Dd7YjKM01UUNxA7wZNHoOBBxexe
        sJnFDsJPIqcEXQ1mceR6BKP//Lim
X-Google-Smtp-Source: APXvYqwhGs2nCVjUHVJbOZR5au9KKYXo1ItSkiNTGDAraeaWwj7EXz9gtVYO0xbzJNEik/fSYoIEVg==
X-Received: by 2002:a62:62c1:: with SMTP id w184mr131203668pfb.95.1558927574837;
        Sun, 26 May 2019 20:26:14 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id j14sm11103107pfe.10.2019.05.26.20.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 20:26:14 -0700 (PDT)
Date:   Mon, 27 May 2019 11:25:51 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     davem@davemloft.net, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, mhocko@suse.com, sfr@canb.auug.org.au
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mdesc: fix a missing-check bug in get_vdev_port_node_info()
Message-ID: <20190527032551.GA19187@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In get_vdev_port_node_info(), 'node_info->vdev_port.name' is allcoated
by kstrdup_const(), and it returns NULL when fails. So 
'node_info->vdev_port.name' should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 9a26b44..8e645dd 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -356,6 +356,8 @@ static int get_vdev_port_node_info(struct mdesc_handle *md, u64 node,
 
 	node_info->vdev_port.id = *idp;
 	node_info->vdev_port.name = kstrdup_const(name, GFP_KERNEL);
+	if (!node_info->vdev_port.name)
+		return -1;
 	node_info->vdev_port.parent_cfg_hdl = *parent_cfg_hdlp;
 
 	return 0;
---
