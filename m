Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D93CC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DD62072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578581560;
	bh=HbvKUMdaUu3b/IJoDT+9OZ3fpqmPG2yHecbyeGE+rg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ATOeOCt5QKhKVqkKqfKh24aOc3UzUzugFfzYx+xYoCBdZxKTl6butbu9hEo1fK0BG
	 6lirHektybg6zeWNLL/FcYmtVjku/+/gxfSSNTd3GecLSWyWxefzGdkgXuQuE4PO5z
	 lUTNBnsoNloTaVydD62L6QNRz2cdBayJdpEbDD4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbgAIOwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:52:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34347 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgAIOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:52:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so7749737wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bq/UNz6VnMzWh6CqwcPfNQvr+yqEkMp/bGSrK8EZXos=;
        b=LW/5PtVMTKC8lXojjIVvtHgfS0C1XVIhYQ7F3l8Ld3gzutewZYsmZ8l9Wb2uv+fXDB
         5sxMMuLMBQFO37Pw4CWXqj+0fwaBQRYJo4u/w5up35BQGGDd9atGg7ps5PXvDt9wnmIb
         gTHUhNC5YN38ZpgSPBe7qc6xhc4oiN2QI8cLh8qz4hEdItEOcQMLY+hg/na5BQcQUblZ
         /Gdt013sfz6s/sBXFzYQmx2v1mlLNZGqW1gr7ifxz7FoXv8+aLeck1bdACACwfOWYnKS
         EichQ6s/Cv2lpw1KyN8C+gkT27rXbUaGHOUYn7kPyDoWA6ZeoZS/nFDL1sk6d8b726/W
         zKJg==
X-Gm-Message-State: APjAAAVGwzQHuewotNOC4VHudhmsDGejHAl+XAUiOvWctPgmOxdlun90
        dnnm3DdcAqVK0pI5a6ytmrs=
X-Google-Smtp-Source: APXvYqw2YPxpCJJ3XW4b5++NF5wmoEcgATcMckvUCdWoKPvEh2fmpMG2cvaSGtmLRqRRd2id3UzIog==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr11167161wrw.165.1578581558073;
        Thu, 09 Jan 2020 06:52:38 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z123sm3252357wme.18.2020.01.09.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:52:37 -0800 (PST)
Date:   Thu, 9 Jan 2020 15:52:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20200109145236.GS4951@dhcp22.suse.cz>
References: <20191127162400.GT20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271625110.17727@www.lameter.com>
 <20191127174317.GD26807@dhcp22.suse.cz>
 <20191204132812.GF25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
 <20191204153225.GM25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
 <20191204173224.GN25242@dhcp22.suse.cz>
 <20200106115733.GH12699@dhcp22.suse.cz>
 <alpine.DEB.2.21.2001061550270.23163@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001061550270.23163@www.lameter.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-01-20 15:51:26, Cristopher Lameter wrote:
> On Mon, 6 Jan 2020, Michal Hocko wrote:
> 
> > On Wed 04-12-19 18:32:24, Michal Hocko wrote:
> > > [Cc akpm - the email thread starts
> > > http://lkml.kernel.org/r/20191126121901.GE20912@dhcp22.suse.cz]
> >
> > ping.
> 
> There does not seem to be much of an interest in the patch?

It seems it has just fallen through cracks.

-- 
Michal Hocko
SUSE Labs
