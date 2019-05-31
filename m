Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C6EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C528F26F9B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gqQvc6m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEaWJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 18:09:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44213 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfEaWJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:09:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so7396283wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mfg+WnExM9IDxwQ3GIescl8fTMcBUXF0iWpzmhsc0Ow=;
        b=gqQvc6m/IE4KhvJtYD22mB6DFJrC6TRT0jRl3At0zdC4HkIO4HTbOU+gkSTJLtiVHO
         d2Pytt4RQaoMKBYmQD9GmRU6vw5udrJUWvlFkcmkOAMPj1nIP0oD3dd19207O9Q1ktc5
         5QwYZran2v5dPHcSqydCxHuJT4sHk8cuYlZgam0OvIiIrZ2rNCW3/ISVznnux7D/BZfH
         7e5zgJmO5kMFaSBINFN1csKsXb2IJ5T/F/rdJQjXHYMDROLGMl8aksDBeL1YsVxhFQUF
         pmZE8T3spJwHcLw7olslX8n4miI0okoBfpur0B3K/znHah3jW9FzKO9ZGqCNNf2f2QPu
         7OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mfg+WnExM9IDxwQ3GIescl8fTMcBUXF0iWpzmhsc0Ow=;
        b=m7LLYwJfiEFyPFl+NYdzRXwgFreiheHaIU1r3+C7d8LkA+7Dl5jyKJkGNYGK5DOGTB
         EgxnI2Zgk6otyityBqJrngRsr5GzRDkfpw97CjL+olsVhca7pnzMi1oMu4ogd+/wzzc5
         aAvZBIvniZaZLVlbYY9k1KwedxTNkfieKwy4BHZs8R80GlOQ+7WDJemNzMTMTqwOwKYS
         PaF3M2W90NsOlLhX2CaJMztRyelI2q1XdJXN9NxASEbxwVpNQ1Eio3Y3pINCoqGetGyr
         B8yroacoAzaAetCkBzoZb+Z/OMgLADYXZv5a6cmvTNXVpbEq7oDMPp1aNPAgyNqbIa7j
         2MYw==
X-Gm-Message-State: APjAAAXIRDFzT5cqYljyHHSCyAo6LB0RaWLtkgXbPRJ8w/f06VmCnCEj
        0rXxMn4YiORvLfSxtMvUKgQkNA==
X-Google-Smtp-Source: APXvYqyM1BrmfXdXLpdNzGf3XeEte6aFrlMVGlMceLwxa2Jfci15tAOkH1kB7Q+eqdN2gl1CjdBNTg==
X-Received: by 2002:adf:9023:: with SMTP id h32mr8164520wrh.95.1559340541718;
        Fri, 31 May 2019 15:09:01 -0700 (PDT)
Received: from brauner.io (93-32-55-82.ip32.fastwebnet.it. [93.32.55.82])
        by smtp.gmail.com with ESMTPSA id b17sm917188wmj.26.2019.05.31.15.09.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 15:09:01 -0700 (PDT)
Date:   Sat, 1 Jun 2019 00:08:59 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>, linux-api@vger.kernel.org
Subject: Re: [PATCH v1 1/2] fork: add clone3
Message-ID: <20190531220858.nyr7kdduk4auu67m@brauner.io>
References: <20190529152237.10719-1-christian@brauner.io>
 <20190529222414.GA6492@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529222414.GA6492@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:24:15PM -0700, Andrei Vagin wrote:
> On Wed, May 29, 2019 at 05:22:36PM +0200, Christian Brauner wrote:
> > This adds the clone3 system call.
> > 
> > As mentioned several times already (cf. [7], [8]) here's the promised
> > patchset for clone3().
> > 
> > We recently merged the CLONE_PIDFD patchset (cf. [1]). It took the last
> > free flag from clone().
> > 
> > Independent of the CLONE_PIDFD patchset a time namespace has been discussed
> > at Linux Plumber Conference last year and has been sent out and reviewed
> > (cf. [5]). It is expected that it will go upstream in the not too distant
> > future. However, it relies on the addition of the CLONE_NEWTIME flag to
> > clone(). The only other good candidate - CLONE_DETACHED - is currently not
> > recyclable as we have identified at least two large or widely used
> > codebases that currently pass this flag (cf. [2], [3], and [4]). Given that
> > CLONE_PIDFD grabbed the last clone() flag the time namespace is effectively
> > blocked. clone3() has the advantage that it will unblock this patchset
> > again.
> 
> Hi Christian,

Hi Andrei,

(Traveling until Monday, so sorry for delayed responses.)

> 
> Thank you for thinking about time namespaces. I looked at this patch
> quickly and I would suggest to move a termination signal out of flags. I
> think we can add a separate field (exit_signal) into clone_args. Does it
> make sense? For me, exit_signal in flags always looked weird...

Yup, that does sound good to me.

> 
> I will look at this patch more detailed later this week. Thanks.

Excellent!

Christian
