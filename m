Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F31C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4B920862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918567;
	bh=hnUej7ys3ITiP39luoDvCJAWYDcmxkOIaF1YbLFXxxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xCF7A2Jpf2mdYAr5fSy8nOF9GE4RZIl6I0qNvHu8IKa5ycvbki1o0SXX05nMn+kxc
	 dFPDwqSb8KdD8IfAjVxld4LAzCQlSmn1unsVfq26laINx4eymCS6fsWLmNwoSqDAuM
	 N/PyFKEEp3BCARXgT7SF2hQjxO+L7b99Dv/tuV1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfEOLJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbfEOLJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:09:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E9C2084F;
        Wed, 15 May 2019 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918563;
        bh=hnUej7ys3ITiP39luoDvCJAWYDcmxkOIaF1YbLFXxxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pS5wNnD6V1YqI4kC5zb5VUsGUAywBEbgyOamCCGb7N9kyS+2sX4jYmFboEm0Tc7Qd
         YdXQwTv3vuKKoLwuuPl/8yEHzkigWMMPXPXusPQ/kgqUx3/1+LyXr9wCFAyXKEuKrE
         8+fQfGse2Ui6K6qk5GmAp0Fn4Pe6nufy6GSqECE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 180/266] x86: stop exporting msr-index.h to userland
Date:   Wed, 15 May 2019 12:54:47 +0200
Message-Id: <20190515090729.016771030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit 25dc1d6cc3082aab293e5dad47623b550f7ddd2a upstream.

Even if this file was not in an uapi directory, it was exported because
it was listed in the Kbuild file.

Fixes: b72e7464e4cf ("x86/uapi: Do not export <asm/msr-index.h> as part of the user API headers")
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/uapi/asm/Kbuild |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -27,7 +27,6 @@ header-y += ldt.h
 header-y += mce.h
 header-y += mman.h
 header-y += msgbuf.h
-header-y += msr-index.h
 header-y += msr.h
 header-y += mtrr.h
 header-y += param.h


