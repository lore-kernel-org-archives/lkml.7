Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505A120830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KfrrI3Vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfCYNtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:49:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbfCYNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:49:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so5615850pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gEMxR3R8hBEpdUjHceXVmy1fI1OviFSo7Nzefk6Rk0c=;
        b=KfrrI3VpHzDfm+Fo6yJwhGo1KsoPzZdLadcmNAfepasR4k0Zoqf0byf/mXPV8y22EV
         xckeKuzr63x4zukHO9VmiNCxCAmyBWP4px9fYcjRPIkTZY1BBsFqVv/iYrqjorRj2Fcz
         Jp9WnLuu/hzw4wazOoNB6XyuJTKLA1hoptFeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gEMxR3R8hBEpdUjHceXVmy1fI1OviFSo7Nzefk6Rk0c=;
        b=IB52Pg+jtJ0rxmFMSHSELFSoMTiopEVYqj2o4C8YkMghbBFB9b1Z+EljVRQjy31ZT2
         6MBPHOzIoPZdUE5JYozqBDBVcQJAlhdfwEbjnCBdkq4y8QjkmX1vx8ZQI1fxhbvxClm2
         +o4ReQzuZpW5vBRY1pr6n1FsCRwZejZs03hFKhHzjBWUedc3C3R/CLahLHanDXSB9RBO
         EdUhXVB2h0pbps9TrQyCRwfTc+e5xt4aEraMdeLwSQeGzf910bVYlFUHd9vTCebkjWYo
         +/7DjOlMgmbTWkrYhWrbhPG5TVBrC14q0pnTg0wMbwnJhReMtT0NVZgHrOUUlrC3Zr/F
         avkg==
X-Gm-Message-State: APjAAAWlyYgdTsZ3Jw2GWs48vmgq2e7aqsmkVueH44rHLgj4OPs4BU3q
        hRaIQDy0wQ1E9lVy8ZggTbMU4g==
X-Google-Smtp-Source: APXvYqzXcT4KS4Ahs0r/dMLNwVDljzWyaTnGeltOejYIVHFrWGFL/+7OX6BUZ1c9XSdoS7dHbQKf9w==
X-Received: by 2002:a63:ca:: with SMTP id 193mr23340447pga.288.1553521789564;
        Mon, 25 Mar 2019 06:49:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r86sm25637914pfa.82.2019.03.25.06.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 06:49:48 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:49:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
        karim.yaghmour@opersys.com, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yhs@fb.com
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190325134947.GA187133@google.com>
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 07:19:29PM -0800, Alexei Starovoitov wrote:
> On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > Introduce in-kernel headers and other artifacts which are made available
> > as an archive through proc (/proc/kheaders.txz file). This archive makes
> > it possible to build kernel modules, run eBPF programs, and other
> > tracing programs that need to extend the kernel for tracing purposes
> > without any dependency on the file system having headers and build
> > artifacts.
> > 
> > On Android and embedded systems, it is common to switch kernels but not
> > have kernel headers available on the file system. Raw kernel headers
> > also cannot be copied into the filesystem like they can be on other
> > distros, due to licensing and other issues. There's no linux-headers
> > package on Android. Further once a different kernel is booted, any
> > headers stored on the file system will no longer be useful. By storing
> > the headers as a compressed archive within the kernel, we can avoid these
> > issues that have been a hindrance for a long time.
> 
> The set looks good to me and since the main use case is building bpf progs
> I can route it via bpf-next tree if there are no objections.
> Masahiro, could you please ack it?

FYI, Masahiro's comments were all address by v5:
https://lore.kernel.org/patchwork/project/lkml/list/?series=387311

I believe aren't more outstanding concerns. Could we consider it for v5.2?

thanks,

 - Joel
