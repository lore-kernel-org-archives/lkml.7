Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795AB20673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578600821;
	bh=AuCTRfDnlHBut+DyER6skX1wZsrhBqSJE8yqE0BJids=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e5opg01I+S5qivNsHnEHjBoywA+7UEh6J9My5aI+mSOdWIcFtsWCcFRwfHdScYspk
	 cwTEhqR7m+nGLmADTX1tQCztP0gqUOfVnihTt0jvL6pWI/oHBw2rAw5M3pXLOs5xhX
	 Jj6/j8zStAxwyYraJLlWhKfD5Wu1oay5lIs3MTGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgAIUNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:13:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34040 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgAIUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:13:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so8840803wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bTCYhmwhUsF2jDWQOxPlGiD1ry+I9YZ+HPlDbTNi+w=;
        b=MMTmr+UPo8ROAfB13knC2y/ZfY5VHPxBLs5oA0cI2Z4nBwn8l9HBR+LCyA/QI5U4eQ
         BlTnGfN+RuG3EOIyDF8iPAc891xSvkBxcxlYvrQKeOTrnDke8Ii9gerPuD8sVEgMkdMQ
         KVlqGJzTtjT5tvMVdnyAHakvfgrXInEdOzuTfGCaDzCfKPyzbaESJmNaDXOqfdBPpZkJ
         N5ydgkf3kvHntPoJfWXnfXsARccTCtZtO9Gye9i+bwo4P50p11fTbvF8hsXPA11SwlGE
         chG3sl7J2fcGYBC60ol9AJ0xroaKRmrP2XXI03UO1hyMbexg+xEEdt5nRgXnRMAcrpwe
         J1qg==
X-Gm-Message-State: APjAAAUMuEirCSM/KKC00Md+pKFlYNCtCjkC0Q6mitWqTtqN5mAeNFqU
        KMwdxlbHnJa43etLtdrFZ2Jzu1Oa
X-Google-Smtp-Source: APXvYqxdYEb3O33FLr38TIL6vlIiDaBklOPc8zdsq0e/RR8mTCav5wDEsB880JQODAHjhPLy0eXsbA==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr11546015wrs.179.1578600818725;
        Thu, 09 Jan 2020 12:13:38 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id x11sm3999313wmg.46.2020.01.09.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 12:13:37 -0800 (PST)
Date:   Thu, 9 Jan 2020 21:13:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christopher Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20200109201336.GX4951@dhcp22.suse.cz>
References: <20191127174317.GD26807@dhcp22.suse.cz>
 <20191204132812.GF25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
 <20191204153225.GM25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
 <20191204173224.GN25242@dhcp22.suse.cz>
 <20200106115733.GH12699@dhcp22.suse.cz>
 <alpine.DEB.2.21.2001061550270.23163@www.lameter.com>
 <20200109145236.GS4951@dhcp22.suse.cz>
 <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-01-20 11:44:15, Andrew Morton wrote:
> On Thu, 9 Jan 2020 15:52:36 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Mon 06-01-20 15:51:26, Cristopher Lameter wrote:
> > > On Mon, 6 Jan 2020, Michal Hocko wrote:
> > > 
> > > > On Wed 04-12-19 18:32:24, Michal Hocko wrote:
> > > > > [Cc akpm - the email thread starts
> > > > > http://lkml.kernel.org/r/20191126121901.GE20912@dhcp22.suse.cz]
> > > >
> > > > ping.
> > > 
> > > There does not seem to be much of an interest in the patch?
> > 
> > It seems it has just fallen through cracks.
> 
> I looked at it - there wasn't really any compelling followup.

The primary motivation is the pointless udev event for each created
cache. There are not that many on the global case but memcg just adds
up.

-- 
Michal Hocko
SUSE Labs
