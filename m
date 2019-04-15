Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81AAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A420220645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfDOLhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:37:38 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37126 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDOLhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:37:38 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hFzvX-0006c8-Ef; Mon, 15 Apr 2019 13:37:31 +0200
Message-ID: <01d55c5cf513554d9cbdee0b14f9360a8df859c8.camel@sipsolutions.net>
Subject: Re: [PATCH v5.1-rc] iwlwifi: make locking in iwl_mvm_tx_mpdu()
 BH-safe
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Apr 2019 13:37:30 +0200
In-Reply-To: <nycvar.YFH.7.76.1904151328270.9803@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm>
         <24e05607b902e811d1142e3bd345af021fd3d077.camel@sipsolutions.net>
         <nycvar.YFH.7.76.1904151328270.9803@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-15 at 13:33 +0200, Jiri Kosina wrote:

> > Yes, here's the fix:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=f5ae2f932e2f8f4f79796f44832ae8fca26f188a
> > 
> > It's on the way upstream.
> 
> If there are other reasons why disable BH for the whole function (are 
> there?), then this bigger hammer works as well of course.

I thought there are, but seeing the commit log here I'm not sure.

In any case, even if not, the function itself is part of the TX fast
path, but the caller from the workqueue is very uncommon (basically only
happens for a handful of packets on each new RA/TID), so I'd say that'd
be a good reason to use the slightly bigger hammer (it's not that much
different really, if you look at how much code is covered by the lock)
and avoid doing it all the time when we know it to be not needed.

> 	Tested-by: Jiri Kosina <jkosina@suse.cz>

Too late now to add this to the git tree, but thanks for checking! :-)

johannes

