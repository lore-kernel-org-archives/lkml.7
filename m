Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7AA20850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8ymL09c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391960AbfHWKG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:06:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36513 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391917AbfHWKG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:06:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so8529854wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDP4l9GmXvFT0nPE4ABIMzRwVlQ6J6G+H/L55vIWn5Q=;
        b=t8ymL09cZ8+uv29LqNMPgps9oKg+f5Dk16oRQLxybKKsd9c8sUzebs0GqeD58BouST
         cq+SEQb+fMkF3bd3IpeQ8FXOFWRq6KzM3tc6c7nEn4gnCOG9TK4NbOKArI8y7AcCkQ64
         6MsmDh3uVrDVYtGvpQr6ka/6tQhFl0Qhwp9nKNbxQCLjjeeS8Mm9ZzR2z8V7RIQKh9ME
         +cUNefGqhOuRc1PRT7VTbuuPBY++usaKcy/N6hBLL7iF2iBTbYNyqTXriLVYzmLpXLQP
         WwACLQ9SYL+hDWhq0bsUQUJ/PAZpPupDGvfBPWMw9Z0gbZtJ+8vjs6vMH+2mAitTagXF
         ELuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDP4l9GmXvFT0nPE4ABIMzRwVlQ6J6G+H/L55vIWn5Q=;
        b=qrJkGANtpidE8qD6EpReE1zDSPpDvZaFXFIcLjxUGpb6zJkSiyrV+8DvuBHLhLd5nR
         q97p9ljCV0RDIFr5LllzPaR040j1Dg5rRdJtxEnEjcnMsVoKbyXIdtKZZaaF03pBit0E
         tfUlBop6oPm8Ys09sqCgL3It+Z1kTay/NvJo8OGTfM9qcgQGQ+DLuUM6s+gd0ERjgS1A
         5uam7Fx+AxZxiEQAT/P1Qj3aTEhSylpOeTn0ZaWGC6H0qmgyh/C6t/fF1koZrxQHMWe/
         CRVxbE0yNZGuJ0ReccUJxS1LdxeyEj6CHUr7/JWAmQFDSIhLRitjtjkeUt3KNHieTV9+
         qJeQ==
X-Gm-Message-State: APjAAAXIrG79qfJ0oo7fukDL6yaC8KGju/4bddFRMrAnfZcov5esy+dl
        /ESv37Gc6dFuWQExzhkLcZvEug==
X-Google-Smtp-Source: APXvYqyN2L8xMX3VGeynzX33CKJbYSodQFsHk3uM+77iZOkkpt3ygbqCI0khv5N14Izhi9IKHWfEZg==
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr4295318wmk.51.1566554815196;
        Fri, 23 Aug 2019 03:06:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q124sm2058048wma.33.2019.08.23.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 03:06:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/5] misc: fastrpc: few fixes
Date:   Fri, 23 Aug 2019 11:06:17 +0100
Message-Id: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

More testing on fastprc revealed few memory leaks in driver
and few corner cases.
These patches are the fixes for those cases.
One patch from Jorge is to remove unsed definition.


Thanks,
srini

Bjorn Andersson (2):
  misc: fastrpc: Reference count channel context
  misc: fastrpc: Don't reference rpmsg_device after remove

Jorge Ramirez-Ortiz (1):
  misc: fastrpc: remove unused definition

Srinivas Kandagatla (2):
  misc: fastrpc: fix double refcounting on dmabuf
  misc: fastrpc: free dma buf scatter list

 drivers/misc/fastrpc.c | 74 ++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

-- 
2.21.0

