Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64412C28EBD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44543206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFGCwi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 22:52:38 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:56194 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726600AbfFGCwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 22:52:37 -0400
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x572qaT3018234
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 22:52:36 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x572qVOJ021644
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 22:52:36 -0400
Received: by mail-qk1-f200.google.com with SMTP id q17so398927qkc.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 19:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-id:content-transfer-encoding:date:message-id;
        bh=xhOqOPtnIgT5w7V9kBzDfbIhXpePUc/rfvE+YV2lNhA=;
        b=DvDytAmGhlrhxZNT5YwYK09C2fLh2Fc3EigdsmVb/IWgxfYX3L/qYD/I3+AUPOD3Z7
         YaYP3Zfu3wDNDWdF+uMZRbI6CGKMmL/+ytQ7AMaKpcE4YdKp6p1pRZm0A4zeZq2yivqg
         QF+l2+HWfeiYbayoXgu+mXNCbeUw8vRWQB+kKKpsbEQQ+l727wNkl8qZLIIPdsKwDzu7
         0DL9H47g58b20DmXejLdlZckUC5TcMeYlsmVeT3cd9KnrazLh+eoavC4G3FyjkpwGXFZ
         oCUxLWVuFxJMOhCFvkwvk3THdBnb5J31dS5RUIoCd+UJZywGGe/JrThjtKVl/WbEVsuT
         QH2g==
X-Gm-Message-State: APjAAAXOaigtmkEPbGn/UUvjEf8MrqvFSn9gqwDKYuwKWJKR0LSvygD0
        buJfe34WupnhHzTzryi4NNOIfhVbC5DliGX4oc6gjF8ANUTX0rQrC17zIfzbAbvM41F9SDwy43B
        /ZeSIudIwzgXl1Fv4ScRaOWH4ls/rKTYHyGg=
X-Received: by 2002:a0c:add1:: with SMTP id x17mr11556927qvc.81.1559875951307;
        Thu, 06 Jun 2019 19:52:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz2fYFAOGQCJq0C1I1vfVboOGbANTSG9489ARoGVT1WYRX4pxoio2wTG7MPs8CHgRktMdk4qw==
X-Received: by 2002:a0c:add1:: with SMTP id x17mr11556922qvc.81.1559875951167;
        Thu, 06 Jun 2019 19:52:31 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id k6sm375684qkd.21.2019.06.06.19.52.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 19:52:29 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     David Howells <dhowells@redhat.com>
cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security/keys/request_key.c - fix kerneldoc
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29892.1559875948.1@turing-police>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 06 Jun 2019 22:52:28 -0400
Message-ID: <29893.1559875948@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, gcc complains due to a typo in a kerneldoc comment

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


