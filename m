Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B7C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1C3206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsr2lkou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJHRso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:48:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37499 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:48:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so11210901pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jfCUvf00utDLqMok3FW/zFyOWNZ71A20p4N5OZxf8XM=;
        b=hsr2lkouEZsK3SdykZlaDK0cspXUj5nZC6Nhx/hSVtJafgpvnj+tYqnPkBbAFuA9k6
         dW5gm/H2b+wwpXbVCfNkKzvhuyhHMsoVrXurq65WD8gcKRJh97UgrzgfsqMVCi82B9By
         +z/yiTm/Ejys0+35GvnbolE7A6/L3IBwnAogV5LzOFuK4bUADPWxg3tEjke2aMWl9Xd6
         PmLgtabboC4jIXKWIMKy/UmNwyFhOKN4nflZf5uszg54kP7Z9Om+sNcp58UeOb2dhsv0
         BQZPiPjN5dm7UNXOues5AvSJeASn5hXui8lkj7v1s1MC3xJnj7FdDeWOLf8Qnf4V72uH
         2X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jfCUvf00utDLqMok3FW/zFyOWNZ71A20p4N5OZxf8XM=;
        b=DvXkWI+trByvevkjJ6dFd5E+AA8kIDI9Pw5TYZW95TZ6Zvoh7tQi6kx1VpRBsOVylZ
         4k8gs8+LyNjev1L4KroF/+4exkKRTxylDqFnfaTprTgxmHuAA/7We1JBs7YpB2wkF+Fb
         OWgJFZ+mBO4q5HoxsWKH5ZrvYc27CQp1aGYxkKJfg+FEPt8AnzKWKJoJPZh6IGC6Aejv
         GyZk8U9m5so43N7tPydgEo9nnqczbh3Hgdxcvm1n8DiqVOFYIcNW/3fG/b2TXUHKrCvO
         iEa/SYAN75AOWEYpJblZZ7Uknxtw44ezpe7LusAaRnktYm18bTeoRpD+xQNFzXzk2tCL
         FTAA==
X-Gm-Message-State: APjAAAWcBbUslezW1/2w/QOg0b+dDd2kwRWcns2Eq8vVKdZh+NtewlXF
        eHmeHM/YMN81XPCLnmjZ3FUb5w==
X-Google-Smtp-Source: APXvYqymWlK8N7zXz2sJ/F51jwTVbC2MQbu7sNgYWIHbTTXVCA1R2gUDjXvRgkdF1qAnzpwfY7WviQ==
X-Received: by 2002:a63:c641:: with SMTP id x1mr8912872pgg.450.1570556922615;
        Tue, 08 Oct 2019 10:48:42 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id i37sm2561820pje.23.2019.10.08.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 10:48:41 -0700 (PDT)
Date:   Tue, 8 Oct 2019 10:48:37 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <20191008174837.GA155928@google.com>
References: <20191007213633.92565-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007213633.92565-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> This change adds a KUnit test for the kernel doubly linked list
> implementation in include/linux/list.h
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> This change depends on KUnit, so should be merged via the 'test' branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/Kconfig.debug |  12 +
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 726 insertions(+)
>  create mode 100644 lib/list-test.c

Also, I think it might be good to make a MAINTAINERs entry for this
test.

Cheers!
