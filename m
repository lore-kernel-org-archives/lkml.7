Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11649C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2BA2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ECe6NvFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfGSIuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:50:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52717 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfGSIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:50:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so27999029wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x2r2aQ0QfHY0nbhB8cKUFwTSscENmMp03cfv/kAtz7Y=;
        b=ECe6NvFo9wxPW1KC/Bjj1V5Zw+hvSQIZC14D0c9t7qsZTaNWqBorE0RRdRjd9934XP
         0WQBGEVDEE/bb+iIeZ2ue4n0IfJnstlHhCNdo1wVK/mX3ewodcNOk+d5AWKtmPKyzoZY
         wDlVBnqCglJtKov9IN6I+jKadOGEV8OFsVvpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2r2aQ0QfHY0nbhB8cKUFwTSscENmMp03cfv/kAtz7Y=;
        b=kSl65j4jNQe6GHz9yyE0Re8L3/Er3G9BQWo9kDfimC0MSjk0T8cxJk+v9RXE9BpSlW
         AdUvDTh9DujAifHWO5VgpdOti7H4KkstjXS8rcwqyTcKF6YGAPTC2ySy0h+Zr368zRgu
         a8sOab+4NOhEO9YF+em/gBb7Hu0196i1o4q82SzVibZ5ik23bVnQ8xppRLYd6B4+DL/H
         R8uN3kDhRsi4doiLMzd0edeWlEBiOZF5DsBxoqrViMzhb5XWo2LyYNWRJcwYDXR5NNEY
         G4me4WDI3I4D72ZUms9bnvWsafFSakRmechO+V9zDwN6x0E1j3m7ifQtwIQTVDRytflF
         cvJA==
X-Gm-Message-State: APjAAAXCvx9/i62mAkVNNJ2dSsCA15xAX3+pckL3FOFTFYHit76wql1u
        gGa7PwjMVXwyaAXA1Pz4cncCaH2lxTqaVg==
X-Google-Smtp-Source: APXvYqw1JoWpLmH3YD/r76UHhkPwn+eK0Lt86eaNgA2NYQx2iNZXlwVsI/0LQEeSDJqlXMXeLFi1Mg==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr44941846wma.107.1563526203377;
        Fri, 19 Jul 2019 01:50:03 -0700 (PDT)
Received: from andrea (host234-214-static.12-87-b.business.telecomitalia.it. [87.12.214.234])
        by smtp.gmail.com with ESMTPSA id e3sm26110515wrs.37.2019.07.19.01.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 01:50:02 -0700 (PDT)
Date:   Fri, 19 Jul 2019 10:49:56 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, dbueso@suse.de,
        mingo@redhat.com, jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH 1/4] locking/rwsem: Add missing ACQUIRE to read_slowpath
 exit when queue is empty
Message-ID: <20190719084956.GA6750@andrea>
References: <20190718134954.496297975@infradead.org>
 <20190718135205.916241783@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718135205.916241783@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1032,6 +1032,8 @@ rwsem_down_read_slowpath(struct rw_semap
>  		 */
>  		if (adjustment && !(atomic_long_read(&sem->count) &
>  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> +			/* Provide lock ACQUIRE */
> +			smp_acquire__after_ctrl_dep();

Does this also make the lock RCtso?  Or maybe RCtso was already
guaranteed (and I'm failing to see why)?

Thanks,
  Andrea
