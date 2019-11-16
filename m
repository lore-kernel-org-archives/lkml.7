Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235C5C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 23:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E213120733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 23:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="wLK02EoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfKPXpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 18:45:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45902 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfKPXpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 18:45:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so10815545lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 15:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uHCSh9nUOq2gFA4SxZmd/Wi02WzaMYqqbesRp/X675Y=;
        b=wLK02EoXQvN26ZZudLxdxZ6YijJkH6FgZGzeS3k8aWYHx7h9tuHSqK9HVr4UVWILR/
         xv/5NNzXXTIjGp8GT1+yteESR+V3WD56gEfqoOrXehYgBGS7AbwSRVUbzTdJ7gpPd9vp
         y3U+t4dfmR3K0nj258P+OfrCWvgAl/p8GgxpMHzfK0Co4TvHMUk7qxje+TavO+s+sJkI
         alxm9RnXgR53GpnoI5kPIKOreqknqTlT4uAZWqZV4ZoG1NB8YfxW292nSJzvzRX4Vd+H
         Ve8APFXQJtUaulaukAbLbi6AoX+ihDzSwF3SMrTbzqe9ENZky10Ii3qRhiRKREtHVeh6
         jCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uHCSh9nUOq2gFA4SxZmd/Wi02WzaMYqqbesRp/X675Y=;
        b=Xxqi4RzSMKHIJwFzffHUfRpiUEO8vmdQ+QlvVVSaZcYFB5t97flDazxEk/dAjPBI6c
         FFpUjt07j2uJy8Qi9qB9IMtLuSIESD7p+Xp2G+jVC/tR+NHMe9wDZa1lVQ1NuaJI/0pD
         9TbW25fw/pwdv/bjw1rR+15JbbyTB3Zn2jUG2IurvL1h42IAV/1y2v+gxgOgQ8g/Lkjt
         uJ1jbNx12Stj3I3n6eEn+SrsL0yp+CH/z5J2wZRB0d9xlD4Q2nFkE2lf39d+cHo8FQho
         5/pyp55E88bo+I8WXg5dovC7YGN4bZ/UYLI9qNVD9eHqjbhwI+mt+b0ZCCNHGHBo14Dq
         pdGg==
X-Gm-Message-State: APjAAAVsvmjByuNQjwrLLQVvmeyXaJkXA51OOWuU5+4/sBa2rlN1cK/3
        NSvYy8q0KsEBdj8G2yhFiPVPGQ==
X-Google-Smtp-Source: APXvYqzU7+KlWfCx4jmUs3DZSGvn/oTnC5pEfy07wppBTfZc9fuStdWbiaf3atYujRM8J9TEWeFFIw==
X-Received: by 2002:ac2:5a5b:: with SMTP id r27mr2335425lfn.186.1573947918486;
        Sat, 16 Nov 2019 15:45:18 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f20sm393609lfc.4.2019.11.16.15.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Nov 2019 15:45:17 -0800 (PST)
Date:   Sat, 16 Nov 2019 15:40:48 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm@kernel.org, soc@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee subsys fixes for v5.4 (take two)
Message-ID: <20191116234048.oas2rlfwxlz65jvp@localhost>
References: <20191115105353.GA26176@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115105353.GA26176@jax>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:53:53AM +0100, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull these OP-TEE driver fixes. There's one user-after-free issue if
> in the error handling path when the OP-TEE driver is initializing. There's
> also one fix to to register dynamically allocated shared memory needed by
> kernel clients communicating with secure world via memory references.
> 
> "tee: optee: Fix dynamic shm pool allocations" is now from version 2 which
> includes a fix up with a small but vital dependency.
> 
> If you think it's too late for v5.4 please queue this for v5.5 instead.

Hi,

I noticed you based this on -rc3 -- all our other branches are on -rc2 or
older.

Anyway, I brought this in to the fixes branch, it's the only thing we have
queued up at this time so I'll give it a few days in -next before I send it in.


-Olof
