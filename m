Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E9EC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219FA2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfHAHoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:33404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfHAHoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:44:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E2ABB11C;
        Thu,  1 Aug 2019 07:44:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 74FE31E3F4D; Thu,  1 Aug 2019 09:44:04 +0200 (CEST)
Date:   Thu, 1 Aug 2019 09:44:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Roald Strauss <mr_lou@dewfall.dk>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: UDF filesystem image with Write-Once UDF Access Type
Message-ID: <20190801074404.GB25064@quack2.suse.cz>
References: <20190712100224.s2chparxszlbnill@pali>
 <35c0e9f3-b3b6-96c3-e339-2267a3abde9b@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35c0e9f3-b3b6-96c3-e339-2267a3abde9b@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-07-19 12:44:34, Steve Magnani wrote:
> Hi,
> 
> On 7/12/19 5:02 AM, Pali Rohár wrote:
> > In my opinion without support for additional layer, kernel should treat
> > UDF Write-Once Access Type as read-only mount for userspace. And not
> > classic read/write mount.
> > 
> > ...
> > 
> > It seems that udf.ko does not support updating VAT table, so probably it
> > should treat also filesystem with VAT as read-only too.
> > 
> 
> I thinkb085fbe2ef7fa7489903c45271ae7b7a52b0f9ab  <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/udf?h=v5.1&id=b085fbe2ef7fa7489903c45271ae7b7a52b0f9ab>, deployed in 4.20,
> does both of the things you want.
> 
> One case I ran across today that Windows handles, but Linux doesn't,
> is write-protection via flags in the DomainIdentifier fields of the
> Logical Volume Descriptor and File Set Descriptor. Linux allows
> RW mount when those are marked protected, but Windows forces RO mount.

Yeah, you're right. We are currently completely ignoring the
DomainIdentifier field and at least for read-write mounts we should make
sure it is valid. So that's something that needs fixing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
