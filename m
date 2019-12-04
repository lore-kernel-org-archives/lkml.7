Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCFDC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E3920803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575466098;
	bh=ABbuF9Ja1XTvgy9sKK5WrZynfbuZKtQHLjV0toF4fIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VuKOT0NUwYsORpWuYwbVJUXwBC2ImUmkF7vJPw4lWBPv+CaZjj9MwDMjPPW3tJJyM
	 wbVkCOvYC+SUue8H0jQaQjPkjrr5ZvF5mp101aHOT5qSDsAD1Wmb8zypAycje9/o7k
	 vbCvXITtFmt7v8dyfyoTTOSzvms0OmezfJMugpXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfLDN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:28:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfLDN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:28:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so2173099wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+umYpmj3RQMgtbzhJoN9gGSxfzKMbRv2glQbXHfZy4o=;
        b=QsLiCxnFnJwvaDEX+CeDvWnolklsqh9sztKp3uWya1PI5ON5Ums8XyYTq4S9kR30A8
         HbdZHL7+6GRKj/JJkdnIIt1YUyjwvj/mrJVgZo8ayajgyPAtjqWoVQT/WLHNKnW66DpV
         +z4XSuCZiF6Jr0xvCs+KcFrxWAqk9EY5u1IGWoq7xMqXlpFjIoFKXMKWVr22C0THKR3U
         Y34oTWLvkZmQDoozHdnU5Sgf+5YapF61D88RXqzV9PtzIhEnM2ErnnAcRguBHlm1pXbt
         Ddv5tepOUFoKb15NbPzlDvp0v0kyXhR8tRSxnFL1Oc1HCXDB1R0ShvkVlQwvaOj7jBF6
         2DBg==
X-Gm-Message-State: APjAAAXRAfQQ9uk+crH8ORYih4aKPEG2/dx0pBFzzoVDJMcsUD2ZFSZN
        8wSkwrCh81Iw/LOoW3IOpS9eQ2YnO08=
X-Google-Smtp-Source: APXvYqwBQ4xYTm6PxE2YxFS/RKJtRVFg1psBTqCj/aLhBIfASHzQOS5JBH1XqkdNtWXLUIAQQDvigg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr4119206wrt.367.1575466094463;
        Wed, 04 Dec 2019 05:28:14 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c1sm6273706wmk.22.2019.12.04.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 05:28:12 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:28:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20191204132812.GF25242@dhcp22.suse.cz>
References: <20191126121901.GE20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911261632030.9857@www.lameter.com>
 <20191126165420.GL20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271535560.16935@www.lameter.com>
 <20191127162400.GT20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271625110.17727@www.lameter.com>
 <20191127174317.GD26807@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127174317.GD26807@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-11-19 18:43:17, Michal Hocko wrote:
> On Wed 27-11-19 16:26:11, Cristopher Lameter wrote:
> > On Wed, 27 Nov 2019, Michal Hocko wrote:
> > 
> > > Would you mind a patch that would add a kernel command line parameter
> > > that would work like memcg_sysfs_enabled? The default for the config
> > > would be on. Or it would be preferrable to simply drop only events?
> > 
> > Just drop the events may be best. Then we know if someone is using it.
> 
> I would be worried that a lack of events might be surprising and a
> potential userspace wouldn't know that something has changed.

It would be great to land with some decision here.
-- 
Michal Hocko
SUSE Labs
