Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC43BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9564520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSn0eTlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCFVLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:11:34 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:36351 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfCFVLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:11:33 -0500
Received: by mail-qt1-f172.google.com with SMTP id p25so14638463qtb.3;
        Wed, 06 Mar 2019 13:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kIquJWyF7Ir2rq0egP9RzmDlVClTk83a4ZdvQKSO4LI=;
        b=NSn0eTlEYqnlNsvQjAjNPv4cMX/Jrh2wblCHlnNgAQ5AcvBV8fntGWoeZrEGkNyYM8
         MIwyyD3+dIQUMZIl2aF9hTw5fCPOwijkIPIHifLynblC2vm5efe3heugzhCh6bGIQ9Iv
         ZTfswBePWze9I4+CuBveDlF1J+Ui6iL/lM/XJpN8qIPnYADnGwisBln7V3xnNhmeLww4
         jl2TcVQE5qTQuylvGhXTw/uintUOpmi5xTVASLb06TDTFB02hyFknJfNK9BBNTvn++2b
         AZHqX+HyJdS7y0wsy5O19I4V75aSxtZ1oglh5W/JHRwjlE6xx8rlkMR9X0Zo9KWU9ha4
         4/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kIquJWyF7Ir2rq0egP9RzmDlVClTk83a4ZdvQKSO4LI=;
        b=JFgUJf5I8kCKxgB6Y/V/a/nd0atikucHLSB0fy0H07HnAI+o0PVI87DdDpD8nyDpvF
         qo5NlNcoNM+69cOu4l86G4a9fr908W7EJpSo+vvoW/Wxgr8OiSefyQ52/kkSDYhfDnlw
         7/SDK5R8AufivPCuI92EwCVmfKg3u5PJRlHWRL+a46RJLzPajOxbiQRzq3dducXBdCKt
         BZ1W81pnamR4rrZfB+F9amh0xuPlnUSC0mhVvTmRSktZTHK+tFrwsNjjWAH4x5R+2WAY
         WsKTX+6Qm73YSQMiZgzQ/+YvZIUnPwuBZvXZitgK7Pa0sFhBMEPTZtTbN3liEa/5TLX0
         uZwQ==
X-Gm-Message-State: APjAAAU5+6cM9RLKK5TxeG3D99AUSBvjjwvWDKETz3xVErLgR328MgDe
        rBMLVz4WT5V/DcLnjR13xmA=
X-Google-Smtp-Source: APXvYqxEJKtZZPsv1tcUfPG6Xuf70O9CHghghVRM3k7GRukrAYmGgBITFskx6grftEULy9OkOk0OxQ==
X-Received: by 2002:ac8:23e5:: with SMTP id r34mr7597468qtr.351.1551906692755;
        Wed, 06 Mar 2019 13:11:32 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id j13sm1436201qkl.84.2019.03.06.13.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:11:31 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B88D34039C; Wed,  6 Mar 2019 18:11:29 -0300 (-03)
Date:   Wed, 6 Mar 2019 18:11:29 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 2/7] perf script python: add Python3 support to
 futex-contention.py
Message-ID: <20190306211129.GN30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-3-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302011903.2416-3-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 01, 2019 at 05:18:58PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the futex-contention.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6

thanks, applied
