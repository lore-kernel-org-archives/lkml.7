Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2015C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F2420828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icZmCE5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfCYQUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:20:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33925 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYQUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:20:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id k2so11015927qtm.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVULFDCYzmFfbLTt2e68aOMcl1MFNXL4u+ZalL10/LU=;
        b=icZmCE5VsPVsZe35OzPWWEOoQFaga436/qJ8WfhdLTCLF9Tea3tQPKOjq0zxRDo6T5
         Yy7+sOBtsH6pw+bi2EAk5GtytmRytktAkehh2uYze0K1bzkc7/nMRrXaL9Z5ppZlY1NS
         XRrXsQR2QoIKepa4mTOhDi7ravIBqCVviA/mJIWK5ImDAdQjKN9c5DH1ao3mji1sU4ju
         3GjtKJAXTHy040fKWPlmFIOt6hB4YaMxKrwDeOPiL4wK+AVdIWBt/7dFpvqJfdc6Q9f2
         tZiWb/NmI7Pyz1Lti2wb3ULPn1cs3zv+UFwnSltmkpLRQMqzHQmbI3G6yq1qjUMgq9rk
         9N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVULFDCYzmFfbLTt2e68aOMcl1MFNXL4u+ZalL10/LU=;
        b=aMD2mkYuPdKEoK6ctn6adY9N2lJptKhwsGawxPSsce+oMzfZr+ZnYGWoF0hl11y0zG
         X9zO4EAbYj54yzOKlZhO2awbqSBi4dzc6jNHSuLp4grdJYtDP2kwyw7Oky76crNCthsw
         crjFAeekkWUP4EOISQnd6YXUKeUWcxKVI3jSm3p/aEJuVpqfTt4GNJ1moXWczbd0AWAv
         cBk4AVXf9hNHdC0tiedgwObysKzYgxcRUTU2glbmz1BGdM9ojUkKef3mWnwBXE/axIEK
         7vpHJfdG9arI9m+oHHlJTZcSPCy524LsBhTXTY3NM5YuCRElWXyCuBmotttVzc6Usu0z
         3HMw==
X-Gm-Message-State: APjAAAXrVv3bYVpdwwI88P8IyvwtfOrGB6kw/qkjBtNmtD/oqfkcuGYJ
        aKXSogB2FTBRKJi5vitAIwA=
X-Google-Smtp-Source: APXvYqzhbbmRa+MBdZy7E8Ucf2DbEDYBQ1+4VaFWSuyhOyfjuHYOAw+eVZcuPr3SSsNygFyUNQjXCg==
X-Received: by 2002:ac8:3042:: with SMTP id g2mr21145582qte.1.1553530850034;
        Mon, 25 Mar 2019 09:20:50 -0700 (PDT)
Received: from tzanussi-mobl ([216.46.15.34])
        by smtp.googlemail.com with ESMTPSA id f189sm9577938qkb.79.2019.03.25.09.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:20:49 -0700 (PDT)
Message-ID: <1553530847.6114.0.camel@gmail.com>
Subject: Re: dell_smbios KASAN bug
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Mario.Limonciello@dell.com
Cc:     pali.rohar@gmail.com, linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 11:20:47 -0500
In-Reply-To: <20190325101731.3558ecda@gandalf.local.home>
References: <1553106560.2080.5.camel@gmail.com>
         <20190320144146.08ecd5e4@gandalf.local.home>
         <1553108749.2079.1.camel@gmail.com>
         <20190320151353.1a223c0e@gandalf.local.home>
         <9541737623f942e49e9310aef963ffbf@ausx13mpc120.AMER.DELL.COM>
         <20190325101731.3558ecda@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2019-03-25 at 10:17 -0400, Steven Rostedt wrote:
> On Mon, 25 Mar 2019 13:22:35 +0000
> <Mario.Limonciello@dell.com> wrote:
> 
> > > diff --git a/drivers/platform/x86/dell-smbios-base.c
> > > b/drivers/platform/x86/dell-
> > > smbios-base.c
> > > index 9dc282ed5a9e..c3825c674522 100644
> > > --- a/drivers/platform/x86/dell-smbios-base.c
> > > +++ b/drivers/platform/x86/dell-smbios-base.c
> > > @@ -619,6 +619,7 @@ static int __init dell_smbios_init(void)
> > > 
> > >  fail_platform_driver:
> > >  	kfree(da_tokens);
> > > +	da_num_tokens = 0;
> > >  	return ret;
> > >  }
> > >   
> > 
> > Steven,
> > 
> > Since Tom confirmed this works will you send a formal patch to the
> > ML with this fix?
> 
> Will do.
> 
> Tom,
> 
> Is it OK if I add the following tags to that patch?
> 
> Reported-by: Tom Zanussi <tzanussi@gmail.com>
> Tested-by: Tom Zanussi <tzanussi@gmail.com>
> 

Yep, fine with me.

Tom

> -- Steve
