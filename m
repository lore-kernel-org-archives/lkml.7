Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A5C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3835222C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570042628;
	bh=WpF8Re3Eqymd/wJChhJPfnpiZTj0YSkk2z09XovLTCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KV8IEsWqeZAucYgXuS+jd1uJtePvF35P5ND1jbUjrB9osZmDBlHwSBCaxva/OGO0Q
	 EpktHQoRbtIxQExhjMO58/QHGMY6iTBeVCrV9bisafmhKXX7+DAuKeHw+p5ezLR8uo
	 9B/Giqfb5fi6S2uw3qO9r6NcDrX5s5uu1vEyhDxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfJBS5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfJBS5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:57:08 -0400
Received: from linux-8ccs (ip5f5ade65.dynamic.kabel-deutschland.de [95.90.222.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD5921A4C;
        Wed,  2 Oct 2019 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570042627;
        bh=WpF8Re3Eqymd/wJChhJPfnpiZTj0YSkk2z09XovLTCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uY+KMxa6EHzdWRG8yHRoNenUWG1VSFpPH30eTnifpIFT0PjnmazKkjUnTtCkFL+S
         e5pxahXIF0JieNXgs7N0PTxiqv/65wo9xzdiMLQuw6OfR48n/TkP1G2bJQpY2Nj7+x
         VO5KbJtIw0NrtVs6HxuXfVbeQIxXKLiR2t1AEW9Q=
Date:   Wed, 2 Oct 2019 20:57:02 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] module: various bug-fixes and clean-ups for module
 namespace
Message-ID: <20191002185701.GA29041@linux-8ccs>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927134108.GC187147@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190927134108.GC187147@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Maennich [27/09/19 14:41 +0100]:
>On Fri, Sep 27, 2019 at 06:35:56PM +0900, Masahiro Yamada wrote:
>>
>>I was hit by some problems caused by the module namespace feature
>>that was merged recently. At least, the breakage of
>>external module builds is a fatal one. I just took a look at the code
>>closer, and I noticed some more issues and improvements.
>>
>>I hope these patches are mostly OK.
>>The 4th patch might have room for argument since it is a trade-off
>>of "cleaner implermentation" vs "code size".
>>
>Thanks Masahiro for taking the time to improve the implementation of the
>symbol namespaces. These are all good points that you addressed!

Agreed, thanks Masahiro for fixing up all the rough edges! Your series
of fixes look good to me, I will queue this up on modules-next this
week with the exception of patch 4 - Matthias, you are planning to
submit a patch that would supercede patch 04/07, right?

Thanks!

Jessica
