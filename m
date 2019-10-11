Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1797C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61332089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNLMy2N2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfJKSxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:53:55 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40873 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfJKSxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:53:55 -0400
Received: by mail-ed1-f48.google.com with SMTP id v38so9552386edm.7;
        Fri, 11 Oct 2019 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yMqI9DhuNoBVUsiF9tFhp/RMZZSSrTpL8PL6JDBT+0g=;
        b=MNLMy2N2+o5YMbYOMxiLtlQckrQXS8x6ZfeVTup0DaxlaDhMMyJwMjb9dSzxL8B+fH
         VwtZZTh7iOKjGTm01nwZhXJh2nDxJhqngj6dJcuNofQE1IQ+pGyqhBpMFTsFSceVfBAW
         +SaQKU/vqS37iPFcdMCjVlswYepAfOxJc1utEZbVOsH2Qwuh1VIy6jJB1+ikp4l5tTGN
         R4mAiGh0guB8872men1diPWETn5zWD5RvPO8QuNzjuJu9sfJi86L/QOxWH7J31yqPlI1
         3u/lm5rsqLq17kJteFIc7TKxaC4nRh4RoYIxdrNhLUiQG+UhJxNRd6pZvqcHxxr2G+jy
         9XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMqI9DhuNoBVUsiF9tFhp/RMZZSSrTpL8PL6JDBT+0g=;
        b=G+GM5VYqI0HK+PhLk2fyHMuBLZOe+e25sgTg32mwYgqVFjG2nbEN1wTbJS0tCpE27c
         Q3S3mz9wKjGGlC5b52im4iMO3jHRPg1mWAKQTc8TWFlYwMEn3Cu5tByGhCsdVHDVG0Mw
         cukxJJUugeXmMak00mqmdrM6dcF1PnPH1yIzWPZFfPWtCFgR30LM3eeDD4uRaoRBVAWC
         pt+kEGVp7dsJmdN+fzqC6MdxalNNNr7WCa9nHU2l8siSKEK6W2Bqfp4Gx1dLP0NXpyp7
         9HN9c/47FP25FU5Fs0fA9oAzvQzpHGihFR+WmjMxZlt33FsATtE9NRuqZ5JF/hl6pE7i
         u5ug==
X-Gm-Message-State: APjAAAV15ICs55nIzOFLAxNmhY0LuMSKGodGQUVV5ZjNriSYU26LGwUa
        YA5yti93mXWFZzEm12o0dyjse0fY
X-Google-Smtp-Source: APXvYqxl5sAe94KTB/AtcFi9QjXMyUqKrMtph5PuTkLW1+7ubnnGpH9vqhOB684JFGUl5WSUYOSgJA==
X-Received: by 2002:a05:6402:7d2:: with SMTP id u18mr15510063edy.23.1570820031771;
        Fri, 11 Oct 2019 11:53:51 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4080:1900:e095:3859:da44:d743])
        by smtp.gmail.com with ESMTPSA id qn27sm1287269ejb.84.2019.10.11.11.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 11:53:50 -0700 (PDT)
Date:   Fri, 11 Oct 2019 20:53:49 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org
Subject: Re: sparse warnings on undeclared asmlinkage
Message-ID: <20191011185348.pkfsexr742x5xwgm@ltop.local>
References: <67799c6b-77c1-8488-9595-38ca734e8d5f@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67799c6b-77c1-8488-9595-38ca734e8d5f@codethink.co.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 05:18:58PM +0100, Ben Dooks wrote:
> I was reviewing the sparse output for the current kernel release and
> note there are a number of warnings about un-declared functions which
> are only used for code in assembly.
> 
> I was wondering if we should just ignore those, and have either a
> new attribute for "undeclared is ok" or to make spare just ignore
> anything with the syscall_linkage attribute?

There is already an attribute and it's corresponding kernel define:
__attribute__((__externally_visible__)), aka __visible.

My point of view on the subject is more about the lines:
* who knows about __visble/externally_visible?
* what's wrong/are the disadvantge to adding the prototype?
But it seems that some maintainers are against using prototypes
for functions only used in assembly.

Cheers,
-- Luc
