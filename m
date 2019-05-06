Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4602DC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16033208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557134199;
	bh=EXIJowy68yIzWTch0/VWZz+W3Y3eGdjD1oqF4Wm2DZM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ycADZ8xa3GgIh14pOv8LV2t+voXuwNISiJy7je5dAfDiH+TnhkNTo2SRRl6r2g+QG
	 XcXGzvWwu8+evV36R1uDhiklMjX6u6z455e2aNnrO87euY51Qt707x0Q3cjoeEf6wW
	 mq4upO/ueLvq3J9Acr7DC9peASPMd7Ch7MyRqUC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEFJQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:16:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37870 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfEFJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:16:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id y5so14281408wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Noe9XpMdzV7vjmkjjO3/M95ZrfmDVSYKxgP9yiP33KY=;
        b=iEoaiudUJMjpJkla4+UP4lj10tnw1gdt+0gKfy5VteWdQ5zMDCslxa356gyFmaJkzY
         jE0Ii2rLNeSvUt6krYuuuMXga5AZcLe/eBPSCidy2BY3ZzrAPfxS7KakAmx/y0x+Unkq
         LPUFqiVhKjuO8dk1FaXS/jjoOMuJPBdWhDXuwhJ2LYjOit/C5zwtAyHHU0GiOjicNxke
         7se3Gd0yAe6JlTcQfUlZvQ0/wdZ7ua2dheGR2Wa5GLCPuaKLWlrm9BG2M26RE3IGq1xd
         E/W+q1zVSn1uVs0lGCtUp6bAd+JVupo0HcK81dsbIMxSib3kri63ARaw3/3USXekTOQl
         czew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Noe9XpMdzV7vjmkjjO3/M95ZrfmDVSYKxgP9yiP33KY=;
        b=O+FSAbEf1Kf51D0Tcko+slMbvxRAd7Gv5muEGp7ZW+JqJee0fF8OgOwwbjMgF1foqt
         TFdPs10xeFTkPPtmB/ipf/uG/onZZq6lZfl0/egtQPM7mHDKmvFtSKGyaZLcR8RsVAIA
         VylYaKMrvRPg67DWDWPyuh9AqDm4N9nJKisp2w89kmifuor3YZVnlC41YinPjh90iXDp
         UWhNmDPT3aarVnobTHp7Kc9Axk5+A7yHgHhVHfeEuGodjHUvlOFp6mcd9goiXC/v3/5s
         GGgXE8/iF9jl4ldbLHyCLitosx1uSfC7O2UjjVu5emi43a0SyCNVlyDyrso1fTRbLOkJ
         o+Iw==
X-Gm-Message-State: APjAAAWXaY2TgN0MA0jIy8wcH4JVVx9bobhwetFBXTXzF3k5JO1jzvAo
        yOMu8XEUnK6ko4qE0Ex9rUU=
X-Google-Smtp-Source: APXvYqydl7ZyeYrTOmtqGy0tmubZ9zgUCu4HKJPYmSqWg/bv+V1yjgYXR/0zP5bOHWlMBEYBDn5rAA==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr15466603wml.108.1557134195738;
        Mon, 06 May 2019 02:16:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k67sm13771734wmb.34.2019.05.06.02.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:16:35 -0700 (PDT)
Date:   Mon, 6 May 2019 11:16:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] SMP hotplug support changes for v5.2
Message-ID: <20190506091632.GA42696@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest smp-hotplug-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

   # HEAD: d4645d30b50d1691c26ff0f8fa4e718b08f8d3bb smpboot: Place the __percpu annotation correctly

Two changes in this cycle:

 - Make the /sys/devices/system/cpu/smt/* files available on all arches, 
   so user space has a consistent way to detect whether SMT is enabled.

 - Sparse annotation fix

Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      cpu/hotplug: Create SMT sysfs interface for all arches

Sebastian Andrzej Siewior (1):
      smpboot: Place the __percpu annotation correctly


 Documentation/ABI/testing/sysfs-devices-system-cpu | 10 ++--
 include/linux/cpu.h                                |  3 +-
 include/linux/smpboot.h                            |  2 +-
 kernel/cpu.c                                       | 64 +++++++++++++---------
 4 files changed, 48 insertions(+), 31 deletions(-)
