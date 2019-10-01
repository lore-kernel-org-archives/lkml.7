Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9F8C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA2B2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArdtP1c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfJAXKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:10:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35718 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfJAXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:10:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id v8so13541604eds.2;
        Tue, 01 Oct 2019 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rllEIXSEaJY+0zEEMqfyvHADIZRp1u2OsWJwhWHfzJw=;
        b=ArdtP1c3q8CKnJz8AiZ8hgGXcZmYBVvJZ3S0smD/DiUBn7H/KRI2q9TXLCyZ9Zu889
         5zVdKYAW6jn8Pqft0KmuoBugb4FxcLj+QUeYxPcqOWsDuq6T0erzPFWmz7koAt/fYmPw
         wf6FaZRScZ+IcqZoPxQbPlzy0zBvHpQTGRURHmg1Z5nOTiIqzJZhxo0S6eqkSPjLgWJk
         4nGEkE5/ch89ON3SGlCUw33/Z8j+Iretag3f99oQ6NuUl7xqXDzut4RmFqTcOX+Ljk0B
         ixqlo8pDNQ90eJ+aNm4Yl8cbYZyJmq/IDQmXeqN/j3CqYdFC3jiLUwhvxxCgmZEJ3tG7
         YN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rllEIXSEaJY+0zEEMqfyvHADIZRp1u2OsWJwhWHfzJw=;
        b=V5oPr9ntI8Mn7/j3PpwfKNvlCjrNbZlSlnElq5RY6hOXJuYCFHTpq7v7BD1LiaEVzC
         1quvelCgJFKfFZbxML6wb2/fxn/VJ/J7Ju0aiZJDxqC0V7T7C3fBZRUoAIspa3+h2vG9
         EVgqDEN6OwfyqhltOZDuiJzOYHOrJ//7MIXiKFLGbdWQYcE6CgZ4qOZ5G//pWm/E4B9m
         jylk14LWuvkvfU55qcZZkeyJbQ9dXmytXZ3VaGLHRPx8onRpjwd4sZfsAN5/F8HwF2zZ
         6qJaMO6sl8sko8/Fj0Y/ftShyKjgxXE9V0wgoMGH3AiY/OWmt2kQN0LKZKSd0obVmqDn
         DzwA==
X-Gm-Message-State: APjAAAWz5bl+rpk9DsIYUOKEgQJqBefJbyRVghQcvQuzkV/JTGVK6qUr
        TXdw8zRgUwplsd2iBrEdqfQ=
X-Google-Smtp-Source: APXvYqxCwnsxrsZ0hgw5ZP4b4Wj0yx4DKc0RYyXjQaniqT/qEmoXZMwtUiZu8tdA5iigF8D9bEQC4g==
X-Received: by 2002:a17:906:48e:: with SMTP id f14mr524812eja.15.1569971420589;
        Tue, 01 Oct 2019 16:10:20 -0700 (PDT)
Received: from desk.local ([2a02:a03f:4080:1900:c8a8:489c:8544:d3e4])
        by smtp.gmail.com with ESMTPSA id q16sm1991662ejb.41.2019.10.01.16.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 16:10:19 -0700 (PDT)
Date:   Wed, 2 Oct 2019 01:10:18 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, sparse@vger.kernel.org,
        linux-sparse@vger.kernel.org
Subject: Re: Many unexpected warnings with current sparse
Message-ID: <20191001231017.67txq4dhrvhyzbu5@desk.local>
References: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 11:28:16AM -0500, Steve French wrote:
> Updated sparse to get rid of some unneeded kernel sparse check
> warnings but now get many more
> 
> I get 100s of warnings similar to
> 
> ./include/linux/quota.h:114:17: error: Expected ( after asm
> ./include/linux/quota.h:114:17: error: got __inline
> 
> but that is simply
>         default:
>                 BUG();

Hi,

I don't see this on v5.4-rc1 with defconfig or allyesconfig and
sparse's current version. Any sparse's version since roughly
mid-December should give the same result.

If you're using an older version of sparse, please upgrade.
Otherwise, please send me your config so that I can take a look at it.


Best regards,
-- Luc Van Oostenryck
