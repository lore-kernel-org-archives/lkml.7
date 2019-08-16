Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602D5C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343772077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565985843;
	bh=1lnmZoylRn/3evSXk3p+Am2em5Hl2BPcjyIWGe0p/Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rEJR3D2U6I4BG2Zgg5kRjLy0r/Kf211q9IWL5I1cMqonEGD0bGKUJVhXjGaJTqNmb
	 tDo7IChtet1J7yoPaUpkKHNO6fYsjCEG6l9jDQ2GtSvFPG711LD1XwI7V22BPKXlGU
	 /PQoXePTPa/5bI3tcnT4OcCsQaDW9HnKqYyGWbUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfHPUEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:04:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:40895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfHPUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:04:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 13:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="179767694"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2019 13:03:35 -0700
Date:   Fri, 16 Aug 2019 14:01:26 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>
Cc:     "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ryan.Hong@Dell.com" <Ryan.Hong@Dell.com>,
        "Crag.Wang@dell.com" <Crag.Wang@dell.com>,
        "sjg@google.com" <sjg@google.com>,
        "Charles.Hyde@dellteam.com" <Charles.Hyde@dellteam.com>,
        "Jared.Dominguez@dell.com" <Jared.Dominguez@dell.com>
Subject: Re: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Message-ID: <20190816200125.GB6883@localhost.localdomain>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
 <20190814201900.GA3511@localhost.localdomain>
 <0cafca37-011d-4c19-4462-14687046a153@grimberg.me>
 <d71fc97ef6c8428f96ecfb2cec6077ab@AUSX13MPC101.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d71fc97ef6c8428f96ecfb2cec6077ab@AUSX13MPC101.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:43:02PM -0700, Mario.Limonciello@dell.com wrote:
> > We need to coordinate with Jens, don't think its a good idea if I'll
> > just randomly get stuff from linus' tree and send an rc pull request.
> 
> The dependent commit is in Linus' tree now.
> 4eaefe8c621c6195c91044396ed8060c179f7aae
> 
> Also it was reported to me after this was submitted that the comment
> whitespace should have been aligned during the switchover from v1 to v2.
> 
> V1 the whitespace was further left since it was applying to 3 drives, but now
> that they're combined in v2 the whitespace wasn't adjusted.
> 
> Let me know if you want me to resubmit v3 w/ whitespace modification or
> if you will want to adjust that locally when you pull it in.

Go ahead and resend the patch with your fixes included. This is going to
have to wait till next week anyway in order to have a clean pull request
through our normal path to mainline.
