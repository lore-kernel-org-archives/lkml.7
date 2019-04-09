Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720FBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A2720880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfDIELs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:11:48 -0400
Received: from smtp105.ord1d.emailsrvr.com ([184.106.54.105]:57118 "EHLO
        smtp105.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbfDIELr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 00:11:47 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 00:11:46 EDT
Received: from smtp22.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp22.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 2A125E013C;
        Tue,  9 Apr 2019 00:04:50 -0400 (EDT)
X-SMTPDoctor-Processed: csmtpprox beta
Received: from smtp22.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp22.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 23DD7E0151;
        Tue,  9 Apr 2019 00:04:50 -0400 (EDT)
X-Auth-ID: mcdermj@xenotropic.com
Received: by smtp22.relay.ord1d.emailsrvr.com (Authenticated sender: mcdermj-AT-xenotropic.com) with ESMTPSA id 9413BE013C;
        Tue,  9 Apr 2019 00:04:49 -0400 (EDT)
X-Sender-Id: mcdermj@xenotropic.com
Received: from [10.0.3.61] (c-73-96-52-102.hsd1.or.comcast.net [73.96.52.102])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 09 Apr 2019 00:04:50 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.100.42\))
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
From:   Annaliese McDermond <nh6z@nh6z.net>
In-Reply-To: <20190409091231.57cf760a@canb.auug.org.au>
Date:   Mon, 8 Apr 2019 21:04:48 -0700
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <22BB74F1-60F2-4880-B91E-E36E57F1FBC8@nh6z.net>
References: <20190326100145.3ee50933@canb.auug.org.au>
 <20190409091231.57cf760a@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3445.100.42)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen --

I’m testing a potential solution now and I’ll be submitting something in the next couple of days.  Thanks for the heads up.

--
Annaliese McDermond
nh6z@nh6z.net

> On Apr 8, 2019, at 4:12 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi all,
> 
> On Tue, 26 Mar 2019 10:01:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> 
>> After merging the sound-asoc tree, today's linux-next build (x86_64
>> allmodconfig) produced this warning:
>> 
>> sound/soc/codecs/tlv320aic32x4-clk.c: In function 'clk_aic32x4_pll_recalc_rate':
>> sound/soc/codecs/tlv320aic32x4-clk.c:149:38: warning: 'settings.d' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>     ((settings->j * 10000) + settings->d);
>>                              ~~~~~~~~^~~
>> sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.d' was declared here
>>  struct clk_aic32x4_pll_muldiv settings;
>>                                ^~~~~~~~
>> sound/soc/codecs/tlv320aic32x4-clk.c:149:15: warning: 'settings.j' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>     ((settings->j * 10000) + settings->d);
>>       ~~~~~~~~^~~
>> sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.j' was declared here
>>  struct clk_aic32x4_pll_muldiv settings;
>>                                ^~~~~~~~
>> sound/soc/codecs/tlv320aic32x4-clk.c:148:37: warning: 'settings.r' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>  rate = (u64) parent_rate * settings->r *
>>                             ~~~~~~~~^~~
>> sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.r' was declared here
>>  struct clk_aic32x4_pll_muldiv settings;
>>                                ^~~~~~~~
>> sound/soc/codecs/tlv320aic32x4-clk.c:151:56: warning: 'settings.p' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>  return (unsigned long) DIV_ROUND_UP_ULL(rate, settings->p * 10000);
>>                                                        ^~
>> sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.p' was declared here
>>  struct clk_aic32x4_pll_muldiv settings;
>>                                ^~~~~~~~
>> 
>> Introduced by commit
>> 
>>  514b044cba66 ("ASoC: tlv320aic32x4: Model PLL in CCF")
> 
> I am still getting these warnings.
> 
> -- 
> Cheers,
> Stephen Rothwell

