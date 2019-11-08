Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDAC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061F2214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxjdFP0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfKHFVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:21:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34791 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKHFVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:21:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so3911965pff.1;
        Thu, 07 Nov 2019 21:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGFx+amGu93F2A50py9iOALjdTJpw7/ItloLfCzH0sg=;
        b=FxjdFP0WXWrfIrLD+8gcWy/umEQbWOunx9yjkSz/LLLs4K/VyjyX0EgEYa5CMm5F6w
         SAUoch3awY5CzsHatHgtVRC9h1rmotllGqaN7eQVFoLIwA4Q7Zfr1e8Z2B18dGZ8xAu8
         QoYbA/t5omu9u3U2icdTWcCYwlPbKzMHqD+IgJulOgosUZgxH5W3MHmYQI71tuBjOFFx
         BR8e64XCMSY5iGEB4Z+DLlWTaRinUpFPqPcq4EDdv7x59vVinY1VwRfkEjmIHzX0rDCi
         +62w0PF625kC9XHstmRDdqFR5vEHmEAF85ioDHVJZVjWR+jFhBb7oYGuTP7cAbiCvHCX
         TScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pGFx+amGu93F2A50py9iOALjdTJpw7/ItloLfCzH0sg=;
        b=EdKyxzsWvPDMvN8XpZcmpbIcdgYO6f6rCRytxfyQWlAIeBjNpa4VvfHLvj8exCWAHI
         3FyGZRKYrDIJOZGsL7XrfriftSDcXBVLOkCdkvtb6HW3aeHNHD4C0LmYfJ9DCQvzERvg
         3Ex7zamrQv1XjxQh6NYU4cV9Dde+EMC8L9/Y7JwKnLS680vM0uFyxypKDi1Mh8Zm1Mbc
         stK2pR8HV7zC50ADaG+T2rV85yGxeEfHQ3HThHuWzg8AuaTbzN56kPBElSe1a3bWciXk
         2LYZv1zvgapvmfsX7XcEu9r2Cw3tm9u3hx7v8s2N/ELjunUl73mPyR4itUWnlYfma6lN
         5f6Q==
X-Gm-Message-State: APjAAAUeEIjlls39I0r/5S5tj9x7QP6VN6mvN3BPmW/wu5a9FsXmbV9v
        ZbqylMuNPRIKnP1wYckKMKs=
X-Google-Smtp-Source: APXvYqxciNZfaCcNzGy2TBZD43B3E6OOWrVWrEa5IIAHVWjFI1D487hSYs23XimTIBVclBiUU770SA==
X-Received: by 2002:a63:234c:: with SMTP id u12mr9244517pgm.384.1573190458914;
        Thu, 07 Nov 2019 21:20:58 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:58 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 11/11] fsi: aspeed: Fix OPB0 byte order register values
Date:   Fri,  8 Nov 2019 15:49:45 +1030
Message-Id: <20191108051945.7109-12-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jeffery <andrew@aj.id.au>

The data byte order selection registers in the APB2OPB primarily expose some
internal plumbing necessary to get correct write accesses onto the OPB.
OPB write cycles require "data mirroring" across the 32-bit data bus to
support variable data width slaves that don't implement "byte enables".
For slaves that do implement byte enables the master can signal which
bytes on the data bus the slave should consider valid.

The data mirroring behaviour is specified by the following table:

    +-----------------+----------+-----------------------------------+
    |                 |          |          32-bit Data Bus          |
    +---------+-------+----------+---------+---------+-------+-------+
    |         |       |          |         |         |       |       |
    |   ABus  | Mn_BE |  Request |   Dbus  |   Dbus  |  Dbus |  Dbus |
    | (30:31) | (0:3) | Transfer |   0:7   |   8:15  | 16:23 | 24:31 |
    |         |       |   Size   |  byte0  |  byte1  | byte2 | byte3 |
    +---------+-------+----------+---------+---------+-------+-------+
    |    00   |  1111 | fullword |  byte0  |  byte1  | byte2 | byte3 |
    +---------+-------+----------+---------+---------+-------+-------+
    |    00   |  1110 | halfword |  byte0  |  byte1  | byte2 |       |
    +---------+-------+----------+---------+---------+-------+-------+
    |    01   |  0111 |   byte   | _byte1_ |  byte1  | byte2 | byte3 |
    +---------+-------+----------+---------+---------+-------+-------+
    |    00   |  1100 | halfword |  byte0  |  byte1  |       |       |
    +---------+-------+----------+---------+---------+-------+-------+
    |    01   |  0110 |   byte   | _byte1_ |  byte1  | byte2 |       |
    +---------+-------+----------+---------+---------+-------+-------+
    |    10   |  0011 | halfword | _byte2_ | _byte3_ | byte2 | byte3 |
    +---------+-------+----------+---------+---------+-------+-------+
    |    00   |  1000 |   byte   |  byte0  |         |       |       |
    +---------+-------+----------+---------+---------+-------+-------+
    |    01   |  0100 |   byte   | _byte1_ |  byte1  |       |       |
    +---------+-------+----------+---------+---------+-------+-------+
    |    10   |  0010 |   byte   | _byte2_ |         | byte2 |       |
    +---------+-------+----------+---------+---------+-------+-------+
    |    11   |  0001 |   byte   | _byte3_ | _byte3_ |       | byte3 |
    +---------+-------+----------+---------+---------+-------+-------+

Mirrored data values are highlighted by underscores in the Dbus columns.
The values in the ABus and Request Transfer Size columns correspond to
values in the field names listed in the write data order select register
descriptions.

Similar configuration registers are exposed for reads which enables the
secondary purpose of configuring hardware endian conversions. It appears the
data bus byte order is switched around in hardware so set the registers such
that we can access the correct values for all widths. The values were
determined by experimentation on hardware against fixed CFAM register
values to configure the read data order, then in combination with the
table above and the register layout documentation in the AST2600
datasheet performing write/read cycles to configure the write data order
registers.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-aspeed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 95e226ac78b9..f49742b310c2 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -459,11 +459,11 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	writel(fsi_base, aspeed->base + OPB_FSI_BASE);
 
 	/* Set read data order */
-	writel(0x0011bb1b, aspeed->base + OPB0_READ_ORDER1);
+	writel(0x00030b1b, aspeed->base + OPB0_READ_ORDER1);
 
 	/* Set write data order */
-	writel(0x0011bb1b, aspeed->base + OPB0_WRITE_ORDER1);
-	writel(0xffaa5500, aspeed->base + OPB0_WRITE_ORDER2);
+	writel(0x0011101b, aspeed->base + OPB0_WRITE_ORDER1);
+	writel(0x0c330f3f, aspeed->base + OPB0_WRITE_ORDER2);
 
 	/*
 	 * Select OPB0 for all operations.
-- 
2.24.0.rc1

