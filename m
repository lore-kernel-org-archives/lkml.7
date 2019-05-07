Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26614C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFC820B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207171;
	bh=PmCGJ0NjA0CzWNNs3pQMoJSk+k9SlvmAm0wpIjRrbI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3rq3hJzmCJPNDzn07SPn2ZqKYHptsJRjYQg/bOoZ2+sSZkmMNaiqY4eNcxcVI+Ti
	 mq4TEAA8ZF1RofvyypUx/s/dwp6tAX+Fa0nc2JULJv3Vez4URxeS7JnY0Bcl//iWNj
	 Yp0ky0m1cWZuPnLWw53CyLvIPfINhMDXyqayIenQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEGFcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfEGFcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:32:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69FB2087F;
        Tue,  7 May 2019 05:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207165;
        bh=PmCGJ0NjA0CzWNNs3pQMoJSk+k9SlvmAm0wpIjRrbI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLOd7mYaUBoz7F8oeoAlsf4SYO0prf6UyfQejAudn/iLNx8tD/Ao/WAR5pWVHV9az
         bsau7V9y7DhaYd6KLdw+MffmygNvRo7UB+t/MDSECbKBaJczxV43xf+nCw7Jypetgd
         EINMZoy9KQwFI5m1nR3pDrWMb9+c5svEIWzuiGSM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 06/99] HID: input: add mapping for Expose/Overview key
Date:   Tue,  7 May 2019 01:31:00 -0400
Message-Id: <20190507053235.29900-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 96dd86871e1fffbc39e4fa61c9c75ec54ee9af0f ]

According to HUTRR77 usage 0x29f from the consumer page is reserved for
the Desktop application to present all running user’s application windows.
Linux defines KEY_SCALE to request Compiz Scale (Expose) mode, so let's
add the mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 59a5608b8dc0..f55bfcabd718 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1041,6 +1041,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x2cb: map_key_clear(KEY_KBDINPUTASSIST_ACCEPT);	break;
 		case 0x2cc: map_key_clear(KEY_KBDINPUTASSIST_CANCEL);	break;
 
+		case 0x29f: map_key_clear(KEY_SCALE);		break;
+
 		default: map_key_clear(KEY_UNKNOWN);
 		}
 		break;
-- 
2.20.1

