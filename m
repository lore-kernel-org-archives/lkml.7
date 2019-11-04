Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39FECA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 05:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B32521D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 05:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="V8fsDNiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfKDFt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 00:49:28 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45435 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKDFt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 00:49:27 -0500
Received: by mail-pg1-f177.google.com with SMTP id w11so200545pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 21:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vLPhmFH0lirMn9kftpW2taUAg55QYbU+yuMOsULSwhY=;
        b=V8fsDNiCq7EMxCvkBUIYI8dLXDN5gKcbc41mHIaV4EG6U1VHznHJiZSxS8Ngo/7EWp
         HeHKfeCHud1qSafqWuJWYaECSU58AsvcSUVSVAU8DQagSdTwRCZXdPfjEBhxiEmiZPcw
         JJpv/bjiIfyxtPRfY26VKF0+mASokJp1p4XMAKCZ6QeHdmWDySCapFZsgEwFcDCvHocM
         81VV7DX/iMKkoLW+s9ZlA/rxgZkNs7bKYNdLZZ5mEbwoWD60bL9cXzRn7RNoVk572XLy
         I3oopnft+0gnEkVAOnseW54GtSY0We+BUvv+5oUVLLNfcY/OrfNnsJ2aaLQ7Utz5vcKg
         +NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vLPhmFH0lirMn9kftpW2taUAg55QYbU+yuMOsULSwhY=;
        b=EXnTyeXNJUnq7UIDkYI33bU/aIpBY/BFf6MRkpQOegkbg1dKuk+Q+4XDv/9RhG6KkI
         KZ8s3UyJf4aL5McJJkVmhZ6LAcO92ddvvVeJ/35qyTrVUs1cVw6peR3sruEYgOyIwBQ0
         HnVVcYsXCXHX0I4lnGsqxZqh8P5BGRCLmS0OeRERGpiilo45wHsKLsGhhiQuKEHUvAiC
         AYpjdNqLbj62wYg0K80jvfxUi7XTYIMx58cKCpxgXfh4N8avklg8jfMCh/PzX5OugbW7
         LCILrgLvYKdwlLP6kMxGXAfofzw8HIUFYGNeSNZPo89tEk1gQNM8QxGVuIfnhWV2gn3u
         yCnQ==
X-Gm-Message-State: APjAAAV0GIScd2Lqtx1z856WMiYmCOTXRyD7RvC8R++HcgYAZIbFQFXD
        bm1D8/8Jo5xIWb8eFF8uSGx3CA==
X-Google-Smtp-Source: APXvYqy2gMtZu93mAqoRUYvZsNfYPi1Lv07OqGl8c4eptZ6pT49OOU7aZV+cJhDYrFN7XVFd0q/UaA==
X-Received: by 2002:a63:b44e:: with SMTP id n14mr28270433pgu.154.1572846566432;
        Sun, 03 Nov 2019 21:49:26 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5975:7f6f:59ab:7646])
        by smtp.gmail.com with ESMTPSA id n62sm20828513pjc.6.2019.11.03.21.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 21:49:25 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Sun, 3 Nov 2019 21:49:24 -0800
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.24.0
Message-ID: <20191104054924.GA47418@syl.local>
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junio,

On Mon, Nov 04, 2019 at 02:36:50PM +0900, Junio C Hamano wrote:
> The latest feature release Git v2.24.0 is now available at the
> usual places.  It is comprised of 544 non-merge commits since
> v2.23.0, contributed by 78 people, 21 of which are new faces.

Thanks for a great release. As always, your release notes were
very helpful in putting together GitHub's release highlights [1].

Onwards towards 2.25!

Thanks,
Taylor

[1]: https://github.blog/2019-11-03-highlights-from-git-2-24
