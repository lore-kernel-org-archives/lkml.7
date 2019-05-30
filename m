Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E9DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7328243C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR6DVP6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfE3A6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:58:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38534 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3A6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:58:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so1802759plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 17:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+73xvdlcJ2eRJCM1UROZ+oXQ5VEB4CGineXnjJmLoCU=;
        b=rR6DVP6iekA4Srk7Rc/isdvP+qxvJsUoGtrpYqRGyb91Nc7U1gGWmhu7cQP0uaz4tf
         Rzj3J1AILdzyLJuSQN9qSJTwrdc6ww8s161DFllflfKdms/JJuj/yLYhp0kpbcniI8MV
         FNN/p6wJ/ZzJg1tTeAvTIi7WROUBz+RHNd+8vU1o5N/VLF/6tcO1mA0dbMXxnAp641ut
         AKvubsGEhalc5JY459/1Layiq4LibuWFqrnv6GOti10fgIJu5V//+PS/lnkx1Fp6ZSJp
         kjqFKGxL2r+oJfrmLAAoyiwG7idmnGVHEqKghiAbtjHkxsvo7WFG4U/Ehl2NuBtjpBio
         C22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+73xvdlcJ2eRJCM1UROZ+oXQ5VEB4CGineXnjJmLoCU=;
        b=UQJO7K24nWUsJEhvIsShBhGnol5oQy6c6JFO5/RQvLHja7+4W1pztNtTu0tkZ/gTQg
         G4vyabtYBRpmp46S7wD4x6mt7YkQ2B+TqxihuJjF9qSvLXTuJkUPPpfLFbgKVxbR90pC
         se2BSu5ioRVDsiRnksaHYSM5Adm2idsbh6CzoIAMoB518NOsnM5qAZChepmksgqNKhnH
         HM/MSFvnqmt1equ0+TcMoKqdmO1jJVWbN2cs2GPcYo954dkthbG0E9upQAJccI6acjxN
         eO+ZGrOWnv2Vbqt0mhjA5YX+f5mHrFNsONGn5r+OqcmOVzZWO4iKZ9zEinhGjzgKJfmK
         YjTw==
X-Gm-Message-State: APjAAAUlyMAab6Y5zOOzPj4tFQKlH/t48ikEwRmZlfDRmwCO93qHILnP
        73nQsbLNQqy/adYBfPWTRmV+f64QbhM=
X-Google-Smtp-Source: APXvYqyOEDUjVwZVh3I1SmKM6dFRgomEnU+HMaj4eKj9Hvhiu9AvpipD06Wl/aZe+Shq9nLaVW+Flw==
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr957256plp.174.1559177917778;
        Wed, 29 May 2019 17:58:37 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id u3sm857766pfn.29.2019.05.29.17.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 17:58:37 -0700 (PDT)
Date:   Thu, 30 May 2019 08:58:22 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dlpar: Fix a missing-check bug in dlpar_parse_cc_property()
Message-ID: <20190530005822.GA5942@zhanggen-UX430UQ>
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
Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
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
