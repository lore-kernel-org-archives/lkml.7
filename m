Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F003C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69EA20718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="0Sj/qMkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNMNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:13:49 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:43946 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNMNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:13:49 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C805B5C007B;
        Thu, 14 Nov 2019 13:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1573733627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGcTdtN/MMxtvEXNLiMcbFR7YdpQSTDkoKDyROnitfA=;
        b=0Sj/qMkVY/zyapS6VOue3Au59dG3wB5fGIihIlat7Nk3+FJutis0FeEEJ1r1/PuwXJx6DU
        vHsl3phpd2EUakLysHmBUQAcCDlG6aTF2Acch4VlXKcUe2EIFec3ncjK6/WjoGmMOCvF/i
        q+YEemzUA72jeRc/awAo8AbT4Q8iGVo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Nov 2019 13:13:47 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Mark Brown <broonie@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, phh@phh.me,
        b.galvani@gmail.com
Subject: Re: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
In-Reply-To: <20191114115430.GA4664@sirena.co.uk>
References: <20191113182643.23885-1-andreas@kemnade.info>
 <20191113183211.GB4402@sirena.co.uk> <20191113202633.66a91d96@aktux>
 <20191114115430.GA4664@sirena.co.uk>
Message-ID: <25f0d55696be463def622a37a1f2b826@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-14 12:54, Mark Brown wrote:
> On Wed, Nov 13, 2019 at 08:26:33PM +0100, Andreas Kemnade wrote:
>> Mark Brown <broonie@kernel.org> wrote:
> 
>> > This definitely looks like a bug but without a datasheet or testing it's
>> > worrying guessing at the register bit to use for the enable for the
>> > second LDO...
> 
>> I am hoping for a Tested-By: from the one who has submitted the patch
>> for the regulator.
> 
> Or a reviewed-by from someone with access to the datasheet.
> 

I guess Pierre-Hugues should have access, as he introduced the part?

>> Well, it is not just guessing, it is there in the url I referenced. But
>> I would of course prefer a better source. At first I wanted to spread
>> my findings.
> 
> The URL you provided looked to be for a different part though?
> 
>> I am not pushing anyone to accept it without Tested-By/Reviewed-Bys.
>> What is a good way to avoid people bumping into this bug?
>> Maybe I can find the right C on the board to check.
> 
> That'd be good.  Or we could fix it by just removing enable/disable
> control for the second LDO entirely and if someone needs that control
> they can always re-add it.

We use the RN5T567 and I added support for it. Unfortunately I have no
access to the RN5T618 datasheet so I cannot tell. The RN5T567 has both
bits in marked reserved, but looking at how it the enable bit are
distributed otherwise this patch fixes it in the only way it makes
sense...

--
Stefan
