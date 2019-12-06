Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA53BC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9AA206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="wVsQlnEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFOKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:10:46 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44024 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfLFOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:10:46 -0500
Received: by mail-il1-f193.google.com with SMTP id u16so6337022ilg.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1YCWj4FzeVMFw7aPkv0f3vTJdk6KStMPvm4QDDtRoKw=;
        b=wVsQlnEEP00IyLn0NxUfNYmgRpx08qlKit0M/qQKRFSZCiM/zugpkeZ7s3lWRpScqh
         j/3zA/S7huJHRyimHxTic6SikWnjV0zzDpxEnJTrAlWNsSZDTP2xKPou2MfQ83sdMPac
         vZPtpi4C2KmJNlaiblnd2JEh0hAaC7vEqrXM0KT6a3OVQCFAlMDEJCZz1f4Bsx2GX8pB
         //kWW+qa2xxBradAYr7rtqBRrvCvsEgMVz7aGaZSa+q3an17+hnpKfJ2xhutdlxKzV/n
         Y6rJynf/nqEznj7mqAKGZrB06A+IwIq+o/JqLgdnrF2IjQsgIvMeWoLxjn+uzSO2JeM1
         C7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1YCWj4FzeVMFw7aPkv0f3vTJdk6KStMPvm4QDDtRoKw=;
        b=h59bgH1uvm8cxUumR7NrMAa08XFueyzVAES+d7uryQu8DIyF11PWSZ7QBMu6qpPZnC
         O14Jni9X8v5YKFebiyBp/WLvYX5wjAUm9iQCTc6O73LI8euZ5fPMT947o2JDCMVLb8di
         i3QYVw2O/0KADHBOR8v5OE8lmaUQRwyjD6w5DCxBDtgZWYkvsJyyrimFycLiRzgYkBIv
         V0dTM2knd0b5Co+B+GEfAFF/nAxH7NYS6uVnK1ix+VrjYCOtD9vVD1gWJG/wJWlee/lO
         PZTUr1VjHmekuX1l+W6gGXZolo8XN7wYu6QW+xbHsAfXsPXJ4WhCaJD5xYLTQNyPcH3F
         Fm2w==
X-Gm-Message-State: APjAAAVoW2GXyBSUcztrVRS/B/Hb67ojB4LCHuJ5lYycEc/mSGCjFKBu
        BHEpFFghKbpsKzwR0tjRy7dg5L6m/LI=
X-Google-Smtp-Source: APXvYqxsa/txcRrIVZx26A+Ibxru94YoeqcnDJg06Ubl7ybKXXw+jIXNv8C+cTh9ikFkRi1dOjEDOw==
X-Received: by 2002:a92:4010:: with SMTP id n16mr15082339ila.260.1575641445120;
        Fri, 06 Dec 2019 06:10:45 -0800 (PST)
Received: from cisco ([2601:282:902:b340:45e0:b82b:a61a:f45])
        by smtp.gmail.com with ESMTPSA id e73sm3174303iof.63.2019.12.06.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:10:44 -0800 (PST)
Date:   Fri, 6 Dec 2019 07:10:45 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
Message-ID: <20191206141045.GA22803@cisco>
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 11:44:53PM +0000, Sargun Dhillon wrote:
> PTRACE_GETFD is a generic ptrace API that allows the tracer to
> get file descriptors from the traceee.
> 
> The primary reason to use this syscall is to allow sandboxers to

I might change this to "one motivation to use this ptrace command",
because I'm sure people will invent other crazy uses soon after it's
added :)

> take action on an FD on behalf of the tracee. For example, this
> can be combined with seccomp's user notification feature to extract
> a file descriptor and call privileged syscalls, like binding
> a socket to a privileged port.

This can already be accomplished via injecting parasite code like CRIU
does; adding a ptrace() command like this makes it much nicer to be
sure, but it is redundant.

Tycho
