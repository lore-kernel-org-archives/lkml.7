Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D672222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grq6Vx4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfLKT2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:28:22 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50971 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfLKT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:28:20 -0500
Received: by mail-pl1-f202.google.com with SMTP id s4so2227234plp.17
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w8T1tJgYart3GIn2vBDFWmGy68ONR95xCRrn5VBOMwo=;
        b=grq6Vx4iT1p3AioOKXNrVj+mGC0kw1VP1PMFFA8WmR+nVr2GyjjF2xypwVSeP/CgNN
         s97hKv/BI9N/sK7rmD+m8IHm638StLAWHZVrurD5CXyz+IB2HiwYYJBbZDXr34rdhU+/
         GqSW0Qa591NX4SRHolq7/NDQVXXc1/63Ro+fIj7uAt0ucfkFYLFtROZc0ifzzjenBAv6
         zE/UcxkeO2cfyvbisn9gYEWbxFGZxK2KXfwCAceJ1X+SyqL8GJTAHr/0okFPmItv1yXy
         MulZzpqvLq0KZrAu8q8Jb06Trgk2wRFe9vE3hyH6zr82AaxkJwszmZp7cXK2C0KWobTB
         Lt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w8T1tJgYart3GIn2vBDFWmGy68ONR95xCRrn5VBOMwo=;
        b=sQ7s1MUb4ctMxLuzqC0oFpfOGsCKhLF+q5DL+ri7aHFF9cbtVNuOMXqidP2MTo8rsp
         j3WHtKA8Xfv1sgFk11uI86CGCPKAT1SVX7APO4mKArdp4UbcTypZguFyl9rU+KuTxTHO
         CWoT62Z9tRZM3PLMSkufPRq0CU1jHLAAnV0xMtoIklAXD6LLqt7PAEpr75NuIe1/PGPN
         FZYeIi+t2IhQI62ST8XusRq6J7REL5M5qTuWOqEynubRSOdzZ+l+kZaVp8XVfDb6N3b9
         a6aVVzw+HKiyau2NA0JIem7S6A1ZlAyVHWI9cq84T4mn2Gb8cBxHcz16uCvbSVxlVt6X
         ts5g==
X-Gm-Message-State: APjAAAUl8CRk7VtCo7esQSpR8GoZLZnSVfxGsX4qZQnWISvyg3+fzLWU
        +0+6tIe7sJ3fbB+9mvToTSZVvMLUJfK4aCCBDSopoQ==
X-Google-Smtp-Source: APXvYqwkzzn/pM/huVKkvtemHGMC1edO2ak5A2f9koCyENCr+Vky/i+di1h6KmbXFJ0lnG3qgtT6DNxhUk1251m2lCbSzQ==
X-Received: by 2002:a63:2063:: with SMTP id r35mr6178563pgm.120.1576092500248;
 Wed, 11 Dec 2019 11:28:20 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:27:41 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1 6/7] staging: axis-fifo: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Moses Christopher <moseschristopherb@gmail.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_XIL_AXIS_FIFO=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/staging/axis-fifo/axis-fifo.o: in function `axis_fifo_probe':
drivers/staging/axis-fifo/axis-fifo.c:809: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/staging/axis-fifo/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/Kconfig b/drivers/staging/axis-fifo/Kconfig
index 3fffe4d6f327f..f180a8e9f58af 100644
--- a/drivers/staging/axis-fifo/Kconfig
+++ b/drivers/staging/axis-fifo/Kconfig
@@ -4,7 +4,7 @@
 #
 config XIL_AXIS_FIFO
 	tristate "Xilinx AXI-Stream FIFO IP core driver"
-	depends on OF
+	depends on OF && HAS_IOMEM
 	help
 	  This adds support for the Xilinx AXI-Stream FIFO IP core driver.
 	  The AXI Streaming FIFO allows memory mapped access to a AXI Streaming
-- 
2.24.0.525.g8f36a354ae-goog

