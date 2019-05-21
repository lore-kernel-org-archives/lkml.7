Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105BCC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48F521773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558421403;
	bh=EukdVb7ua8yXTr4sHy+0d/eK8g+RFTAGvo7SKqQ24qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FmTihcaumvfY8EigQql0r+1Gy4Q/Vb7xesmtSH+1/RNSuz5fsvltFALHyhd2RtKJe
	 R6/M0/jP62GlvV1vnqmm2sfD2/mp++dfNrRNvw3xGwcJIWXk4hNrUMzzDdLugIYqq0
	 rpRm3F6va92nq1EXLbkNXbE/0GGzgp9BikVZ1CbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEUGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:50:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfEUGuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:50:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C37FAF70;
        Tue, 21 May 2019 06:50:01 +0000 (UTC)
Date:   Tue, 21 May 2019 08:50:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 4/7] mm: factor out madvise's core functionality
Message-ID: <20190521065000.GH32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
 <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 08:36:28, Oleksandr Natalenko wrote:
[...]
> Regarding restricting the hints, I'm definitely interested in having
> remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
> madvise() introduces another issue with traversing remote VMAs reliably.
> IIUC, one can do this via userspace by parsing [s]maps file only, which
> is not very consistent, and once some range is parsed, and then it is
> immediately gone, a wrong hint will be sent.
> 
> Isn't this a problem we should worry about?

See http://lkml.kernel.org/r/20190520091829.GY6836@dhcp22.suse.cz

-- 
Michal Hocko
SUSE Labs
