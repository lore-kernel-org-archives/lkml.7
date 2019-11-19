Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB7C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750A5206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKSI4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:56:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:60994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfKSI4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:56:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63269AD22;
        Tue, 19 Nov 2019 08:56:40 +0000 (UTC)
Date:   Tue, 19 Nov 2019 09:56:39 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de, sj1557.seo@samsung.com
Subject: Re: [PATCH v2 02/13] exfat: add super block operations
Message-ID: <20191119085639.kr4esp72dix4lvok@beryllium.lan>
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
 <CGME20191119071403epcas1p3f3d69faad57984fa3d079cf18f0a46dc@epcas1p3.samsung.com>
 <20191119071107.1947-3-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119071107.1947-3-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 19, 2019 at 02:10:56AM -0500, Namjae Jeon wrote:
> +static void exfat_put_super(struct super_block *sb)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	mutex_lock(&sbi->s_lock);
> +	if (READ_ONCE(sbi->s_dirt)) {
> +		WRITE_ONCE(sbi->s_dirt, true);

No idea what the code does. But I was just skimming over and find the
above pattern somehow strange. Shouldn't this be something like

	if (!READ_ONCE(sbi->s_dirt)) {
		WRITE_ONCE(sbi->s_dirt, true);

?

Thanks,
Daniel
