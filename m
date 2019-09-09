Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA04C49ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48BA216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/hI7Abt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbfIIB2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 21:28:45 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:41745 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732062AbfIIB2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 21:28:45 -0400
Received: by mail-pf1-f176.google.com with SMTP id b13so8086292pfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 18:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e21MJlkm97ORelJAhgeLaoLq/TpNVvuy8j3w5P3pM6c=;
        b=e/hI7Abt5WCT7EnPRBljdZfQIVy4E7GM/CJIe7sqAJT95VsX/n3chVf0kWesNmNk7A
         KoGlFiM5jWnk6+kAz6vW9VWnx2FhhUliBtyh3WlEK4OyRTxj62kR2ldJlgfRsLkrG7Ks
         9EScgN0L6dpr1Se09nHh9AgKoL8BxarGKZr6zCHyUbxUw7Lwjn22ShQ9anpdWujPDCzR
         iB7J/Zgr9QQtS5J2fvUZX/500hqlstrVM042IuHA4bcKziafNQ+ARq1M1UFmVuX51JVS
         Oal4K7OeBd8UWYxIASA4xmiFXxwe7rUJ9Yys0Oku6+brghXPqq5WM/Xe5JCpRcWatNhn
         huog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e21MJlkm97ORelJAhgeLaoLq/TpNVvuy8j3w5P3pM6c=;
        b=lR9EX/LTh9Om2xLSGLlT8JZPPrg3ZEGUpbIVDKckmRcATQ5ey+D5/mKWlJ4onF0TaL
         IzJCA0ZtuaAWMVt66AroZAdz1gWUo5xDW+r7ghr6a+xNCQdHdaOtgevGNQZA15XwKje+
         xJgbT/4O9EZDSbJujhLOzADiixmZvspUR8D1h0jQxSO6Dqf1TOrugv6Pr7wCdGJCHqJW
         HDvtd6YCDjgkJpb9hveFwt8h4h3+NkbO5KFfbLWPjbykckvUBoB9XVnN7drb7UMqP6Ot
         46riN/XG54tRF+Z22LrbGvDtF4k311QW3cizwrcwgL4LToXKWITmSUNFA0Aua5ENCZkX
         VdVw==
X-Gm-Message-State: APjAAAVyaG1wm+Huql4fgHE1L0XVw23U97e2yhVKLytdC5208hx2BpZU
        0qREt4LA2qt7qTKguRKN9Ob9UQ==
X-Google-Smtp-Source: APXvYqx1BUlBFXDbSTAJ4FHqjnXhSwvMdZclJEz/cyFfeg5DWf8xPDztYLw3PeyJ+BINXL72AjpNVQ==
X-Received: by 2002:aa7:9a97:: with SMTP id w23mr24116070pfi.148.1567992523975;
        Sun, 08 Sep 2019 18:28:43 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id a3sm279452pjo.18.2019.09.08.18.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 18:28:43 -0700 (PDT)
Date:   Sun, 8 Sep 2019 18:28:37 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 03/19] ktf: Introduce a generic netlink protocol for test
 result communication
Message-ID: <20190909012837.GA33048@google.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
 <a29b3d27234a7ad3f5d6f7571d08167077dc0350.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a29b3d27234a7ad3f5d6f7571d08167077dc0350.1565676440.git-series.knut.omang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:09:18AM +0200, Knut Omang wrote:
> The generic netlink protocol used to communicate between
> kernel and user space about tests and test results, as well as some
> means for configuring tests within the kernel.
> 
> Unlike other kernel side test code in the kernel, ktf does not print
> anything from inside the kernel (except for optional debugging
> features to help "internal" debugging of ktf or ktf tests).
> Instead all test results are communicated back to the user space
> frontend, which decides how to do the reporting.

So why netlink? Why not just a file interface?

[...]

Cheers
