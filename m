Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C92C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08F2206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyehQsj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEDJqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 05:46:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEDJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 05:46:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so10771603wra.12;
        Sat, 04 May 2019 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYUTX8c297XneKoeSHCwPD3Tbzv8GCxiVDcwaABHHH4=;
        b=FyehQsj0iz19/S/64W7860H/+PpCUHNoh0SeHhJYj8GrEuvYN8u33g+SiEl074A+r/
         4UzSKxyGBWEV2mgJwwaW7zF0X8mS7c7y1d2rVpTKA4m/Y2Ep6mE2l77pGuNcygUVMnbN
         bgfm8BmqEqyqmnwPs6GKyqIy5QyG87Ypi+t7tgdkSm4Ngr5zLRj1ecRHBfObr3ryrKtj
         L0zxHLG4/kB7tKsd5XvDsPLN9Brtk8lexo4fA+DnQlp/GQJMu+q6feEnbJd/yTsTz1hy
         r4OH+9pqdOWuwEVYc7zbgVeX9hBd+xeendcg7m53Ma2366ykIhgc9y+lMDhwI8Q5HNBg
         yrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYUTX8c297XneKoeSHCwPD3Tbzv8GCxiVDcwaABHHH4=;
        b=njyJj4cVMpwSMkLR/fnJLRktyZXJrk0RaRkbo3VXseuuxvi0Kxdoul7mkPa7hLwV0x
         W+DqD135Bm/anx6/K3TaUsFKbHBY+1fh6z8l67kedehvvOokDSt25bI48+XbeBcVOtmG
         f3u/j3ZOsLdo/Ty2SF4xK/jkQsRn/ajxH4FjrxKkNbrz2ygJrVTu1PtcQphLlq0Re+Xm
         w7AIxSAQtlvagiQApChP025r/w4mEAiKjriBGG1Gw/6v0VbcsMS0difzCstWXEtggwRM
         I/83tqkt16XRmtbnd8nDOKEwUH+04j2Sa/fRg9SpPVh6dFfE7Xq9fzMW4rHuwzAhYlCF
         eJSw==
X-Gm-Message-State: APjAAAXqLFu2x6U5Y0qzHxLBScROZLNro7b++EmZlyECRHVR+iYQffEV
        0tOQUGJ6AIFKX9FRR+mXijQ07DPmKgc=
X-Google-Smtp-Source: APXvYqySDk58+Ey8TwLCmjRFF+pdfssWmvkU1t9Uiz2ydtw5eBduck1epz7H7O7ZWN8IGlOybKXooA==
X-Received: by 2002:adf:90ef:: with SMTP id i102mr8152105wri.133.1556963158730;
        Sat, 04 May 2019 02:45:58 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-179-250-108.red.bezeqint.net. [79.179.250.108])
        by smtp.gmail.com with ESMTPSA id o6sm7624806wre.60.2019.05.04.02.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 02:45:57 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Refactor file_systems to use the kernel's list
Date:   Sat,  4 May 2019 05:45:47 -0400
Message-Id: <20190504094549.10021-1-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct file_system_type defines a next field which is used to link the file_system_type structs registered to the kernel. This patch set replaces the propietry linked list implementation with the kernel's list.h.

This change makes clearer interfaces and code (e.g. the change in register_filesystem and find_filesystem), and eliminates unnecessary usage of * and & operators.

Tested by comparing the lists in /proc/filesystems.

Carmeli Tamir (2):
  Use list.h instead of file_system_type next
  Changed unsigned param type to unsigned int

 fs/filesystems.c   | 69 ++++++++++++++++++++++++----------------------
 include/linux/fs.h |  2 +-
 2 files changed, 37 insertions(+), 34 deletions(-)

-- 
2.19.1

