Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295E0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCF522BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564181660;
	bh=0I8ibO4ILGJpL8erC1yuBP5LAOpyh2rkqKPnbsCnLuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=edxOjbY6HNcAiWF3+wVL3y6lxzBA4xBPfMjVy4UK4yUc8Z77fsRkNZ9n6EtfZp2y/
	 4bBch3sNPoepaPlmT1jgSMlhDCeCFSgcRqTFcTaPO3FpsZqgCZVDIbLnupW4eniWVS
	 7RyMWbhp1JVTOTwFUwXz+XL7rYaPk7gxrmYRBA24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfGZWyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfGZWyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:54:18 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66CEC218B0;
        Fri, 26 Jul 2019 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564181657;
        bh=0I8ibO4ILGJpL8erC1yuBP5LAOpyh2rkqKPnbsCnLuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pK1MW8MvICaSKOlCQqHnQ9l6nuLWH6z5U/EVYmUGTyLWaJMRR5LGPnmkHYCxsAgVO
         blFDeY2cL9fAqNHU9VjvQ4Kfda8QxzbtCF2lQT8kJ+rUUblKp5A13I2P6xwKeiY4qq
         zxEv6sAEkwCslSXWueRrCDWR7IN/4kpH6j9BxHnE=
Date:   Fri, 26 Jul 2019 15:54:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jack@suse.cz, arnd@arndb.de, linux.bhar@gmail.com,
        hariprasad.kelam@gmail.com, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: reiserfs: Fix possible null-pointer dereferences in
 remove_from_transaction()
Message-Id: <20190726155416.86f1b96302273b91129e6dc3@linux-foundation.org>
In-Reply-To: <20190726083838.8301-1-baijiaju1990@gmail.com>
References: <20190726083838.8301-1-baijiaju1990@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 16:38:38 +0800 Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> In remove_from_transaction(), there is an if statement on line 3447 to
> check whether bh is NULL:
>     if (bh)

We already know that bh != NULL here.

	cn = get_journal_hash_dev(sb, journal->j_hash_table, blocknr);
	if (!cn || !cn->bh) {
		return ret;
	}
	bh = cn->bh;


Please prepare a patch to remove the unneeded test?
