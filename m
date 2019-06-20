Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACFC48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87652082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561028120;
	bh=ARd8o7DsVO6LyiT+h3owUTvWRaLdT1ZGMsrV1pSgkEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fkz8tWy0rBDCu0BWg8qZanXCwwJGMxwGnLRojcXPLDu9I77v4BE1+B9UWP/1mmsY2
	 bRMVVRed8lBv5+qOO5etmn1ej/G4tSppk9Xq3e6Z/UavpFdFjtfd/PrYnY5hQpPbQf
	 jgMtbuRVUGaXmA+fpoFiJLSDJ+qDlJoj8ZtqlUwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFTKzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:55:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfFTKzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:55:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03F8AAD12;
        Thu, 20 Jun 2019 10:55:16 +0000 (UTC)
Date:   Thu, 20 Jun 2019 12:55:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190620105515.GE12083@dhcp22.suse.cz>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-5-minchan@kernel.org>
 <20190619132450.GQ2968@dhcp22.suse.cz>
 <20190620041620.GB105727@google.com>
 <20190620070444.GB12083@dhcp22.suse.cz>
 <20190620084040.GD105727@google.com>
 <20190620092209.GD12083@dhcp22.suse.cz>
 <20190620103215.GF105727@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620103215.GF105727@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-06-19 19:32:15, Minchan Kim wrote:
[...]
> Then, okay, I will add can_do_mincore similar check for the MADV_PAGEOUT syscall
> if others have different ideas.

Great that we are on the same page. We can simply skip over those pages.
-- 
Michal Hocko
SUSE Labs
