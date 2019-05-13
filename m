Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D11208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UoICGRVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEMWrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:47:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36926 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEMWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:47:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so4612409wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8NwNULtWwx5Pb38bN7drUkQb+DIEmPFqpFPgTOk+Y5o=;
        b=UoICGRVQhswOm1w0iBq2Dfnoa/DuU5x0oxvr4b9rlhFV4602wc987vTNuAOIMD4cGN
         orAe6wjXnlnfvmZBTV5AA6aVHi+O6TtxHJr3Kx4AWhv7Jnpdm7sa+z8ehEpcK8qLFPCD
         ND8kzfU1vYDNxwdVwUj9akBh7LErIPmKopZWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8NwNULtWwx5Pb38bN7drUkQb+DIEmPFqpFPgTOk+Y5o=;
        b=AhYkwTnv723DErJg+bDdx3QDurMTw2cTkIi+NcdmvClySMcBq24ew8QUCPwabKv1AQ
         wLcJellDvfyoJ5MMiY+CU6PhIgdKQZcwRxlFGZLg90SLL1VIGDNGN9oMpBEMfH/63dz9
         n2d8fY0XE2s5dBit2GwIH2wpcDG+dN2JSO2i3GeKTxnmgn1Jai5g88ylgqZfxFyUMyWm
         KMpHGcJfoLljJad59cCDrwrRHcOMskL6PWSJ7Iz4p4BdY/wyx8IMHjmsZtooTSnwDrdS
         0CpVH7OFiUe+f+NgnGvwuN9dixL4p5gck6aMLRmS0fr2tNld3nnJJUvrKywXeeT1zaoZ
         kU4g==
X-Gm-Message-State: APjAAAXo/mUNtJzS8isaYLT46iGg32MSgPlkFuhSe9HiMQld/aYx8za0
        scppCpS77vHYmHXBWpuggz4p4Q==
X-Google-Smtp-Source: APXvYqz1cHGnFV2c26Yq8lWgWFigtzB9Z2gxdmJXAG64GHifi4xxw7rXJ++5iixNDSYxTdVGWHdErQ==
X-Received: by 2002:adf:f788:: with SMTP id q8mr19337838wrp.181.1557787630962;
        Mon, 13 May 2019 15:47:10 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id u9sm1451813wmd.14.2019.05.13.15.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 15:47:10 -0700 (PDT)
Date:   Tue, 14 May 2019 00:47:03 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Yan, Zheng" <zyan@redhat.com>
Cc:     "Yan, Zheng" <ukernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/5] ceph: fix improper use of smp_mb__before_atomic()
Message-ID: <20190513224703.GA2957@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-5-git-send-email-andrea.parri@amarulasolutions.com>
 <20190430082332.GB2677@hirez.programming.kicks-ass.net>
 <CAAM7YA=YOM79GJK8b7OOQbzT_-sYRD2UFHYithY7Li1yQt5Hog@mail.gmail.com>
 <20190509205452.GA4359@andrea>
 <6956e700-ef56-7f20-4e6c-3ad86c9fd89e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6956e700-ef56-7f20-4e6c-3ad86c9fd89e@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>         /*
> >>>          * XXX: the comment that explain this barrier goes here.
> >>>          */
> >>>
> >>
> >>makes sure operations that setup readdir cache (update page cache and
> >>i_size) are strongly ordered with following atomic64_set.
> >
> >Thanks for the suggestion, Yan.
> >
> >To be clear: would you like me to integrate your comment and resend?
> >any other suggestions?
> >
> 
> Yes, please

Will do: I'll let the merge window close and send v2 on top of -rc1.

Thanks,
  Andrea
