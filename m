Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B86C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D5216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="qZFM76xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfD3CMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:12:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46517 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3CMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:12:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id w73so7230427qkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 19:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvEs9iF7UgH1KoPh1IzqcTHpTm8A152gkwFXPuBPxi4=;
        b=qZFM76xqwX0nHQwBnaEyXEkQW/Nn9Cxxfguc3CWDmtGBZ32MljDrhYn2YTKLFb7Czx
         aw4hhzV5DzabQQFxoo8Nsg3ioD25APmb9se+2ym5QcnWM3B9BYPyAqPUcz/6uZig0zyT
         QAnHoCyQzZJjTocOK9ePD4uO3nvTnIcDpEPEqjgS+9y6hgxX3Y0WpEX0qbcrYbmQpb9Y
         dXwB7l0x1Q60XoUvmNmN0l+k1O0Nt5tbcrB80rYUK5LvOGE0n5Irshwld5BaFlIWmK4g
         rUX3SKGhr0BSwseFpeLZXj2M8hWfaw5/kziMKB1BAgcTE/54PH5LvR17oSCt6ECW6TpY
         RVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvEs9iF7UgH1KoPh1IzqcTHpTm8A152gkwFXPuBPxi4=;
        b=KS/xG46Ji/cY0F8U6td99omJo9+5k7gKPA0I4OcZxOwxgoxVbZUW+on/6KeMmQSd+P
         dN1ET/rHXkP+K2T3oa9wKQsAQixTWxawW+z+firLGA5EBB98ParcI0AsgNHfHmxttbwT
         /c36aHlYLYNfqVVdE9DBpzh7Eh8KeZLtOUS5iF7LRDpkzP326owm7ZLnUAsoerzrVXYB
         yL1vl3ogb9cvgQRzfuaIrt+yO0QgVATVABONH/DGb+4/1rv5w054Ls9Q6+gvotLkS9af
         rTNgns8nTV52OcX+RbNpaYFaRYI3WvbXFCxMrSQi6bnNckhX39nlHLT1e+s2qUT5rMvT
         VwfQ==
X-Gm-Message-State: APjAAAUapRnowEed1sbqYfu/GYmjps4iHZknuYEE/9OzOW4E9kP1YqvA
        aLBOZDeLmPjhIjLlwu+YEtH2nHip38H4a7rm9ju5eg==
X-Google-Smtp-Source: APXvYqzqb3PJHn1yZcKtN0ujVfgfOiIbacUnfqiU/Iwlvs3nFz94JrQtCCBqvBgb2BgMuPsnhY7XSR/J6J3QytvtpQQ=
X-Received: by 2002:ae9:e60b:: with SMTP id z11mr18198439qkf.80.1556590356354;
 Mon, 29 Apr 2019 19:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190415055358.9269-1-chiu@endlessm.com> <CACRpkdanhW206AEj7m+2FQBhJ5epUzw60Y6v+k-eoJLLW_-SSQ@mail.gmail.com>
 <20190426125031.GQ9224@smile.fi.intel.com>
In-Reply-To: <20190426125031.GQ9224@smile.fi.intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 30 Apr 2019 02:12:29 +0800
Message-ID: <CAB4CAwfF7FoQK9OndOm_yHQe19j=E_cNLn3eTBfoggEacONiyg@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl:intel: Retain HOSTSW_OWN for requested gpio pin
To:     Andriy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 8:50 PM Andriy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Apr 23, 2019 at 12:38:17PM +0200, Linus Walleij wrote:
> > On Mon, Apr 15, 2019 at 7:54 AM Chris Chiu <chiu@endlessm.com> wrote:
> >
> > > The touchpad of the ASUS laptops E403NA, X540NA, X541NA are not
> > > responsive after suspend/resume. The following error message
> > > shows after resume.
> > >  i2c_hid i2c-ELAN1200:00: failed to reset device.
> > >
> > > On these laptops, the touchpad interrupt is connected via a GPIO
> > > pin which is controlled by Intel pinctrl. After system resumes,
> > > the GPIO is in ACPI mode and no longer works as an IRQ.
> > >
> > > This commit saves the HOSTSW_OWN value during suspend, make sure
> > > the HOSTSW_OWN mode remains the same after resume.
> > >
> > > Signed-off-by: Chris Chiu <chiu@endlessm.com>
> >
> > This v3 patch applied with Mika's ACK.
>
> Hmm... It's supposed to go along with our PR.

Anything I can help with?

Chris
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
