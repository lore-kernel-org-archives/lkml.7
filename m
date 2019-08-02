Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824F2C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536C52087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564756875;
	bh=27JDgjeBeYHkegBu/Pc8hn2E1ZlDtWcpwxV9VSZ+gWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o+AZRkqAioPE0IG7XJNPuPLRSkCuV+jPh2iDLLOCnBuJf9ePeXVlxUlNAsOdWIO67
	 v7JS7PacdP1zRQ5vB8Q7iWaZYNwiVPSXsqFQ+rFdSX5YnBl5yoCK/Djr83hhCLQ5mR
	 9g2CSNOkUFZ4ESSgjVaEL5ve6OseJmgp8oPsMeww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395001AbfHBOlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:41:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732186AbfHBOlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:41:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B63D5B60A;
        Fri,  2 Aug 2019 14:41:12 +0000 (UTC)
Date:   Fri, 2 Aug 2019 16:41:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Masoud Sharbiani <msharbiani@apple.com>
Cc:     gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190802144110.GL6461@dhcp22.suse.cz>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190802074047.GQ11627@dhcp22.suse.cz>
 <7E44073F-9390-414A-B636-B1AE916CC21E@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E44073F-9390-414A-B636-B1AE916CC21E@apple.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-08-19 07:18:17, Masoud Sharbiani wrote:
>  
> 
> > On Aug 2, 2019, at 12:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Thu 01-08-19 11:04:14, Masoud Sharbiani wrote:
> >> Hey folks,
> >> I’ve come across an issue that affects most of 4.19, 4.20 and 5.2 linux-stable kernels that has only been fixed in 5.3-rc1.
> >> It was introduced by
> >> 
> >> 29ef680 memcg, oom: move out_of_memory back to the charge path 
> > 
> > This commit shouldn't really change the OOM behavior for your particular
> > test case. It would have changed MAP_POPULATE behavior but your usage is
> > triggering the standard page fault path. The only difference with
> > 29ef680 is that the OOM killer is invoked during the charge path rather
> > than on the way out of the page fault.
> > 
> > Anyway, I tried to run your test case in a loop and leaker always ends
> > up being killed as expected with 5.2. See the below oom report. There
> > must be something else going on. How much swap do you have on your
> > system?
> 
> I do not have swap defined. 

OK, I have retested with swap disabled and again everything seems to be
working as expected. The oom happens earlier because I do not have to
wait for the swap to get full.

Which fs do you use to write the file that you mmap? Or could you try to
simplify your test even further? E.g. does everything work as expected
when doing anonymous mmap rather than file backed one?
-- 
Michal Hocko
SUSE Labs
