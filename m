Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2DDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55A2208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="kyP/eNBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438286AbfFLLOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:14:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39177 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438275AbfFLLOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so6091296wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ty2XijTo8qzlvWIRg0ZCeFPnQ4bNV/bDxc1SRgb6iN0=;
        b=kyP/eNBTAZVl7AnnqwObvvrM3tqayRsKb073Bm/hcEIyx7Ex2NgEMqajny0Y81CoDw
         2ppIdkgB2jVGEdaggnB0DncQVLUlO59WMGp3pC/at+0e7ohsNLEJg1pdKtvtAXo3rj8n
         tG+QbHxkmoiYkkNPI8RDGfkzOWwEm5phagzIQ4nslDn8D0RZU/gCt02Hl2/5eTdkeA68
         ftTEchRVAKEVQKWNV7/NlonObf4V++ZFDwbP31kq1d+jieUGmrrwKESqrLh0PkHD46Jk
         bFjWEU7K4Rrv+ud3KyGChSkal6qvGFhN3fcV/iD9k/K++QiN2D4dzmjP+73dO/zr49+4
         sSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ty2XijTo8qzlvWIRg0ZCeFPnQ4bNV/bDxc1SRgb6iN0=;
        b=WE0VrQ9mvGwqp4mLlQoUuGqvV5Q/+pvphstXkJcFSabbcnh8mjuPUraF+zUlQ3eoNd
         eSCfr5G1uBNpn8cGXXbnuhJCmhhX76RInlyeN3Sgf6o5ne/ssLPfngDHmYTgsyirWysC
         rSRFmFuJEZgnCmk8iMGfx5JOcsZdF9e/6LfG6KpL/g1RpbohVvsKt2bq3vRwcSsk2zNN
         IPKtRccRbtPnvdRWGoVb8JaMT+qLsy8f1Dqzs9pTib3TRYj/3ZCKYH1tdKtymApFWrTC
         6EfQrnvDtZVeLFD7lGb8kWRYgN51VQ0SFJlmvi8dIKsNIbSarGi09CgXbG7MzhbSKV3O
         CMYw==
X-Gm-Message-State: APjAAAW+2P67oIDbkRCXfm3Buns5AG/D8lWiP2zsyIwlytWYk4szZDgB
        aKqy4PxfDst1SYw4Vcs8Ggz9lR5gnqDBAA==
X-Google-Smtp-Source: APXvYqwZOCKItFssqrJwKk7MTTd0XJLNuRWwgIPMocmAo9N/2avS/g7Rf/iVxuLALuach9gSgPQ3nA==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr22159144wmg.7.1560338088311;
        Wed, 12 Jun 2019 04:14:48 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y16sm14843742wru.28.2019.06.12.04.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:47 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/6] serial: uartps:
Date:   Wed, 12 Jun 2019 13:14:37 +0200
Message-Id: <cover.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is fixing several issues reported by checkpatch but also
major number handling for multiple allocated ports. For more information
please look at the first patch which describes more details.

When this patchset is applied driver only reports one checkpatch warning
which should be fixed via console.h first.
include/linux/console.h:147:    void    (*write)(struct console *, const char *, unsigned);

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+				    unsigned n)

Thanks,
Michal

v1
 https://lkml.org/lkml/2019/6/10/186
 https://lkml.org/lkml/2019/6/10/187


Changes in v2:
- Fix typo in subject line
- Swap patches compare to previous series
- Add Fixes tag
- Split patch from v1
- Fixes second S_IRUGO usage
- Add Fixes tag
- Split patch from v1
- Add Fixes tag
- Split patch from v1
- Add Fixes tag
- Split patch from v1
- Add Fixes tag
- Split patch from v1
- Add Fixes tag

Nava kishore Manne (5):
  serial: uartps: Use octal permission for module_param()
  serial: uartps: Fix multiple line dereference
  serial: uartps: Fix long line over 80 chars
  serial: uartps: Do not add a trailing semicolon to macro
  serial: uartps: Remove useless return from cdns_uart_poll_put_char

Shubhrajyoti Datta (1):
  serial: uartps: Use the same dynamic major number for all ports

 drivers/tty/serial/xilinx_uartps.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.17.1

