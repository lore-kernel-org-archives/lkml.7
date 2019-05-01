Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA49CC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694BF2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0X8dbtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEAOG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:06:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40108 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEAOG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:06:28 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so9921267itb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E795LI6DFPTjELna7wlroDOyVglvCzshh15J6Ms0wog=;
        b=Y0X8dbtpTJH88c0UyuELfUtVSgnpvcgCOv73m6I/PeXDyk+qjzYKemxyxfx4FXTVai
         on2+G2znWnUGCfCxV9mmb09yvIKARMfY1bqaYwTJ/GlX9WuWSFcgWoIbnWrQ2V/WeF7N
         /mI8gxnzHGN29OXPObhc1gi9bvcmaMNKgK7NDcfECIb/f7tjSpn/z9UPGk0l80e1/TWY
         b6l/p6YuHG/wbRz/e7R0otPBp2dJTO4BzOFVQEQesgHLiBu2VKixDM/HhU9vQz96XyAP
         a41z1l3MR0SjzZ3Qh1th+RTgvsL43tTxJmca4+gv8LFylzXe0EsdMDvIurWJf/7/fx8L
         Z0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E795LI6DFPTjELna7wlroDOyVglvCzshh15J6Ms0wog=;
        b=LZbf4lzfjozzpTsVlgc/o1D8trycxXMgnCh9Jhorx8q1yxnsTJqsKrzc2W80m0szpX
         cnna5caeGL3ss0Q2gfG8IGhusccGD17BZIyX76T2ME0ysIEiOb70reTM723cfon8T13F
         ayTtIyDCrJgIGJIvgBs4YKOAb5iYlHr0gQcs4NukRR83sjzeRqOIejXzgX1HO6Y53uWk
         56XXKeZLI3Ffd07eCVaDiKkBj33zVEmhqWTZ18GHNQY+RG+CQxQ3T5iNRM4U4CVwmXVq
         Y/AUHu2yBid4SVhPqQXkrbXpD9YYBvnBxVLWNXwXNWmvY86gWAlFnrvX+jQZ3oH7sS9Q
         3Qxg==
X-Gm-Message-State: APjAAAVau3XbPP/cWUDHXVJzOHphVfQa/QpUH5KC6lWJb58HrwqS/CGg
        dWRXyRnfKL2TXAW4XYKau6O14kYm
X-Google-Smtp-Source: APXvYqxgL1mDtVg2oA0par6BPfWok5HhVd0uQ5RRYEH+v6yNP7dls5c8kQGAjyiJ3Jyxp7sRmukmuA==
X-Received: by 2002:a24:3246:: with SMTP id j67mr8195403ita.70.1556719587910;
        Wed, 01 May 2019 07:06:27 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id j132sm13466179iof.37.2019.05.01.07.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 07:06:27 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] staging/fieldbus-dev for 5.2
Date:   Wed,  1 May 2019 10:06:24 -0400
Message-Id: <20190501140624.6931-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a4965d98b4d1ffa5b22f2039bc9e87898aff4976:

  staging: comedi: comedi_isadma: Use a non-NULL device for DMA API (2019-04-27 15:00:35 +0200)

are available in the Git repository at:

  git@gitlab.com:TheSven73/linux.git tags/fieldbus-dev-for-5.2

for you to fetch changes up to 7721d1955e07f42670ea761a37b5661626b75891:

  staging: fieldbus: anybus-s: fix wait_for_completion_timeout return handling (2019-04-29 09:35:19 -0400)

----------------------------------------------------------------
staging/fieldbus-dev patch for v5.2

This contains just a single, non-critical bugfix.
It has been tested on real hardware.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

----------------------------------------------------------------
Nicholas Mc Guire (1):
      staging: fieldbus: anybus-s: fix wait_for_completion_timeout return handling

 drivers/staging/fieldbus/anybuss/host.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
