Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE83C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C3F2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kY0hE6X5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfFRGmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:42:38 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16189 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfFRGm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:42:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d08858e0000>; Mon, 17 Jun 2019 23:32:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 23:32:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 23:32:45 -0700
Received: from [10.26.11.141] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 06:32:42 +0000
Subject: Re: [PATCH V1] i2c: tegra: disable irq in tegra_i2c_xfer_msg
To:     Bitan Biswas <bbiswas@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        <linux-i2c@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     Shardar Mohammed <smohammed@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>
References: <1560835386-2865-1-git-send-email-bbiswas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <30d1d048-f474-f1fb-6415-ee6389900032@nvidia.com>
Date:   Tue, 18 Jun 2019 07:32:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560835386-2865-1-git-send-email-bbiswas@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560839566; bh=36AfYXlVRsIoRYgUu6dWpzivHUbZQ39MsVKao4WnHfE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kY0hE6X5Z5s5Kt/F5TcMUn842rvnQIIrOM8tb1SCa2FxEQYtNnoJBGWfFzCSSJvzH
         EubDQzNfMSuSGsgWi/37RYYEw/cUNWGCLIyaVFd7IYd3Kd/U9JG4vwGxV9rvMzP+f2
         KhVt/Dkph9ZaaL3xEVZrPuEpEiQBw687VetjNgzIrwKp89qIRBWSbh9st2o/4ixpsJ
         VW8gNsiOX8aSQal9sL69b7+kw1BpXiSb3fsXbokFtwEozpMK049eo1z6trKatajUtl
         +detDi5RcfTMtBYxEXi08tlEZ2kXNeGRlDugGL7sp9GR7yEpAO9BthfyHfaZ9e17nk
         3pW2Im5oNYYpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/2019 06:23, Bitan Biswas wrote:
> Synchronize ISR and tegra_i2c_xfer_msg execution
> by disabling interrupt. This avoids spinlock usage
> for same purpose.

I think that you need to explain the motivation/benefit of this. It is
not immediately clear to me. Sorry if I have missed some previous
discussion.

Jon

-- 
nvpublic
