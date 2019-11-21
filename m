Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301E920672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f/yitGOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKUU7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:59:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41264 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKUU7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:59:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id 207so2235494pge.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8Oee3vw8WRriKUoe5bSDCmHamPjslpnmApMeu92EjOg=;
        b=f/yitGOmaX1zVyf8c9dnjx1HQ0qr34w/JLsFbCb0RzFmfXL8vdk+ZDfAVW+GG2CxFr
         gPs208G9vnH8kUUxhpv4iW3DRbhVF/MU9iIgqExyDU0pW+KfXk18RsptF8ZEaIr2FJ22
         dPlXj0aJkD2/blKkCxO5n76q6ZOebV6QRErZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Oee3vw8WRriKUoe5bSDCmHamPjslpnmApMeu92EjOg=;
        b=BMpGiH7AGeXrchuWmk1VqjZW1t6W0v4LMvHHe+XX6p1MeUxKR478fFd6szj0WWw51/
         rxM+AjZvIjQY+H1psJVDISl3fwgAXbK1/3FLZihPn5ljnTkKPeCib+Fux2XohS37kclo
         qo5HRgt2+U//mvKFsz6SFvcmOWoXhVDL8iNxUxfO2W35+RdwRLsZvpuXik8OwAieTzGc
         Kgf7LeSOSIE6dwL+8TMNNZTpIvnudA/0kGkS7dgVO0xUKiXMoBIKGnP6pff9YFOWtF7r
         AA8/LXhY9TSFQGt/gFh0/LH9AfBAQtngo20DznAwvnSTS7di3jUnH/Yol3dDZB5fhxZB
         5BjQ==
X-Gm-Message-State: APjAAAXWo675tY7oo6t1z4f++IOU3Lvy9iTN/fza25Rdh2e6tyMu4J+l
        UJy1NzGBwvErwuZl+Qr8Ls9x2A==
X-Google-Smtp-Source: APXvYqwL0OXmzN8/bfX694dBzdWxuxxtGXMPFhfm81eIowKKqapauOLMdkt26IfydJnmN7bOoWrzWg==
X-Received: by 2002:a62:2bc1:: with SMTP id r184mr13133526pfr.88.1574369973119;
        Thu, 21 Nov 2019 12:59:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm4658805pfg.3.2019.11.21.12.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:59:31 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] docs, parallelism: Rearrange how jobserver reservations are made
Date:   Thu, 21 Nov 2019 12:59:26 -0800
Message-Id: <20191121205929.40371-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
    - correct comments and commit logs (rasmus)
    - handle non-parallel mode more cleanly (rasmus)
    - reserve slots 8 at a time (rasmus)
v1: https://lore.kernel.org/lkml/20191121000304.48829-1-keescook@chromium.org

Hi,

As Rasmus noted[1], there were some deficiencies in how the Make jobserver
vs sphinx parallelism logic was handled. This series attempts to address
all those problems by building a set of wrappers and fixing some of the
internal logic.

Thank you Rasmus for the suggestions (and the "jobhog" example)! :)

-Kees

[1] https://lore.kernel.org/lkml/eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk

Kees Cook (3):
  docs, parallelism: Fix failure path and add comment
  docs, parallelism: Do not leak blocking mode to other readers
  docs, parallelism: Rearrange how jobserver reservations are made

 Documentation/Makefile                   |  5 +-
 Documentation/sphinx/parallel-wrapper.sh | 33 ++++++++++++
 scripts/jobserver-count                  | 58 ---------------------
 scripts/jobserver-exec                   | 66 ++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/sphinx/parallel-wrapper.sh
 delete mode 100755 scripts/jobserver-count
 create mode 100755 scripts/jobserver-exec

-- 
2.17.1

