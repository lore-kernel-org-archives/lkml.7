Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA81C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3701121726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558940660;
	bh=BNsn1O1Jjx/fgP8OEF7ejUZfkpZpn6+6gvSCOKwpwUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zjGBRmTLQ4XLBnme/QgOb9r2R60SJL05JKOX3f+m87hwyjX1PNkyHH3P7mV3L5YAX
	 DWBkJNu1isnGNf84tG5+JY7cBcKit5HqZHDuFolyyg0aaBorn5Tq9wL2B55q21Gow5
	 Domc/5j8DXWu0sydyGQkqqH9Gw6v6ahasv4VzjDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfE0HET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:04:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfE0HET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EFD7AD9C;
        Mon, 27 May 2019 07:04:17 +0000 (UTC)
Date:   Mon, 27 May 2019 09:04:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jordan, Tobias" <Tobias.Jordan@elektrobit.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm: mlockall error for flag MCL_ONFAULT
Message-ID: <20190527070415.GA1658@dhcp22.suse.cz>
References: <20190522112329.GA25483@er01809n.ebgroup.elektrobit.com>
 <20190524214304.enntpu4tvzpyxzfe@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524214304.enntpu4tvzpyxzfe@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-05-19 17:43:04, Daniel Jordan wrote:
> [ Adding linux-api and some of the people who were involved in the
> MCL_ONFAULT/mlock2/etc discussions.  Author of the Fixes patch appears to
> have moved on. ]
> 
> On Wed, May 22, 2019 at 11:23:37AM +0000, Potyra, Stefan wrote:
> > If mlockall() is called with only MCL_ONFAULT as flag,
> > it removes any previously applied lockings and does
> > nothing else.
> 
> The change looks reasonable.  Hard to imagine any application relies on it, and
> they really shouldn't be if they are.  Debian codesearch turned up only a few
> cases where stress-ng was doing this for unknown reasons[1] and this change
> isn't gonna break those.  In this case I think changing the syscall's behavior
> is justified.  
> 
> > This behavior is counter-intuitive and doesn't match the
> > Linux man page.
> 
> I'd quote it for the changelog:
> 
>   For mlockall():
> 
>   EINVAL Unknown  flags were specified or MCL_ONFAULT was specified with‐
>          out either MCL_FUTURE or MCL_CURRENT.
> 
> With that you can add
> 
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> [1] https://sources.debian.org/src/stress-ng/0.09.50-1/stress-mlock.c/?hl=203#L203

Well spotted and the fix looks reasonable as well. Quoting the man page
seems useful as well.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
