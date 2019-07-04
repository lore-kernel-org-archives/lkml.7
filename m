Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E56C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C67B218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="AyQi7k2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfGDGDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:03:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39042 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGDGDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:03:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so4733466qkd.6;
        Wed, 03 Jul 2019 23:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zG2Of7qq6RulfRoGA24ViJMIHN/A2MnjJcuk8GFFPiU=;
        b=AyQi7k2FK19mqnfZWe8DFRAlQoaJ5OBq0zRpGB3BojaSjcjlF4pojGyZmhsQkjnrZ5
         tBQ50ZL9x+GFTFIYmdOeTBPYzTV07VWfxEBKpMsN9PXMFYTchK854G1xljgKUna8ShVz
         +Zt7MFZGBkqlpVTxU8VsMwxOvQ3jb5XPwNikE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zG2Of7qq6RulfRoGA24ViJMIHN/A2MnjJcuk8GFFPiU=;
        b=SmhXfmQwgnXi47C+X+3ntdldEYfk/ClqfdYIaPJXHA0X8IEoa/5n7mqUNd1sy2duJt
         vc0GaKrJQ2YV0hItHPRhZJYqlKbkJr02+VYjh9lVQschfhfMNjpfSWU28x4fbRqQtgbF
         fyY5qZAw+8Xx+Kb56N7uGlzeMeGAT0J8UgQ+aRu0akOP6LQm9OvEw+My011bCIx8Q6fA
         M6kdJcyDDiDwc00bgzPQWP3+XXckwHWQ5LFpPDpvz3BMm2zR+LII75HyeuQCV2YKyXu8
         6dSgnC0rnZS6RnSccAOyspk76V5s2ljg65NFccmI+yXPepLP1WiijUOVBfiUfZKsqzz/
         n7+g==
X-Gm-Message-State: APjAAAWpWcGJWuPTsrUAQIqLFmWgfPLO8FMrOV9BzPtRRRt295vaTe3j
        WygRINxWNg++el6vk8cDGDk/Q2IzxG59qfgcaDs=
X-Google-Smtp-Source: APXvYqw+Amd7bjbM6pwFDC0KhTxwoLjTDilYHLUZ6jAkmLyi1Ph6j3gRhhpup2bzVUpZApwWaDIHSZsE2Bir5EmK3D8=
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr33772264qke.171.1562220210922;
 Wed, 03 Jul 2019 23:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
 <041ce2ab04d0594accdbf51078906ac116cc0253.camel@kernel.crashing.org>
In-Reply-To: <041ce2ab04d0594accdbf51078906ac116cc0253.camel@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 4 Jul 2019 06:03:18 +0000
Message-ID: <CACPK8XdGC4V5xs5S=JHk=tUayLGHQkF5eH0pvFnyffpDaUuqQQ@mail.gmail.com>
Subject: Re: [GIT PULL] FSI changes for 5.3
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 at 05:32, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2019-07-03 at 03:39 +0000, Joel Stanley wrote:
> > Hello Greg,
> >
> > We've not had a MAINAINERS entry for drivers/fsi, so this fixes that. It names
> > Jeremy and I as maintainers, so if it works for you we will send pull requests
> > to you each cycle.
>
> Ack. I no longer work for IBM and thus cannot handle that subsystem
> anymore.

Stephen, can you swap out ben's fsi tree in linux-next for this one:

git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git

Branch is 'next'.

Cheers,

Joel
