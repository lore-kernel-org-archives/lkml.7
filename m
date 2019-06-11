Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA481C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3A82173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279131;
	bh=Af2Xf7oCOA4TNNRVlRh/3Omz2g+vvajcN7rh7OOMonQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CPStBqbbb5dxyCEYroRMx6R7GNGjXWjgUZ0M8TFhJwK8Ix7JbeHoTZi77lNi9UEQG
	 n9rbUK9YdgCFVbSsCqyFduBpVJDQ2+SPh1Ir60LO3yo9h8kyIVY0FwpHYx7YErSPoR
	 oQHs9qPyt0wGbntAy4ddFTe03O2WAn6xwS4Kza7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392131AbfFKSwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:52:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39071 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbfFKSwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:52:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so7997956pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yy0OWXyZ8KVFOzQyma6HgIMdzu+QpAU/FsXhUq9xLso=;
        b=ej7JmHmwRccfgX6J9SleW4kdB4KDGp/zlkFhjqLihF0Qg20fcfmQPNhv8Yo4vVgzFb
         r6fl2Yh7LPmoTyKpA+k8WVRXZdX/l/CCm7ERyV7UpACwM5LA9X0dF8loQVuqkTDm1xxe
         2um711N+byV34Tmma9+No0AiRSItUAz1slLbsBcK5OZpIJp2/MSnCIFBcXz2bM4HdRXa
         0PLKAwPi3/q4MlFjauQifoFZXFtBlv5aZjExLl49KxcuNh4TL9MpoBWQgjVcG74dLIZz
         FaY5mQhKhROOkpNRjSG4XKe/tZ+8wTWe/68kw4aj8IDDWMkjwq7/2F9/43z3WEj3D3dS
         rmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yy0OWXyZ8KVFOzQyma6HgIMdzu+QpAU/FsXhUq9xLso=;
        b=W5piQtQej3h8/X8Ci0ZRJJerK1WSStlyE8Kn2NYzRhP6PiQskWvbIAfENFMwfaIW4k
         VrlqrMx3o8iw8Em90hKnwR1x59SWrH00MC5NhOylsXqeiCD536N0Hh+6q2DSDc6lcYXY
         VAqQ9z+eil8tzuH7N7UztTUV9xC7fo4KzT4NgCYLsH8QDaaQ3Mn/ChTG0VACYbXNX3v9
         ta8aX5jA1KhrNwsOZet6g26J5RX0XWkffMvJf7Q0k6ayFTKkFDfrNPrgY3cBYrNuugF2
         3/Rt9a1CznHvmk07vErVus+aEJYzfKVmB2XkWyZ+a0qwg1/R007z2jKfot6+MYOA7hie
         rFQg==
X-Gm-Message-State: APjAAAXyozzb/HMnOWk+JItG10orRYHeB5rZ3ERXR5FVTm1jLTN4ZfR1
        Ar/SoPUwpMYantXb0/9HjMk=
X-Google-Smtp-Source: APXvYqxZttuM3YSEYQATNQB0u9z+UnACicWJQv56CJx/lsbzVj1DKqMvzdoAzz3koBp9Fe7tzkSuEQ==
X-Received: by 2002:a17:90a:30cf:: with SMTP id h73mr28803429pjb.42.1560279129539;
        Tue, 11 Jun 2019 11:52:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id a12sm8962468pje.3.2019.06.11.11.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 11:52:08 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:52:06 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+4d497898effeb1936245@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, mwb@linux.vnet.ibm.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error: WARNING: workqueue cpumask: online
 intersect > possible intersect
Message-ID: <20190611185206.GG3341036@devbig004.ftw2.facebook.com>
References: <000000000000f19676058ab7adc4@google.com>
 <CACT4Y+ZZy5nqduErU8hjKrwThHiybGpwd3QzOviAWftZFZ4d2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZZy5nqduErU8hjKrwThHiybGpwd3QzOviAWftZFZ4d2A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 07, 2019 at 10:45:45AM +0200, Dmitry Vyukov wrote:
> +workqueue maintainers and Michael who added this WARNING
> 
> The WARNING was added in 2017, so I guess it's a change somewhere else
> that triggered it.
> The WARNING message does not seem to give enough info about the caller
> (should it be changed to WARN_ONCE to print a stack?). How can be root
> cause this and unbreak linux-next?

So, during boot, workqueue builds masks of possible cpus of each node
and stores them on wq_numa_possible_cpumask[] array.  The warning is
saying that somehow online cpumask of a node became a superset of the
possible mask, which should never happen.

Dumping all masks in wq_numa_possible_cpumasks[] and cpumask_of_node()
of each node should show what's going on.

Thanks.

-- 
tejun
