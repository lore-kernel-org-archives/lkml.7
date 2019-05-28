Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8EC04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B0020883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559047117;
	bh=FwJ305qcCDT2qEfKhuJoOjhdYgfIw+CZ3Rkals6Walg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=db/uj4n5AA3zZmCcpqspqULzPa0xWXSW7orEkl4L5MasZ39BdAc/JPM/AAI3BtqiO
	 35AoZTD/cIbpA1dFw9Q/mNiTJ6NPtk1waQaO9yj/h4aieal6Mg1IWJlHW+0QvYv1Je
	 RIq7jxfay2ssXZvHmxL5ok3DFavQ+wzqvuI6gP7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfE1Mig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:38:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:37230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726933AbfE1Mif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:38:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D83D5AE86;
        Tue, 28 May 2019 12:38:33 +0000 (UTC)
Date:   Tue, 28 May 2019 14:38:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190528123832.GD1658@dhcp22.suse.cz>
References: <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com>
 <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com>
 <20190528104117.GW1658@dhcp22.suse.cz>
 <20190528111208.GA30365@google.com>
 <20190528112840.GY1658@dhcp22.suse.cz>
 <CAKOZuesCSrE0esqDDbo8x5u5rM-Uv_81jjBt1QRXFKNOUJu0aw@mail.gmail.com>
 <20190528115609.GA1658@dhcp22.suse.cz>
 <CAKOZuesnXGAsQgkB45n=jqwDRQ4_aoPiydmZxfxPmzO2p=cTow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesnXGAsQgkB45n=jqwDRQ4_aoPiydmZxfxPmzO2p=cTow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-05-19 05:18:48, Daniel Colascione wrote:
[...]
> The important requirement, I think, is that we need to support
> managing "memory-naive" uncooperative tasks (perhaps legacy ones
> written before cross-process memory management even became possible),
> and I think that the cooperative-vs-uncooperative distinction matters
> a lot more than the tgid of the thread doing the memory manipulation.
> (Although in our case, we really do need a separate tgid. :-))

Agreed here and that requires some sort of revalidation and failure on
"object has changed" in one form or another IMHO.
-- 
Michal Hocko
SUSE Labs
