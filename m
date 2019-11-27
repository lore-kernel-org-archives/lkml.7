Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E63C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7476F2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574876603;
	bh=7n/KZtpRiTjohP5m286k/mZdMpMe7XcqDJHWTGhntVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A1NaqSt4BxgEvexzbQaZ2FxUS0hB/J6Dx/bKe0VhSq1JYiuCkiUvkL7YPetjzjOUJ
	 2QgPzNd60GbvxNPkvO9q6jn4ww3igxmCEVYKkyID6c888JLXgByB5mGo3yNe60P6Ct
	 O5KF/PeTPu4wJex1Zo+qjceZvJ6dMkgfsNuKfxOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfK0RnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:43:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38986 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0RnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:43:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so1747621wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tSJWGvRdO6CDjk2KxjQwZuJhy9Tg5L6rOZn+ujJ/7s0=;
        b=l4ZR4/lOUOzCy29UwPOA06UEFV973rxG09u2lhxTDl+bw7hnEVYd5zBF4A9ZpVBs29
         wmSGq5HslF3i/f2mMQ7pKNO+vCx7sS9zs4tVHEtmiAZkziA4oPm6eeIi91WMk99gaJkb
         qHmxyn7bgl6BqkbCpWc+KQneW2ADRO/vtEA4UAiY8dZMqMakYckH5+EZVHlJ+eOPsus/
         O6Ier0v0xZP4xZnif4S2PmGbtE3ANoYmJQ5p/HG+xASIBRoQj2d6nxEJFXKkTuiJAhCb
         q9Z5+SfQhMBkoBTl8Sz7P983yYXiLc0vCT6ocNO44qhXCYiOomCN2fEmtPQJotSvUZ7c
         alAA==
X-Gm-Message-State: APjAAAUmMGMBzN6gPBfvcTc9SDqd9F7WRaO1WyIAeQ+LwX16RKfrqK/7
        tuW9s2jl8a4430PB7v+1tLLF1aS0
X-Google-Smtp-Source: APXvYqzv9kcJZil504sQkm/RB2JOZoRsmDokWfG9DlfgoAOwM/RjtikAFwIH+MsDscDTE8hWf/AQJA==
X-Received: by 2002:a1c:7d01:: with SMTP id y1mr5341026wmc.157.1574876600033;
        Wed, 27 Nov 2019 09:43:20 -0800 (PST)
Received: from localhost (ip-37-188-137-84.eurotel.cz. [37.188.137.84])
        by smtp.gmail.com with ESMTPSA id t12sm2235062wrs.96.2019.11.27.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:43:19 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:43:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20191127174317.GD26807@dhcp22.suse.cz>
References: <20191126121901.GE20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911261632030.9857@www.lameter.com>
 <20191126165420.GL20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271535560.16935@www.lameter.com>
 <20191127162400.GT20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271625110.17727@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911271625110.17727@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-11-19 16:26:11, Cristopher Lameter wrote:
> On Wed, 27 Nov 2019, Michal Hocko wrote:
> 
> > Would you mind a patch that would add a kernel command line parameter
> > that would work like memcg_sysfs_enabled? The default for the config
> > would be on. Or it would be preferrable to simply drop only events?
> 
> Just drop the events may be best. Then we know if someone is using it.

I would be worried that a lack of events might be surprising and a
potential userspace wouldn't know that something has changed.

-- 
Michal Hocko
SUSE Labs
