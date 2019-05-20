Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCB5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560932171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwKcFS84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfETUzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:55:09 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56460 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfETUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:55:07 -0400
Received: by mail-qk1-f201.google.com with SMTP id q17so13660241qkc.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CEe51n1cJjGjM3r3jhy0lvCRaDr0xuP675ZqA1iPYL4=;
        b=KwKcFS84Od+0uDcbkZwTpIrT43f2kU8zmORrILLiHk2F8YkNKiv1DApHnhAMtYlYNA
         TTKtXmA8TJ8/ipv7ecH3TyAPVRf9bZ8GXZEFmFgwDXPD4Hjtc9OoZlG6aBmwZtYTn8Oc
         Nvt9VJVKM4ko0egxxq7cUr2yFh5bt2A6FPsfeESlkTgj+tTo5HipWQkdt0PV7yGNpC2p
         qwWO/zif0wXn7M/9LQBi1kh21TF0FRSHZu9qfX+5MMJsj7woSz3xBh9gb5WkU4/0KX4c
         dnI+ZE7GgTCEi7VKzXkA1bmYAkK0Nv9eJ0xJyAJqd/DQAikMJoy/AIkKcuCOHk84b2v+
         el5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CEe51n1cJjGjM3r3jhy0lvCRaDr0xuP675ZqA1iPYL4=;
        b=D1VI96gUvihKUBKdMVCHebHRPwGhbC67YHm2TsbXB80QjZ123sUmHF8No6q7x7MrY3
         DWXJd81N2B6UZzy+Ywj5JyG2r4MwW4Bv7IHg/adv+WhgmzesDd+WFhWiwgexgMYRkrt4
         ecQU+O+hvNvBfLQRBG5UnHqjYtjMhM4cRbpxUGx3P/I0UNl+AHOkmIuSOyQ0uoC4dG7g
         hIm/Nz0L5yJfegc0f1jn+L2wmbejgA0COyDmYYL+ljf053gzhwI+A9EKMoIhQaE5ti6R
         t6o5xdktPTCHtdVWyNv8QjUNw10QSSA/9tkamnXjM8eg2TjJ2lgyqwlSlmwj2Lmb9B3B
         02RQ==
X-Gm-Message-State: APjAAAWFl23ylEVTNXUqFdZZDKn+nG5zLh1QTDK6ZAOoIEWwXf0ZZray
        SW46fo5o7QY2QGKBr+vChOwoAahnJ9ukiVijoB7mIQ==
X-Google-Smtp-Source: APXvYqxcgPZwWQB2M99XR5b353YmJ/Ei17uYUIv35ZBhj13nsYbaZL7VC+EcLkbxPlvT59VqEEmZiqG52LG+K02tnRds4g==
X-Received: by 2002:a05:620a:144c:: with SMTP id i12mr32298826qkl.243.1558385706056;
 Mon, 20 May 2019 13:55:06 -0700 (PDT)
Date:   Mon, 20 May 2019 13:54:57 -0700
Message-Id: <20190520205501.177637-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V7 0/4] Add support for crypto agile logs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identical to previous version except without the KSAN workaround - Ard
has a better solution for that.


