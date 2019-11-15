Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14264C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E265C20727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573777824;
	bh=yJKFYb8fJypr2wTAgsff0UsCFgPG4gcuFQXMSb8Cbps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f/gEQM39OpaicJZpnE6TtyAWEg7Q2/Jp3/yfZWX/fb4FU07d5QimQIi2VxdBVu1m7
	 PwR/lCDCE945FBr/UN7QomLQaswfN0qKMAWkvYKddc4ooa+iJjSZfmlcAtx7DGHuQt
	 87CTfJ1ZStcGc1L8DmWHtaq5MqqP+Kv0IuM+wc9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKOAaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:30:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36524 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKOAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:30:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so4856209pgh.3;
        Thu, 14 Nov 2019 16:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bRROesaeb887xsfxVtqXv2u2WV15FLCC+kH5tjbZrG4=;
        b=rahj838TYFEVrCmHe0gH4QiWTRk4J4HGu0pIFSvO5x1a0HQZovDk8FQtaidt4Rw5YG
         5vJ+jYIyP6CcJWTHsoAhuGuJ7Q7Kp3WojhPmVBDOj+B7GjmkLe94jwetzhrziI0VBQhZ
         xkoAhVkKbDnuex2tvVLA40/+BwknEownVEZJXVsXjOXommRCUwsIyMNRL5MzaMZBlJLK
         aUbMocugarGvpBA/OKTBv3CDnwG4S//9c9WMRu8ZoBiPJw+8FM2MhBJiblyfh631ptBp
         es6NqZsP/4ApwJKQq1sMSjhGP5GOyNbv9K4b1797ta8Jd0AMSQBHK3WTo6ZHUxQY7+fi
         UY7g==
X-Gm-Message-State: APjAAAW7QiPpVxz/uCMkp4uyv97nhqBMN4VYHrSorV/4G7x4BDzFj+9t
        N3yBb5A/DjnhCEyiQBzdS+Q=
X-Google-Smtp-Source: APXvYqxRCiDHNwOwz8S2vHv+Vw1KysxP6MjchfjJ8RJjB+G4iXLq5xzmRwKDSWDpgbgjjVU/9UyUpw==
X-Received: by 2002:a65:528b:: with SMTP id y11mr13072963pgp.420.1573777820863;
        Thu, 14 Nov 2019 16:30:20 -0800 (PST)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id y24sm9046884pfr.116.2019.11.14.16.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 16:30:19 -0800 (PST)
Date:   Thu, 14 Nov 2019 16:30:51 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        qiaochong@loongson.cn, kgdb-bugreport@lists.sourceforge.net,
        ralf@linux-mips.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        James Hogan <jhogan@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] MIPS: kdb: Remove old workaround for backtracing on
 other CPUs
Message-ID: <20191115003051.blbbwr7hmuqyzjwb@lantea.localdomain>
References: <20191109191644.191766-1-dianders@chromium.org>
 <20191109111623.1.I30a0cac4d9880040c8d41495bd9a567fe3e24989@changeid>
 <20191114105125.t3jma3ghwj2wtv6w@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114105125.t3jma3ghwj2wtv6w@holly.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Nov 14, 2019 at 10:51:25AM +0000, Daniel Thompson wrote:
> On Sat, Nov 09, 2019 at 11:16:40AM -0800, Douglas Anderson wrote:
> > As of commit 2277b492582d ("kdb: Fix stack crawling on 'running' CPUs
> > that aren't the master") we no longer need any special case for doing
> > stack dumps on CPUs that are not the kdb master.  Let's remove.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I have no way to test this personally, so hopefully someone who uses
> > kdb/kgdb on MIPS can.
> 
> I took this as a hint to add mips support to kgdbtest ;-)

Wonderful! :)

> Support is added and working well. Unfortunately lack of familiarity
> with mips means I have not yet figured out which mips defconfig gives
> us working SMP (and what the corresponding qemu invocation should be).

You can build 64r6el_defconfig & boot it something like this:

$ qemu-system-mips64el \
    -M boston -cpu I6500 -smp 4 \
    -kernel arch/mips/boot/vmlinux.gz.itb \
    -serial stdio \
    -hda my-disk-image.bin \
    -append "root=/dev/sda"

Linux should see the system as a single core with 4 hardware threads
(VPs or Virtual Processors in MIPS terminology).

> > Ideally this patch should be Acked by MIPS folks and then land through
> > the kdb/kgdb tree since the next patch in the series, ("kdb:
> > kdb_current_regs should be private") depends on it.
> 
> An Acked-by from a MIPS maintainer would be very welcome. Perhaps
> with a bit of extra work on the above I might be able to provide
> a Tested-by:.

The patches look reasonable to me; I was hoping to test them before
giving an ack but haven't had the time yet. It seems you may be making
that easier :)

Thanks,
    Paul
