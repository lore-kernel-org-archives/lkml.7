Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B99CC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 02:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E3920879
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 02:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFapM4S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfEZCmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 22:42:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34627 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfEZCmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 22:42:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so7578898pfa.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 19:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RkwkVNo4DaOAeSezSEZu1BPpQiUJsVlAu63Y3Q0J0as=;
        b=VFapM4S61GN+qB2G5Awgz4EuZ7yRQpW5xmyqY4EJy7hgZoOhboT6a+qHK2PqxWCkPL
         15ScBNmaZczxsVO7e/1c/O8157kJf7c92iQ/OqMSa8nhIBDY83MpZ0Ki8V9hsjWm3Y7v
         npbBYYyr5TXyszywUTBOjvyfEZAwVoXy3f2SEyfm4e8a2jbCEfu/qHiw7wRFnEpTEaYq
         zgiOTzbBMglOZpVMB8HECsv1kJLFGama3c33LH/ik4ZF0HfUzSX4cSAoETRuSnYqwFQb
         nUcwvSC1VuaB12z/gvbu/rG/UavbB2tDo/xCdpDmsfvScfii2ye+BDlVO4Ayx0qGOW4N
         uLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RkwkVNo4DaOAeSezSEZu1BPpQiUJsVlAu63Y3Q0J0as=;
        b=c5Pw0LMSx5nqhhdVlEdg6e/Tv48LeCfWQFLdhi/0+TCB5ocjFt6NkNFbtxJ7MjVHOV
         CgqOnmvmN5ZY/dqjGfMWWwXVLq7+4hEda12i9EPDzqKm7ubLun1vZ99WWZ4DBUzyFQ0N
         TUQ4BMKzSkOqBJfQJcxAW6wZq/kMIJzJhz1fT/yp0eGmTfaggM/lcp25bqH2a4TsTFql
         iGu4aLxpNFJ/Ra9dm4ricQ2PPT2Dxspn96KXVfUcPi9lg8YTu93ayiIlBAL68K/AG43L
         hTQ4wUvEAO5Y07IBROZTGCgLBSD/TvVL6hLINFyjxTaFgS8B0DY5Q7NMG2/FeBNz2Wtc
         5knQ==
X-Gm-Message-State: APjAAAU8LnDNHHpH8Da1mQrWw6+j5cK/cBJxD45AH63rmQOlMxdH8/gG
        XCGizjQkZXlky7m896ikmUWiOq2S2qfChw==
X-Google-Smtp-Source: APXvYqzhU0q+xAJJr+wkGRKHfJ7wM4m07WOVr8SelRqPTAl8YrGIJfpYwR3QkiLJFS/jJUK2djjF0A==
X-Received: by 2002:a17:90a:35c8:: with SMTP id r66mr20779605pjb.17.1558838571495;
        Sat, 25 May 2019 19:42:51 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id x16sm6526480pff.30.2019.05.25.19.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 19:42:51 -0700 (PDT)
Date:   Sun, 26 May 2019 10:42:40 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org
Cc:     nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dlpar: Fix a missing-check bug in dlpar_parse_cc_property()
Message-ID: <20190526024240.GA14546@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dlpar_parse_cc_property(), 'prop->name' is allocated by kstrdup().
kstrdup() may return NULL, so it should be checked and handle error.
And prop should be freed if 'prop->name' is NULL.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 1795804..c852024 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -61,6 +61,10 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
 
 	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
 	prop->name = kstrdup(name, GFP_KERNEL);
+	if (!prop->name) {
+		dlpar_free_cc_property(prop);
+		return NULL;
+	}
 
 	prop->length = be32_to_cpu(ccwa->prop_length);
 	value = (char *)ccwa + be32_to_cpu(ccwa->prop_offset);
---
