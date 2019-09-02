Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA92C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D80D22D6D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567455448;
	bh=IbT7vUIYsqxU2Jcyo958ZQAhcKohxrkReb0+kES6rOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l2edwiGawQrMS3H245tEQ81esAb+J5Brn0fhMrDj3KumbB/xYTw82XyYexGeVklaX
	 Rym18I/YNratGCSi/YKRu+kfmJSl6aPZqDtn4S65aVhIcekX3h08CQyw7lPjLJBa+L
	 C9o8OaD3KTx1YS2cGyHm/RRa4JM8mN7wokrFzAPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfIBUR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 16:17:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfIBUR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vyrAwk633Q2uTNUkmkIFpLBBAXkNdWuZxdwn7dVGxrY=; b=hVIFb8G2bhmnQDj/v+uSR2npO
        ojrsH0Y6h3ctrWe/irN5y65I1oa10334XO2C7SVcrctOZKqjhSnWQFT+et9ljyfayJLRYWsy9oRp/
        QXqXw8f2RbsZHoGYMJRGiYi4AI4KNIcX/dqoHF3gk6+XmIgb7C1yvlKkU25SPjYBOf9L9Lfek/I5k
        5NVZWnRuY0j57y2d3NXxu39tO0fHHzvFNor1OkjRBNrAztkRxnuezsEKjew+gcQumi5QhH2cuNC5p
        G4lNzWSgAshmFI2hnwyV5EvTDn1LAy3LOXELiO14Ov2sUEmCG6NfZY9/glQz75uhGyFztLQmw/rnG
        Y2fn5dKxg==;
Received: from [177.159.247.242] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4slN-00021w-D9; Mon, 02 Sep 2019 20:17:21 +0000
Date:   Mon, 2 Sep 2019 17:17:16 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] EDAC: Small cleanups and fixes
Message-ID: <20190902171716.50c226d6@coco.lan>
In-Reply-To: <20190902123216.9809-1-rrichter@marvell.com>
References: <20190902123216.9809-1-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Sep 2019 12:33:38 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> A bunch of cleanups and fixes for issues found while working with the
> code. Changes are individual and independent from each other. They can
> be applied separately (only #4 depends on #3).
> 
> Also updating the reviewer's entry as I will be able to do some
> reviews for edac code.
> 
> Note that patch #3 is an updated version of a patch reviewed before:
> 
>  https://lore.kernel.org/patchwork/patch/1093466/
> 
> Some references to ml discussions that are related to this series:
> 
>  https://lore.kernel.org/patchwork/patch/1093480/#1312590
>  https://lore.kernel.org/patchwork/patch/1093466/#1310572
> 
> Robert Richter (5):
>   EDAC: Prefer 'unsigned int' to bare use of 'unsigned'
>   EDAC, mc_sysfs: Change dev_ch_attribute->channel to unsigned int
>   EDAC, mc_sysfs: Remove pointless gotos
>   EDAC, mc_sysfs: Make debug messages consistent
>   MAINTAINERS: update EDAC's reviewer entry

For the entire series:

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> 
>  MAINTAINERS                  |  1 +
>  drivers/edac/edac_mc.c       | 20 ++++----
>  drivers/edac/edac_mc.h       |  6 +--
>  drivers/edac/edac_mc_sysfs.c | 91 ++++++++++++++++--------------------
>  drivers/edac/ghes_edac.c     |  2 +-
>  drivers/edac/i5100_edac.c    | 16 ++++---
>  include/linux/edac.h         | 10 ++--
>  7 files changed, 69 insertions(+), 77 deletions(-)
> 



Thanks,
Mauro
