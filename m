Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEFAC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6821221734
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564066374;
	bh=UiAPxBMDA0i/iMkH2fdA0nFfj4Rn3c8p0jAXHIvZ0og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gv4C3lW2RtN7R8EcH7JOKXwffZH7DBsC0C3kYVfPEW3xGlRSoLZgGRtHavwU0fLIu
	 rF5gYzjIQKJ5ObJ241Yu+VLwcMci1NjZ1rCm6xxmf6v/mmA4XPdNRJoMG7TxMGBNuo
	 xXsG34b48IRZKJchETDtGTCy6Ckn/czX16zQX4ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbfGYOwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387646AbfGYOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:52:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4E421734;
        Thu, 25 Jul 2019 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564066372;
        bh=UiAPxBMDA0i/iMkH2fdA0nFfj4Rn3c8p0jAXHIvZ0og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI7UPyLJQ98A3zSspuu8RTVksaDq1QaMKEkkw7btW+Aj4OCcSqpUxLcys6FN/ctNf
         ZxrqUa+qWaSzdtNjYKLdto+bbh0+HjEuSAbH4vhDNqyhcp92mdZ7sGuW6Ucol5y1Ds
         zmVnX+Gywp1MH4/lE9cQ3GEbGP6Cb/cQusPgDVmo=
Date:   Thu, 25 Jul 2019 16:52:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Disable procfs debugging by default
Message-ID: <20190725145249.GA32271@kroah.com>
References: <20190718092522.17748-1-kai.heng.feng@canonical.com>
 <20190725075503.GA16693@kroah.com>
 <83A2CB3F-B0C4-43C6-A3A6-B6E8B440BECC@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83A2CB3F-B0C4-43C6-A3A6-B6E8B440BECC@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:48:42PM +0800, Kai-Heng Feng wrote:
> at 15:55, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 18, 2019 at 05:25:22PM +0800, Kai-Heng Feng wrote:
> > > The procfs provides many useful information for debugging, but it may be
> > > too much for normal usage, routines like proc_get_sec_info() reports
> > > various security related information.
> > > 
> > > So disable it by defaultl.
> > > 
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/staging/rtl8723bs/include/autoconf.h | 4 ----
> > >  1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/include/autoconf.h
> > > b/drivers/staging/rtl8723bs/include/autoconf.h
> > > index 196aca3aed7b..8f4c1e734473 100644
> > > --- a/drivers/staging/rtl8723bs/include/autoconf.h
> > > +++ b/drivers/staging/rtl8723bs/include/autoconf.h
> > > @@ -57,9 +57,5 @@
> > >  #define DBG	0	/*  for ODM & BTCOEX debug */
> > >  #endif /*  !DEBUG */
> > > 
> > > -#ifdef CONFIG_PROC_FS
> > > -#define PROC_DEBUG
> > > -#endif
> > 
> > What?  Why?  If you are going to do this, then rip out all of the code
> > as well.
> 
> Or make it a Kconfig option? Which one do you think is better?

No new config options please.

> > And are you _sure_ you want to do this?
> 
> Yes. The procfs of rtl8723bs is useful to Realtek to decode but not to
> others.

If no one else needs this, then rip out all of the code that uses it,
not just the single #define.

thanks,

greg k-h
