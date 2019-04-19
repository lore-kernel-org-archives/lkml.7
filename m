Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB69C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5020643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555700482;
	bh=BLzOKfj2jVAqEtKTCL2mM9RY50WMl9H+jqil9WkFS1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a9yZOP73GOFtK3V+zrcvZyAY/abR4btzjADrjfHT07UeBqNgzaTUZzNmfGGU78tzU
	 5jq+y0fqQhFJeDuS9TPpI6QYIIoM+3yZlYgHOZSoOY2tw4sAOjZACfo6guHn0nZRXI
	 Clvgt7X4xvd8k6PqHxG1fW1aST/ZqrhW9WXGy2UA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfDSTBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:01:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40194 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfDSTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:01:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so7930189wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pE4QfeyozDJk6wp5vAMY7zRWHsv00K/WmdJQ3fe/zk8=;
        b=pE9AQ3LhrTyXPbobNVa5g+Va2diZ6RHtbt1LY4XQWEaL0UjgksnVD6qfkrgWSZsmai
         UxAAT1u+2BUG1gL4Jysz7LtnKSivE7NZ/8GYk7AD25noCA6Zyq+ocnlNa1WqVy5ZSMiK
         FRsHSg/q33xYtvz1lS9EVrp8OkKuF5I++S7tqFhhhMvYq8eyHJvi6TeFBse04IlEj+YU
         ZgWZsI9Iy+bnlWlCp4C6klkFm85zQboVO87OQKUEHY9W0K2nYIecN7lY4oLGSBCVQvqg
         HgdBoQGcLU9c26VcViqdy+1hqizC6Nctjjd17CT1VPIalao5hfg09Ji4w8cMS8QWRqwC
         XUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pE4QfeyozDJk6wp5vAMY7zRWHsv00K/WmdJQ3fe/zk8=;
        b=BnkkOgSHL9xh/dqGeN8U6m7hzogAP8CMAh5VzyN10YGDuRIZovibZFMyd4Ji4HPv3A
         oPy5ifX34dBSce9NsqSXcWzRFRQiER0h55tcLfLTUalx1jAzButoT/qBlJFrIC9JG5Ad
         v0VNEpAjamWIlk+rSSPgYGh3+Amo+o6kntZ3ltKWSndsU7rU/XuY0kMzLRWxD4N7lXIh
         Za0G/z7gjBZO5OvRo9UGJ1wyV4B30xrSpK821SIO7nmLQdckKQiMDw9YVApRf+KFrfpq
         8X67aZoLJkMF2RVGrHlI2w6R6B28OBgs/swOIuHN9nUm6Rr8k09uAQyWJTLsA9rMWZRw
         HSlA==
X-Gm-Message-State: APjAAAWp0FpO+X8AolZB5F2+SKHxTGJmEh2zJwoILOhJ/29034jMj0X/
        qCntZ3dHdPXsqJVxMUa49/ZW7gwT
X-Google-Smtp-Source: APXvYqynAvniqRo62b68csy0wDuhyK4h+d7MFZxlTveE2cmPWuaX/QnNivPUl6DqCf0oIwtoxaMC9A==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr4226840wrn.39.1555700476025;
        Fri, 19 Apr 2019 12:01:16 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 11sm3953916wmk.17.2019.04.19.12.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 12:01:15 -0700 (PDT)
Date:   Fri, 19 Apr 2019 21:01:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V3 0/9] x86/jump_label: Bound IPIs sent when updating a
 static key
Message-ID: <20190419190112.GA95540@gmail.com>
References: <cover.1545228276.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545228276.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> Considering that, in this test case, we are saving the handling of 53 IPIs,
> that takes more than these 135 ns, it seems to be a meager price to be paid.
> Moreover, the test case was forcing the hit of the int3, in practice, it
> does not take that often. While the IPI takes place on all CPUs, hitting
> the int3 handler or not!
> 
> For instance, in an isolated CPU with a process running in user-space
> (nohz_full use-case), the chances of hitting the int3 handler is barely zero,
> while there is no way to avoid the IPIs. By bounding the IPIs, we are improving
> this scenario a lot.
> 
> Changes from v2:
>   - Switch the order of patches 8 and 9 (Steven Rostedt)
>   - Fallback in the case of failure in the batch mode (Steven Rostedt)
>   - Fix a pointer in patch 7 (Steven Rostedt)
>   - Adjust the commit log of the patch 1 (Borislav Petkov)
>   - Adjust the commit log of the patch 3 (Jiri Kosina/Thomas Gleixner)
> Changes from v1:
>   - Split the patch in jump-label/x86-jump-label/alternative (Jason Baron)
>   - Use bserach in the int3 handler (Steven Rostedt)
>   - Use a pre-allocated page to store the vector (Jason/Steven)
>   - Do performance tests in the int3 handler (peterz)
>
> Daniel Bristot de Oliveira (9):
>   jump_label: Add for_each_label_entry helper
>   jump_label: Add the jump_label_can_update_check() helper
>   x86/jump_label: Move checking code away from __jump_label_transform()
>   x86/jump_label: Add __jump_label_set_jump_code() helper
>   x86/alternative: Split text_poke_bp() into tree steps
>   jump_label: Sort entries of the same key by the code
>   x86/alternative: Batch of patch operations
>   jump_label: Batch updates if arch supports it
>   x86/jump_label: Batch jump label updates
> 
>  arch/x86/include/asm/jump_label.h    |   2 +
>  arch/x86/include/asm/text-patching.h |  15 +++
>  arch/x86/kernel/alternative.c        | 140 ++++++++++++++++++---
>  arch/x86/kernel/jump_label.c         | 174 ++++++++++++++++++++++-----
>  include/linux/jump_label.h           |   6 +
>  kernel/jump_label.c                  |  73 +++++++++--
>  6 files changed, 359 insertions(+), 51 deletions(-)

Note that I've applied these to tip:WIP.x86/alternatives to help move it 
along and help with testing, but before this can go upstream review 
feedback from PeterZ needs to be addressed.

Please send the latest series (v3, v4, etc.) with full patches to make it 
easy to review from scratch to everyone - I'll reshuffle the WIP branch 
accordingly. These are not stable SHA1's yet.

Thanks,

	Ingo
