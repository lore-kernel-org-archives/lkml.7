Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C36C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA2D206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="OGIdl4Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfE3ORe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:17:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37973 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfE3ORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:17:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so3926829qkk.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pHhULM6LCxpOl4YmMJrRtsFZqp4MioLGBgjQDLV7UUA=;
        b=OGIdl4ZjCoSlz0gdKNWOUYeUIuSpdJRlUHlg3eC6Kry5yyE2RN9BKXXqp7ujZcPc3C
         cdhhCF23BRpzTTjxCSpZXSVGz7w6UsMy/8lwBulW9XbexiU4N3/8zs2Vr6XK9reyEqdo
         tZX5qGydkxevTV27TwcB+na+UmQ++cHqdIDLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHhULM6LCxpOl4YmMJrRtsFZqp4MioLGBgjQDLV7UUA=;
        b=c7rsV3K7740F3Z0/hVPN/gG3W2BJyn7vT7oL31gyyQBgQoYOGgOFF7az67Tc4GvFN3
         kpSH1bCbqXzEW2WK6z7l14xkryM/vKSQwVSzev1NCl2NDBcSOB6H5KGlsc5bgXKFl6Mi
         8G/fxSlgoO+Lw0xCIdx5/ZyeQVn0TF5j3OZejpljU6nmAIg6OChYeP6rkqaz2W+PGpu7
         aWE/PN1JvXPtyxUm/SzNaFukwcxkME9Ts/qAwXnpgSShezNSwb6fUSmRiaoduJiZmDGR
         YAXf5bjDDV+WHE5Kz18B91+0VBUqOWXL8oI7G6TKF6GaICzdbLojv95B9ANIAIRsNhJg
         PAYg==
X-Gm-Message-State: APjAAAVLwYHbgT1A83OEugmFzxsgfPfJuLK1PZQ3iJYPtFblMJMnMshs
        M5bX2zlg/tN8eK6+JvH5pHqewQ==
X-Google-Smtp-Source: APXvYqxSEC1BncPcBKawWoP3L0D9lHeE5bOG+Sj+2evPu176Zw0/3mJOo2lzqlRmoo7tqeMd8QVHAA==
X-Received: by 2002:a37:af03:: with SMTP id y3mr3434003qke.296.1559225852070;
        Thu, 30 May 2019 07:17:32 -0700 (PDT)
Received: from sinkpad (modemcable060.224-21-96.mc.videotron.ca. [96.21.224.60])
        by smtp.gmail.com with ESMTPSA id y8sm1725994qth.22.2019.05.30.07.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 07:17:31 -0700 (PDT)
Date:   Thu, 30 May 2019 10:17:25 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190530141725.GA15172@sinkpad>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-May-2019 10:04:39 PM, Aubrey Li wrote:
> On Thu, May 30, 2019 at 4:36 AM Vineeth Remanan Pillai
> <vpillai@digitalocean.com> wrote:
> >
> > Third iteration of the Core-Scheduling feature.
> >
> > This version fixes mostly correctness related issues in v2 and
> > addresses performance issues. Also, addressed some crashes related
> > to cgroups and cpu hotplugging.
> >
> > We have tested and verified that incompatible processes are not
> > selected during schedule. In terms of performance, the impact
> > depends on the workload:
> > - on CPU intensive applications that use all the logical CPUs with
> >   SMT enabled, enabling core scheduling performs better than nosmt.
> > - on mixed workloads with considerable io compared to cpu usage,
> >   nosmt seems to perform better than core scheduling.
> 
> My testing scripts can not be completed on this version. I figured out the
> number of cpu utilization report entry didn't reach my minimal requirement.
> Then I wrote a simple script to verify.
> ====================
> $ cat test.sh
> #!/bin/sh
> 
> for i in `seq 1 10`
> do
>     echo `date`, $i
>     sleep 1
> done
> ====================
> 
> Normally it works as below:
> 
> Thu May 30 14:13:40 CST 2019, 1
> Thu May 30 14:13:41 CST 2019, 2
> Thu May 30 14:13:42 CST 2019, 3
> Thu May 30 14:13:43 CST 2019, 4
> Thu May 30 14:13:44 CST 2019, 5
> Thu May 30 14:13:45 CST 2019, 6
> Thu May 30 14:13:46 CST 2019, 7
> Thu May 30 14:13:47 CST 2019, 8
> Thu May 30 14:13:48 CST 2019, 9
> Thu May 30 14:13:49 CST 2019, 10
> 
> When the system was running 32 sysbench threads and
> 32 gemmbench threads, it worked as below(the system
> has ~38% idle time)
> Thu May 30 14:14:20 CST 2019, 1
> Thu May 30 14:14:21 CST 2019, 2
> Thu May 30 14:14:22 CST 2019, 3
> Thu May 30 14:14:24 CST 2019, 4 <=======x=
> Thu May 30 14:14:25 CST 2019, 5
> Thu May 30 14:14:26 CST 2019, 6
> Thu May 30 14:14:28 CST 2019, 7 <=======x=
> Thu May 30 14:14:29 CST 2019, 8
> Thu May 30 14:14:31 CST 2019, 9 <=======x=
> Thu May 30 14:14:34 CST 2019, 10 <=======x=
> 
> And it got worse when the system was running 64/64 case,
> the system still had ~3% idle time
> Thu May 30 14:26:40 CST 2019, 1
> Thu May 30 14:26:46 CST 2019, 2
> Thu May 30 14:26:53 CST 2019, 3
> Thu May 30 14:27:01 CST 2019, 4
> Thu May 30 14:27:03 CST 2019, 5
> Thu May 30 14:27:11 CST 2019, 6
> Thu May 30 14:27:31 CST 2019, 7
> Thu May 30 14:27:32 CST 2019, 8
> Thu May 30 14:27:41 CST 2019, 9
> Thu May 30 14:27:56 CST 2019, 10
> 
> Any thoughts?

Interesting, could you detail a bit more your test setup (commands used,
type of machine, any cgroup/pinning configuration, etc) ? I would like
to reproduce it and investigate.

Thanks,

Julien
