Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4092AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7D220828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567702621;
	bh=VF21wO/T4d8LCF2D1OECLiXuw50KBbzTmxNIWz5eU6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FGHs1ygpzXCnEfyPvEdK/YaAx4Ovq/k4+8LP2gACf3Bfz0oY4t0qAT5eFZZ/Rnbgo
	 CwF+4ljqnrLNu2zfTJURyEXFSsLFYW+0s+mU6Ix6LPdRoXeUfYk3opB98vpcdlFNpP
	 jzhM3LGZDlK6t3KWvfFG5JllsNH51ERRPozIA6DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbfIEQ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:56:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43808 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389547AbfIEQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:56:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id l22so3579738qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5mycqLCRbA7lwnvP83RNLCIqoNgkUH7WIXxE+/8/JcM=;
        b=WxabH0l5zOXFLoANtc5dyOMXrIGpLtBCH7a2cPEC5NpGTiaWG1DT5brKfMI89xuscs
         7S6MwlN/LmTP8FBpI6SZOyeOjgngVQlVMwYCou9QYgWiM6cJHkg8R/rw9nl2VcU5EO6I
         b4TdV1G9V6M3kgkXUUuYEphAXRB/Qu9GLaoAr3sheLeEhMvxQCPR+YcyrRPuuosk/WKN
         DdWq6v5X30bKhRu9DGkt4SHW4u61V5Efb/sIPRQD4L2bHW+59MNabPqXctPCbsu2FBT1
         953fHpn9iFKRIC3ulNhWoS2HsCwlNX2llRAsv8q98BiCXCOdW1D2FKMFt9dtI/017f+2
         cAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mycqLCRbA7lwnvP83RNLCIqoNgkUH7WIXxE+/8/JcM=;
        b=LWxHVoZrnSvX6zgXQNT3SrZ4Palkn4TjyIiiGpN3ukOt5aeLDI6JFyVqJreDpITLSy
         XPrll0p3B6UMO9Cwm8csncjHDZWaAE1DFOJCqvsKSRmhvyPjmrOqXqoi43VoD6C2TGwK
         POycq9F1KrlHoODy0YCgxMbAj0b3uXAGN9aDxYA91+mVNA2WM/HG3e+erGEdZX4g6kYh
         YCQUu7pYvZi0DuQQbZsJhZWo3XtEfyjsOE80ioxP0eXmc0/EaAckUlQK+si3mRcTC6ws
         6FqqY5R1/IVSixHR4qywYQX0dvte2vdkI+xZKOO8XF+WVrtrdbaENzsbjZJh9zTWeeO4
         3IUQ==
X-Gm-Message-State: APjAAAU0ofaRHSS8Xet3AZazWYgtMnCj6SFr6B4Cm0jNNe2KxlGk/9k+
        cm3FQd4zR9H2gBP7JCBFoHQ=
X-Google-Smtp-Source: APXvYqzzoPepW7IRA2rcCADmuifyBTo2UlZ6moC1zFQim8QWAmnmnOrzoq5SkdeMQbzFQDdXQyMdRQ==
X-Received: by 2002:a05:6214:15d1:: with SMTP id p17mr2513926qvz.74.1567702617502;
        Thu, 05 Sep 2019 09:56:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:5196])
        by smtp.gmail.com with ESMTPSA id w126sm1330151qkd.68.2019.09.05.09.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:56:56 -0700 (PDT)
Date:   Thu, 5 Sep 2019 09:56:55 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20190905165655.GK2263813@devbig004.ftw2.facebook.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
 <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
 <20190903021306.GA217888@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903021306.GA217888@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Namhyung.

On Tue, Sep 03, 2019 at 10:13:08AM +0800, Namhyung Kim wrote:
> So is my understanding below correct?
> 
>  * currently kernfs ino+gen is different than inode's ino+gen

They're the same.  It's just that cgroup has other less useful IDs
too.

>  * but it'd be better to make them same
>  * so move (generic?) inode's ino+gen logic to cgroup
>  * and kernfs node use the same logic (and number)
>  * so perf sampling code (NMI) just access kernfs node
>  * and userspace can use file handle for comparison

The rest, yes, pretty much.

Thanks.

-- 
tejun
