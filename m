Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0640F20830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1Junbl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfIMFvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 01:51:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38838 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfIMFvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 01:51:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so30707014wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 22:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Phaw5vbTT2faE0N3gJYnU+Jk+6mkAT8/6QLIHkDqelw=;
        b=n1Junbl+PAAZAQDIPZK5uCYARN4Il+YCpwChpr2oNQQ/fP6+kYqUaUmkGkk70Y0tja
         Q5hx+8kvb7FdV3kaQYo4PdOCoywynD4zVtl24jnqxOVHta064PTIy1KZZvCuCWIRlwUi
         bwmJ0jVW10DKFf/IqA67ybeyPxW6EQYIPAv6ivjUDpecnj6EyRTfH8ufY+vcLQ2oijC/
         Jzm9TJKV1lJe21DUh/wWh/gpOaYNePyjCtNBXWaORspnGSwCM7+Uigo4px77MrZ17ZNv
         n0Z+2il/JAMxWNZzJTwoUG5nHMBFD6kJW5xUgNdSYMEcZMhR5EdK/qyQpjXhe0gqSQhc
         pyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Phaw5vbTT2faE0N3gJYnU+Jk+6mkAT8/6QLIHkDqelw=;
        b=QvGxG0o8oajwS8qxhqfyZgxIlicdVgDtdp/pji9FSejl6R9UiyZYSq2iCNTKc4pMbZ
         9oGoF0HWqsUcLfSXJlhPCMaxTcrFCh9RJBYOyw8UA6p3v1chxXLF9eitzf9Zc+oEJO7Y
         qHqPyKeQCRGOI99VSyrG1HkjxibbAD9QpdkmPbWiMpJSOlF4hleYMFfLLUggP7g6rNTi
         wuljDGkf7jwffVSHEWHEwamIhlJNLd1RD0JFjTij+DYp7Buk89V39yC/kW/xWM87Vjz2
         hD8HkGH7NWpEj+5daKaTv4UHAaqxfaQVppgmt5D01jO8mCyqoqc/fuKQM6nBTG+OYPdi
         XOmQ==
X-Gm-Message-State: APjAAAVRLieboMG8IRPK4xyZmUOuR66qNjYCohiWHaSzz9y59Gq0VCX4
        jD+eN5vNXiyJnEKMv98r3VM2Trz4
X-Google-Smtp-Source: APXvYqxD+ywAwmLzUEqqo3xtMGt3wUdwMno0tLYEvxObOX4qB9I3z8Lk53z/BkFdH6spnuGDE8Qo0A==
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr2611823wrx.171.1568353857634;
        Thu, 12 Sep 2019 22:50:57 -0700 (PDT)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id h125sm2429279wmf.31.2019.09.12.22.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 22:50:56 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/etnaviv: update hardware headers from rnndb
Date:   Fri, 13 Sep 2019 07:50:36 +0200
Message-Id: <20190913055052.25599-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the state HI header from rnndb commit
a04283591a8a (rnndb: update MMU exception causes).

Changes in V2:
 - Only update state_hi.xml as suggested by Lucas Stach.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/state_hi.xml.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/state_hi.xml.h b/drivers/gpu/drm/etnaviv/state_hi.xml.h
index 41d8da2b6f4f..0f93dbbbaaeb 100644
--- a/drivers/gpu/drm/etnaviv/state_hi.xml.h
+++ b/drivers/gpu/drm/etnaviv/state_hi.xml.h
@@ -8,17 +8,17 @@ This file was generated by the rules-ng-ng headergen tool in this git repository
 git clone git://0x04.net/rules-ng-ng
 
 The rules-ng-ng source files this header was generated from are:
-- state.xml     (  26087 bytes, from 2017-12-18 16:51:59)
-- common.xml    (  35468 bytes, from 2018-01-22 13:48:54)
-- common_3d.xml (  14615 bytes, from 2017-12-18 16:51:59)
-- state_hi.xml  (  30232 bytes, from 2018-02-15 15:48:01)
-- copyright.xml (   1597 bytes, from 2016-12-08 16:37:56)
-- state_2d.xml  (  51552 bytes, from 2016-12-08 16:37:56)
-- state_3d.xml  (  79992 bytes, from 2017-12-18 16:51:59)
-- state_blt.xml (  13405 bytes, from 2017-12-18 16:51:59)
-- state_vg.xml  (   5975 bytes, from 2016-12-08 16:37:56)
-
-Copyright (C) 2012-2018 by the following authors:
+- state.xml     (  26666 bytes, from 2019-08-13 11:26:49)
+- common.xml    (  35468 bytes, from 2018-02-10 13:09:26)
+- common_3d.xml (  14322 bytes, from 2019-08-20 20:31:50)
+- state_hi.xml  (  30396 bytes, from 2019-08-20 20:34:03)
+- copyright.xml (   1597 bytes, from 2018-02-10 13:09:26)
+- state_2d.xml  (  51552 bytes, from 2018-02-10 13:09:26)
+- state_3d.xml  (  83505 bytes, from 2019-09-06 09:32:54)
+- state_blt.xml (  14252 bytes, from 2019-08-13 20:00:42)
+- state_vg.xml  (   5975 bytes, from 2018-02-10 13:09:26)
+
+Copyright (C) 2012-2019 by the following authors:
 - Wladimir J. van der Laan <laanwj@gmail.com>
 - Christian Gmeiner <christian.gmeiner@gmail.com>
 - Lucas Stach <l.stach@pengutronix.de>
@@ -48,6 +48,9 @@ DEALINGS IN THE SOFTWARE.
 #define MMU_EXCEPTION_SLAVE_NOT_PRESENT				0x00000001
 #define MMU_EXCEPTION_PAGE_NOT_PRESENT				0x00000002
 #define MMU_EXCEPTION_WRITE_VIOLATION				0x00000003
+#define MMU_EXCEPTION_OUT_OF_BOUND				0x00000004
+#define MMU_EXCEPTION_READ_SECURITY_VIOLATION			0x00000005
+#define MMU_EXCEPTION_WRITE_SECURITY_VIOLATION			0x00000006
 #define VIVS_HI							0x00000000
 
 #define VIVS_HI_CLOCK_CONTROL					0x00000000
-- 
2.21.0

