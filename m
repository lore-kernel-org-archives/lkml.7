Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A5CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74742146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SdOOU2ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfC0RbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:31:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33664 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfC0RbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:31:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so1392793pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wze83KFIvJTV8YI9HnSthl69lDUr/t9qneSOCvDPwuo=;
        b=SdOOU2hawDlo5SMbEn9D2CIF+57XHG+Np+8/YOU8jfYrzQb9EtsEViDRR6QVjuczdq
         vwD1JMvisVX+L2XBmIrDJid9FKifEg/6SxMp3r9GC0seMybpj53JzUliGn+EiaFYb1mp
         40b/KVkkbOV9eLTG1ErMds04ybgFDOSahHxNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wze83KFIvJTV8YI9HnSthl69lDUr/t9qneSOCvDPwuo=;
        b=TEGmW+PQyDhuaJ3IIWgfP+1e89kR1ZAU5VjNpwLdRW5MjhlQbWibSSmvNigjV0eJ49
         AQUCr3Mmi0vdF5jY/6sWdFm/0872n2LXxCcTqVTCZOX92QWQQHpkDfjfpBxnmpyuo3/i
         4DavtcFBUE/zmsWZEKtwu9VAcq1TX7MDCugvaum204N07vAkyKeEBbjCNvDaFGAXQp8K
         yaNUble/DhillBaSkKEWoYJFFG9/6QGsoP5Lx8QquaVqsLTDQfZPGoxcFlO4YDVaZO9V
         8cX5V7N9PcoDPgTZ2MilwtXcxG3/wJs0amSmruf3Am8vd06AafQLdYG07/wYJckm8y6u
         5TQA==
X-Gm-Message-State: APjAAAWBrhLz5tXHODRYlqqb5B862yp3LsfEnigHn7fQ/zoyeXw0E6WZ
        UbYALyM75rNDvHq76TDaIzaUyA==
X-Google-Smtp-Source: APXvYqxfzd5JrLje0ulUoGoeoWa0jegNU5VZnyBKdl4S9CJ1ugHkq+sCNO41wLB6Z/a+lVS1qV2Xpg==
X-Received: by 2002:a62:14d7:: with SMTP id 206mr8302102pfu.162.1553707866476;
        Wed, 27 Mar 2019 10:31:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d69sm28438011pfg.26.2019.03.27.10.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 10:31:04 -0700 (PDT)
Date:   Wed, 27 Mar 2019 13:31:03 -0400
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
        rdunlap@infradead.org
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190327173103.GA205980@google.com>
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
 <20190325134947.GA187133@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325134947.GA187133@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:49:47AM -0400, Joel Fernandes wrote:
> On Thu, Feb 14, 2019 at 07:19:29PM -0800, Alexei Starovoitov wrote:
> > On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > > Introduce in-kernel headers and other artifacts which are made available
> > > as an archive through proc (/proc/kheaders.txz file). This archive makes
> > > it possible to build kernel modules, run eBPF programs, and other
> > > tracing programs that need to extend the kernel for tracing purposes
> > > without any dependency on the file system having headers and build
> > > artifacts.
> > > 
> > > On Android and embedded systems, it is common to switch kernels but not
> > > have kernel headers available on the file system. Raw kernel headers
> > > also cannot be copied into the filesystem like they can be on other
> > > distros, due to licensing and other issues. There's no linux-headers
> > > package on Android. Further once a different kernel is booted, any
> > > headers stored on the file system will no longer be useful. By storing
> > > the headers as a compressed archive within the kernel, we can avoid these
> > > issues that have been a hindrance for a long time.
> > 
> > The set looks good to me and since the main use case is building bpf progs
> > I can route it via bpf-next tree if there are no objections.
> > Masahiro, could you please ack it?
> 
> FYI, Masahiro's comments were all address by v5:
> https://lore.kernel.org/patchwork/project/lkml/list/?series=387311
> 
> I believe aren't more outstanding concerns. Could we consider it for v5.2?

Just to highlight the problem, today I booted v5.0 on an emulated Android
device for some testing, that didn't have a set of prebuilt headers that we
have been packaging on well known kernels, to get around this issue. This
caused great pain and issues with what I was doing. I know me and many others
really want this. With this I can boot an emulated Android device with
IKCONFIG_PROC=y and run BCC with that that. Also I want to do the BCC side of
the development, but first want to know if we can merge this upstream.

Masahiro, I believe due diligence has been done in solidifying it as posted
in the v5.  Anything else we need to do here? Are you with the patches?

thanks!

 - Joel

