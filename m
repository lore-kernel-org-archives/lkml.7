Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A822DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612AE20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kY6JfNrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfENK0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:26:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35768 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfENK0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:26:40 -0400
Received: from zn.tnic (p200300EC2F29E5000DF69AC748EB6F4C.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:e500:df6:9ac7:48eb:6f4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91C161EC0BB1;
        Tue, 14 May 2019 12:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557829598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=75r4LBmhsLjK7T7MiGrcymngD4KDDKnjiQu/ckjCNtM=;
        b=kY6JfNrCjN/wWgX7Sy+irVQMMrDIiz7OfoyMptDmHIJ8rYd9/5wBg0w+1nLPwpFZ2YoH0x
        9DzBlot19K+WJyJ56BV2zFaw49j72WiVmfV1lgADWGaYtJm7SUOfjcGUK1pwKZvZfDVz/+
        lCvYQ37oU0G9WAcB3BKQ39geAZ7Rx+U=
Date:   Tue, 14 May 2019 12:26:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LICENSES: Rename other to deprecated
Message-ID: <20190514102632.GA4574@zn.tnic>
References: <20190430105130.24500-1-hch@lst.de>
 <20190430105130.24500-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430105130.24500-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:51:30AM -0400, Christoph Hellwig wrote:
> Make it clear in the directory name that these are not intended for new
> code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/process/license-rules.rst     | 8 ++++----
>  LICENSES/{other => deprecated}/GPL-1.0      | 0
>  LICENSES/{other => deprecated}/ISC          | 0
>  LICENSES/{other => deprecated}/Linux-OpenIB | 0
>  LICENSES/{other => deprecated}/X11          | 0
>  5 files changed, 4 insertions(+), 4 deletions(-)
>  rename LICENSES/{other => deprecated}/GPL-1.0 (100%)
>  rename LICENSES/{other => deprecated}/ISC (100%)
>  rename LICENSES/{other => deprecated}/Linux-OpenIB (100%)
>  rename LICENSES/{other => deprecated}/X11 (100%)

This breaks scripts/spdxcheck.py, it needs below hunk. Also, should
"dual" be added to license_dirs too?

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 4fe392e507fb..1a39b34588b7 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -32,7 +32,7 @@ class SPDXdata(object):
 def read_spdxdata(repo):
 
     # The subdirectories of LICENSES in the kernel source
-    license_dirs = [ "preferred", "other", "exceptions" ]
+    license_dirs = [ "preferred", "deprecated", "exceptions" ]
     lictree = repo.head.commit.tree['LICENSES']
 
     spdx = SPDXdata()

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
