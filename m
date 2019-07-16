Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B44C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E6F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EcohRi1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbfGPWly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:41:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37828 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:41:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so9807084pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DGWXFIfIr7/IFH288mFlt26MHGG0aBhmbsLutWSVGes=;
        b=EcohRi1mZ4EKL6fwSiAwLWMcin7sZI+MIk6GCtiDhRSMgWytraFqoXaoMFt+sbbrmE
         oHi2Lcvn9GOyVANvC0LB1lm5QZolkzZfux4aeLYce0/r0oOt5wzbHM50iaMO6QGv+zkS
         XrbhX93qjQC/C2ig8+xzL9NrBodFi1QjO+wxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGWXFIfIr7/IFH288mFlt26MHGG0aBhmbsLutWSVGes=;
        b=mI7LY6UAi+B4pymVnLXkiZtfIOzQdEHL+3nhuhwEhWTDalLJ2CoSGnh/TRVZwIi3Lo
         YByHA/niW8JHsMZU5Dhd528CuRju1P39DNJXrRRc0YkHrJO3GjL7j39qQTAMdAo2RxFF
         2LnUr62RN20WMjJBu6rfj62aq0HZM4D4LUUbVKCqpd/EzgDrw9vwrV0oG6ddqH08JC06
         aLRaybwh5LC8YThYSJCaSQFpiYn6VHMmGhcqT38PhtYGrIH+xkoAGGnW6mZ6W5CFi3je
         cRVzlVd4t5V7ru1gBdRSt3u9oG7ep2GntvzBqRcJxOa5bB6XO7+eyPXHS9McOJDTWkve
         WzKA==
X-Gm-Message-State: APjAAAXMl122GA04drWtfidDpazAX3QI+SwNyd1lZbzFvr+DkxOmjzVf
        XpstguhkaAszLLUkpcxieIk=
X-Google-Smtp-Source: APXvYqzcNNkpVR9OaPGYAXeKbbnGq3wrAudoy6HeZtUyNn20UB68UolNI9+loJGUKXR9bk/jgaWPig==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr3698792pgk.209.1563316913467;
        Tue, 16 Jul 2019 15:41:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x14sm24967454pfq.158.2019.07.16.15.41.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:41:52 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:41:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Brendan Gregg <brendan.d.gregg@gmail.com>, connoro@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        duyuchao <yuchao.du@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        jeffv@google.com, Karim Yaghmour <karim.yaghmour@opersys.com>,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        Manali Shukla <manalishukla14@gmail.com>,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matt Mullins <mmullins@fb.com>,
        Michal Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>, namhyung@google.com,
        namhyung@kernel.org, netdev@vger.kernel.org,
        paul.chaignon@gmail.com, primiano@google.com,
        Qais Yousef <qais.yousef@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC 0/4] Add support to directly attach BPF program to
 ftrace
Message-ID: <20190716224150.GC172157@google.com>
References: <20190710141548.132193-1-joel@joelfernandes.org>
 <20190716205455.iimn3pqpvsc3k4ry@ast-mbp.dhcp.thefacebook.com>
 <20190716213050.GA161922@google.com>
 <20190716222650.tk2coihjtsxszarf@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716222650.tk2coihjtsxszarf@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 03:26:52PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 16, 2019 at 05:30:50PM -0400, Joel Fernandes wrote:
> > 
> > I also thought about the pinning idea before, but we also want to add support
> > for not just raw tracepoints, but also regular tracepoints (events if you
> > will). I am hesitant to add a new BPF API just for creating regular
> > tracepoints and then pinning those as well.
> 
> and they should be done through the pinning as well.

Hmm ok, I will give it some more thought.

> > I don't see why a new bpf node for a trace event is a bad idea, really.
> 
> See the patches for kprobe/uprobe FD-based api and the reasons behind it.
> tldr: text is racy, doesn't scale, poor security, etc.

Is it possible to use perf without CAP_SYS_ADMIN and control security at the
per-event level? We are selective about who can access which event, using
selinux. That's how our ftrace-based tracers work. Its fine grained per-event
control. That's where I was going with the tracefs approach since we get that
granularity using the file system.

Thanks.

