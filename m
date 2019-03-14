Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7383EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4375020657
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552573233;
	bh=wzzya29QyW+T8hDlZFAoUkjxznrh6jDYYb441OOw46s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A3xyqGtr4zRK38WQwylVcVaATIe3TmaRnEh+eDbTEtQrvq4qFP9/BKM3bo+aKbJ5q
	 +Dlb2azZWWIPx8mhRymSTm1gm1w37fv6xxIoGpuQbs3Z4k+31oJCHhv1mhcnnrHUmx
	 bM9wqXXwMBaBXG7CCkwPFSkv2GB0KIvnpAgYD240=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCNOUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:20:32 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41446 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfCNOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:20:31 -0400
Received: by mail-yw1-f66.google.com with SMTP id q128so4516765ywg.8;
        Thu, 14 Mar 2019 07:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8mTep7UKi3RVTha3cdSDpOfpnX8BCXABEaLsSre1NvU=;
        b=rHdXg0qogT4YeqBKO5znP9kNa5gJnDxWrOzCQ2RnIdXL62bhvsf+5iiqtv1WH3RvXr
         j9a9k1X2WvQldA3aS6tc4AQKtz2XZQmETzY6SLpJZtG2crKgq0S4RtzPpKWD5UZk1KZ2
         +w621qdOnd8Nak7Fko1jaHnOgU8UVH1pQ64gjxboqqyO27L2csz4TYm3rz+nHMMGkRYp
         +1klHjX7ICQVBDx0A2Gxg9A0GL7ojbTLxsJqLfmuCjj4XcMXoc5L2muPELKfoBI7EM8+
         3T1XE27Ew0syxnZCipG/vh7B4Ynvhyt9YzMkg1/0gxLzFPEHX2e3m5LpQ4lhexee1FqV
         uOOg==
X-Gm-Message-State: APjAAAUM8EQo58uwihdpvwOUXJrdCjq5GW+tab1As8lTrgpg4onEJJ3y
        aqYbm5EHcKbWX/wncmIDl04=
X-Google-Smtp-Source: APXvYqzJaDVwA2CtV+NhKyXDzAqLj6XrF2XP1FMvT3Y1AKXf6PAH0ucZUopNI84qyl/h+wmGYcGxQQ==
X-Received: by 2002:a0d:c5c3:: with SMTP id h186mr26991941ywd.462.1552573230775;
        Thu, 14 Mar 2019 07:20:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 81sm5866075ywr.21.2019.03.14.07.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 07:20:29 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Thu, 14 Mar 2019 14:20:26 +0000
Date:   Thu, 14 Mar 2019 14:20:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     Shuah Khan <shuah@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] error message found related
Message-ID: <20190314142026.GE1038@42.do-not-panic.com>
References: <20190131183109.10919-1-jeffrin@rajagiritech.edu.in>
 <20190211214002.GV11489@garbanzo.do-not-panic.com>
 <CAG=yYwkYwiB1dfDJg=VB_Kd1Hu+i-WrFN8SyKT9hKP55WzyA3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwkYwiB1dfDJg=VB_Kd1Hu+i-WrFN8SyKT9hKP55WzyA3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:56:46PM +0530, Jeffrin Thalakkottoor wrote:
> > Your subject is too long.
> ok . i have changed it
> 
> 
> > Please upgrade bash?
> anyway now i have an upgraded one.
> 
> here  is a clipping related to the error
> ---------------------x-------------------x----------------
> Thu Feb 14 23:49:13 IST 2019
> Running test: kmod_test_0007 - run #4
> kmod_test_0005: OK! - loading kmod test
> kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
> kmod_test_0006: OK! - loading kmod test
> kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
> ./kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1
> 0006:10:1 0007:5:1 0008:150:1 0009:150:1: syntax error in expression
> (error token is "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1
> 0007:5:1 0008:150:1 0009:150:1")
> ./kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1
> 0006:10:1 0007:5:1 0008:150:1 0009:150:1: syntax error in expression
> (error token is "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1
> 0007:5:1 0008:150:1 0009:150:1")
> Test completed
> $

I do not see this at all. Does anyone else see it?

  Luis
