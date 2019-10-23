Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9134CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70816214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571833346;
	bh=FNIPVrq2LQ8gefsurgILCb/DLkZroCyJOYJn/s1YYw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b8G78PzQYcD0xd3Oo1fgfos6fjfUmxXESEKESRh+ri0mzshFj9Os4mCAVLoC8571H
	 r88YCkXTR/vXugNHEcqdfi3Q6A3GcCEhgM8KP0+r0/LRbK+io0jelw+LoLp5dKpkq8
	 ed6+RYyjBv6BD8dJScKGg2uXPI7h1Z7IOqP7SQl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405309AbfJWMWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:22:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35835 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJWMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:22:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id c3so10023886plo.2;
        Wed, 23 Oct 2019 05:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGOd+RlzHcqaTlF1JPWEkVlZmBukFEwJbzB8xB2wblk=;
        b=FjvfOW/5TY+zYLAFTUHJbU0pTTKuSep6aCaPc28Y3VOTm49UI/K5PeDskMioNLD3nz
         frc4EMqi4x1F1qfj8uBAnjhudU/75GfUDoA8ZfalPl0CUdEXqSQORIbzHzHuW+Qhujyj
         jshcvNzsyK61XB4M09gGOPEG2dWEHyrCI9WB/66aHXrqwD56QSohsiLcgRUpgETm08Tt
         SeszwR0v89nMEhf9yioMjg7rHj4IqKX6I6LAYTM7zUR0iRLQ4z6lasOVlMwjokplFKp7
         b2+u0dtHpUGTmUdtTM9EQ7Q7oPSPL3ywOInGAIBxkuk7jolRZG/I5IoMF9uOHr6qaRQz
         xsMw==
X-Gm-Message-State: APjAAAVF8NsNbNMqJeAOXdC+EDjpa414O8XmWra2EKUADPnUcNQT4Hfh
        OJ1XgnKFA5LAGhhqpAMV0Oo=
X-Google-Smtp-Source: APXvYqy5diu3PtRJ2JIKX1AdFDxYHzyNkjfxebBm29xPVpKyTPe11U6ji3IiHAbkpA1Iok43Zy9PYA==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1mr9355798plt.67.1571833344011;
        Wed, 23 Oct 2019 05:22:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m5sm23643604pgt.15.2019.10.23.05.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:22:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 76BEF40244; Wed, 23 Oct 2019 12:22:22 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:22:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Shaun Ruffell <sruffell@sruffell.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/4] export/modpost: avoid renaming __ksymtab entries
 for symbol namespaces
Message-ID: <20191023122222.GA27861@42.do-not-panic.com>
References: <20191010151443.7399-1-maennich@google.com>
 <20191018093143.15997-1-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018093143.15997-1-maennich@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:31:39AM +0100, Matthias Maennich wrote:
> The introduction of the symbol namespace patches changed the way symbols are
> named in the ksymtab entries. That caused userland tools to fail (such as
> kmod's depmod). As depmod is used as part of the kernel build it was worth
> having another look whether this name change can be avoided.

Why have this as a default feature? What about having an option to
disable this feature? The benefit being that without a full swing of
tests to avoid regressions its not clear what other issues may creep
up. With this as optional, those wanting the mechanism can enable it
and happilly find the issues for those more conservative.

  Luis
