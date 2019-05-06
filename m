Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AB3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD33D20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rg74RFa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfEFTb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:31:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEFTb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gZ+PznOa1NPjwtyprbc4xPeHY4zz9L/0ME3WLNqb0aA=; b=rg74RFa+90w0Nw3xnzbjpJ8v6i
        KTB6rv1ErhwxB+owHswOKFjpS88NMEarvqWtjhl0donO1sfb4HH5TfrKgK8y2SfOVFy4W3HkEFmLJ
        lrZlgBYYAtfSkn2tk30kjrsbEg6Q/Oe9NjoCneCzyacU5IwQdbSS8f5HUqn7ioebEafQ5y7uzy8FM
        Awxinlg4oyPq9iH5PejF8x8bI8y9ep2pJ+64PBSgq00De78MRLU1fqk4iH9cmw0plZvg6q7CfZtdF
        6KAFObr9ILkjwJE94jh8zGy0FveUCKx1wLZ3iTBLnWpLKiXgDL2aDBq+hv0lEBaFZbRBJDTE1uPhu
        myKi9A0Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNjKh-0008GU-35; Mon, 06 May 2019 19:31:27 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] x86: olpc: fix section mismatch warning
Message-ID: <76cbb7d3-bb91-4900-0275-a9b09fd7c77b@infradead.org>
Date:   Mon, 6 May 2019 12:31:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix section mismatch warning:

WARNING: vmlinux.o(.text+0x36e00): Section mismatch in reference from the function olpc_dt_compatible_match() to the function .init.text:olpc_dt_getproperty()
The function olpc_dt_compatible_match() references
the function __init olpc_dt_getproperty().
This is often because olpc_dt_compatible_match lacks a __init 
annotation or the annotation of olpc_dt_getproperty is wrong.

All calls to olpc_dt_compatible_match() are from __init functions,
so it can be marked __init also.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: x86@kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/x86/platform/olpc/olpc_dt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20190506.orig/arch/x86/platform/olpc/olpc_dt.c
+++ linux-next-20190506/arch/x86/platform/olpc/olpc_dt.c
@@ -220,7 +220,7 @@ static u32 __init olpc_dt_get_board_revi
 	return be32_to_cpu(rev);
 }
 
-int olpc_dt_compatible_match(phandle node, const char *compat)
+int __init olpc_dt_compatible_match(phandle node, const char *compat)
 {
 	char buf[64], *p;
 	int plen, len;


