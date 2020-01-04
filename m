Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A2BC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA8722B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgADOQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:16:28 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40680 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgADOQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:16:28 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A7A1B2002B;
        Sat,  4 Jan 2020 15:16:24 +0100 (CET)
Date:   Sat, 4 Jan 2020 15:16:23 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/12] initramfs: refactor the initramfs build rules
Message-ID: <20200104141623.GB17768@ravnborg.org>
References: <20200103175915.26663-1-masahiroy@kernel.org>
 <20200103175915.26663-12-masahiroy@kernel.org>
 <20200103195205.GC21515@ravnborg.org>
 <CAK7LNAQXx0RGutdOe4JFLTbjm7=cx9aEKQ-823-irED4SyCmMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQXx0RGutdOe4JFLTbjm7=cx9aEKQ-823-irED4SyCmMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=Kv6UVFhzZyljNNiE3VoA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro.

> > > +else ifeq ($(words $(ramfs-input)),1)
> > > +# If CONFIG_INITRAMFS_SOURCE specifies a single file, and it is suffixed with
> > > +# .cpio or .cpio.*, use it directly as an initramfs.
> > > +ifneq ($(filter %.cpio,$(ramfs-input)),)
> > > +cpio-data := $(ramfs-input)
> > > +endif
> >
> > This part will now work if the file is named foo.cpio.bar.
> > $(findstring .cpio, should be used and not $(filter %.cpio
> > At least if the comment describes the intended behaviour.
> 
> 
> The 'foo.cpio.bar' is taken care of
> by ifeq ($(words $(subst .cpio.,$(space),$(ramfs-input))),2)
Clever, I only now realized how this worked.
> 
> I admit the comment was confusing.
> 
> 
> I will clarify the comments as follows:
> 
> 
> 
> # If CONFIG_INITRAMFS_SOURCE specifies a single file, and it is suffixed with
> # .cpio, use it directly as an initramfs.
> ifneq ($(filter %.cpio,$(ramfs-input)),)
> cpio-data := $(ramfs-input)
> endif
> 
> # If CONFIG_INITRAMFS_SOURCE specifies a single file, and it is suffixed with
> # .cpio.*, use it directly as an initramfs, and avoid double compression.
> ifeq ($(words $(subst .cpio.,$(space),$(ramfs-input))),2)
> cpio-data := $(ramfs-input)
> compress-y := shipped
> endif

Looks good.

	Sam
