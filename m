Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1717DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18842054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566315019;
	bh=ylcKMJ6x2QXBWKuPJcuKgIYZgkhwp2Vs1rA2emBsrBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jkif4IISi0ciJm2pzBR9Z37bqZkpf9NWBt+GWEcK3PURdd+PfUa5Ajt13jS1jnO/v
	 M9R0r1IoHUBwmfHl3msGRwLmx2xWyU1J+aOv1AZgp06qYazR3IBk19MFJJc2OUyzgy
	 OFmxw7HKB9DMHUj79I/VfbwZzGh5gGhzsa5K/VsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfHTPaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbfHTPaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:30:17 -0400
Received: from localhost (mobile-107-77-164-38.mobile.att.net [107.77.164.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C492054F;
        Tue, 20 Aug 2019 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566315016;
        bh=ylcKMJ6x2QXBWKuPJcuKgIYZgkhwp2Vs1rA2emBsrBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HyA0Tlb2abztO/53cjB7DUMi+aWWeBxM9PlI9TeMRVs9klPRYesSvG9rWu8eEelmd
         BeHx5/FWAq/74KAOy0gFSfii+jLy5p8YS+z4Np9QFfc5PtuIkubvdRbM+cAdnZGeX1
         APMjIqzM8q/pCDJXaUZ3HLE9esJq5FHzMIhQp8xE=
Date:   Tue, 20 Aug 2019 11:30:15 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Tools: hv: kvp: eliminate 'may be used uninitialized'
 warning
Message-ID: <20190820153015.GN30205@sasha-vm>
References: <20190819144409.13349-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190819144409.13349-1-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:44:09PM +0200, Vitaly Kuznetsov wrote:
>When building hv_kvp_daemon GCC-8.3 complains:
>
>hv_kvp_daemon.c: In function ‘kvp_get_ip_info.constprop’:
>hv_kvp_daemon.c:812:30: warning: ‘ip_buffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  struct hv_kvp_ipaddr_value *ip_buffer;
>
>this seems to be a false positive: we only use ip_buffer when
>op == KVP_OP_GET_IP_INFO and it is only unset when op == KVP_OP_ENUMERATE.
>
>Silence the warning by initializing ip_buffer to NULL.
>
>Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Queued up for hyperv-fixes, thank you.

--
Thanks,
Sasha
