Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A520692
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltmeFcRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfINTsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:48:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37743 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfINTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:48:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so9293252pgg.4;
        Sat, 14 Sep 2019 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKInT2K3atHuPlqq8+cjdUQu+K/vViz1lIlROGINXn8=;
        b=ltmeFcRmDc/TSVjQiuSmk9J4ylDAncd63yh67V/Fenijf1Sf3zdTpdPa81Uyppp0f3
         6yOcsYuysTAH1RUB4ZGpGMSdq4tzjZFw+NbUTMRm2RCon5LJQWXP6TKV2pC5ZtmOLd6f
         sYevofolclKABmoAsrXiZwC5BuaD0s4UUmQIidG9zwEw5oP9Xz7oK/trzLmelacWexCl
         Z2wM/yruj3AeHY7NRCLTmcejWplW4t7jMxb0N9I+v+d/tCvku9ig3BU0Zp3HnzX75PJi
         UOhj3QAEh46nk5qgeVbxBhXcTS9UWFnciklSYgrhcPbavGp1rWxRYaSZCEqsc1NUFoES
         UUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKInT2K3atHuPlqq8+cjdUQu+K/vViz1lIlROGINXn8=;
        b=G2sU6j6HYq/L8Y6tkq2w8DCtPFq5WCMiEmKjX2hLWywI86hjqTXrmDD10/ayV9LW5+
         Z/qG1H4BaGKqeFVTSmVhVqYW1EZ4uwWpGlsgHGDu4xcu5QNkl4SsSjivdTRn2FR1nZFD
         4FE9DTTLLVzrLf6ClezY51g1TMWRV2a2Fz+Cwvj+5Kfc+J77Hf7dBTNMAtRDpk/4bCA2
         4c2w9dxwi4a5YpK+4BcZnZBME9E9XEXy6S1VIBTEjnFc3rTkFIAGzn/Wr8SEfzdEy97j
         LlFj6CmEhHtVPnfBBxBOjwC4rxuGlp3WhJWF37TKiEE0g6wqRh1zT7FpuWNBZhwqqr09
         wlLg==
X-Gm-Message-State: APjAAAX1zxgElyvN22tAICfSf4axP/Sxn3xmADLpLQ3x7HT9+wFklkKh
        eE9iALPv4GkPIxn5bLXGe/Rho8fUQHBjxaXacRfVEabWKpU=
X-Google-Smtp-Source: APXvYqzHtdyPYTMkYN1DBv0EWRPjMw8USxk1F35fog+vlB3Wy2AN0Kvm0y/tyidI2X/LcbCPW81pb+8GxtYapzHGTYY=
X-Received: by 2002:a17:90b:151:: with SMTP id em17mr5138324pjb.132.1568490526305;
 Sat, 14 Sep 2019 12:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
 <20190914171950.GW2680@smile.fi.intel.com> <85876cd057ff5f871dd830ff19a6e32c83e8e344.camel@linux.intel.com>
In-Reply-To: <85876cd057ff5f871dd830ff19a6e32c83e8e344.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Sep 2019 22:48:35 +0300
Message-ID: <CAHp75VeE+Z+KQOOvYgD+3-MsRTe7WPnxPTyTtQrLdQ8mQ=6y4Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] tools/power/x86/intel-speed-select: New command and
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 10:22 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sat, 2019-09-14 at 20:19 +0300, Andy Shevchenko wrote:
> > On Sat, Sep 14, 2019 at 12:05:08AM -0700, Srinivas Pandruvada wrote:
> > > This series contains some minor fixes, when firmware mask is
> > > including
> > > invalid CPU in the perf-profile mask. Also add some commands to
> > > better manage core-power feature.
> >
> > Hmm... 150+ LOCs doesn't count to me as minor fixes.
> > So, are you considering this a material for v5.4?
> Sorry, I should be clear. It is for 5.4. I am trying to catch merge
> window. None of the fixes are critical. The majority of the code is
> added for new command features.
>
> What is your cut off for 5.4? I want to send some more features if
> possible for 5.4.

First PR already had been sent to Linus.

-- 
With Best Regards,
Andy Shevchenko
