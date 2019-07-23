Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F43C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD637218B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="gD/APuRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfGWMJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:09:42 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:52714 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbfGWMJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:09:42 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 45tHLX4VsczB2;
        Tue, 23 Jul 2019 14:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1563883700; bh=q/yqkme0C5nm6xJG/9o9HPjCC0u8xeyhijug6sZ7k/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gD/APuRSZrrHK4hhyBmpFxgqfD5T0wnt6MQ0H+qmr+SCrP6+MxCYH6++gALgCFYPh
         ppyIod4Cq1HzGiEGAH2UxgvxbCmJZQnNtnwWRmRRMMlYeIjH0btNBDfUrsPUqeRMgL
         Mb9oCbuXVHaGScENi/ZyoJiPTXzlP+kFMwitF/a/ZUjglMopk+FixPCHQ9tcC0EGUF
         8helInVP32KiWZk/Rage+Oktv/klcwMDsVCMkw4dn4Q7VTgVjuqqBGVaXmPj6J0czZ
         uc9jS20L7VBgq+4zDrnaT5znUqqSfzDw1246Y9yngdJhOpaMh6ohIXvkYvue5+cnoP
         0SCbHQuVkFHqw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Tue, 23 Jul 2019 14:09:38 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: act8865: support regulator-pull-down property
Message-ID: <20190723120938.GC14036@qmqm.qmqm.pl>
References: <d02d7285ef26f59ce43a3097e342eea081b98444.1563819128.git.mirq-linux@rere.qmqm.pl>
 <20190723105432.GB5365@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190723105432.GB5365@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:54:32AM +0100, Mark Brown wrote:
> On Mon, Jul 22, 2019 at 08:13:29PM +0200, Micha³ Miros³aw wrote:
> > AC8865 has internal 1.5k pull-down resistor that can be enabled when LDO
> > is shut down.
> 
> This changelog...
> 
> >  static const struct regulator_ops act8865_ldo_ops = {
> > +	.list_voltage		= regulator_list_voltage_linear_range,
> > +	.map_voltage		= regulator_map_voltage_linear_range,
> > +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> > +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> 
> ...doesn't obviously match this code change which looks to be
> implementing voltage setting (as well as the pull down stuff but still).

It's just an diff-artifact of changing act8865_ldo_ops meaning. It's
now a copy of act8865_ops with .set_pull_down added. Previous
act8865_ldo_ops is act8865_fixed_ldo_ops now.

Best Regards,
Micha³ Miros³aw
