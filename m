Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBEEC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890AA2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VuU2Pa0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392954AbfIYUMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:12:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41159 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbfIYUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:12:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so60626pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Jna560TLuCXx87ceJCymiwtgkmh7HkrMG2IFgw1kI4c=;
        b=VuU2Pa0nBBkxwAP9ay+E9uFWWwIVwYqseAK+ma9eJZFXhVQN0qi+UjD6soxXNTeZqf
         GrarSQAhhPI3J1vEGx/BK9yp/fT8XW7v6L5dyzHQRVN6n+yriwbjsGmhDeb3kP+IElVG
         twwLQiDdTpGuKXcUmsqMHE/DrcsjfZAgIx3H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jna560TLuCXx87ceJCymiwtgkmh7HkrMG2IFgw1kI4c=;
        b=Ht4DCU+zeSEicAI6Eav0MlElJtg/enPqSq7R8JSccev2BJFMJizWl9IsqxoP9HKikN
         kVhys3dUDVPhbpiworxSZn8UfM6gAu4tmAXqVFClvy+qllUkAkMVEZMrQdcA9DWmMsMo
         wrvNyLZJuR9n3RRzjKsdzDmElFEcuTKnAWUwHT34dlMfVs3KJoG9QVfPlC0I7tyfVOwb
         4GEIinK3sW0sCk0zUTZ98Uvep4eFgnHeV43CHy4tm9Iv6VfkKYRhUY4PIDecitFragaV
         kdDnSSO1sTgekD7kMCeE+0P3FcdZPZwS6Z8V18suLmZHXGROvIOmdL5kWHGbjhU6qvpD
         RLRQ==
X-Gm-Message-State: APjAAAVAltzPZoYXZvMBtwkUdWhgw4X6GvyPTvh7ygf4neh+ARuAN0Y+
        oBmO+SoinjX/zXFtrXnywLv5MA==
X-Google-Smtp-Source: APXvYqxDgsn2vYK72wwqUc6AnpeWlXdjSD2e1YwZ+LWSbLufCkg3PlfC7SJqBS+r43Bc7NNyT/WRQg==
X-Received: by 2002:a62:583:: with SMTP id 125mr28598pff.69.1569442359691;
        Wed, 25 Sep 2019 13:12:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q30sm35535pja.18.2019.09.25.13.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:12:38 -0700 (PDT)
Date:   Wed, 25 Sep 2019 13:12:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>
Cc:     s.mesoraca16@gmail.com, viro@zeniv.linux.org.uk,
        dan.carpenter@oracle.com, akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        lkml <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, solar@openwall.com
Subject: Re: Unmerged patches adding audit when protected_regular/fifos
 sysctl causes EACCES
Message-ID: <201909251307.B970AF1E7@keescook>
References: <CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQOdkFq0PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQOdkFq0PA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 02:58:28PM -0400, Jérémie Galarneau wrote:
> Hi Kees,
> 
> I have noticed that the two top-most patches of your protected-creat
> branch were never merged upstream [1]. Those patches add audit logs
> whenever the protected_regular or protected_fifo sysctl prevent the
> creation of a file/fifo.
> 
> They were mentioned in the v4 thread [2] of the "main" patch and
> seemed acceptable, but they were no longer mentioned in v5 [3], which
> was merged.
> 
> Now that systemd enables those sysctls by default (v241+), I got
> bitten pretty hard by this check and it took me a while to figure out
> what was happening [4]. I ended up catching it by adding a bunch of
> printk(), including where you proposed to add an audit log statement.
> 
> I just found your two patches while implementing what you proposed almost 1:1.
> 
> Was there a reason why those were abandoned? Otherwise, would you mind
> resubmitting them?

Hi!

There was concern about getting buy-in from the audit folks delaying
things even more. Instead of waiting for that, as it had already taken
a long time to get consensus even on the functionality, they were
dropped.

I'll rebase them and send them out again; thanks for the ping!

-Kees

> 
> Thanks!
> Jérémie
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/userspace/protected-creat
> [2] https://lkml.org/lkml/2018/4/10/840
> [3] https://lore.kernel.org/lkml/20180416175918.GA13494@beast/
> [4] https://github.com/lttng/lttng-tools/commit/cf86ff2c4ababd01fea7ab2c9c289cb7c0a1bcd5
> 
> -- 
> Jérémie Galarneau
> EfficiOS Inc.
> http://www.efficios.com

-- 
Kees Cook
