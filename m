Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D59C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912D220645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1+cB6Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfDSSwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:52:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38672 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfDSSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:52:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so2967979plb.5;
        Fri, 19 Apr 2019 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CX8mWHi5JP8YBeb+oMpVfgjuWx7XmRHb9Tyvaknfgqo=;
        b=t1+cB6MlGgLB+qRRLIOaQLFwiYSR1AngcrSiTahDGi9q5trmEhQ9T/PBBscfj0L1YY
         Qifs630A39yD5Zj+JTgGWr7dZOkNJLKNLFAdcMVFhygelnYrGdL0U5K1tXDqO6W4lSfi
         SOSEiq71dtVqDK21K6aTLvKgEbvoEknuP0QuQBqvxyAtbzlC2btOmVaba9dLMqYf3TJK
         2ozzuiwacMXhhhxOYzRpEhvPHnz0KCrmamMVy3FPMUkOTSW9rzvz+FjtGuZS8av5mYbA
         6xxeJYaMcSrJDNc7J8JJ2GULmJdsw8HslfmPX8IU7dTbfCaKCkz5ZINkPm7vNhS/sq24
         kS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CX8mWHi5JP8YBeb+oMpVfgjuWx7XmRHb9Tyvaknfgqo=;
        b=gGwX+ehqw8ggaNyHQidZH8IhfOSk7NuGgZYru1thC5iugzccM76jRX6sdDv82MX0uy
         jFBOQMSPCQ6tUn/vs2DSvnLRdK9nekWBO51UhwpMw9ZclB2ouhseSWl+J0BUUXsM0EYf
         e7WyjMrruPtSMwcv3h2agH8aRQCDA+sSUWFJtQlsvADjFf93sCwuJwivkXlvpUd5HfLw
         YaDb5Og0xhn/HyfJ2HHlmVzCOrpELRZc5KQdZKUA770OswnrpWLKrjf1jHRc5ygFV33a
         CVqFJ8mOBTvqGO7xypka9soRJ68yNusD23+C8BWSuJYhHPem9b4GKpMvHxl6v/XM3Kk/
         MNVA==
X-Gm-Message-State: APjAAAVj7z6e0iMIYPl38Oa7+bzpA1t3p8UlklU6hfF5f7ADzDjRDW0x
        +oT2yVXCq32yrLKakvJ122eDpWJd7Rs=
X-Google-Smtp-Source: APXvYqzbvBNOdLZ2cNdWWDJE5+W/lr32cz8zracrIE0uyClcR+47TH3Gf5rqJlpddFrF/2H48s5rwg==
X-Received: by 2002:a17:902:2825:: with SMTP id e34mr2285618plb.264.1555659129002;
        Fri, 19 Apr 2019 00:32:09 -0700 (PDT)
Received: from localhost ([61.199.190.18])
        by smtp.gmail.com with ESMTPSA id s187sm4248660pgb.13.2019.04.19.00.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 00:32:08 -0700 (PDT)
Date:   Fri, 19 Apr 2019 07:11:52 +0000
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Message-ID: <20190419071152.x5ghvbybjhv76uxt@penguin>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

On Fri, Apr 19, 2019 at 12:17:44PM +0530, Mukesh Ojha wrote:
> For some reason my last mail did not get delivered,  sending it again.
> 
> 
> On 4/18/2019 11:55 AM, Mukesh Ojha wrote:
> > 
> > 
> > On 4/18/2019 7:13 AM, dmitry.torokhov@gmail.com wrote:
> > > Hi Mukesh,
> > > 
> > > On Mon, Apr 15, 2019 at 03:35:51PM +0530, Mukesh Ojha wrote:
> > > > Hi Dmitry,
> > > > 
> > > > Can you please have a look at this patch ? as this seems to reproducing
> > > > quite frequently
> > > > 
> > > > Thanks,
> > > > Mukesh
> > > > 
> > > > On 4/10/2019 1:29 PM, Mukesh Ojha wrote:
> > > > > uinput_destroy_device() gets called from two places. In one place,
> > > > > uinput_ioctl_handler() where it is protected under a lock
> > > > > udev->mutex but there is no protection on udev device from freeing
> > > > > inside uinput_release().
> > > uinput_release() should be called when last file handle to the uinput
> > > instance is being dropped, so there should be no other users and thus we
> > > can't be racing with anyone.
> > 
> > Lets say an example where i am creating input device quite frequently
> > 
> > [   97.836603] input: syz0 as /devices/virtual/input/input262
> > [   97.845589] input: syz0 as /devices/virtual/input/input261
> > [   97.849415] input: syz0 as /devices/virtual/input/input263
> > [   97.856479] input: syz0 as /devices/virtual/input/input264
> > [   97.936128] input: syz0 as /devices/virtual/input/input265
> > 
> > e.g input265
> > 
> > while input265 gets created [1] and handlers are getting registered on
> > that device*fput* gets called on
> > that device as user space got to know that input265 is created and its
> > reference is still 1(rare but possible).

Are you saying that there are 2 threads sharing the same file
descriptor, one issuing the registration ioctl while the other closing
the same fd?

Thanks.

-- 
Dmitry
