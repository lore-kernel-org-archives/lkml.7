Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BC5C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8791A240D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMbzJCif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE2THZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:07:25 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33681 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2THZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:07:25 -0400
Received: by mail-wr1-f48.google.com with SMTP id d9so2562187wrx.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EMWVHKNLHJx2k009VtfJGPtw/+7rslOuZN+Hf86IYNE=;
        b=oMbzJCifRpQVEckVfOqfk25Etld5Z+FILaN45WsutdB4pRyFc7+Ag/VqkrwNMDdbIE
         TL11PGkir1WFM0tr/P1lVLRmAZ36IiMGWOSKYGdFBBpPNjzvRHRV5o3bacBPz4E/2mO1
         ht+A2P1bMpRaa76vY4hBi4rNkBvV59dmQAISJT1mt3gBU+gjWZX+r3hV+uwQ0s6HkQ36
         NhEzGaoigQsIse4Vsep7FAfJlE8/PO25FXVUCe64rWBw1IGj3LGFwQ+vRioikTnkjlU9
         2hwX8t5sCoSZMbIJJ+7RFrJCNCEv9dJRTZLxh5qOtMXckLhzw6ADCggrI6HbN8FzNBLd
         mUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EMWVHKNLHJx2k009VtfJGPtw/+7rslOuZN+Hf86IYNE=;
        b=i7fz2Nf6LvOMzbpwJyqtH3ZockzXqHQHD/xkEkQF0LJCfqN397AwQysWTRjaLqF70b
         RcULhsEt6eC41xzhoG93+cyvMmh8bqEVI2jo8DJ52p3pArA1lCYOoEqSSFa3GfWWbL+v
         pHrSyegXGSV6dt1fIuBjdVslsDEY4ksgUm3u5Of+y4NuPP3dBmtyZKia/tIqzXPurRp8
         0wi3ya8DUu9gLFL4IXRwPs08mkOKWe31Y1XPXlo6oFysQBURbD7YDi2c9m7qDMjydF/9
         H5kTT3Ckedgt92fUsj4f1azIUMqdr/VgY7Ga5j0As/bTRQcYWlknUys4eUvUu6qo1e2X
         dSpA==
X-Gm-Message-State: APjAAAWuzUpTj/UTCgPDAwNOvCqfaZRiKDYB81eWWyVtSQ/nXEoGaZWQ
        F8SceGiq0HIhfwceFPKtLJsgeZw=
X-Google-Smtp-Source: APXvYqz8s4LdTieo3+BWpXylqtpo3ruD5HCbmGBaAYvUdm4j6KseHFnT0lB8r0AqwfB8c1hkz/Rhqg==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr12878095wrw.65.1559156843540;
        Wed, 29 May 2019 12:07:23 -0700 (PDT)
Received: from avx2 ([46.53.251.224])
        by smtp.gmail.com with ESMTPSA id s62sm195648wmf.24.2019.05.29.12.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 12:07:22 -0700 (PDT)
Date:   Wed, 29 May 2019 22:07:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] add typeof_member() macro
Message-ID: <20190529190720.GA5703@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add typeof_member() macro so that types can be exctracted without
introducing dummy variables.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/kernel.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -88,6 +88,8 @@
  */
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 
+#define typeof_member(T, m)	typeof(((T*)0)->m)
+
 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
 
 #define DIV_ROUND_DOWN_ULL(ll, d) \
