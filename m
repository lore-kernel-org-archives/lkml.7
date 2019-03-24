Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CC0C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7023F20896
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlgMgDap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfCXVjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:39:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35563 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:39:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so7024564wmd.0;
        Sun, 24 Mar 2019 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6pqCkxXq/b/N9uVrwU+oMnL9SMQF4R8lo2BCTugnag=;
        b=SlgMgDapELYq5ys358aM76isrZtUSGVhkMQ+nPYdfA+WGQkKZHBVDaqYozS8SXj/Vp
         2kow+dHV3nwngqK1xliw0ASIv6iNcTebBZ2R/ulyXkjRMGmy9EuFJO7F5fGCP8K8q1A+
         g/binMxje+k3JaqhRwgRDtwNSvwjm79j26XKdLWHaromf0JY+DO0MyxkoERPOpBBH+vx
         O1WkaeK8BleYRRt+CjCGM6YNfmdvTXm3xP5GeaP0m8aTfTy3zMUwuw1VXxr4bNqf8IqJ
         QJ8XT5Mcexd99vE8eyEiWJT3jndC2HgpdWdN4FFXvnxqKgjeGJ9dWvcFkWI+q76pb+5I
         CWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6pqCkxXq/b/N9uVrwU+oMnL9SMQF4R8lo2BCTugnag=;
        b=X5CpyBUQ2Fiqj9xpK3llImyazdYd3qGjMf9qbIJAiYXRUcNxOagLlFtsd6MZs1MpdF
         fBd6RF1dpsXiuwgUzhV08TxoI6tNGEbHajKLkUFqCsvecv/eJVSPE4t9fSxWrl9yBtYn
         NisnBZ4DnwCdlSw2DGBDKgGskL3tL/qwzyAPoPP69xicnRHfHkqbJ6DKyfopFzFO7V/F
         20/H0M4lKE8jkDtLqKKGljMWfsxJX+79REXkSmTG3ayf6ajO4M9RWLUylOn9zWgwlc8X
         4VDl492PFQwNtoeJ4r50GyQVZnwqtg42YJTMWLVChuNnJzW98k6KVJsGtg64dPTAoGbl
         ulwg==
X-Gm-Message-State: APjAAAXsoIyjmmTq3yZevMiXWvXet00PcohkqzSpVQJ32CTnLXRwr0tG
        O7UHHmRSf6zeg3LD4RlZtSA=
X-Google-Smtp-Source: APXvYqwB9h5L9MWyHOR0K/O3AW6NFaq/6gvMhSmAyEghfMqiVqOcf1bbNB3dCST7LqgJ9ri1SUyjgw==
X-Received: by 2002:a1c:4d:: with SMTP id 74mr9154569wma.1.1553463559228;
        Sun, 24 Mar 2019 14:39:19 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id t14sm7119514wmi.16.2019.03.24.14.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 14:39:18 -0700 (PDT)
Date:   Sun, 24 Mar 2019 21:39:16 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yifeng Li <tomli@tomli.me>
Subject: Re: [PATCH 5/8] fbdev: sm712fb: fix crashes during framebuffer
 writes by correctly mapping VRAM.
Message-ID: <20190324213916.7xfxb7itj5ooydse@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-6-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-6-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Teddy,

On Sun, Mar 17, 2019 at 06:25:01AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), running fbtest or X
> will crash the machine instantly, because the VRAM/framebuffer is not
> mapped correctly.
> 
> On SM712, the framebuffer starts at the beginning of address space, but
> SM720's framebuffer starts at the 1 MiB offset from the beginning. However,
> sm712fb fails to take this into account, as a result, writing to the
> framebuffer will destroy all the registers and kill the system immediately.
> Another problem is the driver assumes 8 MiB of VRAM for SM720, but some
> SM720 system, such as this IBM Thinkpad, only has 4 MiB of VRAM.
> 
> Fix this problem by removing the hardcoded VRAM size, adding a function to
> query the amount of VRAM from register MCR76 on SM720, and adding proper
> framebuffer offset.
> 
> Please note that the memory map may have additional problems on Big-Endian
> system, which is not available for testing by myself. But I highly suspect
> that the original code is also broken on Big-Endian machines for SM720, so
> at least we are not making the problem worse. More, the driver also assumed
> SM710/SM712 has 4 MiB of VRAM, but it has a 2 MiB version as well, and used
> in earlier laptops, such as IBM Thinkpad 240X, the driver would probably
> crash on them. I've never seen one of those machines and cannot fix it, but
> I have documented these problems in the comments.

I only have access to SM712 and I am testing this series on it. Can you please
test them on SM710, SM720 and also on big-endian machine, specially the patches
from 5 to 8.

--
Regards
Sudip
