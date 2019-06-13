Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8DAC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B59920665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560445081;
	bh=oRxS3rXLBliH6ljftU1oTejjr7HJ+6gusgCTrBwC6Zg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Cx7RezIv/XkEBpRpaj1rvg/LA+AxwrJLti+3KfK6NHAHa6gPgI8L0LvGeWbeLOU1n
	 9VFcbgNgKAJllfMixh/Hq903ffREW/XHWKwCsL538g+yt/WTwgWdz8veh9q5T/OSYO
	 U2yal0ZgKXshfuwfWsqDcsDNSGPui9csvcfffG3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfFMQ6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:58:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41898 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbfFMA40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:56:26 -0400
Received: by mail-io1-f67.google.com with SMTP id w25so14564514ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 17:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkcj3BQbpEkEnqOK+uHZ7nr7fw6gEDD/oUsx/9wwTd4=;
        b=LqRWBI0hJrcjJzYAivHAYqULbk0CIycXU6i0jDc7csOonzYn6F/eeIy4evS/8Rw+EA
         sOzowtAp8cRe2oAXrmK2oANmfRCc1RlcIo4SgG47KhoiW2isPpYm/15picKHGP1JLbbD
         KvSfq6QRyOmULADX6DtLp/hFsQeg/7lf+TwiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkcj3BQbpEkEnqOK+uHZ7nr7fw6gEDD/oUsx/9wwTd4=;
        b=X+xSCO/tZYKOXN9a8zCe9HJwQWty9nVC8fDzvbYdBC4JYAi0oEjCjtYE6o69uvIjxC
         MBVihZzZqp+RMaMC9MwTfIRPTk8ks3dczEokrLU+bEui6oGPR/v5gEXh5pPdJiwCRD5n
         n/LZMSMpC5FJYPD3OrXL/NEmGGkIvpUdJqGEgsJ1SzqWhPhVd8FWFcWGfZwDoMMY8TAU
         gANOIH/5BDkDFsEp71zTyb0nZJH2jOu5JZYQgWUvZ/wt4jP8zC8GU3K3V3G1fyv6z+5J
         3Bi7+IDyj5t+Urtdqq8bOTuwrZFGUqHeVIRZVjL8kwocULJcIx+uoAxn3rKMCkgCvlOe
         NiaA==
X-Gm-Message-State: APjAAAVew/uswqBNqA/oJUvmdhMTYQGyDb2YLIUyku2SI5OpiJCs7G6V
        HLrjZyH+fMWXfMU4hpBVZOWwNQ==
X-Google-Smtp-Source: APXvYqxvC3zECoViy2agAnshwbumcqgc2CkHnX9zeTiVO5ngljLDWmHjYttKZ6NbHlppewno3l4rFA==
X-Received: by 2002:a5d:9047:: with SMTP id v7mr34272949ioq.18.1560387385204;
        Wed, 12 Jun 2019 17:56:25 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f71sm723185itc.5.2019.06.12.17.56.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 17:56:24 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: media.h: Fix shifting signed 32-bit value by 31 bits problem
Date:   Wed, 12 Jun 2019 18:56:20 -0600
Message-Id: <20190613005620.7362-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix MEDIA_ENT_ID_FLAG_NEXT to use "U" cast to avoid shifting signed
32-bit value by 31 bits problem. This isn't a problem for kernel builds
with gcc.

This could be problem since this header is part of public API which
could be included for builds using compilers that don't handle this
condition safely resulting in undefined behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 include/uapi/linux/media.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 9aedb187bc48..383ac7b7d8f0 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -146,7 +146,7 @@ struct media_device_info {
 #define MEDIA_ENT_FL_CONNECTOR			(1 << 1)
 
 /* OR with the entity id value to find the next entity */
-#define MEDIA_ENT_ID_FLAG_NEXT			(1 << 31)
+#define MEDIA_ENT_ID_FLAG_NEXT			(1U << 31)
 
 struct media_entity_desc {
 	__u32 id;
-- 
2.17.1

