Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5955C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E2E21852
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPd+kuMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfIPPnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:43:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38457 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfIPPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:43:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so226495pgi.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GIKTiyEj4N0Tk5F27SiQQIDS5N8HwkMtaseA3IamvV4=;
        b=JPd+kuMRkI2hyka5aobdVqsgU5OzRfLwXigswG+wwo96vSE8DXOebxg2e1XNYJZBsf
         59bDUGGC7oi5JbEuuWjRdZxbg/K0OZX5XOJicvXosVR3JbCO1p8bdFMoPD/depZ2O1u6
         NpV4abQFpjO+ytgnmHQuNOVMxs9ELWhv7MmvQFSP6Bo3Lv4x1hnIQuNLKaEROSYCptgq
         rxSTEfQk9BduAkK+fypO8uzRLfmDuuI4A7e/38REN+iJ4EGnGfThYlQUPCOcCCMGnWvB
         wyAf2EVEbGUs6Ow33skONvtObFJN83ChEks9cPcEcP3UweycIwBOPhXkAMePm3NuOGJE
         RFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIKTiyEj4N0Tk5F27SiQQIDS5N8HwkMtaseA3IamvV4=;
        b=VOKS/0t0GgsnjDvYUanvXo/4EC/qjUYI4thRZFfXekk7Y3wL9RYahSDwp+6qJX7Lu5
         ZA/nOiRELgQpJtGPHkM6i4XQuwPhyfdeViHvPxo/aLY4S1tUcjCM31hn7W4TOLGtAYSF
         y7F5QrfX3Jx3lhJ8TUGtCumqtrGyREQtjxY9bWtlUWkVROixeNYl76SyeSeX0Wtqsiu9
         yFkx7k7fyol8KkYInmiJs0L7gP2FtC1wc8JPbQh3GsVFvIRjy9q3x4ffoTTvU3RkUr66
         6AcXlmJOZGUhzeAdHqGHp5+Kc93k8zuPHz8TXbAbgexiy/zwcTq6kaxUnyZgaxVWJnvH
         1sRA==
X-Gm-Message-State: APjAAAXIKKuFohIeIVQYNS8AKvwG6drsUrrsX2NYU+fr++1b+jVBlup5
        XkLJx89/NvlW/o3TSmcVJds=
X-Google-Smtp-Source: APXvYqweEKNe6aDL2/LMO034hvNQ2czMevJUdslQ+3U9k2rktGL8GiKf/o0Mqi4l2pInj+Kdp1R0KA==
X-Received: by 2002:a17:90a:b013:: with SMTP id x19mr403482pjq.58.1568648619545;
        Mon, 16 Sep 2019 08:43:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p189sm57462133pfp.163.2019.09.16.08.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 08:43:38 -0700 (PDT)
Date:   Mon, 16 Sep 2019 08:43:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
Message-ID: <20190916154336.GA6628@roeck-us.net>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
 <20190914152544.GA17499@roeck-us.net>
 <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
 <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net>
 <20190916134920.GA18267@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916134920.GA18267@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 03:49:20PM +0200, Thierry Reding wrote:
> On Mon, Sep 16, 2019 at 06:17:01AM -0700, Guenter Roeck wrote:
> > On 9/16/19 12:49 AM, Arnd Bergmann wrote:
> > > On Sat, Sep 14, 2019 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > On Mon, Jan 30, 2017 at 12:05:06PM +0100, Thierry Reding wrote:
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > 
> > > > > Hi everyone,
> > > > > 
> > > > > This small series is preparatory work for a series that I'm working on
> > > > > which attempts to establish a formal framework for system restart and
> > > > > power off.
> > > > > 
> > > > > Guenter has done a lot of good work in this area, but it never got
> > > > > merged. I think this set is a valuable addition to the kernel because
> > > > > it converts all odd providers to the established mechanism for restart.
> > > > > 
> > > > > Since this is stretched across both 32-bit and 64-bit ARM, as well as
> > > > > PSCI, and given the SoC/board level of functionality, I think it might
> > > > > make sense to take this through the ARM SoC tree in order to simplify
> > > > > the interdependencies. But it should also be possible to take patches
> > > > > 1-4 via their respective trees this cycle and patches 5-6 through the
> > > > > ARM and arm64 trees for the next cycle, if that's preferred.
> > > > > 
> > > > 
> > > > We tried this twice now, and it seems to go nowhere. What does it take
> > > > to get it applied ?
> > > 
> > > Can you send a pull request to soc@kernel.org after the merge window,
> > > with everyone else on Cc? If nobody objects, I'll merge it through
> > > the soc tree.
> > > 
> > 
> > Sure, I'll rebase and do that.
> 
> I've uploaded a rebased tree here:
> 
> 	https://github.com/thierryreding/linux/tree/for-5.5/system-power-reset
> 
> The first 6 patches in that tree correspond to this series. There were a
> couple of conflicts I had to resolve and I haven't fully tested the
> series yet, but if you haven't done any of the rebasing, the above may
> be useful to you.
> 

Maybe Arnd can just use your branch (or rather part of it if you would
split it off) since you already did the work ?

Thanks,
Guenter
