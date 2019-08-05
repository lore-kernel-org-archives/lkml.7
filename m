Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785E5214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uhwlkx7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfHEQ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:29:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfHEQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O/cOvUBI1ERP7wt0pfm8UV4BQQBmZinQ5jmqMRrRT3s=; b=uhwlkx7DAglWC5KpvGCBlGwg1
        dUAcvuQB7umeU4YBhYbXiVAyRPD7tzseUppEYZnnSCIOzseQwE0QYorBjauDfE8NRP6Qj43yyZuhg
        xFAH+So5W5IUjbIQdh2VgfV5GhBzlLmnnhwpvWKVIYqLrkEuZVT3NSn2wgmTV33eoCcZglBGtqBtL
        EV46nqrG6G97PZThySj8vmaQ612Rv/qJrnj543XuVvp0rlKJTdmI1NpQn/iQ/eoSmc5p+M/uEdTaN
        Vw4/pYS7sbzYLgbUxOGNTo+9OHFUUvyVc96rNgdlmcvT8PbQHjsHi9DWoV1j9vFB8mhnh+n9FKJhF
        6AFBLIRqA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hufrq-0000iB-Sq; Mon, 05 Aug 2019 16:29:51 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kernel-doc: ignore __printf attribute
Message-ID: <77cf8297-7de3-4ad1-d497-4ad941012b75@infradead.org>
Date:   Mon, 5 Aug 2019 09:29:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Ignore __printf() function attributes just as other __attribute__
strings are ignored.

Fixes this kernel-doc warning message:
include/kunit/kunit-stream.h:58: warning: Function parameter or member '2' not described in '__printf'

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 scripts/kernel-doc |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20190805.orig/scripts/kernel-doc
+++ linux-next-20190805/scripts/kernel-doc
@@ -1580,6 +1580,7 @@ sub dump_function($$) {
     $prototype =~ s/__must_check +//;
     $prototype =~ s/__weak +//;
     $prototype =~ s/__sched +//;
+    $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
     my $define = $prototype =~ s/^#\s*define\s+//; #ak added
     $prototype =~ s/__attribute__\s*\(\(
             (?:


