Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDE7C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7508C21726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561584671;
	bh=ZG5f3JAV6TERl+IO7K3Nb6FwhQkQTiEfZcT+EyzKjEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g25BdPo9EVTOg75pcZor7FL9BLkxIVAssAKacl4ZWYXQ4ajQfBH/KwYzqrjl5kErt
	 oLZ15O1umQZeUKaZCi6R4ASEg7TKZkzOsHfWqppi87QxDr3gsRyPn+fcazECjI+8ux
	 VD8GytKVZpDFnx4JVHn2/JbHpKV9RzBWUoij9G8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFZVbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfFZVbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:31:09 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555EC2177B;
        Wed, 26 Jun 2019 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561584669;
        bh=ZG5f3JAV6TERl+IO7K3Nb6FwhQkQTiEfZcT+EyzKjEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lz1qZOjDN0aXbiClwfnHDJzEwlFtOMqcwnZcV/0BtDdweV0CoVcUT7b6d01PSDEQD
         H3wAqwRQL4FrG/UjIxqhusu18Eva70weTOdkbcwvKn2dydvSJU/Ad1mlD1CRNRFlvA
         voKoFlTRLNCPrwi5MNABvsjxFp7LXxQ1I+H/tiTY=
Received: by mail-qt1-f173.google.com with SMTP id n11so217987qtl.5;
        Wed, 26 Jun 2019 14:31:09 -0700 (PDT)
X-Gm-Message-State: APjAAAXYUmmbgfzP5g8jB9O8/JvvvhKywS+ljLl4f9IrdN1eX1fuUhon
        N4gXOK1jpuIjCtRVRXUoHphR0EoxWUt7zlqFDA==
X-Google-Smtp-Source: APXvYqzJqURS7zIwm91J2eVG/x5K+JGr2IfLArbpvvGiwiiDLbGBBxyBhmadbwt3i7Je1+hcFJ3BfhbED/7irBbvVG4=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr55449qtc.143.1561584668555;
 Wed, 26 Jun 2019 14:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <20190624223707.GH203031@google.com>
 <20190625035313.GA13239@kroah.com>
In-Reply-To: <20190625035313.GA13239@kroah.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 15:30:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJyO9Fpq+Lzrc9NdiFBZ_9M31_mjfRyKM=ENtW-zVa8VA@mail.gmail.com>
Message-ID: <CAL_JsqJyO9Fpq+Lzrc9NdiFBZ_9M31_mjfRyKM=ENtW-zVa8VA@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and
 optimize probe ordering
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sandeep Patil <sspatil@android.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 9:54 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 24, 2019 at 03:37:07PM -0700, Sandeep Patil wrote:
> > We are trying to make sure that all (most) drivers in an Aarch64 system can
> > be kernel modules for Android, like any other desktop system for
> > example. There are a number of problems we need to fix before that happens
> > ofcourse.
>
> I will argue that this is NOT an android-specific issue.  If the goal of
> creating an arm64 kernel that will "just work" for a wide range of
> hardware configurations without rebuilding is going to happen, we need
> to solve this problem with DT.  This goal was one of the original wishes
> of the arm64 development effort, let's not loose sight of it as
> obviously, this is not working properly just yet.

I fail to see how the different Linux behavior between drivers
built-in and as modules has anything whatsoever to do with DT. Fix the
problems in Linux and use the dependencies that are already expressed
in DT and *then* we can talk about using DT to provide *hints* for
solving any remaining problems.

Rob
