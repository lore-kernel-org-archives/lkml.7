Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1BF217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aqrr9mcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDKQUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:20:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45754 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKQUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:20:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so3673587pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3w9TkuZHAqslrWVxIfj/pr9QdQEYv2bicep/qG+WXX8=;
        b=aqrr9mcq2AeDtB59HAIaIucdjBx2Yzk4ptZilZRNndX4ha+I/ju9YYj6Ggq9psCcEz
         hfJ+mbRqvBmAbF1f+WvsNFsFx/SGp9HVcxK7Ubjt5dpdAcTKAm0klQaEKf/Vye2SKLMP
         AmxCHFkVF6LGPtlspwIna02aLr9Ak/6fx+p9RNdrExRDBFEUxLgR40S24CZXf1g9nU/Z
         rJ9uqvU/B/pldGfMkK9jbbCAZGSt+ViBEROl5PTlZAVVNcTn9wq4FzBGrcqCqdmDTLh8
         gygeK5c51xR8R0XeR0q5qi5WCnUGLHmY5qtRS5RQy5JA0JI46557f9Co/Wvw+bBfqWnG
         kKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3w9TkuZHAqslrWVxIfj/pr9QdQEYv2bicep/qG+WXX8=;
        b=o1qcOWVWASRGhD1NP7jVtrrpBY2Wkf/XpQNbSwLbI1I/mjZGl4MHDJKA7+nwmPFK6k
         BWvEr770Hzbmq021yvU6jXxtmTQba2f5PAeE1sPG9vojMa/2muPQbyQXMZ/OlW3eR9ZF
         Je7zkRZqA12MYoZ77wVAcYrNlRkaZa+7GiUDnULlX4MnT6mDv8eipUAtqKoFR9r/HuUs
         M+OiRqmrlQjF9PegNiJorQvEMXYLw2fKmBuYcg9R2EmFkMPhisrl9MMpwAXhU7cSAk4p
         hFKUIa90cDUpJhb/QQy16oH0NN/W9FSPhLFwGnZZEwmkeaDJJf4VRETRMk479wXoGSWB
         0xrQ==
X-Gm-Message-State: APjAAAWYf9R4T+d8t4AztCHJyTLzhBiX2n6Asko04vHFcZuCx3Gfnp4f
        NS15Bv8C52Rc7N4ZBq0JoiDp4Q==
X-Google-Smtp-Source: APXvYqzUPW5eM71ndUc6UDWTkzD31OKaYqK67v6v5VZ9SRY7hlz4748BeUborAx0SFYr/LSSK6DuEg==
X-Received: by 2002:a62:69c2:: with SMTP id e185mr50470609pfc.119.1554999623683;
        Thu, 11 Apr 2019 09:20:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3fed:2d30:9d40:70a3])
        by smtp.gmail.com with ESMTPSA id c22sm42692365pfn.136.2019.04.11.09.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 09:20:23 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:20:22 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        rientjes@google.com, willy@infradead.org,
        yuzhoujian@didichuxing.com, jrdr.linux@gmail.com, guro@fb.com,
        hannes@cmpxchg.org, penguin-kernel@I-love.SAKURA.ne.jp,
        ebiederm@xmission.com, shakeelb@google.com, christian@brauner.io,
        minchan@kernel.org, timmurray@google.com, dancol@google.com,
        joel@joelfernandes.org, jannh@google.com, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RFC 0/2] opportunistic memory reclaim of a killed process
Message-ID: <20190411162022.GB124555@google.com>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411105111.GR10383@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411105111.GR10383@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:51:11PM +0200, Michal Hocko wrote:
> On Wed 10-04-19 18:43:51, Suren Baghdasaryan wrote:
> [...]
> > Proposed solution uses existing oom-reaper thread to increase memory
> > reclaim rate of a killed process and to make this rate more deterministic.
> > By no means the proposed solution is considered the best and was chosen
> > because it was simple to implement and allowed for test data collection.
> > The downside of this solution is that it requires additional “expedite”
> > hint for something which has to be fast in all cases. Would be great to
> > find a way that does not require additional hints.
> 
> I have to say I do not like this much. It is abusing an implementation
> detail of the OOM implementation and makes it an official API. Also
> there are some non trivial assumptions to be fullfilled to use the
> current oom_reaper. First of all all the process groups that share the
> address space have to be killed. How do you want to guarantee/implement
> that with a simply kill to a thread/process group?
> 
> > Other possible approaches include:
> > - Implementing a dedicated syscall to perform opportunistic reclaim in the
> > context of the process waiting for the victim’s death. A natural boost
> > bonus occurs if the waiting process has high or RT priority and is not
> > limited by cpuset cgroup in its CPU choices.
> > - Implement a mechanism that would perform opportunistic reclaim if it’s
> > possible unconditionally (similar to checks in task_will_free_mem()).
> > - Implement opportunistic reclaim that uses shrinker interface, PSI or
> > other memory pressure indications as a hint to engage.
> 
> I would question whether we really need this at all? Relying on the exit
> speed sounds like a fundamental design problem of anything that relies
> on it.

OTOH, we want to keep as many processes around as possible for recency. In which
case, the exit path (particularly the memory reclaim) becomes critical to
maintain interactivity for phones.

Android keeps processes around because cold starting applications is much
slower than simply bringing them up from background. This obviously presents
the problem when a background application _is_ killed, it is almost always to
address sudden spike in memory needs by something else much more important
and user visible. e.g. a foreground application or critical system process.

> Sure task exit might be slow, but async mm tear down is just a
> mere optimization this is not guaranteed to really help in speading
> things up. OOM killer uses it as a guarantee for a forward progress in a
> finite time rather than as soon as possible.

With OOM killer, things are already really bad. When lmkd[1] kills processes,
it is doing so to serve the immediate needs of the system while trying to
avoid the OOM killer.


- ssp

1] https://android.googlesource.com/platform/system/core/+/refs/heads/master/lmkd/
