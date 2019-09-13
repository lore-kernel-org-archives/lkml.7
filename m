Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB7C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655C220693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRXRlbz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391426AbfIMPZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:25:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390565AbfIMPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:25:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id q18so3212227wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5yU3rghmAwN9MxI/i5JDus3MW7CSOhhz7L0A/VGfFA=;
        b=zRXRlbz0H6w40kJ5AeH9lKO8XkNrQt9ggCrnpQFdy/UDo+Wctu4pYReuEaFyNnBoxO
         szc/J2Zpv9FxCkEdC2Lq/Pyyt6ME00V6EV3atcyX9+BMRZiZ8Cd/R4ymDBtskrsMbPBU
         Ft7xE39tsOMfe3mvI6l3O7sA6eK5ysUNR6j89AzMVJi4vjn7Fl5MFs2sQTRawZE+8PfM
         UIlic3eYp31eqbvYcQLSS6INpc1WTVWHDDF8tPuPPPg3ByEDL6r2rqR0sgU80CeoBUEP
         LA79I//LlvtAm7u016Dx87HPod3KOqNCnKdnMysbX7Oax0XLbXUuQ8mLL3fLIQ0a82kM
         hDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5yU3rghmAwN9MxI/i5JDus3MW7CSOhhz7L0A/VGfFA=;
        b=aILmWuYtf3PwREajxd13BUAJlAv2TOGPfYIbmA5UhgUbzTQpEu6MfrhJPmAb4Wllgo
         PeVLDFNKiJp/FVB6a3DI0/vwvFVNU/Ji4b6DF5xtEd11hTF27LofKxswTcY+MU8zkl2v
         guGc1JuRg6W6YKGctiMuOB8W/lGc5jZPGc+1dXXFVQVEuVbXcNhq+4rYeZOg+dKZZ0AN
         un49mjrXZoEOTJmFX0JbGY1GFZgUyIs6BmK8o08BgEnOA0SLR1XKHlbfQmc0eaJ0j68I
         USOnwGrl7e1Cadbm7gFdMvxk+LCLCzd5YnqP+SXuTQlmhQNhh5fLBILkFtSiZkRJYz/y
         xTAQ==
X-Gm-Message-State: APjAAAUmjKAfxsMxK6kxJ6ih+8mQ+nQnNjCP3zVVp/z2QFyDBOZi7m4t
        LlcfcqbG0r3VkIJ4PLBjt+lu4Q==
X-Google-Smtp-Source: APXvYqzXzTQZgybNMkXGYzw52JEoAUdNUxrVU+VZECFsG/Vil6v52cxi0e+tjHjldZTQxZVfM/DBNg==
X-Received: by 2002:a1c:f519:: with SMTP id t25mr3807183wmh.167.1568388336647;
        Fri, 13 Sep 2019 08:25:36 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id d9sm48717728wrc.44.2019.09.13.08.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 08:25:35 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/5] misc: fastrpc: fixes and map/unmap support
Date:   Fri, 13 Sep 2019 17:25:27 +0200
Message-Id: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

These patches implement a few fixes identified while working on the
QCS404 ML integration plus we now have support for mmap/unmap of
buffers (so the process can be created with less initial memory
requirements).


Jorge Ramirez-Ortiz (4):
  misc: fastrpc: add mmap/unmap support
  misc: fastrpc: do not interrupt kernel calls
  misc: fastrpc: handle interrupted contexts
  misc: fastrpc: revert max init file size back to 2MB

Srinivas Kandagatla (1):
  misc: fastrpc: fix memory leak from miscdev->name

 drivers/misc/fastrpc.c      | 209 ++++++++++++++++++++++++++++++++++--
 include/uapi/misc/fastrpc.h |  15 +++
 2 files changed, 213 insertions(+), 11 deletions(-)

-- 
2.23.0

