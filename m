Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A8C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DA9214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBEFrbsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfFIMs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:48:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36789 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfFIMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:48:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so3578094pgb.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GWbqPRicVJeNZyyJn+9jqmHZeCWZTUn9+XwG0T4VgwA=;
        b=nBEFrbsYSyLw9JK8mSoYmUtoaLLg1kZvEZE8OZu+2t8xdYiz012j+tncUdTqyRMmL2
         Vla33Vvj9KNr+gCHDZhoVmMbYj3UjaESqHRorsGzAu7UE9sqS3tAptabgrm/97O4GF1B
         wTsxVsf20HOkQuAjjrMIfzdeKIw9FtDeEkfAyPBflHZZZwVyY3mb2hINUfsORmMmLtOV
         4kTjz0P9PCRgbIUaEekduvvYk7/ksvT0PiuV0VnZtikLauCUVx5Oma+KhcW2hra/eo2/
         Eup1QNLhH8VU8lIYU8lbW9Zf5OXSdXKUdCIfeIM0bb8LQSiuzTNTn2Vw4Faw3XR9CVfd
         8/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GWbqPRicVJeNZyyJn+9jqmHZeCWZTUn9+XwG0T4VgwA=;
        b=nv/mK+cIz3SbYtNrc0y3RlYm/A2+iL/SM2lI3akOnbWUGASyDkW2mpl+RqIlvotG1s
         WCxBwrK3XJzD6TT/QppOwqfQAPX5b58w+hLo2yQx0nC4KigHEei2SiCjtCUi2y7IyDhV
         oqAgsbtWE759cjOGVLpKPAJgUr+WgyhZJoCPzqsB7GU3+m9F/tZXrt/Ag238EmXqdi+S
         OzR6mSGAhtTdFdf5IvgepJamjGpKFnyZH0LMT98rVM0MVColHYn3VrxBqCQMbDrh1oFx
         QNivYsN77jRwGlM4HqZSTqAm9ANSHDSCOf7fiAe8NOou9m+0bo3Hv/eKU4GPBeYmVjn4
         kVMw==
X-Gm-Message-State: APjAAAWk2pasHFbECNtwJiRRYPqZms7OGAMcItYW5f0kmvIgmoY9vUT+
        joEv/4ExxYALSsCudhUSIuA=
X-Google-Smtp-Source: APXvYqyQjOzCBZe5RP7vIT0dEkdZZLVUMTUUpxhL+l2jR++vMB14wViUmx7itvaIeQx7782IRbxMbw==
X-Received: by 2002:a63:f957:: with SMTP id q23mr11574838pgk.326.1560084537116;
        Sun, 09 Jun 2019 05:48:57 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id u7sm6991216pgl.64.2019.06.09.05.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 05:48:56 -0700 (PDT)
Date:   Sun, 9 Jun 2019 18:18:51 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Straube <straube.linux@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8723bs: fix warning comparison to NULL
Message-ID: <20190609124851.GA4043@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issue reported by checkpatch

CHECK: Comparison to NULL could be written "!pxmitbuf->pallocated_buf"
+               if (pxmitbuf->pallocated_buf == NULL)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 4e4e565..c125ac2 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -50,7 +50,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 {
 	if (alloc_sz > 0) {
 		pxmitbuf->pallocated_buf = rtw_zmalloc(alloc_sz);
-		if (pxmitbuf->pallocated_buf == NULL)
+		if (!pxmitbuf->pallocated_buf)
 			return _FAIL;
 
 		pxmitbuf->pbuf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
-- 
2.7.4

