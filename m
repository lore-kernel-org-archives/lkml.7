Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E47C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D2920678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emL8WP5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgAITZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:25:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgAITZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:25:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so3656130pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAjqIDcyKtCkeQ3NC3uPAZEniDBqyHWB4h3FVSAU1gQ=;
        b=emL8WP5mcndb4EapKnqp6DcpdLGh22V4ZAtETfs70LQhMGpkcMCK2M6FIt9FktWfSP
         ITH5i2lXEJkw0pAZw4Lnpdul+Y2lFBnLlav7skLg26FMFCFMQb4DULmdVeLLlRw6nUZ8
         BDePsczDPhLnrtGVsAv0EbI1CfzIRcOVBd9Cgetm2+bIiZEvuGpWHTnf2OhvZ1NTB0tM
         6A+6xHO95Aww7UAHOLT/nJs7bZ+HErEOe78wXEGpO2yKp+sfsytSnyfDuOpZ8xXNwtpC
         BUdUNiqqVRNQ7IEn1uo1xBv0NHAk4N2ORCXeHt/gPl0sqWJCpsdbFsSYnWkTy1SEROMM
         sLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAjqIDcyKtCkeQ3NC3uPAZEniDBqyHWB4h3FVSAU1gQ=;
        b=XAIM6eI4ck56GekmSMt+JC0XC4ugEx+bB2PhEDukD4Dhi8gjxThN40C2L+abyt8VNG
         j8tbvKG4MxfHQagGaKnnFxE1sPK2iNDa7M6FhYH0LFIYUFDdo1F6TjDSrgmpqQFRHlVv
         PuRtDDfhI847N3C2lFMCWJtSP7tCp+7njdClbGzlxj6/KxEcUsBMmC2USvTOHTp+Mq0F
         8M4Uz6HXCfnONmMJeNtr5ZXrKR6senVD1C4s7l2WGewK5UE8AUNTYBtlxRG0sBFyfI91
         3R9wXUQbkJLIIDS1zrnciyFk47Ge1NNvi0be4vsZk9o9NcVV/rzoK2pa8BTtX9UMQW8P
         MHPQ==
X-Gm-Message-State: APjAAAVgdWxC6iVQuPgnPILEEihmHPjYVvV0Ci/Ao3XAoc2o67xyoU8z
        MIw89qi8ylsSfTQZhJuuu2WMK4ti
X-Google-Smtp-Source: APXvYqwpKe9ih+ecA7Wkx36FWbGA2ELIOsfDh8N4qe/F9W4Hy4j3PAhEFCZzTyifVojyCUEZC+dE4Q==
X-Received: by 2002:a65:4206:: with SMTP id c6mr13181440pgq.46.1578597908828;
        Thu, 09 Jan 2020 11:25:08 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d1sm4241576pjx.6.2020.01.09.11.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:25:08 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:25:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [GIT PULL] HID fixes
Message-ID: <20200109192506.GI8314@dtor-ws>
References: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm>
 <CAHk-=wj+zyWsZGhiCiopkrnu1_bkNE1Ax+82sP4Donsv9pUZuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+zyWsZGhiCiopkrnu1_bkNE1Ax+82sP4Donsv9pUZuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Jan 09, 2020 at 11:14:22AM -0800, Linus Torvalds wrote:
> See
> 
>     https://lore.kernel.org/lkml/20191209202254.GA107567@dtor-ws/
> 
> for details, even if I haven't gotten a pull request from Dmitry since.

Sorry, I really disconnected over the holidays. I just sent you a small
pull request with this (and couple other) fixes.

Thanks.

-- 
Dmitry
