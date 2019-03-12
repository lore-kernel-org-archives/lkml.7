Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE39C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDAD214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCLKUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:20:33 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59722 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725894AbfCLKUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:20:32 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CAKVEP002168
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:20:31 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CAKQR1003002
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:20:31 -0400
Received: by mail-qk1-f200.google.com with SMTP id w134so1735426qka.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=S4f8mukhVG52l+5kjOyJAjkxc3McbgHCDiXi+GIJ6n4=;
        b=kS9sOrzG9pPCty6FAqwL49Y2HVKgp1Gp7cUMe87ZNeak3pcj3p4T4nEmQOb6Ck+2wz
         mwfLNfd4TOje03LlT3qw7ncv7lb4HF1HlrdnpI47iKUIb9TslIYhIDL5zmY8UO2EXXZm
         Fg0aPmLIoD9wyue5W1qtAZyKWB/WrIOoa/HSYhoG0q3A59cKznWkhbjwfJGvmp6772hX
         KT28KRBJe6rBHl/2zsVB0NVE7viaDAcd0lO7NDS8X4Lhvoqy930L+tHO7CciE+QdNKwg
         QgWeYUDRjUbconSN9m/m62WOdnWEQzc2iJlhuAMpLlXt4nf4DiLfbwwDrUBjhfGIeg83
         j9mA==
X-Gm-Message-State: APjAAAXWz9m4T85IbnsfnL5NJtk+avPuAQ0+2y2lwjgPZS0gpQM+xpDS
        DyNYEP9dIqDkQjY77a1eqMlSWAIZ8OAAIrPWhqfXOnY8XFQzvKT9N9lILlzaeW3B4yL3MLaZ14j
        /dqAfJUvSb3stjglSXxMPqws6U+zLVXRf5aw=
X-Received: by 2002:a37:a147:: with SMTP id k68mr27705366qke.190.1552386025986;
        Tue, 12 Mar 2019 03:20:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy7may2CMmPFfnmT/077LcVpYvB1DaIHeodbe0XiCEIJSBgiDK0gMDDqx4zOYSqjxt8dgFvpw==
X-Received: by 2002:a37:a147:: with SMTP id k68mr27705355qke.190.1552386025818;
        Tue, 12 Mar 2019 03:20:25 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id f126sm6326536qka.14.2019.03.12.03.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 03:20:24 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     David Howells <dhowells@redhat.com>
cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security/keys/request_key.c - fix kerneldoc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 06:20:23 -0400
Message-ID: <12308.1552386023@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      security/keys/request_key.o
security/keys/request_key.c:35: warning: Function parameter or member 'authkey' not described in 'complete_request_key'
security/keys/request_key.c:35: warning: Excess function parameter 'auth_key' description in 'complete_request_key'

Fix it up to match the function

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 2f17d84d46f1..2623253ae6c8 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -24,7 +24,7 @@
 
 /**
  * complete_request_key - Complete the construction of a key.
- * @auth_key: The authorisation key.
+ * @authkey: The authorisation key.
  * @error: The success or failute of the construction.
  *
  * Complete the attempt to construct a key.  The key will be negated

