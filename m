Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65819C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354072084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwhf8UzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbfCANeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:34:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46865 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCANeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:34:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so19990354edy.13;
        Fri, 01 Mar 2019 05:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6MiZRbDnFH7E3sPevTt6YhdflgjtqJuZkFaKR9B+10c=;
        b=Gwhf8UzVyQ5TTnrHzZt85WH8n5rO4e/J8AQOuD4D7RiMKIAjHD73QIGbNTrwbVK0r4
         ee062GyOlOd+THHQUh+FWqPoSy777Je8u6Hn0+nyQtjCOEvIB06s/E1ZK9njJcE/oakE
         wc0izpwyldbadj/M8pX0zLkIvu9cTYPWOKFWtM/5lt7sm35kMKco6TkiiGxsAYmrmhtF
         Ycmb1WMW8Lvr1iW0grqu8TEBIRTQr8JR7oxPRDQVItoCsCK71geuOoM5nxZt4oZfYPIw
         26VC5A4DQW55OifHxbgte5uXwG6hXZ/Whc21E4i4/a+R9TcWz3kpxZf3cP5mjAZQI+K8
         bfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6MiZRbDnFH7E3sPevTt6YhdflgjtqJuZkFaKR9B+10c=;
        b=VMphgbj92xMQmJcNwBmzBKvRMoBwgBivC/1uDGgHDcEgDyZcJVEiut7HMVLFCbNqHW
         rohuz/ufs1HPsWBmxP7+EXkilzY4gLICnWwqHwlMpKZHj3YpP1P7WyxgofyH4Yl9UxO1
         sbN23+ubMvtRciRxZ0sKv4Mg1dBclQA0C28tV3vtgSv1MOwcAmVpWrQLecDTMdlIXFF7
         MLuO4RqM3acqM2ZzGINL/tA0asZBwlM1AfGFUISKYXDbj9C3G/ibJ+h3x1nyMojjf8ap
         JrIXr7mvL7rLMvEnrcfoZ5qntoOifODrUPwayROxtwfVmqaY1llWVYUNobxidfgUj3AY
         SmVA==
X-Gm-Message-State: APjAAAWhN0l88BghdlMUXETNJEFVNvX15fKR2OdcZdzg3gm9GGuESOH6
        wI9TBJJnt15SPMEnUm+CkTTM8YWl
X-Google-Smtp-Source: APXvYqyxI1YdeSwPP4f69XAvM48o5OYHKZTRAMJvPkbFLk88ucx5KThhacqKYxGeHSwsGHpNXvrcAA==
X-Received: by 2002:a50:ed81:: with SMTP id h1mr4282612edr.145.1551447251406;
        Fri, 01 Mar 2019 05:34:11 -0800 (PST)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id w33sm1769058edd.62.2019.03.01.05.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 05:34:10 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:34:08 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riku Voipio <riku.voipio@linaro.org>
Subject: Re: [PATCH] scripts/package/Makefile: put proper config in source
 tarball
Message-ID: <20190301133407.GB20771@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20190221215901.23970-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221215901.23970-1-ar@cs.msu.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> It is widely known that one can build a kernel without a .config in the
> source tree by setting KCONFIG_CONFIG equal to the actual configuration
> file path.

> When making a *-pkg target, make(1) prepares a source tarball and tries
> to pack `.config' in there regardless of the value of KCONFIG_CONFIG,
> failing spectacularly if .config is absent and packing the wrong config
> if it exists.
> Let's fix that.

> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
Reviewed-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
