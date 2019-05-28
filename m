Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5904EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3076F208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559071355;
	bh=NNBPdal1/mPJSYY/vCIJCUtKr1A1D9YM+1nS3i59aSE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q6/xhuD2MaG/IqxwIPdSCTveKcqFd/NgrV5qd6b88wF4zcsx4SItIDTVj/A0FZHia
	 lE+Qi5YldFnlsygpQNOO8TDiG3p9gbh8+cphMpFGKXmAupGmaNvR1X5hesZ+NELU/R
	 PAX/PKbYojnBX4PHeKBbtFMD8PbcPKcZSBYq1Who=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfE1TWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfE1TWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:22:20 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486F420717;
        Tue, 28 May 2019 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559071339;
        bh=NNBPdal1/mPJSYY/vCIJCUtKr1A1D9YM+1nS3i59aSE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=e1nbRXCK4zkM43bwpA5IrqL1jWKct4Vq1WA8Ly1whHC4PevDXtD8UwtxpDcbwlBcX
         u/Iy2IByYwwRF19Qp4GyUTYlrxIALyEi6wSSyzRpxuAIegbR20IpBovAr6moj9KZWm
         p33c+UH3muKLCd+niSSyVHKnZqH4ONYuiwzaoRzE=
Date:   Tue, 28 May 2019 21:22:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: "nosmt" breaks resuming from hibernation (was Re: [5.2-rc1
 regression]: nvme vs. hibernation)
In-Reply-To: <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905282118070.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm> <20190524154429.GE15192@localhost.localdomain> <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm> <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com> <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019, Jiri Kosina wrote:

> [ some x86/PM folks added ]
> 
> I isolated this to 'nosmt' being present in the "outer" (resuming) kernel, 
> and am still not sure whether this is x86 issue or nvme/PCI/blk-mq issue.
> 
> For the newcomers to this thread: on my thinkpad x270, 'nosmt' reliably 
> breaks resume from hibernation; after the image is read out from disk and 
> attempt is made to jump to the old kernel, machine reboots.

Thomas figured it out (and this should be really more widespread than just 
my machine :) ).

nosmt forces HT siblings to mwait, but that explodes after %cr3 change 
during resume, as the mwait target address is all of a sudden not valid 
anymore for neither of the hyperthreads.

That also explains why I apparently didn't see it that regularly with 
kaslr disabled.

Nothing to do with nvme, so let's not continue coming up with proper fix 
in this thread.

Thanks,

-- 
Jiri Kosina
SUSE Labs

