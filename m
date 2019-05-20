Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5553216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjImSPDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390724AbfETNyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:54:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40417 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbfETNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:54:02 -0400
Received: by mail-io1-f65.google.com with SMTP id s20so11071975ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLnbwDX9nYp0llQixdztrdIhtIxceeBj4sRkANMpAsM=;
        b=GjImSPDJy8ShaSr+Kmu8fSik802cD/opDqpkNym+Rodro2w5D8/smsz5ZmejQAI+3y
         rsMqynEsw+xD73XJE5d+sP0np/oEVRcnrXkMM30Bicl9+VFtXV9SuzefGaTp0w4dWx2d
         gi5l9+EIC4mBj33w5DZLCU64lejWFarf0dO7qDS6jpd6go9WsencnubQbU03VtsuVQGB
         Wi/mc7Rfz9MNa5VQGnlpXL+mSKXz08kZGb2y304tqMZ88wLNA/kRxIWRufMs4aVFw1eg
         THnozwMZuhU1xKj5vFnIDhkCPEcKJuuwv5I1KzcdIDa2FRbX69m2+OO9aXrAu/pemwyP
         obCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLnbwDX9nYp0llQixdztrdIhtIxceeBj4sRkANMpAsM=;
        b=SzFT8i3JjuS6r2X0Otnx1TTz0bIgDBnVQ8IeJCMnU5G8LDqYA0Exn6U+GoxviDyG6r
         IemGW8J+8YeIKegHp/t18803PrkvL74cYkt75INTramWs2pCb1kRBL3DLrkbcrC5MjgE
         RAFeda9t+dypwGuqHUDhNrpo5EW2aTzL8pKcR941UPWAAz2t85FRAQqzE3J7uACG6Rt3
         zMEExBzx5UDlKzlBnxrRs6fLSkcCpW3tp4GnjyufOh04neLxUwEuyp+R22BbcucL8wHy
         RmxgfQFx1qAzP0nLFDs55i9uJ7e5dGulxq9JdC/KXU0Qov8RTxg6quRY6mB254J+Ey6p
         z6RQ==
X-Gm-Message-State: APjAAAVWD7eyS5jZw8uYM+GSwamaU2/xsvKGXy2LTx1Ig2Zn/P65yeQq
        Sc3sdqjlQHEYYVtMlsh6BSGA9A==
X-Google-Smtp-Source: APXvYqzqoaiVRHeh1u5raWwifMwfTaaj0AJU7hX2u6GIaGAJpAwDTwJ/wtrswXd4pH9nAZw7EOEz5A==
X-Received: by 2002:a6b:f305:: with SMTP id m5mr40986039ioh.271.1558360441814;
        Mon, 20 May 2019 06:54:01 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id n17sm6581185ioa.0.2019.05.20.06.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 06:54:01 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     arnd@arndb.de, subashab@codeaurora.org, david.brown@linaro.org,
        agross@kernel.org, davem@davemloft.net
Cc:     bjorn.andersson@linaro.org, ilias.apalodimas@linaro.org,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] net: qualcomm: rmnet: fix struct rmnet_map_header
Date:   Mon, 20 May 2019 08:53:47 -0500
Message-Id: <20190520135354.18628-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520135354.18628-1-elder@linaro.org>
References: <20190520135354.18628-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C bit-fields in the first byte of the rmnet_map_header structure
are defined in the wrong order.  The first byte should be formatted
this way:
                 +------- reserved_bit
                 | +----- cd_bit
                 | |
                 v v
    +-----------+-+-+
    |  pad_len  |R|C|
    +-----------+-+-+
     7 6 5 4 3 2 1 0  <-- bit position

But the C bit-fields that define the first byte are defined this way:
    u8 pad_len:6;
    u8 reserved_bit:1;
    u8 cd_bit:1;

And although this isn't portable, I can state that when I build it
the result puts the bit-fields in the wrong location (e.g., the
cd_bit is in bit position 7, when it should be position 0).

Fix this by reordering the definitions of these struct members.
Upcoming patches will reimplement these definitions portably.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index 884f1f52dcc2..b1ae9499c0b2 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -40,9 +40,9 @@ enum rmnet_map_commands {
 };
 
 struct rmnet_map_header {
-	u8  pad_len:6;
-	u8  reserved_bit:1;
 	u8  cd_bit:1;
+	u8  reserved_bit:1;
+	u8  pad_len:6;
 	u8  mux_id;
 	__be16 pkt_len;
 }  __aligned(1);
-- 
2.20.1

