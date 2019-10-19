Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B08FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26AF222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="M6VCMhS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfJSCA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 22:00:28 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:21032 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfJSCA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 22:00:28 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x9J20N5O031630;
        Sat, 19 Oct 2019 11:00:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x9J20N5O031630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571450424;
        bh=IXeAOItcs0JKX4/at0twHz9xHrOXD8X+b3ZQGcBCOXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M6VCMhS3NLozRLvjZ32JcW9YVaeQpewvOA9t3n/aZ+U0gVMiws9wyk8r6RAxWS5Xt
         JuLOiUIK2RpDMXuW3P9JQfnc/d5++NWCe6prlS1TZRF4ZIEHx0kL/mBaV5IKajOCxq
         T//RmnN/C1OtETwpdGr4OYLi5SaI+A08+lHCYTSm9Cgrlf5bh0IJxbHmlB0kZAGhoq
         gnPOExPizinuLOHVc2WG0EzJ6RoxvCWWHOPgqTBxClC5MBVgxWzxTQkpfVlQIEEcxH
         DvVCjjgezDiI54jSfBFIcJmv+9sNDNTopfmQwF/mfpSflaNuhAEdBk2GbHXkwrTVrS
         ehY9Ilb6dNqvw==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id y129so5305762vsc.6;
        Fri, 18 Oct 2019 19:00:23 -0700 (PDT)
X-Gm-Message-State: APjAAAUj+6atop3V3aUYD1IO6cUGSBfvSd/3dWnIWa/kzQ0PDgY9P3bz
        Ee8SxoeN5g9O7H0snLZUcqhTVpOKpD3hZRAWCJI=
X-Google-Smtp-Source: APXvYqwn0eSTPeUejo/av+n/6ebQWpCbKXjt+ofHiw8ZGV8MqIwAmIp0JR53ZIzhSRo/C6tjmshPUaAIkGG7MkcyZEE=
X-Received: by 2002:a67:e354:: with SMTP id s20mr7386598vsm.54.1571450422335;
 Fri, 18 Oct 2019 19:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <1823C41A-3296-4DEA-B71F-5AD548335F8B@goldelico.com>
In-Reply-To: <1823C41A-3296-4DEA-B71F-5AD548335F8B@goldelico.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 19 Oct 2019 10:59:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFk--KYWNrrduiPgeBAu6T49brJXd_Nb8ZQOfYrbFmAA@mail.gmail.com>
Message-ID: <CAK7LNARFk--KYWNrrduiPgeBAu6T49brJXd_Nb8ZQOfYrbFmAA@mail.gmail.com>
Subject: Re: ARM: add __always_inline to functions called from __get_user_check()
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 7:06 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi,
> I wonder what happened to your patch. We were "hit" by it in v5.4-rc1 and
> after finding, it made our OMAP based device bootable again (using our
> own defconfig which optimizes for SIZE).
>
> But it does not seem to have arrived in linux-next

It is in linux-next.


> and should IMHO
> be fixed during the v5.4 release candidate cycle.

I agree.


Masahiro

>
> BR and thanks,
> Nikolaus Schaller
>


-- 
Best Regards
Masahiro Yamada
