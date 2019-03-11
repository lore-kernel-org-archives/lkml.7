Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E271A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7BHn5Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfCKP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:28:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37923 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCKP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:28:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id m2so4297658pgl.5;
        Mon, 11 Mar 2019 08:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=k99t01FnTowbQW6ZCl0NJtyXLV7y5o0Gwv4+MzhnJfw=;
        b=r7BHn5XzlJsOtG6wIhFqCRguCp2OzW3dwYHHl3+3oL2tj1yt1Msdk4jTkX+B7Lmo10
         SmOmCcU/7Qu4hUdVHRw9d5upabuFP8/nGcV8F44z1z4NhzZbJrt5DrblUYJ5RMSHa02v
         WjRkS0d0S2mEdn5UFXdjCnLoLRWBvorxezA27cwR+3sJB2C8KZpv+9waEV8OilXXPCCf
         zYTd4Qua/t+/fDNQbhnQhROGDy0bBCKYXpCJDZbYj2sU+teeKCdYo6x8s24yTb/Tce/S
         CxFfq4Hf5u+JogUwtxCOyE7AqAYFc/0OgVu9W2SqIUI60UxqvvmoEeKDIhN7gge6XfxB
         SUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=k99t01FnTowbQW6ZCl0NJtyXLV7y5o0Gwv4+MzhnJfw=;
        b=atMwWJB3ldeZ6ujSBejX/6eLR1w435C58AI8P2ls0oEswwN0kV748esAQn+ADsZ1QO
         umFBtscgzjjLUxYbNQMtJwYA44blUQHwwSM7XVpV+fObsq/XaFK8zGDUn5y5xcTOgBGw
         MNjtpqZDQhHYbdQ29AomwheKbaGEzJTs041nCXxzTvrkFB8RcqCT0DU5ILXsDTzOrEs+
         AibI8J2TggRLEcrI+sYdeOvUmHdtBNXu53UwUyvdKuaHH/NMpAaXAj2QON0tB3TgpQcr
         KptNHBS8Rm+MpiJmvo/gEu4wSexcd+q7rmAxB+NkUMUGeqLaWquh1YmYvcfXTo/NTWE3
         cvWQ==
X-Gm-Message-State: APjAAAXbnNX0oOELPf5PcKwLKufzHg36/5lpQDqweFpL/8gpZMIOLeYd
        aMjVZ0tS+DbFTKgMK9F5HQ0=
X-Google-Smtp-Source: APXvYqys0h9qxIZzJsZ4w9rct2p5yu6JIRDSByFEKGHiW9w10zMbZLOEtJH2zm6hcZru5XCG1ACf9Q==
X-Received: by 2002:aa7:87c6:: with SMTP id i6mr33191481pfo.208.1552318102324;
        Mon, 11 Mar 2019 08:28:22 -0700 (PDT)
Received: from sabyasachi ([2405:205:622c:3be1:a4f9:f674:88cd:e152])
        by smtp.gmail.com with ESMTPSA id z7sm14899864pfl.4.2019.03.11.08.28.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 08:28:21 -0700 (PDT)
Message-ID: <5c867e95.1c69fb81.4f15a.e5e4@mx.google.com>
X-Google-Original-Message-ID: <20190311152814.GA7955@sabyasachi.linux@gmail.com>
Date:   Mon, 11 Mar 2019 20:58:14 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jrdr.linux@gmail.com
Subject: [PATCH] fs/block_dev.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/dax.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index cdda48f..8abcdb6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -29,7 +29,6 @@
 #include <linux/namei.h>
 #include <linux/log2.h>
 #include <linux/cleancache.h>
-#include <linux/dax.h>
 #include <linux/badblocks.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
-- 
2.7.4

