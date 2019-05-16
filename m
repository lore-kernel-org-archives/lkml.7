Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAF6C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C3B20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NUHjLNzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfEPRvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:51:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44991 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEPRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:51:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so1966720pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3MehJCeTwhon04Mi3jlr6XP1VZlknSXqvgatwZv6jJw=;
        b=NUHjLNzvryP7eUCB/OheR8fl9HVzx4+e5yOzozH6wnP784DMzcpOrywTxRsNm7Op4Z
         Xv/SxoQPGv25NdYi85H4zZcmws0GndiOKk3SFFMKcRiZmWg5SGt1kauGU96iRPp7S0ed
         EX7zM7LpO8TRujsXVYJpnKQhF0Pl0jtTdwQGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MehJCeTwhon04Mi3jlr6XP1VZlknSXqvgatwZv6jJw=;
        b=gRcdHCkam10Y+eNNJAX+oo6ux0G89r8U7PoY9xusoKslKBzxU0D+wTQYPll4jsfLqC
         j4CpjBvPDMoI1DSvW61TgmkSYN/VINZ6zW08I5yP+XdvH+olri7fxc2LXElAtwS29HzT
         SbzC8kmuBnAFttYgpVMAT57ZpSHYAjyLhYeVGzLe9dTw1bqVhRvCqTGb44h8yAguWCT6
         5xHGLLgbggNwVKrdTQ4bC6mey1kAiV1vSuunesnDg0vRZYBLYWIRIdLIZUfOetmAFyI2
         gLZfvOBQSZLWmrbYTpG3I8mDqLE/kBDvyWzdyRNQCedIzIvvVAReavB0GBKsndDTvH8a
         GCkA==
X-Gm-Message-State: APjAAAV3q0RWl4boZ1KwFGaMcxuYLk09Zqhq9eJ7nT+AV5BxQnKwMhpd
        DKQ2vjnRvIBpLDMuF2bCTi2ukA==
X-Google-Smtp-Source: APXvYqwhBIWPRqZhsA9f77AUcheg/JhpgCM+kD/qRifj7nuwbRLzTzHv/Uh7FXrybqS4V06uT3v2Wg==
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr32624739plb.115.1558029072975;
        Thu, 16 May 2019 10:51:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k63sm9704031pfb.108.2019.05.16.10.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 10:51:12 -0700 (PDT)
Date:   Thu, 16 May 2019 10:51:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <201905161050.4B81082@keescook>
References: <20190423183827.GA4012@beast>
 <20190514120416.GA11736@probook>
 <201905140842.21066115C5@keescook>
 <20190514161051.GA21695@probook>
 <201905151151.D4EA0FF7@keescook>
 <20190516135606.GA25602@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516135606.GA25602@probook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 03:56:07PM +0200, Johannes Hirte wrote:
> On 2019 Mai 15, Kees Cook wrote:
> > Various stupid questions: did you wipe the whole bulid tree and start
> > clean? 
> 
> No I didn't. And this fixed it now. After a distclean I'm unable to
> reproduce it. So sorry for the noise.

Okay, whew! Thanks for double-checking. No worries about the noise:
it wouldn't have been the first time I broke some corner case. :)

-- 
Kees Cook
