Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684CEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378C520700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MV9uQy98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfJCNeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:34:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33528 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfJCNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:34:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so1831740pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gIJ0jka5KGWKgQ+rBKh8A6Mx56u7SdInpqBfmXz3Utc=;
        b=MV9uQy98Z065rms1TwM6tj4f1tV2LO6r1ieHREYC6llSHizBltPP8izrXgxgbYw2Ld
         Gyk989EXU8KdwGcq/ow5/MpntpGo1s7M09J7PYtoEU5s8MecaETscT+qJ2siEKZ+i4xT
         9CDTEiAvrBMy0XVuXe03U/HjBgoDVNS/kfiVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gIJ0jka5KGWKgQ+rBKh8A6Mx56u7SdInpqBfmXz3Utc=;
        b=JTapex+3PDw+efThirmlDN0M636Ydod3UO/aJAjLOY+6WsVDWAdnq8RUeL0supt/SF
         BSWzIYkM9mP0lLxZpUXfH1ugcEvuJuBPxbrLc6SfPNXjy8IyfLA+4V4ux1jW2y3iEuY3
         a8Qe/wX6CEOQy9SLHw/WPzotW98n7/eFMSU90uZKIAJzcehV5Ue2FvoN496ramCr/fRO
         tcxQZDGAWxBjX21T+v4dfNtNFNUhcm371Z4NsUV4G0u9b8T6rIEQwKq5gbow8ZihHnxi
         a+R9KWSphA6BKG+HewQDbgxO9er9YDDPPVAMg0UY3KULcfMliikqXRxXNdxXJqJqlzMi
         jDbQ==
X-Gm-Message-State: APjAAAXI+OV4a5ISuhYb6vJXewdUR9OHPYAEVHOcSdqRRLcQsOOtIw60
        CSHLv5DJRcc52h+FmN8n0bNvF8sDJIg=
X-Google-Smtp-Source: APXvYqwus8tWonGG4CW+EsZatpnlv3ocaEzjlNXWm+Vi6UxtwMEz0iQgojBYqS/sKSoS30qCg5VV1Q==
X-Received: by 2002:a17:90a:6547:: with SMTP id f7mr10374905pjs.13.1570109659113;
        Thu, 03 Oct 2019 06:34:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p66sm2976468pfg.127.2019.10.03.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 06:34:18 -0700 (PDT)
Date:   Thu, 3 Oct 2019 09:34:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paul McKenney <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Add me for Linux Kernel memory consistency
 model (LKMM)
Message-ID: <20191003133417.GC254942@google.com>
References: <20191002152837.97191-1-joel@joelfernandes.org>
 <20191003115727.GA13200@andrea.guest.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003115727.GA13200@andrea.guest.corp.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:57:27PM +0200, Andrea Parri wrote:
> On Wed, Oct 02, 2019 at 11:28:37AM -0400, Joel Fernandes (Google) wrote:
> > Quite interested in the LKMM, I have submitted patches before and used
> > it a lot. I would like to be a part of the maintainers for this project.
> > 
> > Cc: Paul McKenney <paulmck@kernel.org>
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I don't quite understand how you ended up with that Cc: list (maybe some
> other LKMM maintainers would have liked to receive this email, to update
> their send-email scripts if not otherwise...) but welcome on board Joel!
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you! I CC'd Paul and Alan but I should have manually CC'd all the
maintainers in the file. I typically use get_maintainer.pl for CC lists which
in this situation did not work very well.

thanks,

 - Joel

