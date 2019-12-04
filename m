Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD66C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6702081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575473550;
	bh=e517Yg9aumVhsxOa0qUbC+kXGIaj1ydlq4wSKgUoxpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P1K7Kk4ffU1tn0DH9LHQ1lSnFX6gQwf4gxfoWiinZhwBGTql4iro/4iw3gSW6VN23
	 uva+904+TZ5vwq9YYgtbQctcAkNqtsep5Md8tlBl0zEMUPBiAXMeQFV35XynK1rW6p
	 12y9CFDdSSqQGG5HnKDK0rgn9v4RtYRP+eAKVlF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfLDPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:32:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfLDPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:32:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so162283wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqpdfGJVxXCTd1ysYnxGhEaU7ov9/g/+UiQFsLmwatE=;
        b=H0UvgD27x0mH7eA+xDS2DPfoV384onhiB1GvAKxBYknCfyhmQwily4z9W9BFLkQjlz
         qDePjavJshCAdnxMB+XI7jCJljzRiyCX5kMrNENum7ke8mspj8Kk86cZAvKb3YUN+1d0
         RK0240GQPBgbcc9ndb6TTkAAk7tUFDuRdGp3LLiFpqRx8gXowWCcvOF7nnNcWlJmK8Ak
         YpldZe9VmJZaAkJ2I4P3N3hvz6yUqHI24RciBHQzlnp9pQp+TAkqXvcouTi2v9H4n6o0
         IJ4tvhanNHgLDSTLwWcDKrkH3Kxl2aiDFgarEAyo+CVF45q0/1av9tCV7jir7Cx4cjqB
         58fg==
X-Gm-Message-State: APjAAAUFBQfbEMyTG+zoJnUejIxOw9Qs6zuXfv5nGTFe8WxA58UlJuXA
        DIRFjaWd0clWru7cYXrPff6QmRv9
X-Google-Smtp-Source: APXvYqwn/WBB/hzGKanp+10p5bs6mE9YPi314bhT+wgpY0uHtHl9inmjfYZyNG1dLol7J+sZ06AyBg==
X-Received: by 2002:a7b:c7cc:: with SMTP id z12mr140509wmk.115.1575473546961;
        Wed, 04 Dec 2019 07:32:26 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n12sm7280468wmd.1.2019.12.04.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:32:25 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:32:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20191204153225.GM25242@dhcp22.suse.cz>
References: <20191126121901.GE20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911261632030.9857@www.lameter.com>
 <20191126165420.GL20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271535560.16935@www.lameter.com>
 <20191127162400.GT20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271625110.17727@www.lameter.com>
 <20191127174317.GD26807@dhcp22.suse.cz>
 <20191204132812.GF25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-12-19 15:25:43, Cristopher Lameter wrote:
> On Wed, 4 Dec 2019, Michal Hocko wrote:
> 
> > > > Just drop the events may be best. Then we know if someone is using it.
> > >
> > > I would be worried that a lack of events might be surprising and a
> > > potential userspace wouldn't know that something has changed.
> >
> > It would be great to land with some decision here.
> 
> Drop the events. These are internal kernel structures and supporting
> notifiers to userspace is a bit unusual.
 
As I've said I believe it is quite risky. But if you as a maintainer
believe this is the right thing to do I will not object. Care to send a
patch?

-- 
Michal Hocko
SUSE Labs
