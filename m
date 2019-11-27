Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C38AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE9F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574838522;
	bh=UqlPXgYCB4OEuqIeo+OfzvDZdoCkNQAXuVafkKUn788=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IfVBD5hOurjZPnFj5k2/Kh/algl7sDARynnoVWdsAw+knL9+L4DaOYZsA0pt088t1
	 1FOvfawNH3cu3J3kLGN+94NR88Gn+NdYkqLRKdFatxm6DK7Ya/8eWTSXucwFfbs5lG
	 bh0eTrSdHmSVuh/VWmNICd4ZVLK2Xi+1EM1YiWi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfK0HIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:08:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38686 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK0HIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:08:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so6129573wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 23:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MvmIEpATuvMobwrVTFdR9fJXJjdJiximyoAaKAfPkU0=;
        b=bIC5dDfkOY04fDcZFUcTbzETKsEMDmkJlaljnqs/1S5PvRJNllNE6mJ77CnQQFR6PM
         geOCdgnfDkTTt5T3k6oKnyvKEDV+MUqeukaTYNCsdn+6HE5RVVqckmv+JozUWE/AXaRm
         FzY+Sf5pyPzs86qOzrgDiubG58ARFwK8UojRCAU2hKh7s0hW2Gxf3wxFb3M+pgxyfV5N
         bnr6ZqppWfeQyxATi72U7kKxXGuowdpyADQSHcqsUY6CQ6nXdQFx8gCSgyPLIQRnl1Iy
         OMd7irP99iH7p5al7MiGkAmxyihIGQENI0N6jHNLDe9fbx1fPFSWqa7UYAV72H1+68uL
         J2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MvmIEpATuvMobwrVTFdR9fJXJjdJiximyoAaKAfPkU0=;
        b=tLr3GbTkhzm1wz9ov8zSuohzY/68deYfb2AT8BK3Bg+4i/UkkJ/6vQs1o1z+zwFRn2
         wN4b3UXpS25h2BWevcrJ6DOWNLpx9TJSzDrUpz05pJjky2uzTnCwU89GtmdjT7SUeJqd
         YXFcVm+wxgEixPHhaTHdUe76qSkeqk60mWKMD3sIKnE0/aTbD59A/IL1wwYs2MEW4Qjn
         1tPteK1xk/+7KpiGZWSGXkLsDPjzgmK+0iPCB7G7Ie15IPJdEiTg6otxclQYhS+ZWAAh
         sSv4hZ89NL4EezvDzWatK+vDTIK/Hf0Lf3o7sBTvRpNS9Bli2I9qhJI1mjrZqYo6UNqG
         tSBw==
X-Gm-Message-State: APjAAAXF/OvXyQwNksyyocGXNx7OFhpHh5ZONeMXQau3gkwxPlivluGT
        cIePps2WExDPPG6xljUQW9xUyUm+
X-Google-Smtp-Source: APXvYqxhrlGFapEC7afU3Xwi8zSS+jvG4H2m4aZ4OP9RvUpUsHpcvTRbvNcaZYMn9DObgmomJk+WiA==
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr2673767wmg.92.1574838518662;
        Tue, 26 Nov 2019 23:08:38 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id m15sm18096496wrj.52.2019.11.26.23.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 23:08:38 -0800 (PST)
Date:   Wed, 27 Nov 2019 08:08:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andi Kleen <ak@linux.intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86: Filter MSR writes from luserspace
Message-ID: <20191127070836.GA94748@gmail.com>
References: <20191126112234.GA22393@zn.tnic>
 <87zhgie6nl.fsf@linux.intel.com>
 <20191126203336.GF31379@zn.tnic>
 <20191126205028.GJ84886@tassilo.jf.intel.com>
 <20191126205351.GG31379@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126205351.GG31379@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Nov 26, 2019 at 12:50:28PM -0800, Andi Kleen wrote:
> > You'll almost certainly violate Linus' golden rule of application
> > compatibility and the whole thing will be reverted in the end.

This objection is bogus, the ABI isn't broken, since this is basically a 
tweak of the default security model, by pushing questionable MSR 
modifications to a module or boot parameter. Those who know what they are 
doing can still do it.

The goal would be to make sure via a whitelist that end user distros 
won't have to set this parameter to permissive again, of course.

Thanks,

	Ingo
