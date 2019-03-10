Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E3AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0F620657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="n4uDvpv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfCJS75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:59:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33248 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfCJS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:59:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id h11so2285352pgl.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naRzgdJ8jUvVYH8uTyqd/CYWmmwuTDSS8+rRRSXIaiA=;
        b=n4uDvpv/Ew13GkxFjmbxnFc8gUGqHnNwnERV6hA67Z0N0ovHa0dxHjxa48ZhzOf7dY
         jATjxarUIxYV8KJ60jc6skC3UnKcCHEKvoaTnFlIec4V5F3r8gvZKxA81ul7HuLh0Dk/
         8MP8vw6P0o3BjQnEihO1stzHigtLE/KM2N7BCC8LdiOvZyrrb8XJ2uh7QvChQAJ7USPM
         +abtAgdKGJ3mPTFjFShgWKR+z79CnD/3xXeyHUgU3RhRs9haQ+O2S7VQI6zbGC+V4BQD
         tt9cdyXHpISG3ON6e7z3VepB6Ingcd59UX8lMNXA3VfJBq8EuQYkODSsOQfqiWWQ0LiT
         9cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naRzgdJ8jUvVYH8uTyqd/CYWmmwuTDSS8+rRRSXIaiA=;
        b=hhbgfufcBY+ZVI4s48hiPS2QZGg8feEzDgiWvFcLOGZ1bHB28aj6XNidq72yj9d4CQ
         5edybkklM4IPK7ueoUqoOSni2li/YJf5Gh0UHkJOCbQlAfeqzUfSbuLNQmR/Z53SHwjF
         5j3ktGvnPu+jHSFe64hiQBJeZ02W91HELFxTRt87Rkqa/7qqUuwFEdm/xV9eeorkeOwd
         g5+droc4aE55+U15CSRczv+rIy11cD+1F+5FW2zlAJWyx0UqPaSQY+DLp31oWB0HykpW
         itN1nsikytcctB/Ef6NzAHhA2voECLLVOQ2kIRzQP2mLpr4fkHoSNw6iLv7NT1FAMZBh
         kFcA==
X-Gm-Message-State: APjAAAW34b0Q7I1qxYQRlFyS8aLo/xFa91QHX6mhyynSPGmDipCKlYmz
        ge5YIVIFI0cW7k0mrumQNFLA3A==
X-Google-Smtp-Source: APXvYqyluAC31/q3nmbc3LlyWKDp/+k6dIO4sc3PoMHKduo2TBx5AZ4EX+qbn8Z7VeMzhjYQzdZkIg==
X-Received: by 2002:a17:902:523:: with SMTP id 32mr2477435plf.249.1552244395466;
        Sun, 10 Mar 2019 11:59:55 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id n18sm6886491pfh.93.2019.03.10.11.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 11:59:55 -0700 (PDT)
Date:   Sun, 10 Mar 2019 11:59:53 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: r8169 only works in promisc mode
Message-ID: <20190310115953.2ea3a0e5@shemminger-XPS-13-9360>
In-Reply-To: <2fbb9488-198f-0a9c-af3b-bb45bf424884@gmail.com>
References: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
        <82c0ba0d-c7cb-32fb-8e0b-2191b8678c16@gmail.com>
        <20190310071853.3c726dbc@shemminger-XPS-13-9360>
        <2fbb9488-198f-0a9c-af3b-bb45bf424884@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2019 15:26:16 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 10.03.2019 15:18, Stephen Hemminger wrote:
> > On Sat, 9 Mar 2019 10:33:40 +0100
> > Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >   
> >> On 09.03.2019 03:16, Alex Xu (Hello71) wrote:  
> >>> After suspending, my r8169 (not actually 8169, just that driver) only 
> >>> receives packets when in promiscuous mode. I have tried disabling all 
> >>> offload features except highdma [fixed], and it doesn't fix the issue.
> >>>
> >>> I am using torvalds/linux, compiled about two days ago (not sure which 
> >>> commit). I think this happened after a recent upgrade (some time in the 
> >>> past week). Given the long testing cycle, I don't really want to bisect; 
> >>> I am hoping someone has some idea of where the issue could be.
> >>>     
> >> The provided information isn't enough to say anything. Please create a
> >> bug ticket in bugzilla. Needed information:
> >> - Last working and first failing kernel version (as reported by uname -a)
> >> - Is 5.0 ok?
> >> - Full dmesg log
> >> - lspci -vv output for the network card
> >> - If the issue happens only after resume from suspend, diff of the
> >>   chip registers (ethtool -d) before and after suspend.
> >> - Does removing / reloading the r8169 module fix the issue?
> >>  
> >>> Please CC me on replies.
> >>>
> >>> Thanks,
> >>> Alex.
> >>>     
> >> Heiner  
> > 
> > Bugzilla is not really used by Linux network developers.
> > I just filter/forward mail from bugzilla into netdev.
> >   
> To make sure I understand you correctly:
> Are you just saying "network developers don't actively scan bugzilla"
> or do you want to say that bugzilla shouldn't be used in general for
> netdev bugs/issues? What would be the right tool then?

both.

Please use the netdev@vger.kernel.org mailing list for discussions.
