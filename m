Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7BFC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B93A206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX1/htU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfHOFxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:53:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41022 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfHOFxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:53:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so703690pls.8;
        Wed, 14 Aug 2019 22:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0ATp9HjlGiuVTip9k9ZfspyBy/UaIsWwJV5MOixgE8=;
        b=fX1/htU1s96plQYNCEo4OqSD/SE0mV4DdErSm71213t9UmkDOx5Zz8OrvJy0lQCXNw
         Lq/kbSknEt97lp5tKdS11C9VlsVCxKoea9MA6Uq6wBy2f9KcBFB8wKF71m7KwQgxcr7m
         4TNl6cA1K1KdPIk8bhMEAsq8rDd+9MVe6TJg7569LOuSC9yNsltHIeCheYmsI07nDcFT
         hDe+nHbMwx1lSiH1wa/ngTouF1Oau8501pjU+2D0QrolnMMuM5oDajmaAn04OX/xgGLx
         5KU950Icz0rC4AetnFhySxU5nssCdye0rd/rggAucQOmBcjW0EYHSyiIDxdfLiu7J1DO
         ao3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0ATp9HjlGiuVTip9k9ZfspyBy/UaIsWwJV5MOixgE8=;
        b=skaHA/wavy87an3peGo2BpPJ1SsRhCD4XY1PWEHttU34KK8gUmcp/TucezTxDU10iK
         t61YfooNR7u9WdVS1HMGx6uOKqhNFmDlpjuxh6Xa0Nj5HYBKpjYdUdk0A8DG7YrzJcnb
         3v77Na4LHMvjt1K7Pa+lPwx6aAUWQbHp6untSZJdonnMhfX3rRLIkYvaS8Kn41QrkUY1
         exwKs40b6T2vs6a6Ijtzz1uWvyqm1MnrYpRSY4iunAN7vjeEJCAu3AZkIcfBcWIkGLTV
         6veAPFw4Wpo9P/eJISrQYlpSyaL3c+BUugwQ+cjYAaJSOc4ZTnApDAgzT4VOdsW+P4kN
         vJRQ==
X-Gm-Message-State: APjAAAWf24lZHenqsF/aw0DimmcOeqE/TVXLoY4SsGFpkD1nNNqez2S/
        /EE3zf/Kc5Ar64xo9TosBbI=
X-Google-Smtp-Source: APXvYqzEcC0Qfmgo4HlDcGAv8vuyzzfy2uV07QqVEUqvGtbsmugCbp2dQUrhlxBgibCRD+8HF2WC2w==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr536040plo.258.1565848392301;
        Wed, 14 Aug 2019 22:53:12 -0700 (PDT)
Received: from localhost.localdomain ([110.225.3.176])
        by smtp.gmail.com with ESMTPSA id 65sm1841483pff.148.2019.08.14.22.53.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 22:53:11 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] Bluetooth: 6lowpan: Make variable header_ops constant
Date:   Thu, 15 Aug 2019 11:22:55 +0530
Message-Id: <20190815055255.1153-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variable header_ops, of type header_ops, is used only once, when
it is assigned to field header_ops of a variable having type net_device.
This corresponding field is declared as const in the definition of
net_device. Hence make header_ops constant as well to protect it from
unnecessary modification.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9d41de1ec90f..bb55d92691b0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -583,7 +583,7 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_start_xmit		= bt_xmit,
 };
 
-static struct header_ops header_ops = {
+static const struct header_ops header_ops = {
 	.create	= header_create,
 };
 
-- 
2.19.1

