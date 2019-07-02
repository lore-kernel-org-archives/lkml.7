Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A11C46481
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FC2218A5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGBOZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:25:38 -0400
Received: from verein.lst.de ([213.95.11.211]:42993 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfGBOZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:25:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A94C568BFE; Tue,  2 Jul 2019 16:25:33 +0200 (CEST)
Date:   Tue, 2 Jul 2019 16:25:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Hannes Reinecke <hare@suse.de>, kbusch <kbusch@kernel.org>,
        axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
Subject: Re: [PATCH] nvme: fix multipath crash when ANA deactivated
Message-ID: <20190702142533.GA16763@lst.de>
References: <708068303.29979589.1561975811341.JavaMail.zimbra@kalray.eu> <6416b503-aa20-0094-6acf-101c60e9e3c9@suse.de> <1229162251.30096937.1562061155630.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1229162251.30096937.1562061155630.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:52:35AM +0200, Marta Rybczynska wrote:
> > They idea was to use a 'ana_log_buf == NULL' as an indicator that ANA is
> > disabled, so there is no need to have an additional flag.
> 
> OK, still keeping the split of the helper functions?

I think we can simplify switch nvme_ctrl_use_ana to only check for
->ana_log_buf, and just opencode the actual capabilities check in
the setup path.
