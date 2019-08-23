Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F23EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364AF20850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWT3zdvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392059AbfHWKHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:07:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391985AbfHWKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:07:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so8073761wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2Fx0Pb0mc0UlpujkGqHHioGa7pg7ML7uA9l5iVY0Do=;
        b=GWT3zdvdMQpqxhTsdSyx5rYZ7r7eIIXimBJr7ZlqJJ5t47imk0nWYlAn1gNSED9B3r
         E7s/CvY4Indt8y3xgghgQ7D+78yw7yWehSfvJp/wOa9sgq7U9Kmj7bQpeIwe1yyEf54o
         sx7DX55kGrcVQHnmYinDMa9gM+IrZvDvOMHJpOmMbrK3uT2H0wUxZfGKnDoVnHMAztdR
         GfFDR2vU56i5sk3POxaEEbUAKsmrYCUFzq3RIuNO/LZ4NUXHKH9epCKD6Qw/gn4yD0Hw
         IMjVYH33eGd8swVydp+e4Xwtk/O6E3nbwmAdZVmr762o0lhyC/YmyLNoxmFydIoASpZH
         tr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2Fx0Pb0mc0UlpujkGqHHioGa7pg7ML7uA9l5iVY0Do=;
        b=h6z4H9Omvf30lmCUhK7A+muhXuNqQhCxfXdYvOhpSA4thT1IbZIMifpaBYq312y/9a
         Naap6OJzXEszy+PJOI9qhD0G/m9Buwo9KtLfTYLSJn3hVdVaZFgHNTEXoztlijynByTG
         W3VCRRkFmJsYzX7kTqzUiPQOi/BbgkfPvzcEJO7+SULADiZ3kB3f3Yvmaeno8Bx/rV0s
         ETcke3i7yI8y5OcG4R4KStYOmdIDbNAR+s0u0oPzR/tC4//4YTo5ktJio1GAw21syrEv
         ywqjRXbFopAnBErb7PzXDb7SVbJrPab86cFYiMAv/TBt7khaTRX5s2+MYVidLRA75tFs
         lVMQ==
X-Gm-Message-State: APjAAAWlNH2Mi8Y4b97qxIvr0YjflcHEHtFdn82K8cGJuceqDDGMO038
        TuXRJmk0OW7uNcbhJPjbK1Q9XRyud6I=
X-Google-Smtp-Source: APXvYqws3QSflBFeDgNUBiFdOfNkzoR6ZaMTG5i+APCnxUptHlfDifDRBjd52c1x8Z7GPzfIpmKUSg==
X-Received: by 2002:a5d:4205:: with SMTP id n5mr4175583wrq.52.1566554819104;
        Fri, 23 Aug 2019 03:06:59 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q124sm2058048wma.33.2019.08.23.03.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 03:06:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Abhinav Asati <asatiabhi@codeaurora.org>,
        Vamsi Singamsetty <vamssi@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] misc: fastrpc: remove unused definition
Date:   Fri, 23 Aug 2019 11:06:20 +0100
Message-Id: <20190823100622.3892-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
References: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Remove unused INIT_MEMLEN_MAX define.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Abhinav Asati <asatiabhi@codeaurora.org>
Signed-off-by: Vamsi Singamsetty <vamssi@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 59ee6de26229..38829fa74f28 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -33,7 +33,6 @@
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_CTXID_MASK (0xFF0)
 #define INIT_FILELEN_MAX (64 * 1024 * 1024)
-#define INIT_MEMLEN_MAX  (8 * 1024 * 1024)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
 /* Retrives number of input buffers from the scalars parameter */
-- 
2.21.0

