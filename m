Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F347AC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DF620673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578600912;
	bh=KiyfMYMXrhCPavLiv7IS4vQXlrZMabiyqWz03OECXzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C8KRUb+vfAFOhiHs71uGIeTDtrx6macCliAkg5cvE7WrrpmZN+OuHK7y1wRtBgh16
	 QpudRbSrScVAdecQtQyqHaelrAxIUobGy5x2KvqgZ2yCdtJdlw4VYVdrT1bSHEJwt/
	 +xptQmftXvqPV42czrZO28K0v7Fvw3rkDEWedNjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgAIUPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:15:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33615 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgAIUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:15:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so8859927wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uTckSan/5pI/VRS4OQ1RRQT5RKbU3mqiEyEpjYqvGTA=;
        b=mvFVrFU6zFVfRAnWKS3UMoeYdPYzNlgXOHek3lefxUnllBY2X3bNA/EkUIHepxiYgF
         BxqIvmCx3F9WT6/1gykb/LOLiaAdoXehVrNE5CckyKmD1Rs/DOFKtFtKuFCqFFvoAtba
         MPefvVy24Ky+1UFXUX/RkR9FN1gDKUCs7OxTChQmCpn1rTc+GG5OLt8ON7k1syGzg+Dc
         15/naiBwolmPGMCk7URfd1BqYFEugZLl7gD7xAE5S1Y28GY/2AbYx4Irj2S2kN7S7E+D
         7p6J73M3+QNNgx6WNddK3Y8rxLKuDg/h0CaLlCR17ul8u4fxJxvTch7+ZotScEDsQ/Vg
         1UxA==
X-Gm-Message-State: APjAAAUL6sGeNcJ/A4JJ7SBMPftFXQp9ZEEBelSR/xoLi7r9XOqiZ2kh
        KLO5sb5xEc57QuKj1rWzCFc=
X-Google-Smtp-Source: APXvYqy2pths4TxaoNxjx+VaT2MybVWDUQDC5PH5dz99TaFyRVASX81bpxgJ/jKKzwVfhbV2tI3qNQ==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr12734160wrs.247.1578600909869;
        Thu, 09 Jan 2020 12:15:09 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id e6sm9541041wru.44.2020.01.09.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 12:15:09 -0800 (PST)
Date:   Thu, 9 Jan 2020 21:15:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christopher Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20200109201508.GY4951@dhcp22.suse.cz>
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

Btw. I would appreciate if this was explicit because if there is no
reaction then it is not clear whether the patch has slipped through
cracks or it is not worth pursuing for whatever reason.

Thanks!
-- 
Michal Hocko
SUSE Labs
