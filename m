Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A9AC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91CB20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568203461;
	bh=3i029Up80S1rUYLo2r+PGRL5TaLVXH0IdrEne1LB0cU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=t8B4pLghc11pOP6IBPaoDU+UevUSXJeitckpqw3cL4ZJPGpJWZwzOO8wmx4Db+7Ht
	 cXxsZ50du9VXlQUFqEMqt+yl0zPLAURu4dy+zSaeB6rnOqEebo98taoiUNSD4upXK1
	 Q8SCfYSaQYqlLVPR5e8Uox/8SOdB8RjAvVPzAQtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfIKMEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfIKMEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:04:20 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131C120872;
        Wed, 11 Sep 2019 12:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568203460;
        bh=3i029Up80S1rUYLo2r+PGRL5TaLVXH0IdrEne1LB0cU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=A0DpLyesE8rWipS1e3OmkXDc28PWZsljhwfX/jse8Mi2MXjHAh19nrCyfaYIW6gqL
         txyyUT2qy/JJr0IulNe2VXhWeBiY2TpPXlXJbn/H86z5JbBO/zRSmbDadiIfx9oO45
         OR3EzkFL6QtL68He0PsrVK7nX4gnLOgMZLUViW5M=
Date:   Wed, 11 Sep 2019 13:04:00 +0100 (WEST)
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
In-Reply-To: <nycvar.YFH.7.76.1909111238470.473@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1909111301510.473@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm>  <24e05607b902e811d1142e3bd345af021fd3d077.camel@sipsolutions.net>  <nycvar.YFH.7.76.1904151328270.9803@cbobk.fhfr.pm> <01d55c5cf513554d9cbdee0b14f9360a8df859c8.camel@sipsolutions.net>
 <nycvar.YFH.7.76.1909111238470.473@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019, Jiri Kosina wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] iwlwifi: make locking in iwl_mvm_tx_mpdu() BH-safe

Hm, scratch that, that might actually spuriously enable BHs if called from 
contexts that already did disabled BHs.

So what solution would you prefer here? Just stick another par of 
bh_disable() / bh_enable() somewhere to the wake_txs() -> 
iwl_mvm_mac_itxq_xmit() -> iwl_mvm_tx_skb() -> iwl_mvm_tx_mpdu() path?

Thanks,

-- 
Jiri Kosina
SUSE Labs

