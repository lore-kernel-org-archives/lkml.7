Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82234ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52063208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LcUUdF9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfJJPYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:24:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJJPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WS71rIpoUQoMlhWYH2+T6RbpZuX/AIM2quo5SoNq10A=; b=LcUUdF9yYBPmKwJ4mHbvnW4kF
        BN0N+hWBeffPdMa108MFOrcBUekK333ztf3KLM97bz1zxt002Grd5Fr1RM0lR7yMck1hV7qHKMdZm
        N2oAediNP909LTHhYalXmULuldWZDpdLPkAcqLibq1Q8foUbBsgXQUyqwIeW8K/H75h1WigKNQs8K
        kQN5pOEFSDxTStiaCQV/iO6fWCqKhhybI9UdROGJpg0IfG07WCHFJdVw3dEk2Tb87xwmNEwsv+Uax
        n8DmmqZuSSAg28zmoVvFOxsMarhB2FUbIPjDT/OaUpXFLg95qIFy/h1Z0AUUrHNzi1B62DqqFMz1d
        0fUGgCrTw==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIaIm-0003OR-CJ; Thu, 10 Oct 2019 15:24:28 +0000
To:     linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] security: smack: add watch_queue.h header to fix build
 errors
Message-ID: <0f9adf0a-36b2-81a2-acee-1f9b24cea0bd@infradead.org>
Date:   Thu, 10 Oct 2019 08:24:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when CONFIG_WATCH_QUEUE=y by adding the
appropriate header file.

../security/smack/smack_lsm.c: In function ‘smack_post_notification’:
../security/smack/smack_lsm.c:4384:7: error: dereferencing pointer to incomplete type ‘struct watch_notification’
  if (n->type == WATCH_TYPE_META)
       ^~
../security/smack/smack_lsm.c:4384:17: error: ‘WATCH_TYPE_META’ undeclared (first use in this function); did you mean ‘TCA_PIE_BETA’?
  if (n->type == WATCH_TYPE_META)
                 ^~~~~~~~~~~~~~~
                 TCA_PIE_BETA

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org
---
 security/smack/smack_lsm.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20191010.orig/security/smack/smack_lsm.c
+++ linux-next-20191010/security/smack/smack_lsm.c
@@ -42,6 +42,7 @@
 #include <linux/parser.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/watch_queue.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"

