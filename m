Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6399BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E1B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU8/vVft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCKPf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:35:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46678 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCKPf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:35:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so4295449pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=RXazlCLC+fh5A8rzoHGP/wwJ5mYIgXpL91wntwPhYIY=;
        b=HU8/vVftgSgrcjDC4iI3rpVhwMkdyii723axAkvGwVEp0rdGFG8GhqFOfshDdP2gM6
         Ew2VbsaX8QJVCAMNoqmbCkahw9desLXWnr2XPIFVH+9X+ql+GNss+fZgkexeWMf2UWIQ
         GsBFYWqkrUzH7zVA2+L7zjryn7MwNOORMReAFKCh2hk+NHM1xIATbZkncpKytXMxgV+j
         oNHSScYp4ljM7eGY7dVh+WPaImEPIAT1JpPiHJFkrcnoVhCXCgxbME/Fp9k4hafqoniV
         Oect2xrqNTLbVP1PszRrvznRDuSAUENSz4KPg5tHMjO3hSdl+vRSsJEUnzNc7sI19ubA
         Bfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=RXazlCLC+fh5A8rzoHGP/wwJ5mYIgXpL91wntwPhYIY=;
        b=I7FiixndZ1tFZRg56XwwvlG5MuIitUK4JVYEF/S+jYT6Pt6p3ESjwD4+ZbaYgdyO2b
         hecNLC9UcRS6XEVuQJx+nQmsVsSfhEmBU8pkcQzmwyWvF4HVEdnpP5V4r+YcGvuw1/Jl
         +n4jxIt221PtTYCPdKUhwHHCNfy08nj0soBtBkCpnc9IOAjmuA0nZTbovegGyrHqM1tp
         DFagcykG00Kn6n4Ni0mL/keE0NePEyxmLoDEx0Dmr2cKkdR6FV6vUndJ8QtzszCaE+iV
         WUT11qDd5xpYqRlthF2Zb71suLysbnyzDCz8KK0wm4Fuo7lVbt6v6990joQeAUp5nw5N
         Nimw==
X-Gm-Message-State: APjAAAWtsOnc+ECnHtYahTV44Sd0EddalOJiMkWm/LCzDVoQgEjMr4Ym
        huj7qqcOwkSCtE4c3R0bUq4=
X-Google-Smtp-Source: APXvYqytdj/bkRYSi1csXc8M0KUgIGkhFeEAUCooZtXMCleT2dbNnrWnPITkyJIKiodSgu8KI8/pSQ==
X-Received: by 2002:a62:110c:: with SMTP id z12mr33982851pfi.184.1552318525702;
        Mon, 11 Mar 2019 08:35:25 -0700 (PDT)
Received: from sabyasachi ([2409:4061:2010:45b9:a4f9:f674:88cd:e152])
        by smtp.gmail.com with ESMTPSA id a2sm8347917pff.58.2019.03.11.08.35.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 08:35:25 -0700 (PDT)
Message-ID: <5c86803d.1c69fb81.1a7c6.2b78@mx.google.com>
X-Google-Original-Message-ID: <20190311153515.GA8300@sabyasachi.linux@gmail.com>
Date:   Mon, 11 Mar 2019 21:05:15 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, jrdr.linux@gmail.com
Subject: [PATCH] fs/cachefiles/namei.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/xattr.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 fs/cachefiles/namei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 95983c7..edecb7f 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -20,7 +20,6 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/slab.h>
-#include <linux/xattr.h>
 #include "internal.h"
 
 #define CACHEFILES_KEYBUF_SIZE 512
-- 
2.7.4

