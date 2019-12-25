Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1914CC2D0D2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E104920679
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="n53a0lqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLYAFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:05:41 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46878 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfLYAFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:05:41 -0500
Received: by mail-vs1-f67.google.com with SMTP id t12so13220484vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 16:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VoiVMNxBQvkfO1nvNSopmJtlI9rIbMWEjc866MTLsUs=;
        b=n53a0lqWXWUrQ9CyzbCgTQwXri/c2KLf+C0UBuz8DIvfEUYiASuNPLh+ZboSVat/AR
         NLrpn4tBhLegdcSi9ww+K4JtykUViGV9rror4jM3ebb/aNgYe22HhUlBex8aWPEA3Szs
         dffdcgr4cCBs+CWlygzExTJdmOxOh9YnRBqTpcimVeDcMhMac5iqRX/nJn18XVuwq1oD
         u/6ZdUS+ptW1HeYbYyvGdEpbSp+9UBR0qVhzHf+P9c95TmRF4nrWBIw3CS+8o7bT1Ok0
         CWjPunukg5BNKE35kuYyb6sk4aWMhsjtBuOuZ9ecB5pEIJXJIsX3DLlpUH+F+OMS2AkI
         i0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VoiVMNxBQvkfO1nvNSopmJtlI9rIbMWEjc866MTLsUs=;
        b=e+TvqXBtVNBxDfSZNMmy9QukIsydFrX0qPLiMKz4OrXWZdjCoAa6ySUakt/wRTpbuh
         NHbAhMDL+TEbGFnSNpuxYEmcIyS5wfUzW0kutfMV9bVgac7+ZKCYa+O6uc5TrQBZ3537
         TxAUuruMpHnIZWbtV5e92qwGdhAcE082NpgVoz7rBoorcgOoLQDckRzuYmCV64xqS4it
         G+biYKOK8awFEEdkWffWimwTLyJfvcZ/SqOGkFuQvo/xEwtPCYN5uRU99IGYthOdVDI2
         jfft3MNx4uNia1lhh74hPHRguu5oHF66DoglznQmKeFmTaoJEbzCz3Btqi3c2S/4rFgq
         XiGA==
X-Gm-Message-State: APjAAAWGZoI8/1LA3ik5w+dGnBONHxOuSaAo9BJuMij+hKDnIlF2nER0
        EX1cncf+Eg1vSTPbUoRzEkcFew==
X-Google-Smtp-Source: APXvYqwg806JSSurK1S8eEWGtL7gSPIeBdfl/yNW5wfO5kvd0+HrNpx1BtnoSYOwjmSbe8G38F+iLw==
X-Received: by 2002:a67:ea87:: with SMTP id f7mr20585272vso.52.1577232339823;
        Tue, 24 Dec 2019 16:05:39 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id s6sm4503431vsl.31.2019.12.24.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 16:05:39 -0800 (PST)
Date:   Tue, 24 Dec 2019 19:05:38 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: [PATCH v3 0/3] docs: ftrace: Fix minor issues in the doc
Message-ID: <cover.1577231751.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't want to be pushy with these minor fixes but occur to me
now that, even all seem to be clear in the latest version of the
RFC (v2) related to these fixes, a clean patchset could be expected
after such RFC. So here we go:

Clarifies the RAM footprint of buffer_size_kb without getting into
implementation details.

Fix typos and a small notation mistakes in the doc.

Changes since v2:
  - Sorry, I'm sending this v3 with no changes but the subject of the
    emails because I forgot to tag the last batch as v2. You can 
    ignore the previous versions of this patchset. I'm still getting
    used to the versioning of the patches and all that, my apologies.

Changes since v1:
  - Improves the redaction as per Randy suggestion.

Changes since RFC v2:
  - Take out the notation mistake into its own commit because it
    is not a typo.

Changes since RFC v1:
  - Removes implementation description of the RAM footprint of
    buffer_size_kb, but still make the corresponded clarification.

  - Removes a patch that was just for illustration purposes because
    Steven already got the issue that I was referring to.

  - Adds a patch to fix other typos in the doc.

Frank A. Cancio Bello (3):
  docs: ftrace: Clarify the RAM impact of buffer_size_kb
  docs: ftrace: Fix typos
  docs: ftrace: Fix small notation mistake

 Documentation/trace/ftrace.rst             | 9 +++++----
 Documentation/trace/ring-buffer-design.txt | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.1

