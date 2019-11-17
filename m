Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11479C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AAB206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAL3k/nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfKQRZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 12:25:02 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:34420 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfKQRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 12:25:01 -0500
Received: by mail-pl1-f170.google.com with SMTP id h13so8307261plr.1;
        Sun, 17 Nov 2019 09:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3mg4B929k021pDFFZfZsroPj1OaELDXqTHfnRQbTk54=;
        b=rAL3k/nR/SyEPeEbXtfeNLh/FPCVC8U5jI5UxoS5O2wt/SWbQfTDzpq2IwCqqF5bgv
         D9y0NIbIFCqhNRC5wIEy7xHOeE5VeWo1VREBftV3hh6eFq6G+so00raV/zXd7LcP/1Wd
         15pnQJrO8OSrSBAUFfpnV0zJOSC7/cAuWB/LvpQ6EsrMVeCEgQ2GkvLFElXmugM9taP0
         WYhaxU7605IBSmY4wsR/K75YbYFtS7mCPdkjrdJb7Uz8vYGAXo8HWLKgn+rF9esD17TV
         +kTNkVkPaQ/AmB+dbnGXxIKxiyzXPm6frkG6D/Q7XldaC600YxX9lp8asHtFZm2Vm7Cy
         4cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3mg4B929k021pDFFZfZsroPj1OaELDXqTHfnRQbTk54=;
        b=fix3I07H/EE7T3Cw7qfUTFuHBmC0D5OL0Ivtv+oI/6EVTwbOl9CdUyd4ZwqrxuYwOf
         sj91n9CZRqUhdjoW8u4FSf7OrCqgSTHy1hdro2HFmdmE/7+sShhxHTKKs00bYac+DmMB
         W/3FyyCooYXswwW3RpNrgE3G99QDbZsDA0TJH3pGIKWIpHsLt0nZ+moxMmHDiqtu9FuH
         oCzwGYEvNdnB3E96Gau8QY/mQ3+EzGVHYlPeuIG/GZPtK/M4/lWVPrjFAzqa/Ol9HSkZ
         wD+nqKgxOmWyFmd9dge9tppbwcSO+W7V666sG0xF0uDCC2ra+q1voh+ic2gEaXLc8e2U
         jjhA==
X-Gm-Message-State: APjAAAVs2oeC0l6KRkpvlIFxFow/lcWzb/HyW9Mkt/907w0D9jgIcYqQ
        iwVhJ6ofElHO05KEhYlg3d8=
X-Google-Smtp-Source: APXvYqxzEgApSa2STdoF9ak0XLXHbwK/CwNWTpJRxaegReLY76KfXH1CVtwoe36fbS9tpOpEq4GVAQ==
X-Received: by 2002:a17:90a:634a:: with SMTP id v10mr34135336pjs.4.1574011500915;
        Sun, 17 Nov 2019 09:25:00 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1662:ba74:f9a6:2aa3:8a9a:5581])
        by smtp.googlemail.com with ESMTPSA id x13sm18146302pfc.46.2019.11.17.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 09:25:00 -0800 (PST)
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     corbet@lwn.net
Cc:     raven@themaw.net, akpm@linux-foundation.org,
        jaskaransingh7654321@gmail.com, mchehab+samsung@kernel.org,
        neilb@suse.com, christian@brauner.io, mszeredi@redhat.com,
        ebiggers@google.com, tobin@kernel.org, stefanha@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 0/3] docs: filesystems: convert autofs.txt to reST
Date:   Sun, 17 Nov 2019 22:54:33 +0530
Message-Id: <20191117172436.8831-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch series is for converting autofs.txt to reST, and
updating some of the content.

Changes from v1:
----------------
- Split patch into multiple logical changes as per Jonathan Corbet's
  request.
- Few more formatting changes and fixes, as pointed out by Jonathan.
- Add short description of master map used by autofs.

 autofs.rst |  273 ++++++++++++++++++++++++++++++++-----------------------------
 index.rst  |    1 
 2 files changed, 148 insertions(+), 126 deletions(-)


