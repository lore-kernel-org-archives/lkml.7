Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4C6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6942084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Meag7SAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfJUXAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:00:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33738 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfJUXAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:00:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so9381799pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SURSLeTSL7wuoZg4pBrgsadycsCRF2eCp03BsgMlMG0=;
        b=Meag7SAC6vW6yZS/oje7Wm85r+tkPnshrrX39endzp5QbpqHafCu2b5AXixNaxzyr2
         T0exF/nmDvNL6CK8t1HHVa/h+HdJSIQk/eVvIaVSUfJrmllzSibBHLek3MEJ+3WTpwFQ
         WNIOZv+NBWPOWfhffKEsVZc57W2r5RaQfk/xalhlm0MVkqj84GnTsmODiBjry3GbaDNR
         hEiAeZh/gdpzHD2Ky2Rdr/LbKFtZkBaOceFV/qRATTFS7WowRiOOo6AuhX77xP0w62Ul
         mjKL9ho2bijjXbK3kF5O2f3TT3ctDRA1oJf8dvFieS2zbAHUiF5n76su+tUwwvUiYTpH
         sQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SURSLeTSL7wuoZg4pBrgsadycsCRF2eCp03BsgMlMG0=;
        b=bnnTeUd3pd/dN5Kym+lXTyDelVlrYhIQ5fC5vss3BdQ48744v4F6/E3WZiZEKJZHWE
         JafaNITDpuX/wbcx8O05BYQMlYa/9OH/CWzeJHAFQoBpc5KaDkLmf0sKOwYMO62YTbI0
         OY6W7zt5POL2JCCX8VmwDTgMLWIDuqQkXFopwD60kURLXXAK2BhdDlFBRZAmK3uzdxDq
         eBEukbaYJODaf+aNe87dJRMnUT88pVWTlPS1I8XchUTKSYY6xr7K3U/roNfzyhvR/454
         DY5XxBo/9mfAan3Hk04ZrnVzflxFrlsTVTanYSo4HJYdFUStELfWheg7dbGD3bqt+uJo
         IspQ==
X-Gm-Message-State: APjAAAUftw0vnztbUU97haOkOdqNZWI+zZKjtx23ArbOvqbeniSHgXHP
        iT4g5LF6hlNbtDe+gQ5HUqcJGg==
X-Google-Smtp-Source: APXvYqxYZ2jJ5duUjyqvYuT3lNSHH1ZL2DYp2WDXFH7Aqd7Rk+5j9fUuqhsckt6C5FN5vrOBYczPCA==
X-Received: by 2002:a63:18d:: with SMTP id 135mr328237pgb.326.1571698831249;
        Mon, 21 Oct 2019 16:00:31 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id a16sm16448156pfa.53.2019.10.21.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 16:00:30 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:00:26 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        =?UTF-8?B?UmFmYcWC?= =?UTF-8?B?IE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] bnxt_en: Add support to collect crash dump via
 ethtool
Message-ID: <20191021160026.18b3491e@cakuba.netronome.com>
In-Reply-To: <CAACQVJp1R-9frrgjn6=5s_f3AGBq-fyy5CsYdAio1e=c9iLB9g@mail.gmail.com>
References: <1571313682-28900-1-git-send-email-sheetal.tigadoli@broadcom.com>
        <1571313682-28900-4-git-send-email-sheetal.tigadoli@broadcom.com>
        <20191017122156.4d5262ac@cakuba.netronome.com>
        <CAACQVJrO_PN8LBY0ovwkdxGsyvW_gGN7C3MxnuW+jjdS_75Hhw@mail.gmail.com>
        <20191018100122.4cf12967@cakuba.netronome.com>
        <CAACQVJp1R-9frrgjn6=5s_f3AGBq-fyy5CsYdAio1e=c9iLB9g@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 10:05:18 +0530, Vasundhara Volam wrote:
> On Fri, Oct 18, 2019 at 10:31 PM Jakub Kicinski wrote:
> > On Fri, 18 Oct 2019 12:04:35 +0530, Vasundhara Volam wrote:  
> > > On Fri, Oct 18, 2019 at 12:52 AM Jakub Kicinski wrote:  
> > > > On Thu, 17 Oct 2019 17:31:22 +0530, Sheetal Tigadoli wrote:  
> > > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > > > index 51c1404..1596221 100644
> > > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > > > @@ -3311,6 +3311,23 @@ static int bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
> > > > >       return rc;
> > > > >  }
> > > > >
> > > > > +static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
> > > > > +{
> > > > > +     struct bnxt *bp = netdev_priv(dev);
> > > > > +
> > > > > +#ifndef CONFIG_TEE_BNXT_FW
> > > > > +     return -EOPNOTSUPP;
> > > > > +#endif  
> > > >
> > > >         if (!IS_ENABLED(...))
> > > >                 return x;
> > > >
> > > > reads better IMHO  
> > > Okay.
> > >  
> > > >
> > > > But also you seem to be breaking live dump for systems with
> > > > CONFIG_TEE_BNXT_FW=n  
> > > Yes, we are supporting set_dump only if crash dump is supported.  
> >
> > It's wrong.  
>
> Sorry not very clear. You are saying that support set_dump all the
> time and return error, if the config option is not enabled? If yes, I
> will modify the same way as it makes sense.

Yes, I think users can expect that set will work even if there is only
one dump type/flag supported. Technically implementing the set is not
required from functional perspective, however, we could imagine
software that always does a set before a get, and the set should not
fail.
