Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC803C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D620815
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX5IRl2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfJBATE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:19:04 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45493 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfJBATE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:19:04 -0400
Received: by mail-ed1-f52.google.com with SMTP id h33so13583405edh.12;
        Tue, 01 Oct 2019 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vXTRO1f51dgsXqDnzTMvAOy1VZP11Ly8hhLKToBULAo=;
        b=lX5IRl2RlNZha1HXLktMhgB/5k4qHFwvd9UqTf7hObClzrkt0eUpl8SXu7M2VBcGYd
         KuhENfxEunjTKlcjKvOV8liv/5oVtHoaPz/kx3gjYktm1+ekHBOqSDKwR6EzTUlp2LzL
         UJfXkWe9GFaDIqtaGM0LG4he/1D0LLp61aPSvfraa1muHW1UmBGP8458Y4G59jZBdOni
         fTeJ9W0R5JyWw5ZOY0hRNavfjpAwY1xAupzsdnZ6nocAf2WOxsmbtIy4XxNNKTGH/NiB
         2qSoxB+qMrHaQYLic2A0YgF7TeLeOeydvdIHmoDTZGT5WSGpCTvBKycuBc6p995xxlki
         ZhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vXTRO1f51dgsXqDnzTMvAOy1VZP11Ly8hhLKToBULAo=;
        b=DifVsFBQK4JWXH0zgE24PAbcWGSFIVXTDSJ4+ZhPQ9d49/fPjPv6saMM4DcPZG7MGf
         Fqc5Ez1feCGMIhWFV63MHIL/Svf3S5aDic1TVlDV5T9Lf9MuSTh1ph+vlF/o2gINEjYE
         czKNfPXPM1jSLQjcpa59kB1ZuFFSxNnhvZBAF2tQx/RqTgoz1L4C+OsNhl0/HLw2ZYAS
         sH1/SzMYHOBydUO+/j06jcrmPy5A5EIAqUfBtHWxXs0gA5RtaWFax5GncgzN954vk3TO
         uA0owI/naaJpaK0l4fKbgCQPyFEJwiZyOSzbLYO9upcSzKrozdRxIi9bsXr+fn4rh1H4
         WuvQ==
X-Gm-Message-State: APjAAAW0gaSlwQRzd2agFJ9m0pfLyXOppPY0Cfg5k/yqnpSzbzf7W/H4
        je60IWJHnZ1x1DQYYfkfFqQS2hpm
X-Google-Smtp-Source: APXvYqyepFLItQQIhnNxmZQVwH+9yDq2SSVyiaYcwsLhEEbfrewUgifttjiwVED08Wc6POTeJoec/w==
X-Received: by 2002:aa7:c4d0:: with SMTP id p16mr1014976edr.266.1569975542438;
        Tue, 01 Oct 2019 17:19:02 -0700 (PDT)
Received: from desk.local ([2a02:a03f:4080:1900:c8a8:489c:8544:d3e4])
        by smtp.gmail.com with ESMTPSA id z39sm3487833edd.46.2019.10.01.17.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:19:01 -0700 (PDT)
Date:   Wed, 2 Oct 2019 02:19:00 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org
Subject: Re: Many unexpected warnings with current sparse
Message-ID: <20191002001859.qeyo3btl7tosz3vo@desk.local>
References: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
 <20191001231017.67txq4dhrvhyzbu5@desk.local>
 <CAH2r5mvnYtmfpHY+jeUbN4JehQwY1XfBWYVNSLO+wx1wkAA6gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvnYtmfpHY+jeUbN4JehQwY1XfBWYVNSLO+wx1wkAA6gA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:14:23PM -0500, Steve French wrote:
> It may be related to the following sparse make warning:
> 
> No rule to make target
> '/usr/include/x86_64-linux-gnu/bits/huge_val.h', needed by
> 'sparse-llvm.o'
> 
> I don't see huge_val.h in the Ubuntu 19 version of libc6-dev

Yes, I've been bitten myself by this. It's fixed since a little while.
So, just doing a clean build or removing all the deps (.*.d)
should allow you to build sparse.
 
I've verified the problem with asm and __inline in quota.h:
it's autodetected by kconfig (CC_HAS_ASM_INLINE) so the exact config
doesn't matter (only gcc's version does) but in all cases recent
versions of sparse don't have a problem with it (an upstream version
of `sparse --version` should return "v0.6.1-rc1-37-gd466a0281").

Best regards,
-- Luc
