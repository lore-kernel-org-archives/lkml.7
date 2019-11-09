Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCF5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 20:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8DF20869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 20:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAXINlTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKIU1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 15:27:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33280 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfKIU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 15:27:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id a24so5198895edt.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 12:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+8khpJ1Hz+tMD0njO1mPXhcUz3AaktW0QE8s0RXEy0=;
        b=cAXINlTqhr2dYYRGvd9NyArzc+EEga3e/Nr45Py3EXZQkp8APG66x9NL+TlBrJNRuE
         WMDl88rcOO5QiMtFtuOZGWGdm0PUfwJsY6KNrS9v3OoAIamKh5LFa69MH/du7nB0Vegs
         Ts5glrzo3MD0jk5JV6/lzhHpFCYeH3WI4o0woPVbY8tGPYI8J9UFewDOgRVq6DyowxNf
         KgvNAULB6HecR8O93lRomvc5Ch25S+XIrnY6IHDPqYuiztZdaJZhrZWcbsYBI3ZZc12m
         ISs2hpsm4bcpFCao14BmtTho/xIPg2rgb0U5+uv0vGlxT836+RM2Lr50snCA9TQWEpl5
         5Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+8khpJ1Hz+tMD0njO1mPXhcUz3AaktW0QE8s0RXEy0=;
        b=dbTDhHFBXP9z5zumiog7ly+cr1sqhHbNYq4nOofxNTShWmgx3n5+RBoTDIcdLVr/MJ
         ZvT5gAk+lz7qtgOWuFFHiJwK8JsSiSP424ulYiWTTN8aSke6khjdPhBbCVFKk2tN4z2A
         iEO2A+ro0gfW2c4dYXjjN/RuzeQ2DNf877w0+QtxzFe/7oIJLEqMeJzpMVHZVxh/ZnVc
         9z8OtI4qCVqaS8Ops+DKKje3d/qaQJDWe5MJfT7c04uVU8LTMskBVnjVCJAcxXdSLUk3
         M4aZFKc6GYYBZZvkMGedLx/8iOMJaBx/lFSyClr4/VbpUE3VQjQr6WTVOvgVEMyBZBcz
         lfDQ==
X-Gm-Message-State: APjAAAX40fLqB2raBH5EzfZhD0i5STm0sfWFpkewrH6rhN+PDIXq/xh1
        gLQ70mQ6eNhgX1o3+mNcJHgA6wDk1odg3jA3T+sNLQ==
X-Google-Smtp-Source: APXvYqzHkGJ3thq037poRWi7Fb25K2gOcNkPsCPTR5ycyhsTeNJ5+LOyIylym/6LOuq7Wh1X2CEkYzCBoL15Tpu5SS4=
X-Received: by 2002:a17:906:d93b:: with SMTP id rn27mr3416343ejb.184.1573331260654;
 Sat, 09 Nov 2019 12:27:40 -0800 (PST)
MIME-Version: 1.0
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com> <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com> <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
 <20191109084820.GC1289838@kroah.com>
In-Reply-To: <20191109084820.GC1289838@kroah.com>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Sat, 9 Nov 2019 12:27:29 -0800
Message-ID: <CAOCOHw4AFz2Rj3sLTrboA0pBOkL_5MbitJnFHgBYaVBbWyYATw@mail.gmail.com>
Subject: Re: [GIT PULL] interconnect changes for 5.5
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 9, 2019 at 12:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 08, 2019 at 05:36:46PM -0800, Bjorn Andersson wrote:
> > On Fri, Nov 8, 2019 at 2:39 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Nov 07, 2019 at 05:42:13PM +0200, Georgi Djakov wrote:
> > > > Hi Greg,
> > > >
> > > > On 11/7/19 16:21, Greg Kroah-Hartman wrote:
> > > > > On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
> > > > >> Hi Greg,
> > > > >>
> > > > >> This is a pull request with interconnect patches for the 5.5 merge window.
> > > > >> All patches have been for a while in linux-next without reported issues. The
> > > > >> details are in the signed tag. Please consider pulling into char-misc-next.
> > > > >
> > > > > I don't know about
> > > > > 0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
> > > > > Shouldn't you just fix up the dependancies of subsystems that rely on
> > > > > this?  We are moving more and more to kernels that "just work" with
> > > > > everything as modules, even on arm64 systems.  So forbiding the
> > > > > interconnect code from being able to be built as a module does not feel
> > > > > good to me at all.
> > > >
> > > > Thank you for commenting on this! The initial idea was to keep everything as
> > > > modular as possible. The reasons behind this change is that other core
> > > > frameworks like cpufreq (and possibly others) want to call the interconnect
> > > > APIs. Some of these frameworks are built-in only and it would be easier to
> > > > handle dependencies if interconnect core built-in too. Now each user that
> > > > can be built-in has to specify in Kconfig that it depends on INTERCONNECT ||
> > > > !INTERCONNECT.
> > >
> > > That's fine, when those subsystems start to use those apis, that
> > > dependency needs to be added.  Nothing new here, and you forcing it to
> > > either be "on or off" isn't going to change that.  Let's do it correctly
> > > please.
> > >
> >
> > Please no!
> >
> > Making our frameworks tristate means that we can no longer rely on
> > include file stubs (as framework=m, client=y will fail), so every
> > single client must add the "depends on framework || framework=n" - in
> > contrast to nothing the framework itself is bool.
>
> What's wrong with a single "depends on framework"?  If your code relies
> on this framework, you should depend on it, right?

As your question shows, everyone gets this wrong and the build breaks
all the time (it's not "depends on framework", it's "depends on
framework || framework=n" - and everyone you'll talk to will be
puzzled as to why this is).

But consistently introducing this for clocks, regulators, pinctrl,
resets, etc should be a task so large that people will come out
educated from it - or whatever it is that one feels after fixing
thousands of Kconfig entries.

> Include file stubs
> feels odd for a core functionality, if you can live without that
> functionality, then sure, don't depend on it and all should be just
> fine.
>

Odd or not, it's what we have in all these frameworks.

Regards,
Bjorn

> thanks,
>
> greg k-h
