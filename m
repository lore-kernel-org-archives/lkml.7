Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7112C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AF02084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="VgjwweYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDLPZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:25:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45045 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDLPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:25:47 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so8752087iop.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dLcgpmvIFlGayvhgBFO8bkpVrS2qoxIAT/D3lpu2Hyw=;
        b=VgjwweYs/R/jBeGHOJjd/QLra6Dxk9MdTrP7YHCU3L9y9PC/w+wRjjijcQ1iJKosNC
         QKH+aL+F4YMQRX3wJFsYYzxIZopU5b6j7Y8hafgAwJ08r/rix8GulJxYP7hNGsyJXn69
         eRkS5qR8qpipMUXYYc1TrWGBlAJnzf7iDNWmTebSCWmuIuJDIW9rxqlkPQEHTP/sb9nk
         XUtaEVKM9D1mgTRjc0bll6syKEamIspOcpMvVI8tfEnVsR4tB1OxEIdAP0Zf7d0MZ7bY
         P1VUs3PpOsYcrI90IEce0vS5TqODtaRIXbskTe9afQQk/OgnJldmCNRgr/vAfbSg12R3
         bsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dLcgpmvIFlGayvhgBFO8bkpVrS2qoxIAT/D3lpu2Hyw=;
        b=YNRFbqV+43veMFhyyoDTdbGUG8a6BFymq2rssU93msKys6hQsS+GOqcHSvipRQHMLX
         oucOycECqpmqmkvvligIxJBiZEVPTgz1bXrk+xINtj8Rf9m3trSNUrDp8LIHQ/OTPt/z
         HJtpOZfbkk7/BYxKejX0HyMN3+pAAvONbtEtef5uBpwMrqF8oO3c+1gDPNTrU38xKD0M
         0UH4unyMRW3NUqitmhNN9nahB1Ae2HhBbe8/uUAQ+7EmKXu4D7zqtM+yfaKvSBA1Wzme
         2B8l+M88CVknUQQWYuvQe66ty/S311oKJdK/HsiUl2vU8QAmPiD3fki86TrWXx5SMcrl
         dRVw==
X-Gm-Message-State: APjAAAWqNrI5z/q0tfBfyWPr+CgtCZ5jEIIkMeQlHogZJ9BPguxdPyLM
        oOS2H3JxWySYYhW90X0PUyjO0A==
X-Google-Smtp-Source: APXvYqw6tvslYwjHfXUiyHwHIhotoxtmhsBab8ZREa2o6Hqf1QBtkTX9sFgliUVSU1ELgtK/aPUxcQ==
X-Received: by 2002:a6b:4a09:: with SMTP id w9mr20682207iob.79.1555082746068;
        Fri, 12 Apr 2019 08:25:46 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:e0a2:3243:c21a:e844])
        by smtp.gmail.com with ESMTPSA id h133sm4382987itb.34.2019.04.12.08.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:25:45 -0700 (PDT)
Date:   Fri, 12 Apr 2019 09:25:43 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: Handle namespace failures gracefully
Message-ID: <20190412152543.GB25793@cisco>
References: <20190411235631.GA31624@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411235631.GA31624@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 04:56:31PM -0700, Kees Cook wrote:
> When running without USERNS or PIDNS the seccomp test would hang since
> it was waiting forever for the child to trigger the user notification
> since it seems the glibc() abort handler makes a call to getpid(),
> which would trap again. This changes the getpid filter to getppid, and
> makes sure ASSERTs execute to stop from spawning the listener.
> 
> Reported-by: Shuah Khan <shuah@kernel.org>
> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Sorry for the delay, thanks for looking at this!

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
