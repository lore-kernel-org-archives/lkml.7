Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8592089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556258450;
	bh=pVFOxWgWaMxfLWiY/NztnXdtatBJrWxIU3jjH7VQ5cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtsFB02TnRrOvp3GfWm2X7eQzCk6SuLPPyq11j32JmyKf5arvbbBWwTias2PQNP21
	 vQJCnC/E6sTEE37ey8+1YUdDguQ38tQMDCPJZ8+j+ja7ooCQXKpRNfFQHPuexQuXZp
	 M66/hVjVOfNeMUjuLKjTI+ptKj5/o0ZodlxVDOkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfDZGAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:00:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44653 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDZGAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:00:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so1748378ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1DKoIu004LMu3Dw8Z7EoJTlootMuAsOCFnOWSOWO4g=;
        b=rsHD0kAqesoGjJ5Dmh85YUNQSRASaYQfuqsq6xn/t//qRNDS2YkJn91mjpu3xi1Dak
         zdEoDcHgIBzE2m7ZH98sa4qqsxLP5nzOE86s70caYjgTdm0UUBwAa1bam9UCCihF9uTa
         xbo3m26BttBJ44RhZBFYnR/Xtj1wMe03H3jmXl+psKkjhkhlIubKm0Va5SUbloWsjYHp
         25y8aP+HEYzjVP+4lprcWG1P0ieBqqj3zW0rAHegqBBLZvCVspIEroD8AyGeMr6wxseA
         N3RbxI94S+Fjfwl+IHXOsa3R4Cc0FbeOa5l7zL3VWqOt9UYTBkXzmeXOG4KEIIBRb3BN
         9B9g==
X-Gm-Message-State: APjAAAVOlU2XrMdHyN1LSscSTzMWn/DsXQCqabSpCXlMctidEsqLWF7V
        yftgB9mXgu1BOfR9jGT5dvA=
X-Google-Smtp-Source: APXvYqx/y/q5I1ReEZFCb9+n6Ijoeh+hzzOzscwJzPbPXZXgSxZp1A0MGuThWH6hqcoNr30ks+UQrw==
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr5310058lji.28.1556258405338;
        Thu, 25 Apr 2019 23:00:05 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y8sm5044257lji.88.2019.04.25.23.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 23:00:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1hJttz-0003W2-JM; Fri, 26 Apr 2019 08:00:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] tty: simserial: drop unused iflag macro
Date:   Fri, 26 Apr 2019 07:59:23 +0200
Message-Id: <20190426055925.13430-2-johan@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426055925.13430-1-johan@kernel.org>
References: <20190426055925.13430-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the RELEVANT_IFLAG() macro which hasn't been used for over a
decade.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/ia64/hp/sim/simserial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index 7aeb48a18576..1a338e541334 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -324,8 +324,6 @@ static int rs_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	return -ENOIOCTLCMD;
 }
 
-#define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
-
 /*
  * This routine will shutdown a serial port; interrupts are disabled, and
  * DTR is dropped if the hangup on close termio flag is on.
-- 
2.21.0

