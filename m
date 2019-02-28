Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82065C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BA5204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6qTzMI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbfB1RjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:39:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39170 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732689AbfB1RjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:39:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id b65so7056927plb.6;
        Thu, 28 Feb 2019 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qiWi7lzCnlBini3Sln9qtOtkEtXADQ7lho+ft2Y1gzY=;
        b=a6qTzMI2dColFsIjIbc1lu8Gw9e0pzssZmSV5S7UTWkNlWp16nVlRGaRoJjvEl3ISS
         tTLDvqzkx/MPRYRi5AtpzOH+mfIlgXiVw9kPgpBcBkHkM9VMy24nHPrMpsgk3JSaTwBK
         vxq1pCUbOgH7Skz895cyeW/6KXKvcHfex68SOZLPN4ZZgSGH3YEPDDzFzjEABPzwHXRf
         LVvjmM27F6OogwodiCjWOYFC24A1KarxZxF2U8Nbo59PsgOWnVSc08HqbDwgQgvFExaj
         ayZf/zoP3cGjum7wPDLA5Ww+vu+xV5Lsrk+GIMSh67ks+gTgJxF8LeU/utLiFIETEkA8
         9Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiWi7lzCnlBini3Sln9qtOtkEtXADQ7lho+ft2Y1gzY=;
        b=QydKZj3+ApQ/mMiMkzethdZ8VgZge+t6gh6OwGBEQsSBRrBDx7hogvnUa5DJY+GxyH
         gtyPSXJydXnghHp8andKz3GFIbsj6RF9TZAoJighkqcOE25SWjfRHL3fvpDg0C/nGMcv
         wJjjkCD9TwtnQ9pl3v7EpMCaLUAL/D2Cbtgx4MN8rT8mGBKG+zuQTvdn1T6AZGsKLqKJ
         mVxj0ghOrjM0qyJXCnxEuHtGAmKoMQu4tx4j+wkKaYuDPrMqVqC9EjF0mE8Or300Dlwy
         LK2GT6cvhvzyBJuwLjA0RmqMcEhSWmrRd2DL2S3WHCHdMgLTPNOlAS7F3kh9VSUHAiHk
         x1GA==
X-Gm-Message-State: APjAAAUA2+99lHPY60KhBZfVavXPhL4zIePa34U6lgnA1weug9bnE7Ah
        qzX45jgVd/3CbXHEBXgo21U=
X-Google-Smtp-Source: APXvYqxph1DjgCJxhVChXxi3PZsSedTFsymERRq2wB2lYtiSyONLwE0h0z4l5Af/f6X8bE4fBS6tzw==
X-Received: by 2002:a17:902:9304:: with SMTP id bc4mr536556plb.81.1551375546729;
        Thu, 28 Feb 2019 09:39:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m67sm33759875pfj.70.2019.02.28.09.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 09:39:05 -0800 (PST)
Date:   Thu, 28 Feb 2019 09:39:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: hwmon: Add missing documentation for lm75
Message-ID: <20190228173904.GA18568@roeck-us.net>
References: <20190212113808.3040-1-jagan@amarulasolutions.com>
 <20190228151543.GA18597@bogus>
 <CAMty3ZDR_Vnutobg=wjzwPZ_pkD4pLA76Lpec9u4OR8OtmuLGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZDR_Vnutobg=wjzwPZ_pkD4pLA76Lpec9u4OR8OtmuLGA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:00:44PM +0530, Jagan Teki wrote:
> On Thu, Feb 28, 2019 at 8:45 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Feb 12, 2019 at 05:08:08PM +0530, Jagan Teki wrote:
> > > Add missing dt-binding documentation for lm75 hwmon sensor.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
[ ... ]

> 
> Guenter, could you please pick this.

Applied to hwmon-next (and pushed).

Guenter
