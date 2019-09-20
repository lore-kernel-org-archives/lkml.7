Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D50C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B9C207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392172AbfITRhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390962AbfITRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00FDF20E6;
        Fri, 20 Sep 2019 17:37:14 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78A4A600C6;
        Fri, 20 Sep 2019 17:37:08 +0000 (UTC)
Date:   Fri, 20 Sep 2019 13:37:07 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Milan Broz <gmazyland@gmail.com>
Cc:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: dm-crypt error when CONFIG_CRYPTO_AUTHENC is disabled
Message-ID: <20190920173707.GA21143@redhat.com>
References: <20190920154434.GA923@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920154434.GA923@gandi.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 20 Sep 2019 17:37:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20 2019 at 11:44am -0400,
Thibaut Sautereau <thibaut.sautereau@clip-os.org> wrote:

> Hi,
> 
> I just got a dm-crypt "crypt: Error allocating crypto tfm" error when
> trying to "cryptsetup open" a volume. I found out that it was only
> happening when I disabled CONFIG_CRYPTO_AUTHENC.
> 
> drivers/md/dm-crypt.c includes the crypto/authenc.h header and seems to
> use some CRYPTO_AUTHENC-related stuff. Therefore, shouldn't
> CONFIG_DM_CRYPT select CONFIG_CRYPTO_AUTHENC?

Yes, it looks like commit ef43aa38063a6 ("dm crypt: add cryptographic
data integrity protection (authenticated encryption)") should've added
'select CRYPTO_AUTHENC' to dm-crypt's Kconfig.  I'll let Milan weigh-in
but that seems like the right way forward.

Thanks for your report!
Mike
