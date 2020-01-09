Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0983BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A43206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578599057;
	bh=aWYo5RikeExdUKjeA0IF0IiexjTlOjGLfvmX7ixDTrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1rJXBa8HjrZAFHFgle37OZRWJnhzgzDeCj/wFdwDYwOe5Flg8U6kX0yRYwM/VVTd5
	 MKMwAwWH3AxJIt1gbQyfhVdMPEKp/3sCoFWXyjDfY9BAFBe6Fp99/IPYPTSL35qMXW
	 tvLksqG5hJW8MxYU92Ekl7vWNZkWuwGETM8bItzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgAIToQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbgAIToQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:44:16 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1155C206ED;
        Thu,  9 Jan 2020 19:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578599056;
        bh=aWYo5RikeExdUKjeA0IF0IiexjTlOjGLfvmX7ixDTrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hI9/5ZJ6jUlP4EKQPf1wxWSOPUyG5LAlREt7GtxoKdzNXnPf1UT8pgHco6b2fQpH8
         rJ5o/zai1Qlz483NNtHMgLbB+8eZ1oihjmcSEdUpcGCjNKlKMDZuxEBEnhfmF5MVNG
         vnlDW9U6KJy3/T3EmH1vKZVjpFZAod5e6u7TDEbk=
Date:   Thu, 9 Jan 2020 11:44:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christopher Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-Id: <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org>
In-Reply-To: <20200109145236.GS4951@dhcp22.suse.cz>
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
        <20200109145236.GS4951@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 15:52:36 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Mon 06-01-20 15:51:26, Cristopher Lameter wrote:
> > On Mon, 6 Jan 2020, Michal Hocko wrote:
> > 
> > > On Wed 04-12-19 18:32:24, Michal Hocko wrote:
> > > > [Cc akpm - the email thread starts
> > > > http://lkml.kernel.org/r/20191126121901.GE20912@dhcp22.suse.cz]
> > >
> > > ping.
> > 
> > There does not seem to be much of an interest in the patch?
> 
> It seems it has just fallen through cracks.

I looked at it - there wasn't really any compelling followup.

If this change should be pursued then can we please have a formal
resend?
