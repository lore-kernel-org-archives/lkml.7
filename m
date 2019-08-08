Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C036214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyQVFXvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404830AbfHHW1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:27:37 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54561 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404609AbfHHW1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:27:36 -0400
Received: by mail-pl1-f201.google.com with SMTP id u10so56244627plq.21
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SAgL5jWhKshtX+Ve/3etoFoiXzS3zGjwWIhCQNMQlx8=;
        b=TyQVFXvf/kFQ0bvQ86SWxMEjt4o9KrYaB+Trgezb/Bcgjgn4vD2RJXh/9mMN/R+1g3
         zWjumVbsW1O2SwO93Wvk/2d2HV6gdkTyaYAVxyxE4HDOLaVkN2oUDXmF0WNrUvEdpGWe
         LTLS9MRc/w5cd3uwG/VBZwwv9LOQvSWGwjvCQoHGZ5QyWGilhKZ7vM9KrrUm/+bGwzeg
         YoXbiHjuP3uh8yYk85R08bO6EzqzyUM3ZahO/W1m85nsTtxGqTnaiKrzk5PA9mEWh+Nm
         o+OYx5YirPiUtLnWfU+7rzT/Ff/lPWKk/r2NhGnIycply2w962dtHbE+ogzZVKGMhrxp
         fO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SAgL5jWhKshtX+Ve/3etoFoiXzS3zGjwWIhCQNMQlx8=;
        b=DLpXYq5YLdhxgvNcLE4IheT/i1j9ZkZb5uowO8duB4WSb7FNQNgFjmCEye2tqrvDAu
         1ZRnr9XQBYLrSu9h4wXVdCXqaC6rHDKbgAJkjMd9LVbLVvoUr5dGVui8zf8wwSJ5cpBB
         LXhbu2GM5s+s+6v9QcPoClfQKVeeRttXX0eXhiE5p+LHy3UaquzizJ3Jv+QU4inGhBlX
         OFE0mjDq0I3MBwahj9H3NVJj8NiQICoGaHUvgSM3l0Y5CCqCjl01vamwO+C9iGDitywU
         h0FM4o1+7xF9bq99UZzsdc14zML8Xwq9Y/t2+cQOLadIiNPBxlxPlHqeVo8Bj44/UQZW
         1vQA==
X-Gm-Message-State: APjAAAWb4dkUcPcOhW72HnlSJ4yD3VTAJAhf/C5hK7s1OGDAPCCVzbrR
        5bModBTXABe+8pamQ5AphDmMPMeXl8g=
X-Google-Smtp-Source: APXvYqwu5frW+Wzs28+LrFXoDWWdYZ9T0FrWU2oqJjGiJYltMdSIViaX5d2+U7k19kcFScW35AoYhkkpiOU=
X-Received: by 2002:a65:6904:: with SMTP id s4mr14655909pgq.33.1565303255834;
 Thu, 08 Aug 2019 15:27:35 -0700 (PDT)
Date:   Thu,  8 Aug 2019 15:27:24 -0700
Message-Id: <20190808222727.132744-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v3 0/2] Add default binderfs devices
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binderfs was created to help provide private binder devices to
containers in their own IPC namespace. Currently, every time a new binderfs
instance is mounted, its private binder devices need to be created via
IOCTL calls. This patch series eliminates the effort for creating
the default binder devices for each binderfs instance by creating them
automatically.

Hridya Valsaraju (2):
  binder: Add default binder devices through binderfs when configured
  binder: Validate the default binderfs device names.

 drivers/android/binder.c          |  5 +++--
 drivers/android/binder_internal.h |  2 ++
 drivers/android/binderfs.c        | 35 ++++++++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog

