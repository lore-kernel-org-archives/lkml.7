Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC1C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D43206E1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jD/nU9nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfLBXcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:32:06 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:38563 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLBXcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:32:05 -0500
Received: by mail-il1-f172.google.com with SMTP id u17so1376557ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uAB7m6EBm7LH64uHm2P7qulgR/Phd5SEpXDcC0NfW4=;
        b=jD/nU9ncUTwABnL9cTtzqnxSLUjC7YR759S+8tWe/okFP/D12PdGUwTvNU9uYlIXcH
         L6otTPfAEHHPGWLd8mw7XEGIqpNQ3VkS7ZY3Leh4YyQctEkl6qvEQxrJ8IrAvB6PUt19
         aPcZOq6DVh8oxRV6hBlzabvEc6xKkGs7kltifvV0kTGT04O5Pr/0XTGqzZ25B//aZ19+
         9RebPbmAgdZPWWeCMzJHaHB6tLo8pvqppZKPtz/ftwlVSwEW2eqqo24Fioox4AgfRWNi
         BAL/6FegSca45vWq/G1BTfMZC2RhidA9Dh9EF8EQfc4KpQs/SEvY0ArYIzdiP8YsFpy7
         nKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uAB7m6EBm7LH64uHm2P7qulgR/Phd5SEpXDcC0NfW4=;
        b=bTYEpYqfG7KOtkv3PbaftmicYBrck7sEymmPK1CH3dXeCmqp+cNDsXgujs+Ss4QekL
         3/87H1kzQUP9V6ZO4bbT2G/7LnUcaYyvwKlXl/nmqeTPKDbajHLp04ie2tTVZ57HwDjB
         a34nXps8gci6wM//CBUT88w4L4NnjlckJF3GBIrFv1mnSqsf/3sr1uolumj8tHdg7wHC
         GlE6fP6Ubkc91wLd3cAz9DjpDIHqwGZBbGevcizyXB2Vdp+v4n92ldQ78N52oG2va7d+
         FLx6XYRzWAjvIkDVkRA5OzHk91xLwfdyn2dkkWFRcEkJhx1rDmL/okn7+6+chVwy0T+i
         NHEQ==
X-Gm-Message-State: APjAAAVNlk3PWlKfy9OmyFeEwkLXXJMuv0osLDMS17JE3wzu+uT8nYiL
        qDi9L6EpCypGIoNHu2xzokv0tJ9wG5ENk2NclVFFcA==
X-Google-Smtp-Source: APXvYqyLlTHofgFEQJhW4sBHggg6gotb/5nppYVFMmmnwhNpyhS7sIPgk3giMxcH8j3bX2qFXiDG62Cf/6/RBwHxm5g=
X-Received: by 2002:a92:d744:: with SMTP id e4mr1763696ilq.64.1575329523952;
 Mon, 02 Dec 2019 15:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20191101210803.GA9841@xps13.dannf>
In-Reply-To: <20191101210803.GA9841@xps13.dannf>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Dec 2019 15:31:52 -0800
Message-ID: <CACdnJuuXBQ__Sb8=V7CTZfXH=5LfbiU9SmUKapJov3Cd+aHQcw@mail.gmail.com>
Subject: Re: tracefs splats in lockdown=confidentiality mode
To:     dann frazier <dann.frazier@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        James Morris <jmorris@namei.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 2:08 PM dann frazier <dann.frazier@canonical.com> wrote:

> [    1.763630] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7

This is expected.

> [    2.913934] ------------[ cut here ]------------
> [    2.918435] Could not register function stat for cpu 0
> [    2.923717] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:987 ftrace_init_tracefs_toplevel+0x168/0x1bc

This is not. I'll look into it.
