Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE28C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27373215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfFYIs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:48:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37922 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYIs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:48:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id g4so8447801plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=SbHI+2ZPe2F4trO/RmKldIi3BUNe0clBDqy+3ySKREk=;
        b=Ln6MRThspN5yLcmhMSc5mI3lxabCG+/8pwVbgIs+S4arEpy//800m+lc+5vwtmDk+u
         UDqvJB9jJsAstkMxuOHftK8Y2Bz8EercnXYgUcPRH7H1WQwlmOWuy8Cvz2hZwaOvNML9
         5JB1MX+cz2qvNAgzZzOpsLZChAIbUsIr2mgGe8KX9tUhT++dSLqVUdI2Qrh3Hlk/Im+j
         yN/RzKgv8lV07jXXAytUIRnzcnG5dhzFz/QYy29OjKXtlNA8yvEZe1x6LiXLE8nTo2ZL
         971bogs830TREYDCtOnUnAbTK3+awrRKaE6Oc0A2wRUHMRtFgJOXq8TmYqXergLs9jnu
         74LQ==
X-Gm-Message-State: APjAAAWQ7tI4kGCLVlKP1+Ss9EAWsHO51o8AyQKN8RiK5TdO6WF3ejF7
        17X13F0yaS4dNUglk9TfRZQTwpHMpgZrMNBT
X-Google-Smtp-Source: APXvYqzICITq0LF39qdmLn3FbbAFe2vxOW+Jt8WI+imgxcTmTRasfjQerDzKPJEAr1yYLpBhtC6JIw==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr103841484plb.114.1561452535820;
        Tue, 25 Jun 2019 01:48:55 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id e26sm14280998pfn.94.2019.06.25.01.48.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:48:54 -0700 (PDT)
Subject: net: macb: Fix compilation on systems without COMMON_CLK, v2
Date:   Tue, 25 Jun 2019 01:48:26 -0700
Message-Id: <20190625084828.540-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     nicolas.ferre@microchip.com, harinik@xilinx.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our patch to add support for the FU540-C000 broke compilation on at
least powerpc allyesconfig, which was found as part of the linux-next
build regression tests.  This must have somehow slipped through the
cracks, as the patch has been reverted in linux-next for a while now.
This patch applies on top of the offending commit, which is the only one
I've even tried it on as I'm not sure how this subsystem makes it to
Linus.

This patch set fixes the issue by adding a dependency of COMMON_CLK to
the MACB Kconfig entry, which avoids the build failure by disabling MACB
on systems where it wouldn't compile.  All known users of MACB have
COMMON_CLK, so this shouldn't cause any issues.  This is a significantly
simpler approach than disabling just the FU540-C000 support.

I've also included a second patch to indicate this is a driver for a
Cadence device that was originally written by an engineer at Atmel.  The
only relation is that I stumbled across it when writing the first patch.

Changes since v1 <20190624061603.1704-1-palmer@sifive.com>:

* Disable MACB on systems without COMMON_CLK, instead of just disabling
  the FU540-C000 support on these systems.
* Update the commit message to reflect the driver was written by Atmel.


