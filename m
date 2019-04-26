Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E35C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3973E206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556256324;
	bh=h61k5wbWpjNpjdsHA3O4SHcLHPqyl+O9C21Y+jEaKe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RQATR4BKGExwCwWkd4GwVMmwyvL2xjxfMFTN6qZLGriut5r3+b3jgtJFJqN9kvqih
	 N3YyMoeDFPGgh3l3grUwHi6cllRiXVWxqlXijXt6i26icUi4LhJAs+IqG2e7RcftZm
	 CRlXoIzqkcJN7kf5C+lv4GLa5zSDGWluJKg3pLac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfDZFZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:25:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:42092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDZFZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:25:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC3ACAD2B;
        Fri, 26 Apr 2019 05:25:21 +0000 (UTC)
Date:   Fri, 26 Apr 2019 07:25:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
Message-ID: <20190426052520.GB12337@dhcp22.suse.cz>
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com>
 <20190425121410.GC1144@dhcp22.suse.cz>
 <20190425123755.GX12751@dhcp22.suse.cz>
 <CACdnJuutwmBn_ASY1N1+ZK8g4MbpjTnUYbarR+CPhC5BAy0oZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuutwmBn_ASY1N1+ZK8g4MbpjTnUYbarR+CPhC5BAy0oZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 13:39:01, Matthew Garrett wrote:
> On Thu, Apr 25, 2019 at 5:37 AM Michal Hocko <mhocko@kernel.org> wrote:
> > Besides that you inherently assume that the user would do mlock because
> > you do not try to wipe the swap content. Is this intentional?
> 
> Yes, given MADV_DONTDUMP doesn't imply mlock I thought it'd be more
> consistent to keep those independent.

Do we want to fail madvise call on VMAs that are not mlocked then? What
if the munlock happens later after the madvise is called?

-- 
Michal Hocko
SUSE Labs
