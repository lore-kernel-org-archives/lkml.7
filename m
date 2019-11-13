Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1157C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75785212F3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="VQG9GuAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfKMQbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:31:41 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:33878 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfKMQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:31:40 -0500
Received: by mail-ua1-f51.google.com with SMTP id s25so867063uap.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tqMvp6R7Yw4SmAq29b12cUx08kJZaFb2aktgCaRidVg=;
        b=VQG9GuAhCkrExq0QANlUbr2B7WTTZ7334zQJyl+Wsbbq14nNkc9fkY4Y+tWBCLO2G2
         i3PdOC3wkK81IONAn0hUurXKjI04fcEByfmpOZ6Dxe5/JKB+Ub8YqD3s6msojAKgbs8q
         ktakkePKYuWZkFopjxa/d4TqB4xT8MoWzgc2QZQrZwkIJ4yzpJz9qlZhbqx4kTfkpyzA
         eIqWCQDdycQ4m2/hXDYukiLqQZfVWFCJjtO3+CRQqC8SUEX8bQLA9guRVjloWg+bLi0Y
         G9fbrRy1PHJdxI034dXFg9TdbJom0KIIFxs8k0RnDJWtgdxO9dmwIAoK4BfsZLvUwSGy
         Nuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tqMvp6R7Yw4SmAq29b12cUx08kJZaFb2aktgCaRidVg=;
        b=K0iC6D/U6bdcKT5/zf3NjJMANrRKDq2Od/HPFaOY7II7WZy7iTylliQopaXeCLc/GJ
         oyv9sJ+i4yxuSNcFaFmwnbGkDC8texYJfOiMmSUUM6Np0ynUo/Rzv+pV3rlimVdTCfgv
         K9nC8oP74TmZQy0USPMEY27LnwRoxhETX1wGqd9uuycDWuXl2tkU2On9kJjq4r4uJWb3
         myc2dXi795M6pTcuOUqpRwwgdgazTRPkV3sreQvkeMvTOHICEI3Av32M3p8nvXgFDtGd
         IU95P3q+d7xlvoayUKWSZmL0JmB95D0NWqNoI+WjdFQWkO9MfZD4k3nBNkSqFp3/vMoU
         x82g==
X-Gm-Message-State: APjAAAXb4L0wgmR5a480K2D39LYxuj5BoREaiwgyO4XF2f57A6bLfmbw
        KLhKAJjgUTn2zA4mkjQNSG3Idis2gdogeg==
X-Google-Smtp-Source: APXvYqzw2u4dm/fB/qFWlfB4/plMZGq4mipiSczyOQ19AQjDIj6sE0HXwvqWXTuXReQ3ktMAq6tPDQ==
X-Received: by 2002:ab0:d8c:: with SMTP id i12mr2372886uak.57.1573662698326;
        Wed, 13 Nov 2019 08:31:38 -0800 (PST)
Received: from ubuntu1804-desktop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id j9sm541965vsm.31.2019.11.13.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 08:31:37 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:31:37 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org
Subject: [RFC 0/2] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <cover.1573661658.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improves the documentation of buffer_size_kb by clarifying how is
calculated the number of allocated pages for the ring buffer.

** Do not apply the second patch **. It's just for illustration
purposes.

Frank A. Cancio Bello (2):
  docs: ftrace: Clarify the RAM impact of buffer_size_kb
  ** do not apply this patch ** Just for illustration purposes

 Documentation/trace/ftrace.rst | 13 +++++++++++--
 kernel/trace/ring_buffer.c     |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.1

