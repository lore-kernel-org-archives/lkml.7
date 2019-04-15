Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CF4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED41120848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfDOLKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:10:55 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36640 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfDOLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:10:55 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hFzVf-0005lO-BH; Mon, 15 Apr 2019 13:10:47 +0200
Message-ID: <24e05607b902e811d1142e3bd345af021fd3d077.camel@sipsolutions.net>
Subject: Re: [PATCH v5.1-rc] iwlwifi: make locking in iwl_mvm_tx_mpdu()
 BH-safe
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Apr 2019 13:10:45 +0200
In-Reply-To: <nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-15 at 13:03 +0200, Jiri Kosina wrote:

(FWIW, would be good to cc linux-wireless, but no need for linux-kernel
I guess :-) )

> iwl_mvm_sta->lock can be taken from BH, and therefore BH must be disabled if
> taking it from other contexts.
> 
> This fixes the lockdep warning below.

I don't think this is the right fix.

The only problem is this path:

>      SOFTIRQ-ON-W at:
>                        _raw_spin_lock+0x35/0x50
>                        iwl_mvm_tx_mpdu+0xae/0x5f0 [iwlmvm]
>                        iwl_mvm_tx_skb+0x200/0x470 [iwlmvm]
>                        iwl_mvm_mac_itxq_xmit+0xd5/0x1f0 [iwlmvm]
>                        iwl_mvm_add_new_dqa_stream_wk+0x34c/0x910 [iwlmvm]
>                        process_one_work+0x1f0/0x5b0

which I believe we just made use local_bh_disable() since there are
other reasons as well for that, IIRC.

Yes, here's the fix:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=f5ae2f932e2f8f4f79796f44832ae8fca26f188a

It's on the way upstream.

Thanks for the patch/report though!

johannes

