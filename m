Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF61C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902EA2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556258439;
	bh=1UTOSXycFtZsxSBcMI1jrkPR5+ySKiezxlXD+FlrPUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ozGDR+1VR8LgJc/YuXH6Yw8S+kPwmsG3lDJxVbJd1KuFHV6wj1B8FSBHtAnZnq2mc
	 +tq/PTFEZ3jtnLUaNrpPjxaijm1vobJnwSBNfQE7sPiHc4sJ4uJR3Xh8zwUtydVaQD
	 ZHJTcJBLEbme3UT31uacmx+XlKamMBZltEo+mb+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfDZGAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:00:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40905 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfDZGAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:00:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id t10so741389ljg.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2dvYDWXEfCHqR0qNXZkLgcnw57HtnJmA/hujsX0G3Q=;
        b=Cd8B0RoEaWDPqTbgLFWCUKoRdXtu/WZvxp4k26liA4zeAYUU+jgw7hpOrSeN+5Xr4y
         BCvS5QQ5xN2GhDjoqLtiHpIBqyKEB6Ml2i8rbNeJm7lOj0TvdCGDrFu33eXhBZQOWx1w
         wkekcc9PVUgABrpyj4CJFSe0MZ/Q1uUgp3PZSPcWKijnCV0usOouCaNu04rCqn3gAOyH
         p18ZVSlGSY7oK45nu0UJjCmhf+0haJnBpHiGI9uG7XTjp3tzQJWtpz0oXZe4Ynmq2/yU
         PfsLw+FRwjQWZx35mh2LgAUfSRiohYNi8slT9c/yJJm+j5LammSjJVoRRP/4Xfpcl/k0
         J3pQ==
X-Gm-Message-State: APjAAAUxfimAudSI1xoHmfJeU1F4j+3zjn1l1dv1a1NffsKWM9BYH2+d
        aU0PNipFxlhzSol1mV4taJXl6x5Z
X-Google-Smtp-Source: APXvYqxoXyfjXqb+pfz4b6xzVUsIXb9vLLq6oWKViuTsW+q1Hyb5iAlFDxNFqw62v5vPNHce5x9g9g==
X-Received: by 2002:a2e:9bc7:: with SMTP id w7mr19097293ljj.58.1556258406131;
        Thu, 25 Apr 2019 23:00:06 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t15sm1297931ljd.22.2019.04.25.23.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 23:00:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1hJttz-0003W7-MZ; Fri, 26 Apr 2019 08:00:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] tty: ipoctal: drop unused iflag macro
Date:   Fri, 26 Apr 2019 07:59:24 +0200
Message-Id: <20190426055925.13430-3-johan@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426055925.13430-1-johan@kernel.org>
References: <20190426055925.13430-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the RELEVANT_IFLAG() macro which has never been used.

Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/ipack/devices/ipoctal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ipack/devices/ipoctal.h b/drivers/ipack/devices/ipoctal.h
index 7fede0eb6a0c..78e4fc81fb03 100644
--- a/drivers/ipack/devices/ipoctal.h
+++ b/drivers/ipack/devices/ipoctal.h
@@ -18,7 +18,6 @@
 #define NR_CHANNELS		8
 #define IPOCTAL_MAX_BOARDS	16
 #define MAX_DEVICES		(NR_CHANNELS * IPOCTAL_MAX_BOARDS)
-#define RELEVANT_IFLAG(iflag) ((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
 
 /**
  * struct ipoctal_stats -- Stats since last reset
-- 
2.21.0

