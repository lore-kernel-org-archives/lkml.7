Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1D0C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542C6217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcVosbsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfICDHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 23:07:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33626 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfICDHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:07:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so8312479pgn.0;
        Mon, 02 Sep 2019 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uAKNKTEPFk1mVQ1+Q6BKvm0iGSLi1ciDyCpkJPyNehw=;
        b=JcVosbshXiWymuUsBObokDYauCjKU0VfvBpioyzqVuMAnCQa7+VwRDf+RMdak46X50
         0BUJRroacR9FuBp0fDFKXksCsM4Fun6pP3Pv1SRjd75caVrPdLf2uWWx1xsZLY+KyEC3
         603x6XoemMEs7vA7XneTM7pKK2Mh6ymiAgupVzhX+R8ynUeO2hZ22m+FPMZ4InGtLsY6
         vEq2BgODhmHOcSfgqlObA/l8BVOZ0i8AeAILu81RuWm4n8gtidq+b2tuLXOzyj4D+MOA
         9ayRDZD/Wfx1Qri0sM49idSFxrb0XD5Bd63CGxbctFSWLbgg+nJqMXdBcf+vi775X4Ib
         kpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uAKNKTEPFk1mVQ1+Q6BKvm0iGSLi1ciDyCpkJPyNehw=;
        b=ETx3asnQEoo3V9NRHIZlTN8O/cUmqIlLRG0S+shHQOtJ4yHjFGhmKKk3SGHBaSLerH
         LvupkP+KW+cZv2YCvRolzl0Me7Xy14EF5pMhjYxbxTVnYOfzsw9amM4VYqdmgwrLbVas
         MtrBOxxJn7FmxpkOrF9tDyfhm53F/hrR4lbvy5lhQjvgbIIyn96ikSDTPUXajLb2mtNY
         Ql1BqsZKSxppDwEZ0OIzpl/yidOHKD0Br1ZKtJyOuFxfloEIWv6ZTJVMQ8bCY0dTAXBg
         eMK4ZYFDJO5ixXKbGbFDVOn4aE2W6VQ9DKeIl/3Nh4fFajAY4MKfIpZ3LnrAC8RscVaP
         iHRA==
X-Gm-Message-State: APjAAAXVMvIBHDaGSMnil+966yOphezPT5MOwkg/AJA2E+OREVa8VsCJ
        AoTbtF8tOuw4UxYqNipgBsLYfJs7Z0k=
X-Google-Smtp-Source: APXvYqyItemcIN/Oa2zFnFhC5SQ+uWBBZu0bF3vV7xBRx1fvs/iqvGRKUr1GPfi5PJEblut+UBD35w==
X-Received: by 2002:a17:90a:248c:: with SMTP id i12mr10389198pje.130.1567480055910;
        Mon, 02 Sep 2019 20:07:35 -0700 (PDT)
Received: from [0.0.0.0] (82.ip-201-30-69.topnewsphil.com. [69.30.201.82])
        by smtp.gmail.com with ESMTPSA id g18sm14703807pgm.9.2019.09.02.20.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2019 20:07:35 -0700 (PDT)
To:     harryxiyou@gmail.com, alex.shi@linux.alibaba.com
Cc:     corbet@lwn.net, robh@kernel.org, mchehab+samsung@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   lixianfa <lixianfa.official@gmail.com>
Subject: [PATCH] doc: arm64: fix grammar dtb placed in no attributes region
Message-ID: <3fe85082-6788-c693-c18f-4c029a3d093c@gmail.com>
Date:   Tue, 3 Sep 2019 11:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix grammar dtb placed in no attributes region.
This makes Chinese translation smooth to read.

Signed-off-by: lixinafa <lixinafa.official@gmail.com>
---
 Documentation/translations/zh_CN/arm64/booting.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/arm64/booting.txt b/Documentation/translations/zh_CN/arm64/booting.txt
index 4e373d1..5b01641 100644
--- a/Documentation/translations/zh_CN/arm64/booting.txt
+++ b/Documentation/translations/zh_CN/arm64/booting.txt
@@ -67,8 +67,8 @@ RAM，或可能使用对这个设备已知的 RAM 信息，还可能是引导装
 必要性: 强制

 设备树数据块（dtb）必须 8 字节对齐，且大小不能超过 2MB。由于设备树
-数据块将在使能缓存的情况下以 2MB 粒度被映射，故其不能被置于带任意
-特定属性被映射的 2MB 区域内。
+数据块将在使能缓存的情况下以 2MB 粒度被映射，故其不能被置于必须以特定
+属性映射的2M区域内。

 注： v4.2 之前的版本同时要求设备树数据块被置于从内核映像以下
 text_offset 字节处算起第一个 512MB 内。
--
1.8.3.1
