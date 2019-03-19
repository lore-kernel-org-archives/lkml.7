Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB15C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29A42084F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IwLha9oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfCSC74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:59:56 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39972 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfCSC7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:59:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 8BFD9B4B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:59:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yiSDwP_DZwzm for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 21:59:54 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 5B385B44
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 21:59:54 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id k24so14969452ioa.18
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0k4elvOvDCPl71m/NEQTaD+jUr1qhfrb5+lcPPA9l/o=;
        b=IwLha9oi7d+U8A1j4/oqAuuaGNfaHSvp6KezLw46CXQANHEJOnT3Lp6JGVYEuVhksq
         mtVVB3lK0yAzDWjV7NugHi8JpozwnXc0+CPzj+Al9F1inQaUNorJ6pyvWs7uWsBU27wG
         boGh0NNbvVbUesf3dvKjNorhecyBOFBuy/Je7Rsxt5unhyYUPVp8d4B8l7tlGWArBan6
         1eLiWAZHvbOe0HGvmeO0+6d79OsCjm4JhXHFTnTQV3l0E5SWpQVQcLeWhe3Ua8tHQo3n
         kyKitE49gRr3wDtIcN7d3+RCFBC410VXHd+ZS0ldk7xBo5fPg/Rv1F3nY9hdKPdErLIo
         i5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0k4elvOvDCPl71m/NEQTaD+jUr1qhfrb5+lcPPA9l/o=;
        b=IIZHOuHS2Hh/i3g8YZjXbnIB/KO5m8mhN6gRUBm1hKktbXeczKo6uAFvZ9+rj/yFvC
         1FWSJPmCJnZl/yrG0MxfE0XzgzFDwNhY0C0P5GR5NrT3v2cLAgXAq2ndIgF78u+Ptk9k
         IxqbHOHGma2F+1cfLY7238jnYFuWC5fxS+TC7OGLveigaV5mWoKVBS/FiRKNq6pCndHE
         lm1zb1ldwawNWmeVPBSE0S6rY4K7IQ8NbTnlHSkOP7+3KmfC2gh5L3ExXkBOFtqa5cjp
         yqfrI66XMXkHPuRHAEX1aKLFv5xl1v3HeVlAe41l9mUuOe3q6FxV7aFoHseFLcu8eG8S
         NbLw==
X-Gm-Message-State: APjAAAWzfKRCMGou/tjZTyTlJQu6yOa5sg0OtThb02d0nkucgFyC4RVW
        kSOlgTDnJTfo62xwcJhPzh2Q4gxYZtWRCOVAD4lNWLDHE5AGID8uK/MiYIyxziUCsKg37UgVVWf
        hQyJClIQeDvCECgUb9Mhcmh53X3ic
X-Received: by 2002:a05:6638:1a:: with SMTP id z26mr97566jao.99.1552964394055;
        Mon, 18 Mar 2019 19:59:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzmJqgtQCaGefKcVZEKbMAAAraEQp66zKMmFEQB97/XirnUjIcBdX4ju83UwSGGsS2CVD3fg==
X-Received: by 2002:a05:6638:1a:: with SMTP id z26mr97560jao.99.1552964393893;
        Mon, 18 Mar 2019 19:59:53 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id o141sm723811ito.14.2019.03.18.19.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:59:53 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] udf: Fix to check the return value of load_nls
Date:   Mon, 18 Mar 2019 21:59:49 -0500
Message-Id: <20190319025950.18311-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_nls may fail and return an error message. The patch checks
for such a scenario and passes the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/udf/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index ffd8038ff728..1a38271de6d9 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -573,6 +573,8 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 				if (uopt->nls_map)
 					unload_nls(uopt->nls_map);
 				uopt->nls_map = load_nls(args[0].from);
+				if (!uopt->nls_map)
+					return 0;
 				uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
 			}
 			break;
-- 
2.17.1

