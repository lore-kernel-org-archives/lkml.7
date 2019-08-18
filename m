Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1959C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881DE2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="unozXp07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfHRJeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:34:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50618 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHRJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so517231wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JciP+sgA6x3vXVEb6ByrkWLVlRaOQlC3JG7PQh8jt2A=;
        b=unozXp074XF5Jan16QB+lXoMD/yvOtXVxk/mDNPMre44U1G03QnVVIbI0oKCbGfrF5
         FZxLMRAnfpuUSU/SGDuRA+0NnwqFDx+GtiBkUNlTcF5JHyY46Pk/gUnS0mr8NJmATAcZ
         AkeHnBRIyR28LqPYnbUs/b8UPczClNuBj9b+QWd+3w6qTLFR6H4gXK34PobgkmZQWc7p
         XFB7u9VhSpMg+vVSx3VGFG1pEYs/O8+mel6fQD1/9xWmuzjKswPL/ahQmqXDxmD83Txb
         3vgXruYYnHJQ644+K16obaYPhg5je3nSo5daAOxtT8Au8RABWGYirfMqRyV/XQE9W3bt
         Ibaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JciP+sgA6x3vXVEb6ByrkWLVlRaOQlC3JG7PQh8jt2A=;
        b=KKcBfLjoWSbm6KSe1+cN5kTyrPE2Bs6P50AfhPFqD7QYF1/ynyw6w7YHoIY8GvzLsi
         E5n+xnj0ExXBtZI4ioBbvmDgXq3NSHRJ+iGPHBV1O7B9ZqA0jrD1Uxg5c/XyDwWeuvEa
         GBnsl7lWtYz8F90bLl0WZTADxZO0phynn33dOJ/CRwfejuVmE1FpFANQHRJZ3BzNDFKG
         aLbnvTOpk0q3smn1lIrZHr5JzpwzDElswdeV0bfyerSQPAFTydiLu1cjSnnr+3XK894I
         F/VbgwST+42VpCKei1oOMr1uvkpBJGAEuTf60HNoGvdK2giFXIy86gFzgZvErw7RDEzp
         1jrA==
X-Gm-Message-State: APjAAAVSgqAQ6yfA0Fusir9DDuvav2XH2fYC647KqtEXwXAaih1ppeBb
        SrYlhSDDVjeGW7JdsMi9RI8zt/cpfdg=
X-Google-Smtp-Source: APXvYqwhQG7nxXKN+IpbWvw7/+afOd1NcqO5Vplx4tbYrOBAyH3YIbL/8fIvNaAFkiKsYWsxtTN1Ew==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr15478693wmj.13.1566120879954;
        Sun, 18 Aug 2019 02:34:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w13sm25042828wre.44.2019.08.18.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:34:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/7] nvmem: meson-mx-efuse: allow reading data smaller than word_size
Date:   Sun, 18 Aug 2019 10:33:42 +0100
Message-Id: <20190818093345.29647-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
References: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Some Amlogic boards store the Ethernet MAC address inside the eFuse. The
Ethernet MAC address uses 6 bytes. The existing logic in
meson_mx_efuse_read() would write beyond the end of the data buffer when
trying to read data with a size that is not aligned to word_size (4
bytes on Meson8, Meson8b and Meson8m2).

Calculate the remaining data to copy inside meson_mx_efuse_read() so
reading 6 bytes doesn't write beyond the end of the data buffer.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-mx-efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index b9f9ce089de9..07c9f38c1c60 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -155,7 +155,8 @@ static int meson_mx_efuse_read(void *context, unsigned int offset,
 		if (err)
 			break;
 
-		memcpy(buf + i, &tmp, efuse->config.word_size);
+		memcpy(buf + i, &tmp,
+		       min_t(size_t, bytes - i, efuse->config.word_size));
 	}
 
 	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
-- 
2.21.0

