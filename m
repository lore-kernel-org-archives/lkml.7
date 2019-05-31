Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B5C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D577225230
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFgf8y4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEaBYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:24:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfEaBYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:24:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id c14so2674785pfi.1;
        Thu, 30 May 2019 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PC1WfumcDjGU0yD+5JvFLw/e1vzZYICqxOgcNlrLZLs=;
        b=aFgf8y4hxVqo2mpzXb79+1984QnsepjBu5R9D9FVKNJ4T0qgeM7XIkE0xS8vVVGXuu
         5jWVOqNPrfqb3jvrGomCaykn13NSZ9TcFrq4JeopXIyYJQ4K5We4yEWTsAzIVZqmw2g/
         /v6XEyGauJL1YvYGiqoMtBhehxgak2gT4SwYZvlKtCoNunBrs3NdoimWQ4y+Jq5VDRBJ
         H/BT+FcuLZYfoFG1ZhKJ5ho2A0UO79jsHX9c5FwZCmUZtRK4oypm2aBTZQqWqA9W0hAB
         aqPeSekT5N3TJBPh3Fcp0tlSZhIrqEB3TbF+t5Ye4BoTvTqavM331lDWFks76LhNi2WN
         tBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PC1WfumcDjGU0yD+5JvFLw/e1vzZYICqxOgcNlrLZLs=;
        b=OuBN92KmeqUt7by4//5gGC1NzYl9dJzmpo4MF53JWrTfpzrUA+iGlD0toWT8S3lyuf
         HWga5dFf+WaiHw9NMc8ojaVGkc4T+9qjvnTj8GLzOrN63QVixam9Da2kDKuPTYVnkCGJ
         nRjUvpz+1wYMIheYk6eFw/Qw3z+JKy+5pUV+OpRLu5lGU4eUZrNTGAyi4TA8bKsz8noI
         Ze0WoRA/fRXfnEhPhXuyj/YN2YerjV4Dq/yK6cOzDXRs5/YU1vv0S3nlqVFST2dxP/lp
         a9PoMpNlfg5GzqQ8T9zxGSblMHsKFRiuzAsO5hRSskJm99/4V7skj3G3E+wziDU7n/2W
         IfyA==
X-Gm-Message-State: APjAAAVkK4irLDhr5xw2iIFfpQ4OYnciBRcPnDHNFx3FqjZsXmjqkYLs
        IdPAD4y6HWlMHE8ibdW7VUIK2tMQ
X-Google-Smtp-Source: APXvYqzLXhhYEo3loYmaJI4Wap6Tr4mF1FLkzndADH6DrUxK38ECkn7byFcJ55AOWuhodBQlAO2RBg==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr6714889pfe.19.1559265875653;
        Thu, 30 May 2019 18:24:35 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id a8sm4436752pfk.14.2019.05.30.18.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 18:24:35 -0700 (PDT)
Date:   Fri, 31 May 2019 09:24:18 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     davem@davemloft.net, rppt@linux.vnet.ibm.com, mhocko@suse.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mdesc: fix a missing-check bug in get_vdev_port_node_info()
Message-ID: <20190531012418.GA4473@zhanggen-UX430UQ>
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
