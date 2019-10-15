Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2058C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8234A20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfJOMbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:31:00 -0400
Received: from 8bytes.org ([81.169.241.247]:47552 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbfJOMbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:31:00 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 27D5E2DF; Tue, 15 Oct 2019 14:30:58 +0200 (CEST)
Date:   Tue, 15 Oct 2019 14:30:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        ming-fan.chen@mediatek.com
Subject: Re: [PATCH] memory: mtk-smi: Add PM suspend and resume ops
Message-ID: <20191015123053.GA17570@8bytes.org>
References: <1570622373-16413-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570622373-16413-1-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 07:59:33PM +0800, Yong Wu wrote:
> In the commit 4f0a1a1ae351 ("memory: mtk-smi: Invoke pm runtime_callback
> to enable clocks"), we use pm_runtime callback to enable/disable the smi
> larb clocks. It will cause the larb's clock may not be disabled when
> suspend. That is because device_prepare will call pm_runtime_get_noresume
> which will keep the larb's PM runtime status still is active when suspend,
> then it won't enter our pm_runtime suspend callback to disable the
> corresponding clocks.
> 
> This patch adds suspend pm_ops to force disable the clocks, Use "LATE" to
> make sure it disable the larb's clocks after the multimedia devices.
> 
> Fixes: 4f0a1a1ae351 ("memory: mtk-smi: Invoke pm runtime_callback to enable clocks")
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> base on v5.4-rc1.
> ---
>  drivers/memory/mtk-smi.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

