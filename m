Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01868C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ED6204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pqIE67Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfEBPol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:44:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfEBP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AwMJZ8ssvSb+PhQSXkJQRhxuz5BEqoiX+7/r7FSySMg=; b=pqIE67AhKiWZT5LnLp47MLRyi3
        6tm0nXw7CUFDgV/hsmg33I4MNGizQH3Xn6ph9FYylEJADNj+jGa+2Nty6YS3M93QBQ113yv9oFrAy
        CFlA9qCuM/pt2tr8PJsZ8wCpGPeKpmCgosCHs5Lxff11r7spoh3v7KLNJDtu+tGSYLnhN0cxfCnMz
        sYOi4UOrXMND0OQfqrCPn4t2VMXzyYeKogZTIuofgZvl5IRpd5Bz35ynm7QpbYP31WEYCG7U91zd8
        1MS6QPdFPMQTHmhArNfnvAL+ui9VVwTdl6DedI1R0lOQYV+6dXuG2ufJuv2R2uu+M1AhG80fVhB6j
        cANyYvbw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMDbJ-00019f-83; Thu, 02 May 2019 15:26:21 +0000
Date:   Thu, 2 May 2019 08:26:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Alloc refcount increments to fail
Message-ID: <20190502152621.GB18948@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the comments section of a recent LWN article [1], Neil asked if we
could have a way for refcount users to avoid getting to the saturated
state if they have a way of handling fallback gracefully.  Here's an
attempt to provide that functionality.  I'm not sure it's compatible
with Kees' "x86/asm: Implement fast refcount overflow protection", but
I thought I'd send it out anyway so people who have thought about this
more deeply than I have can tell me if it's an idea worth pursuing or not.

[1] https://lwn.net/Articles/786044/

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index e28cce21bad6..c4b15b5ec084 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -108,6 +108,21 @@ static inline void refcount_dec(refcount_t *r)
 # endif /* !CONFIG_ARCH_HAS_REFCOUNT */
 #endif /* CONFIG_REFCOUNT_FULL */
 
+/**
+ * refcount_try_inc - Increment a refcount if it's below INT_MAX
+ * @r: the refcount to increment
+ *
+ * Avoid the counter saturating by declining to increment the counter
+ * if it is more than halfway to saturation.
+ */
+static inline __must_check bool refcount_try_inc(refcount_t *r)
+{
+	if (refcount_read(r) < 0)
+		return false;
+	refcount_inc(r);
+	return true;
+}
+
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
