Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A7CC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3782072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOAHpvD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgAIEmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 23:42:38 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44896 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIEmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 23:42:37 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so5665155iof.11;
        Wed, 08 Jan 2020 20:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MYw+qe9+3iQrY99XLJ/14FeCGv5Cf0+Xm8g2s8/ZF24=;
        b=mOAHpvD92bOlmKmPB69xojfG5yU2MCplQSwKXDmmGYj/y9pwEVqD2pPLJuGatOKefT
         pCjyHqgt8agznhXv1akuQOcQXpNWt3Oy8UvR7Oi2KfMk9YZHSwlsJiIdaJqaupV/Wfhh
         a+PSSRhyAnLOTSlUTCL/bzQITNv9EFo2d8Dt/UUme0OTeIXXMSdzaciYBAmTVQj8ojCV
         VzX4A0CBV2WNYPFJQ4TUkFGOuwGKHeJnDzcHUTTg8HWf0pmafqGIXxBZ96kBTMDkPmYV
         J/Tz9SWY2IsB7YTfnYL7WxuHygU8fJgOUPynI1LyvRn1uqURFWKGAPU9cQqMsH4XVzxw
         Y+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MYw+qe9+3iQrY99XLJ/14FeCGv5Cf0+Xm8g2s8/ZF24=;
        b=arAHJGMLEd/9hBBOWUrihjvlAVmbCFcqr4aGSJfojIAOq/VnsldZMXmvSY9jLJEO59
         Fs8gQAhruMer5jy8PFwmpD5JETBFC2BZCcDU53zv5olOjsuF67dj2VvjtY24rGimdevn
         3kk+/WkEmnWg0UD8Z+UvODKfTYM1cXanbQ5nyM6DxWqNbJzWql7jl0kn3uwR3PBYY+dU
         mauoENcd/waHtlh9Vfq0Ayt3aE19F4ToktgFrIdcbPbkQSATPSdRApxe7oDvr2VNGL++
         Lq7dYOYdpgG8/dxB4Ozk1J3jmS5wD5VotkOaO9XTMqp+TUO/UrDpf1cvKBWsrRIxIj7M
         Xqpw==
X-Gm-Message-State: APjAAAUOyM/9tnTnwrXDEf2OrR6X64Z15+/QxniNpatHxM9dW/N5brqK
        dTqMLnMGZu9IZVHJrTVcF+s=
X-Google-Smtp-Source: APXvYqxRXXSDl+h+yNJskDo0hvVMLV/KY37ebL8QuwCdA8HaBsSCtn9gguuqDZ3qMe3ToNAWO55EqA==
X-Received: by 2002:a6b:c9ca:: with SMTP id z193mr6061356iof.276.1578544956991;
        Wed, 08 Jan 2020 20:42:36 -0800 (PST)
Received: from localhost.localdomain (24-246-92-100.cable.teksavvy.com. [24.246.92.100])
        by smtp.googlemail.com with ESMTPSA id i11sm1148602ion.1.2020.01.08.20.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Jan 2020 20:42:36 -0800 (PST)
From:   d.changqi@gmail.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changqi Du <d.changqi@gmail.com>
Subject: [PATCH] bluetooth: btbcm : Fix warning about missing blank lines after declarations
Date:   Wed,  8 Jan 2020 23:40:19 -0500
Message-Id: <20200109044019.53134-1-d.changqi@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changqi Du <d.changqi@gmail.com>

This patches fixes two warnings of checkpatch.pl, both of the type
WARNING: Missing a blank line after declarations

Signed-off-by: Changqi Du <d.changqi@gmail.com>
---
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 8e05706fe5d9..1ad98bd65a98 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -36,6 +36,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
+
 		bt_dev_err(hdev, "BCM: Reading device address failed (%d)", err);
 		return err;
 	}
@@ -177,6 +178,7 @@ static int btbcm_reset(struct hci_dev *hdev)
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
+
 		bt_dev_err(hdev, "BCM: Reset failed (%d)", err);
 		return err;
 	}
-- 
2.14.3 (Apple Git-98)

