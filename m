Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24830C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99F12089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556782698;
	bh=fj+a018RcY5YzvR1tpBCT/GJt2M/7xRzRR5F/8H6FYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=loDGTdpnR/UB3fAyFR+y1Zun6k0IRfwQcrsMJMtXjaymHPJETsSAsdf2WKJ7Plkh0
	 jmO0AByA11cOjQDNwpc6fSBSaLZMkiaFPmtBKfDIGRF1VsONwE3gd5k1HToIZIIGOS
	 WzLTdlqY/5beslbiMFafLrsRz//jcaDDiHE/TYCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEBHiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:38:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38032 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBHiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:38:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id e18so1265428lja.5;
        Thu, 02 May 2019 00:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BBJ1hjxqa+5BnXyt7pCtMPz5hZf7jhfxyIk6LZ9P3rM=;
        b=fZLai2Hgs7iH0UDuaGecGdq++MJ55RYWa2BuhClRowkPQw+hXnURfJH9Pplu3ziXxc
         p0mhyARMSDDjHFcbfGEEXcFQsLbqpogawacIXVDQbhJMhrYkfQBmp9/jmu0WpgMT/zyo
         BjuDkIK4On9GSuaz5Vn5xXGcyVfnR52GIzjmmt8tGXixF9FZErMSCZkM/WqLleIMYohz
         LDou1w29UXbxF+eSJQnMcQ6tetr94fLYzvRrNkLnV/hOpdsTaZYf25JLOoqN6VI/eZFL
         DGmDfCA5qeS6mpda7fDomJrI61aj95W46vsd5rOpdaP/NusKjMOZWPeKjkoeXZAPwd85
         MbuA==
X-Gm-Message-State: APjAAAWIHOq9TfCLzYo6hrjSnVjLR+md+IyTU+6XcQJdiThJpa0yGSBx
        KudNG5gOYnUSrVc7bBNKrQ0=
X-Google-Smtp-Source: APXvYqxgXmiMGnAj6ZI51kaf+UJVBTXjjhDiMew5xLleR1sKi+TvBdIjVm6aUGEkdhnkPuFrsHDr3A==
X-Received: by 2002:a2e:880b:: with SMTP id x11mr640795ljh.4.1556782694716;
        Thu, 02 May 2019 00:38:14 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y20sm9328553lfe.8.2019.05.02.00.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:38:13 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hM6IR-0006zW-Bf; Thu, 02 May 2019 09:38:23 +0200
Date:   Thu, 2 May 2019 09:38:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] kobject: Fix kernel-doc comment first line
Message-ID: <20190502073823.GQ26546@localhost>
References: <20190502023142.20139-1-tobin@kernel.org>
 <20190502023142.20139-4-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502023142.20139-4-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 12:31:40PM +1000, Tobin C. Harding wrote:
> kernel-doc comments have a prescribed format.  This includes parenthesis
> on the function name.  To be _particularly_ correct we should also
> capitalise the brief description and terminate it with a period.

Why do think capitalisation and full stop is required for the function
description?

Sure, the example in the current doc happen to use that, but I'm not
sure that's intended as a prescription.

The old kernel-doc nano-HOWTO specifically did not use this:

	https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

Johan
