Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77421C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DE7208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUORUVeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF3HRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 03:17:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39440 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3HRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 03:17:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so12670517wma.4;
        Sun, 30 Jun 2019 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=USPilo/eza/w4LRdmdWLftflIpthdDIyyDRL6/MUMwU=;
        b=IUORUVeYgoGJ4nvT1CYJc6kJiCqkeBoTevogxKfaqvUmkzKM3qeqzgQxf44zbHQoyG
         12YMZWD02qc8CkUtMC3GQ+aWh09f3upPn3qdDAUiWqj2+dua8UhBnQiB68jU+nOGM4Mk
         MFdhiPiQ6Zyd3BFiagSXlgH7i11C6e5Cd7vaB5poLu1TkUZNIP8Lobbadk6X6Cc95WHJ
         BVQzc1zl7cgTFCZG2Xrc8KJ3cpujhrq+fDnGnfSGHgkWjQjcsC8aReu9vr1nYBzwbFPe
         uwDDQUMcATn92JSgwM1PQ4qHllDvSRLuKOjQG+b4ew0XbyrcRng3NbK+6pDomUbvUuWu
         cdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=USPilo/eza/w4LRdmdWLftflIpthdDIyyDRL6/MUMwU=;
        b=FqskC1TK//FyXNLxw7YNJ+NTWXV6bLirVJPGJ1oBGS6bVUvPprCI37EXCZ/PazBwYo
         zvuWpgSPzsor8GkZQmeVsxTnmyZSe5OQhean3w7KHF0WT4aX2SZHbZbpEvkvIpHZyVF1
         gowB55Y4A/S3CoFiuHAfOMOYXBZcodoc3BScfbEBZvoj5tEehkpBierwnrEg+8M27Bbr
         cD/ujJgZa0sdbja0gctlEAh20NmX/oc7vIylSgXi4X0uXVtAClMmrA/tcHBPFDHZSEiR
         XDLBCOIpmQXf/W8bVfELX2+o26v2hBjoLz4mi87Fwd5VzR34dP9q9j+xV8UxfSPb39NY
         qq/g==
X-Gm-Message-State: APjAAAVHB/3Iyb5poyb6NtRukREDLYHjcnrZECMz5hy0HnGIpC2HtKDp
        0bXRnvbfABl5Q3pKJ8lqIJhMiDix
X-Google-Smtp-Source: APXvYqyLF3jMnl50ffZS32xLW/m3hWi4a1yh1P/d/o4gNd2jOvwfR6W1korEUP6fCAXrXZb9Ys7ORQ==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr13065978wmc.47.1561879057189;
        Sun, 30 Jun 2019 00:17:37 -0700 (PDT)
Received: from localhost ([197.210.35.74])
        by smtp.gmail.com with ESMTPSA id x129sm6055865wmg.44.2019.06.30.00.17.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 00:17:36 -0700 (PDT)
Date:   Sun, 30 Jun 2019 08:17:07 +0100
From:   Sheriff Esseson <sheriffesseson@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-kernel-mentees] [PATCH] Doc : doc-guide : Fix a typo
Message-ID: <20190630071707.GA12881@localhost>
References: <20190628060111.24851-1-sheriffesseson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628060111.24851-1-sheriffesseson@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 07:01:11AM +0100, Sheriff Esseson wrote:
> fix the disjunction by replacing "of" with "or".
> 
> Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
> ---
> -- 
> 2.22.0
> 

Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
---

changes in v2:
- cc-ed Corbet.

 Documentation/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index f96059767..192c36af3 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -359,7 +359,7 @@ Domain`_ references.
   ``monospaced font``.
 
   Useful if you need to use special characters that would otherwise have some
-  meaning either by kernel-doc script of by reStructuredText.
+  meaning either by kernel-doc script or by reStructuredText.
 
   This is particularly useful if you need to use things like ``%ph`` inside
   a function description.
-- 
2.22.0

