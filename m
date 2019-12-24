Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE0C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E731B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="o60An8ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfLXXuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:50:16 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:37261 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfLXXuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 18:50:16 -0500
Received: by mail-vs1-f48.google.com with SMTP id x18so13235612vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 15:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9RoNF4Z2jcPEa4/TK6na/OHMz4yt8pFgIcIm/Vj56dw=;
        b=o60An8ciy04JGEFRx6GAw9TXFtgbkULhimdWX0NNCtRzyDrcmeWfJyAvf45rx9/5N7
         BSYV82QGd4SvGwhMKW7wTk9jTYWBLcAqV4AogM+M52N1fMsVDRb6kIlxNKpLAqHoGMTb
         CIvqidR7xElaJbDuYzJ35NVHg++j9BDEkjapx4PRr+SpQSaVZqyRfS2v7W84Lh57OSJI
         ubsJhnZ5NlqRxKhC95vDtOaeOd8t7jyx9rV4J7VrJRh+Au7S8qXSKGW2+uZA2Yao9fkJ
         +I+TAE6bzC1tawvkwTj5gTS3a6HrGFrmRJY76nHjQX7zZgBmyICRjwJl6SuwrqfyNsuS
         acWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9RoNF4Z2jcPEa4/TK6na/OHMz4yt8pFgIcIm/Vj56dw=;
        b=jH/eg09wx1U87sn2WUVGcsN9YJq3V7mW8+AWlDQ6U4tJ7FLqWe/BjBsD/RkMZDwOpd
         D1qN6e53xRnFuXcALe8sw+TCGBD/se/vY2G5SzThEfmbPpTQuWHJPD/8ovQcLtaxqecr
         dNo6Z4iBWXlBZlL+2GMJL3vwvhPpCSxApnCzZnLA0TFnqh2Opdh0WecWe3UdMHoBEEul
         4oQYQqcXaGXnzLwLNX3JWvQb/ufcackGK3xITMH3cmm4hf4fgQSGbfrx3XmibViUWi8T
         QyDw9IQISBhoi7Yql8ae11kWPfk5mwbQ6/hdNTR7DceORkg7luuSJZ3u/yAPKHTDR4uK
         kB8w==
X-Gm-Message-State: APjAAAU9h/ozqrqhIRnhW4wznZHnMgmnP2GcOiFBS287U38T+qhQ25+S
        HZ0Bw+l7Ssxg8D3RkFJacH1HKw==
X-Google-Smtp-Source: APXvYqx7s9Ha+h8SH/MTJPKlM0Nh/XMguFOgNs1AEyuWB40qrXDqfPmP7ItHSSCKFg2w4Ms5Tz27Wg==
X-Received: by 2002:a67:b30b:: with SMTP id a11mr21261188vsm.154.1577231414822;
        Tue, 24 Dec 2019 15:50:14 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id n25sm7348705vkk.56.2019.12.24.15.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 15:50:13 -0800 (PST)
Date:   Tue, 24 Dec 2019 18:50:13 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: [PATCH 0/3] docs: ftrace: Fix minor issues in the doc
Message-ID: <cover.1577230982.git.frank@generalsoftwareinc.com>
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

Changes since PATCH v1:
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

