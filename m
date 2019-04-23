Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476FAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DD120B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POZFyILN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfDWDfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:35:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41717 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbfDWDfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:35:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so6828529pgs.8;
        Mon, 22 Apr 2019 20:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f5FDisW1IfbKw3p/czzCHLl+mRLZlodjdaz3t7G6reo=;
        b=POZFyILNJyT0U6aCajn2izQmqb7z8erVAYkljixBjdTA96YcwdkQOcZxIJ+jMFuOmw
         6MzgWk3fPkuomYL+ZApOcWnpmPlUCNrJKDBRXmuTw7Q/oqf0zB7XJ/QYsz+CkYnHvvuP
         XLyGaC539o8wajkG7CLmCzV2cJFeGhaMT/ETHA+92R1R8c3Grcsb/MRb6BT8+V0i8YjB
         ggskjMjOHqFbuNoj9LK43KiCAompA3LAFD+0Bs6mK+c51z4s/WSGSOOXUvnY9Nt6EcfC
         U82Q0keG3Tsc54rXjuzwMP7fuPRc5CyCe8F+yBs4ma/0vCJv7aNKrBMLh7wQQ2R8oMsM
         9/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f5FDisW1IfbKw3p/czzCHLl+mRLZlodjdaz3t7G6reo=;
        b=ElJ/kXHPkx8tjdPi7eAh2KvzCr7F95pQOQEQPG9JXUjSPcSduxBElz8hn/D+WlpjC9
         jZLiwO0ALFPZ+CTvP7dqCRibNysQ0AfW6RI2c1u+zl+YnnvNB0XRyJzxGGgIs4GE21ac
         YCQLjoE+pUBDCb8BYYjzOatB4j/IN2Ar41OZFTkU5qslCyVb+8J+J1rTzGljS3ci437+
         7kn2BD5GnKe6WCXeFZFS5LfcUIliJqw8G4Tv3oXCT1F506f9z4Fm1+OW+hl4QscXnmhI
         836KOQdOgBDnZvHY5O/KBxe+FjgguGKg22eekdEFFQXzbMaDEy4raPKDkAxz0nPPoNk3
         /krg==
X-Gm-Message-State: APjAAAV2jEmuBqGzUqtmJgotFHRNV2Zpc5DCJjWW6+L67awyNOcWa9E4
        cS+OE4MNYV6824zztKxCGsk=
X-Google-Smtp-Source: APXvYqz7nSCtOTZnTdGdWPLgwRc1EhfYHl+TV4LKgkQU10QKR0apO+vs7PFLhPq8U3FN2BGOYG04RA==
X-Received: by 2002:a62:1a06:: with SMTP id a6mr24085985pfa.18.1555990514547;
        Mon, 22 Apr 2019 20:35:14 -0700 (PDT)
Received: from localhost ([172.56.31.226])
        by smtp.gmail.com with ESMTPSA id s3sm4648846pgi.74.2019.04.22.20.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 20:35:13 -0700 (PDT)
Date:   Tue, 23 Apr 2019 03:28:39 +0000
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Message-ID: <20190423032839.xvbldglrmjxkdntj@penguin>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 02:13:48PM +0530, Mukesh Ojha wrote:
> 
> On 4/19/2019 12:41 PM, dmitry.torokhov@gmail.com wrote:
> > Hi Mukesh,
> > 
> > On Fri, Apr 19, 2019 at 12:17:44PM +0530, Mukesh Ojha wrote:
> > > For some reason my last mail did not get delivered,  sending it again.
> > > 
> > > 
> > > On 4/18/2019 11:55 AM, Mukesh Ojha wrote:
> > > > 
> > > > On 4/18/2019 7:13 AM, dmitry.torokhov@gmail.com wrote:
> > > > > Hi Mukesh,
> > > > > 
> > > > > On Mon, Apr 15, 2019 at 03:35:51PM +0530, Mukesh Ojha wrote:
> > > > > > Hi Dmitry,
> > > > > > 
> > > > > > Can you please have a look at this patch ? as this seems to reproducing
> > > > > > quite frequently
> > > > > > 
> > > > > > Thanks,
> > > > > > Mukesh
> > > > > > 
> > > > > > On 4/10/2019 1:29 PM, Mukesh Ojha wrote:
> > > > > > > uinput_destroy_device() gets called from two places. In one place,
> > > > > > > uinput_ioctl_handler() where it is protected under a lock
> > > > > > > udev->mutex but there is no protection on udev device from freeing
> > > > > > > inside uinput_release().
> > > > > uinput_release() should be called when last file handle to the uinput
> > > > > instance is being dropped, so there should be no other users and thus we
> > > > > can't be racing with anyone.
> > > > Lets say an example where i am creating input device quite frequently
> > > > 
> > > > [   97.836603] input: syz0 as /devices/virtual/input/input262
> > > > [   97.845589] input: syz0 as /devices/virtual/input/input261
> > > > [   97.849415] input: syz0 as /devices/virtual/input/input263
> > > > [   97.856479] input: syz0 as /devices/virtual/input/input264
> > > > [   97.936128] input: syz0 as /devices/virtual/input/input265
> > > > 
> > > > e.g input265
> > > > 
> > > > while input265 gets created [1] and handlers are getting registered on
> > > > that device*fput* gets called on
> > > > that device as user space got to know that input265 is created and its
> > > > reference is still 1(rare but possible).
> > Are you saying that there are 2 threads sharing the same file
> > descriptor, one issuing the registration ioctl while the other closing
> > the same fd?
> 
> Dmitry,
> 
> I don't have a the exact look inside the app here, but this looks like the
> same as it is able to do
> fput on the uinput device.
> 
> FYI
> Syskaller app is running in userspace (which is for syscall fuzzing) on
> kernel which is enabled
> with various config fault injection, FAULT_INJECTION,FAIL_SLAB,
> FAIL_PAGEALLOC, KASAN etc.

Mukesh,

We need to understand exactly the failure mode. I do not think that
introducing another mutex into uinput actually fixes the issue, as we do
not order mutex acquisition, so I think it is still possible for the
release function to acquire the mutex and run first, and then ioctl
would run with freed object.

My guess that this needs to be fixed in VFS layer.

Thanks.

-- 
Dmitry
