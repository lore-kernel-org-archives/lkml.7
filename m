Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFDFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C7820833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555329967;
	bh=6cutzcw5H5wZoQJyOZqZhMyiVlv4eKy00bSFYS0OEcw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=nf33OQsVdVwzRdY6RweadjxpQEoF5FrrH9BIDx19UE+WHU1fis+yYMHJvths7wiIv
	 8xjfiVkUWzPTjIiax2M1zS+AMwKC/bccObs32+lE3895lt3JQTyvQdD+Z4DFLLTbzJ
	 IB1qKpEH6EDXrY1jqXISC+vJlbqIEThc8bKAUdOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfDOMGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOMGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:06:06 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1833520833;
        Mon, 15 Apr 2019 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555329965;
        bh=6cutzcw5H5wZoQJyOZqZhMyiVlv4eKy00bSFYS0OEcw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ul3xyqOmXYOVelEa6QXE2tT28lQnlVi0Z2hF1BKW+oDIXFEhSpIE134JxadjSXXua
         hZh3qZc/4DQ3nYgjKL38lNazc6kDmqxV/XpaeE3vAhnUviJItKKYTznd96evGBKQIU
         2B0HXqiPK4rnKIQ+PqpcIHfk7OrBHgBHJoKJNq+Y=
Date:   Mon, 15 Apr 2019 14:06:01 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5.1-rc] iwlwifi: make locking in iwl_mvm_tx_mpdu()
 BH-safe
In-Reply-To: <01d55c5cf513554d9cbdee0b14f9360a8df859c8.camel@sipsolutions.net>
Message-ID: <nycvar.YFH.7.76.1904151404430.9803@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm>  <24e05607b902e811d1142e3bd345af021fd3d077.camel@sipsolutions.net>  <nycvar.YFH.7.76.1904151328270.9803@cbobk.fhfr.pm> <01d55c5cf513554d9cbdee0b14f9360a8df859c8.camel@sipsolutions.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Johannes Berg wrote:

> > If there are other reasons why disable BH for the whole function (are 
> > there?), then this bigger hammer works as well of course.
> 
> I thought there are, but seeing the commit log here I'm not sure.
> 
> In any case, even if not, the function itself is part of the TX fast
> path, but the caller from the workqueue is very uncommon (basically only
> happens for a handful of packets on each new RA/TID), so I'd say that'd
> be a good reason to use the slightly bigger hammer (it's not that much
> different really, if you look at how much code is covered by the lock)
> and avoid doing it all the time when we know it to be not needed.

Given that we don't have a primitive in lockdep to assert this invariant, 
would you consider queuing the below on top of f5ae2f932e2f in 
wireless-drivers.git?

Thanks.




From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] iwlwifi: iwl_mvm_tx_mpdu() must be called with BH disabled

As iwl_mvm_tx_mpdu() is not disabling BH while obtaining iwl_mvm_sta->lock 
(which is being taken from BH context as well), it has to be always 
invoked with BH disabled. Make that clear in a comment.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 0c2aabc842f9..ad4760307726 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1063,7 +1063,9 @@ static int iwl_mvm_tx_pkt_queued(struct iwl_mvm *mvm,
 }
 
 /*
- * Sets the fields in the Tx cmd that are crypto related
+ * Sets the fields in the Tx cmd that are crypto related.
+ *
+ * This function must be called with BHs disabled.
  */
 static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 			   struct ieee80211_tx_info *info,

-- 
Jiri Kosina
SUSE Labs

