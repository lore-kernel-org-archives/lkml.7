Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F74AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B1E206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZPouwBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfLLO5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:57:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45538 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfLLO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:57:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so1254316pgk.12;
        Thu, 12 Dec 2019 06:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0WhcdRR33BP6aOfthkITtaARbX81vs+CP8HbIHKE68w=;
        b=kZPouwBxetJpiVaX/NEsPrlNjSthou8Id9g6A/b8rX+G6xGM0Td6uP/KZhD6mM5OJp
         P8ANrV6ZZAXDR/XqdeWQQuKuEfz8sjsPhpJmDfvrbOKkttcn71zzqtAvPA4H6zon3pBO
         5bfNAcFV0YV5tUNYYULDwdynZnehZgNGQz6M4M/2wK6UIlnVN2EjhoHlQSXpnkPzKz8l
         8c5zN20bjNZEFWFWwy5euVnFw0foCBIQE9KYayNWAoVCs6AOM2RC64f1kQ4IlejlPuZk
         62pexrrg6KqMBCOjfTJlQanLrcJYs5hwmTrwM+NgoMYordisASJojImLPPO4ZvljCfqh
         fLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0WhcdRR33BP6aOfthkITtaARbX81vs+CP8HbIHKE68w=;
        b=FzVWpQ/LPl1m4AY29bAWqSS3JiNNFeGerWN6L4hkHIQzqQbMOD8tAWz5wUou/yA97p
         M40QSSPuQLDUdgjFqIeKJbIcwr49wCUZVzeyAoFFa3VxCpPTf/nNXzENNqsyi/9FklTY
         g+RdkxGqmSmmYti2DVNTUrDFJGBC8+iCe21ACxyrLpDzqO8Ks290UbTUw+aakjqGK6YJ
         1v4H782wr0buwrfxqY1WDv0jLgxZG3HEDkFQRJoTqrZQl9Ekzkv37vcRVN4qWQzpzDKq
         XcHow1A2ZhchQa5Rixec4O5+nppftuEeadxsZ1K1//BTRpdbCKVHoCpSIbUMk88OqYTy
         awDA==
X-Gm-Message-State: APjAAAWcmB/hQJYqLgYNIhXcscM20uQWe0esyfIdKU91XzKYnSJw/MD1
        l+UUIYHXocrCBriFoiAy70wJLZAN
X-Google-Smtp-Source: APXvYqzLzE3QoOLcJpz/9cKpseC//OAJ8I8/QamS1G+kxt/6OR/ZaicI60KlwVq3a3n3mBFaWLy9Xw==
X-Received: by 2002:a63:d807:: with SMTP id b7mr11164325pgh.52.1576162644417;
        Thu, 12 Dec 2019 06:57:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v29sm7003731pgl.88.2019.12.12.06.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 06:57:23 -0800 (PST)
Date:   Thu, 12 Dec 2019 06:57:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        zhong jiang <zhongjiang@huawei.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: Fix an undefined reference to
 'extcon_get_state'
Message-ID: <20191212145722.GA361@roeck-us.net>
References: <1576136063-50916-1-git-send-email-zhongjiang@huawei.com>
 <20191212090132.GC31345@kuha.fi.intel.com>
 <5DF20530.2040509@huawei.com>
 <20191212092805.GA1375559@kroah.com>
 <5DF20B18.4020601@huawei.com>
 <20191212111805.GD31345@kuha.fi.intel.com>
 <20191212122053.GA1541203@kroah.com>
 <20191212124937.GE31345@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212124937.GE31345@kuha.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 02:49:37PM +0200, Heikki Krogerus wrote:
> On Thu, Dec 12, 2019 at 01:20:53PM +0100, Greg KH wrote:
> > On Thu, Dec 12, 2019 at 01:18:05PM +0200, Heikki Krogerus wrote:
> > > On Thu, Dec 12, 2019 at 05:40:40PM +0800, zhong jiang wrote:
> > > > On 2019/12/12 17:28, Greg KH wrote:
> > > > > On Thu, Dec 12, 2019 at 05:15:28PM +0800, zhong jiang wrote:
> > > > >> On 2019/12/12 17:01, Heikki Krogerus wrote:
> > > > >>> On Thu, Dec 12, 2019 at 03:34:23PM +0800, zhong jiang wrote:
> > > > >>>> Fixes the following compile error:
> > > > >>>>
> > > > >>>> drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
> > > > >>>> fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
> > > > >>>> fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
> > > > >>>> fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
> > > > >>>> fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
> > > > >>>> drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
> > > > >>>> fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
> > > > >>>> make: *** [vmlinux] Error 1
> > > > >>> There are stubs for those functions so that really should not be
> > > > >>> happening. I can not reproduce that.
> > > > >> It can be reproduced in next branch. you can try it in the latest next branch.
> > > > > Can it be reproduced in 5.5-rc1?
> > > > >
> > > > commit 78adcacd4edbd6795e164bbda9a4b2b7e51666a7
> > > > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Date:   Thu Dec 12 15:48:07 2019 +1100
> > > > 
> > > >     Add linux-next specific files for 20191212
> > > > 
> > > > I  reproduce it  based on this commit.  The related config is attached.
> > > 
> > > OK, now I get what's going on. EXTCON is build as a module, but
> > > FUSB302 is not. This should be explained in the commit message.
> > > 
> > > That does not mean we have to force everybody to enable EXTCON in
> > > order to use this driver. Try something like this:
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> > > index 72481bbb2af3..06e026f6325c 100644
> > > --- a/drivers/usb/typec/tcpm/Kconfig
> > > +++ b/drivers/usb/typec/tcpm/Kconfig
> > > @@ -31,6 +31,7 @@ endif # TYPEC_TCPCI
> > > 
> > >  config TYPEC_FUSB302
> > >         tristate "Fairchild FUSB302 Type-C chip driver"
> > > +       depends on EXTCON=n || EXTCON=y || (EXTCON=m && m)
> > 
> > Ugh.  We need a better "pattern" for stuff like this, it's getting more
> > and more frequent.
> > 
> > And no, I don't have a better idea :(
> 
> I think this works:
> 
>         depends on EXTCON || !EXTCON

Yes, that is what I usually use for hwmon, though it dos look weird.
I agree, it would be nice to have something expressing such dependencies
in a better way.

Guenter
