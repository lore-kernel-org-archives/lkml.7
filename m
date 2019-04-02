Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F2C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC392084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXTaYdeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfDBQ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:57:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38264 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbfDBQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:57:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so6678636pfo.5;
        Tue, 02 Apr 2019 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xI0wB9w0C3Gk5On5jdR5Bqd5ct26iDtnFQEUERt5ykQ=;
        b=AXTaYdeLmuhh1n9FpUie/ifYztVIE3JUs75DgIxzL0CQByM/iGDjDfg8gcjvSHJXnf
         PWWD5PQurs8BR7FUIaHGJdaI02ww8C8c3PJyorTplG+f3GLoGBfPERgRur9q58We36s4
         0EB3nDc8SWVb4/03cbJ+8+5vo2gAnojD1TXL/yasO9+YfsK/tuzBJLc/U15oSzQMkvau
         m2XDdRM1YZ9bDbcLofoHPeYguqPeNc5o9M/Vok8CHWoCZpYdJiWItfY/TTKxc4gN72sJ
         5KI9uBifqvMFP3qDL5rJf13ptlxI6wAtLo+igYh1e9mc/WpkCsmiCTpRI4TUmZGzYhFq
         1sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xI0wB9w0C3Gk5On5jdR5Bqd5ct26iDtnFQEUERt5ykQ=;
        b=pMwfgdTCFxuolkLmf438ebkw8u1BO7kp3HdB9UZv2jQ7yBl2/lHOV1dyNE9ahMsvyv
         Yg3bL1rYUhHekV42+HQAA/45GRCB4nbC/zqd2ENBSSnjGghmX1/Rpni5xXwHFovLr+1Z
         13KRrMudgG3lA/5TmkgptqwEvg27AFIS/6f7k4c1Bdmw4Nj2MgAQ0v4gkQyN4ZWIFtQ9
         oBYoIJ+GqgZazOuWgk9K11YuYvReTgIeWBantRM1GA53IWb13gpE6Aq778M27GW8mqND
         GQK03rLJWL4lO+7knhgsKPtusBtOqPdbnCBl+6CbB1FWlSHrh4Qbw9QC3FEEM+5lFQ57
         Ofeg==
X-Gm-Message-State: APjAAAXhpNZ4LQexzKcBWMzfPt76s4F7wNollv76YrOtsmQ+DI+T490b
        w4gq7cE4rWzI2T9ZO3mD1IA=
X-Google-Smtp-Source: APXvYqzhNDTy+HFxNl/izkAnJtTp6XbiJqwNQzG2eVQS7uh9P3Eh+EL4VkIfZJPtntesGr5+jLIL8w==
X-Received: by 2002:a63:5854:: with SMTP id i20mr57984277pgm.171.1554224236489;
        Tue, 02 Apr 2019 09:57:16 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r87sm6865211pfa.71.2019.04.02.09.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 09:57:15 -0700 (PDT)
Date:   Tue, 2 Apr 2019 09:57:13 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: input: add mapping for Assistant key
Message-ID: <20190402165713.GA161074@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to HUTRR89 usage 0x1cb from the consumer page was assigned to
allow launching desktop-aware assistant application, so let's add the
mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index da76358cde06..a7046a322ddd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -999,6 +999,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x1b8: map_key_clear(KEY_VIDEO);		break;
 		case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
 		case 0x1bd: map_key_clear(KEY_INFO);		break;
+		case 0x1cb: map_key_clear(KEY_ASSISTANT);	break;
 		case 0x201: map_key_clear(KEY_NEW);		break;
 		case 0x202: map_key_clear(KEY_OPEN);		break;
 		case 0x203: map_key_clear(KEY_CLOSE);		break;
-- 
2.21.0.392.gf8f6787159e-goog


-- 
Dmitry
