Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88570C352AB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E68620835
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYrL4qkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfIZT2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:28:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35986 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfIZT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:28:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so60840plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MPY9mLobCsFCdGTyhVub8qrg9jLGGnIpfTk+BisJCH8=;
        b=VYrL4qkfnIoJrXhQd4N/uNnqbiyr0k4cU5NBaiNVQ648M7nmosCB93lB4YioJ8uFMn
         66ApM6ofqMqBsXccCOTc4B4eMP5whHQ/qS1OvSBcwUVi5afpmn1lOiMb6dKwFhnHJIbJ
         KYjML4oqBtqr88sdA6pv1lxhcELEjTl06Y7scpK3CarFPh8/khNXk7ftZqi710Db2oms
         nfRxRuETzBWF0hjP9Is7uo9VGJpqPAozmDMQRme3O+FTd0J5h5Id+Ydm1aUx3NXI+sh0
         BEa7zLccBudk4dj6ZlnVUCwcLP9gpavNz9Me5fn7dxcwJgNbiAIc1520e1/MBu9vS2hk
         aQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MPY9mLobCsFCdGTyhVub8qrg9jLGGnIpfTk+BisJCH8=;
        b=kNjW4/idjYiIzMrvQw5mrlpVQNAFiEjNPJuvfXFTIJe8YdV48HG9hAhc+juzODhLhQ
         78IDLNZW6w7wa43ztoW0pGU9kmPwXpcWRtYpt/pmw5CvNp/9rpJDHB9xI0CXHQPOPZ4D
         OnI7wtQfHzjT9Ihp2GO0ZqfLuI06ZUPJbD8jlpwAAtUpkCH5Sg2GKST+sVoFFcx1DI3S
         FEeYeGtidw08yJFM0Rfy+Lj2Mvb6hHuUb5MjKomXsShmZzgTpeU3PkhypVrgt9EPYzLb
         pUjdm0TMe8mPJVb5++BCH8R4IL+97urlQprkyUJ55yQ604llSrWzQddB4Nt1sKdiFEjf
         2hbQ==
X-Gm-Message-State: APjAAAXIRG+PxfvaaQoXlgKnpwSa9HTu8fIqGAG3dpAiytW6bSIvfHqz
        4nEwHUx34XTuzA+EZCLpgAz8sw==
X-Google-Smtp-Source: APXvYqwQv1h8+xAWm6OIXAeweA7guotoMUQPeA635I7aV4IJbD4SmqA/ZxJLNxKi7FavCZOcyKsUww==
X-Received: by 2002:a17:902:720a:: with SMTP id ba10mr215767plb.328.1569526093196;
        Thu, 26 Sep 2019 12:28:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c125sm66697pfa.107.2019.09.26.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:28:12 -0700 (PDT)
Date:   Thu, 26 Sep 2019 12:28:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        shuah <shuah@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
In-Reply-To: <CAHS8izPfKQA8qTndyzWSm9fR_xJ=X-xmE+4P4K+ZFdxrYNuLBA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909261220150.39830@chino.kir.corp.google.com>
References: <20190919222421.27408-1-almasrymina@google.com> <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com> <CAHS8izOj2AT4tX-+Hcb8LB2TOUKJDHScDtJ80u4M6OWpwktq0g@mail.gmail.com> <a8e9c533-1593-35ee-e65d-1f2fc2b0fb48@oracle.com>
 <CAHS8izPfKQA8qTndyzWSm9fR_xJ=X-xmE+4P4K+ZFdxrYNuLBA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019, Mina Almasry wrote:

> > I personally prefer the one counter approach only for the reason that it
> > exposes less information about hugetlb reservations.  I was not around
> > for the introduction of hugetlb reservations, but I have fixed several
> > issues having to do with reservations.  IMO, reservations should be hidden
> > from users as much as possible.  Others may disagree.
> >
> > I really hope that Aneesh will comment.  He added the existing hugetlb
> > cgroup code.  I was not involved in that effort, but it looks like there
> > might have been some thought given to reservations in early versions of
> > that code.  It would be interesting to get his perspective.
> >
> > Changes included in patch 4 (disable region_add file_region coalescing)
> > would be needed in a one counter approach as well, so I do plan to
> > review those changes.
> 
> OK, FWIW, the 1 counter approach should be sufficient for us, so I'm
> not really opposed. David, maybe chime in if you see a problem here?
> From the perspective of hiding reservations from the user as much as
> possible, it is an improvement.
> 
> I'm only wary about changing the behavior of the current and having
> that regress applications. I'm hoping you and Aneesh can shed light on
> this.
> 

I think neither Aneesh nor myself are going to be able to provide a 
complete answer on the use of hugetlb cgroup today, anybody could be using 
it without our knowledge and that opens up the possibility that combining 
the limits would adversely affect a real system configuration.

If that is a possibility, I think we need to do some due diligence and try 
to deprecate allocation limits if possible.  One of the benefits to 
separate limits is that we can make reasonable steps to deprecating the 
actual allocation limits, if possible: we could add warnings about the 
deprecation of allocation limits and see if anybody complains.

That could take the form of two separate limits or a tunable in the root 
hugetlb cgroup that defines whether the limits are for allocation or 
reservation.

Combining them in the first pass seems to be very risky and could cause 
pain for users that will not detect this during an rc cycle and will 
report the issue only when their distro gets it.  Then we are left with no 
alternative other than stable backports and the separation of the limits 
anyway.
