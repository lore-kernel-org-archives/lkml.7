Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC809C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CB021874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJgx9NHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDHVnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37944 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id u24so3741853lfg.5;
        Mon, 08 Apr 2019 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KKY0hvaNu4hf+/38bScsuD0e0OCUZpwqA4DSRzmYgk=;
        b=pJgx9NHPnB526rThaTVLN7DxnBghYTAWfbEPcCb5NRjDcb9Jzz22OdbFlad+UJs9yS
         ZnEH8R5V0LUAJqsl/eLzN8C8vWJBzeaXvvTzEfq6JmxPIWQ+zpjedtBHq3kalilJoJyp
         cX2M3EKSQzw6+Ngg63zRLlxdQFsiAvb0V6aG+vL+o59z6WwQh9m8YglX18+YajkQp84+
         VIq2ocv1QgVpGfjxQhSF6mjPmZEE/ro2hjjOR513zfAiuU8M1Sf/TO3Ixyz5Kwr+h76l
         Yk1yXfrWuQZeOeT96ni95ajoOUt6DGIJjk9Zw7HdN/FqlcHY3jzJvD64/9Nj8vd1xr4e
         u39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KKY0hvaNu4hf+/38bScsuD0e0OCUZpwqA4DSRzmYgk=;
        b=Ma59LUFls/2u8SxfGTJ63HymOZy7pd7C7leApBigLl7Qw8EBY4C2PU8DITuTIph0gS
         3RR9jx14VMfb7u60vbfXr9tkXtuIk7bVzU7tFTVR03eXMKh/LRxri6d9dTj6g3K+JrAc
         ie3LQ4/MMs2Ez8CPM0ZfdGi5fMxFxRNWFApPtQbGbtPEzDfCZ6ciF/cQoWsrzc4taWwz
         Gl/57/dHbJECbe6lrcmZPA+3RY0OJglmvSLdxzce+1fEjlnNspgU6EDB0E8K5gZIS3nw
         Gi/hwAStb/RDJsd7Xb/hDlP4FQT/1aWF782Xq7fDA+bo/3LtMGdUyGjD4fxx6FXwY1S8
         NRmw==
X-Gm-Message-State: APjAAAWgUX34jogspm9ZDxr2qw0k6CChcdfhmmzl/RR+gXvCfoRJZFIn
        kdOlktg3QzmJNfNB1e6C5RQ=
X-Google-Smtp-Source: APXvYqzas3NqbQ2ev87n5lDmlOOSWp4jmG4rANBjwWacDXZ9dNj+KAfTMTlZdcKPo8mkmJh/ojx92Q==
X-Received: by 2002:a19:750e:: with SMTP id y14mr1232151lfe.74.1554759785768;
        Mon, 08 Apr 2019 14:43:05 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:05 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 00/14] media: ov6650: A collection of fixes
Date:   Mon,  8 Apr 2019 23:42:28 +0200
Message-Id: <20190408214242.9603-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Janusz Krzysztofik (14):
  media: ov6650: Fix MODDULE_DESCRIPTION
  media: ov6650: Fix control handler not freed on init error
  media: ov6650: Fix unverified arguments used in .set_fmt()
  media: ov6650: Fix unverified arguments accepted by .get_fmt()
  media: ov6650: Fix unverified arguments accepted by .enum_mbus_code()
  media: ov6650: Fix unverified pad IDs accepted by
    .get/set_selectioon()
  media: ov6650: Fix unverified pad IDs accepted by
    .g/s_frame_interval()
  media: ov6650: Fix crop rectangle alignment not passed back
  media: ov6650: Fix incorrect use of JPEG colorspace
  media: ov6650: Fix some format attributes not under control
  media: ov6650: Fix .get_fmt() V4L2_SUBDEV_FORMAT_TRY support
  media: ov6650: Fix default format not applied on device probe
  media: ov6650: Fix stored frame format not in sync with hardware
  media: ov6650: Fix stored crop rectangle not in sync with hardware

 drivers/media/i2c/ov6650.c | 183 ++++++++++++++++++++++++++-----------
 1 file changed, 131 insertions(+), 52 deletions(-)

-- 
2.21.0

