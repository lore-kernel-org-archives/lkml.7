Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C203AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D4E20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W66qD9Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbfIEOuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:50:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40266 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfIEOuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:50:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so3136823wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mu8BT/Kq3mPuYq+U/eVsorSAUs8xgY+5qDBWnOuM4zQ=;
        b=W66qD9MvYU71Ltt1+svthcd4Eoc/pruAOb+Cxc90hPn6hTfAgyvlaOO5x3Lxv+iONe
         u+OeRB4Ivd38m7NLTHtfKXTI2QPUFnTNX1e6UmAj/8IWnELOAi2cyKe4BfEXafIeVFV+
         Cd+xw0mNiyifqxwttGfBk76Wy7iM/hPNl3Ybeg8Dm3H6wKu0YHPiiY6hmQ6y42tLyMmU
         dNP98tzMgAk80zg1rmNyijzpDIwtlXCx1dofF863CNnaIoHlKB+k/K0n31oNfql04UA0
         54T96xq6Zqjzr5A+BEJmE+euIAIZIrZkmyi/YqvS/CJdu7FZ9UIVIW2dtBoAtUDVwLWM
         iGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mu8BT/Kq3mPuYq+U/eVsorSAUs8xgY+5qDBWnOuM4zQ=;
        b=k02DKON++wIPejNzpgRiuZJ4H8OR3JlKDETM01tq8qC2EXw3A26UACTktcKVpxI62v
         /B+gJEDjF8T/sPcPZlLeWVwv3eKa9P8ZE0VoSL6Nyk8DLAMcKrXHfan0GptRVSeNHM90
         wGtnPuM0ZvMbsSLzksTrH0p0ofkQQzKsfJNfaFcQAuI8FdFMETdVfAfEwZatFlGKjj1t
         IYQXvd0i+OfoqMIVRzrL27dL38A62FFPk/BPGI2JDdqhvewaI/Sf2n+7Xbj0RlF9SC6K
         DishnXuqXfEJGzoTwxHbtI88w6eBGUV3SNHXqyXbbdwg/AHrXJpr3gYwUP4E8FNNZ7oh
         W1Uw==
X-Gm-Message-State: APjAAAVt/w8JkrG828lAGf2TnjqEplhBzHZ/2R20J4nfb1HOpNgCgTBe
        o8nDuPQj5rdraSJA0jftZRtDcw==
X-Google-Smtp-Source: APXvYqxhnotNQfdCvF70keJJMv1v/fWZi9iXhJD03KhF9FGYj9u21+olcp6OoVLCSYjYjB3O6KVk6Q==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr2844478wrs.315.1567695013033;
        Thu, 05 Sep 2019 07:50:13 -0700 (PDT)
Received: from ziepe.ca ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m17sm3175786wrs.9.2019.09.05.07.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 07:50:12 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i5t5P-0005nN-80; Thu, 05 Sep 2019 11:50:11 -0300
Date:   Thu, 5 Sep 2019 11:50:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] libnvdimm: Enable unit test infrastructure compile
 checks
Message-ID: <20190905145011.GA11796@ziepe.ca>
References: <156763690875.2556198.15786177395425033830.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156763690875.2556198.15786177395425033830.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:43:31PM -0700, Dan Williams wrote:
> The infrastructure to mock core libnvdimm routines for unit testing
> purposes is prone to bitrot relative to refactoring of that core.
> Arrange for the unit test core to be built when CONFIG_COMPILE_TEST=y.
> This does not result in a functional unit test environment, it is only a
> helper for 0day to catch unit test build regressions.
> 
> Note that there are a few x86isms in the implementation, so this does
> not bother compile testing this architectures other than 64-bit x86.
> 
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/r/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com
> Changes since v3:
> 
> - Switch the Makefile operator from := to += to make sure the unit test
>   infrastructure is incrementally included.
> 
> Jason, lets try this again. This seems to resolve the build error for
> me. I believe ":=" would have intermittent results in a parallel build
> and sometimes result in other targets in drivers/nvdimm/Makefile being
> bypassed. This has been exposed to the 0day robot for a day with no
> reports.

Okay, again we go

Jason
