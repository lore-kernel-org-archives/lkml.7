Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A46AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 05:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E355D21726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 05:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx/xRliL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfCaFaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 01:30:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45182 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfCaFaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 01:30:39 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so4990446iom.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=z8tehaPDZ+lVU2VLM/ERk0u1K1dfp0io7lPmlULBcUI=;
        b=gx/xRliLQH9rGI9Jp+DGmT5p5XEiGAZDWenSptd/K7iExbOnB+p+v76WrKBj+cuWuv
         egKax8fUMa96HH3kMtABMXI83K3AeFyqAseK/q026UuasKPijHUqApkmO7pHiESC9CsU
         FbvtjnmpAb/AI9eBoBlbiraD8CeZU9bN0lPd+jPiG/SbBwBNcP4gKQCfID0Egt4Ql4CE
         0gGHeSIKsZAmciOoChP/XuS5rp7zuBQ9LyeGDy+odys6zHDnNIJaYBPhm0A2Vh+aIVxc
         tnOH2aInsmo8FUpoxjseN78HNGbagFCA8NkGUgpU8e+zLGOWkVPgmrldSXMTavJ8/hsY
         5Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=z8tehaPDZ+lVU2VLM/ERk0u1K1dfp0io7lPmlULBcUI=;
        b=PWrX2m+3maiZXHKID148vagkR38uQNu7SKK3OxjL3rnhKnc1Tk3dQ3Cc78hFrkDNNR
         UGQrovLlnlHPDhR4HOvDL4NS+ocv+0SmWyVDUkBx3GkzNY0QbNQCUakhZT3XuBAwGkFe
         UjECoCoPiQj/+bji5O/vt7LWPwS3FZRT3HBy6LxivpvGZrO2KWtflAYUYn/vF9CFohte
         yTBCjjPB2ss/OdxPVX2NEYSA8TMYDDtOhvITWVikwAA4wPOeYz50mh8aNmxOyKLq7AeF
         9Sqg6SnREwR/vGozKK+7gfmVaoFASLPdaco3RGvgBjfLj1ea5ARdVBbp0aVR2axVU9ep
         Yi9Q==
X-Gm-Message-State: APjAAAXM/0Cg8Z4PFnOfexjwcLVuSIlMpQ3wfBDf0Q1Qu5JJ72/8U72I
        CQpKHYcMRrGFLtEBas7gm5WdZVMJzsjVuw==
X-Google-Smtp-Source: APXvYqxQixP7SJVyB29FzO8fdvKRL3wHEtXawKkJkJ1XFHW0LfZqe4a9epLXOHU45pjGC+V13N4sgw==
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr36084397ioc.142.1554010238146;
        Sat, 30 Mar 2019 22:30:38 -0700 (PDT)
Received: from titus.pi.local ([66.97.27.10])
        by smtp.gmail.com with ESMTPSA id q17sm3104876ior.5.2019.03.30.22.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 22:30:37 -0700 (PDT)
Date:   Sun, 31 Mar 2019 01:30:40 -0400
From:   Will Cunningham <wjcunningham7@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: greybus: usb: Fixed a coding style error
Message-ID: <20190331053040.GA12974@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line was >80 characters.

Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
---
 drivers/staging/greybus/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
index 1c246c73a085..5b4cbec88159 100644
--- a/drivers/staging/greybus/usb.c
+++ b/drivers/staging/greybus/usb.c
@@ -169,8 +169,8 @@ static int gb_usb_probe(struct gbphy_device *gbphy_dev,
 		return -ENOMEM;
 
 	connection = gb_connection_create(gbphy_dev->bundle,
-					  le16_to_cpu(gbphy_dev->cport_desc->id),
-					  NULL);
+				le16_to_cpu(gbphy_dev->cport_desc->id),
+				NULL);
 	if (IS_ERR(connection)) {
 		retval = PTR_ERR(connection);
 		goto exit_usb_put;
-- 
2.19.2

