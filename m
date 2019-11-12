Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53885C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2762F2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="O8h/X2U7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKLNut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:50:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40504 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:50:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so3030708wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+brfnZ3+v03u1yMPaD19zz4Q+9lSnpvxNNjizUxJGWU=;
        b=O8h/X2U7H3mOoQi1zyRPIOJ5R9L+xqUxQQrdLlrz27hXJiBOJxTVPr709X9PZp3tp4
         Dzwqs6kZzLwAq8G37tvXF8rXTOHJXcGmE8Cyy/envoeYS4f+hZj4lRQKSWDR9/IDhPtK
         jGWhQeDZhr94Q0cEvVHNEmK+7V9JDmpmpCrBjYARVsI0Vi87LmWc819jD7kpDPuSjzaM
         5xUKeRF5F5QgNySAQ61y5m6lLFO2uBKMIgryuVt/YaMUzN4oaKOJECsb78pUIcqw1Mbd
         QI5H6tYV4R9+5jSjG/H73ZgukaVSP0gr6QNkCSkZSTrLY5G/JgAgtI5cJczWsqldWQHP
         gEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+brfnZ3+v03u1yMPaD19zz4Q+9lSnpvxNNjizUxJGWU=;
        b=JIBUU5Wxdi8s+SBNNAGhqMiv99d26b0aXcCLRI288JGkUoTWHifXF95mXYrNp8eqVd
         0+iQZE5LRgz4c7EjfEov9qQ3/moGVLDeTrcCTvnZvMXYwWSZAif/YaC82AvHvQYjK6wp
         bf/g/YME5lrY+uT1AXGzrdjrTdpViNGJnFDsXmh4DIaxq1E/wqkC97lqC6GSDsGR8G6S
         o7kKFJtSvXh/U17m003oEwia0piFWzKHqOxcr9kG/lIJw+EWBJkgVitYYOOs8vBX+8Nu
         Ze0sqICjDq6FwZ7ifotFABpF3RKm0t7lgi/CtIm3LLL9O36TEglHeA8CujVfWjPt5B0X
         VZxQ==
X-Gm-Message-State: APjAAAXczM8FK3symwTG5aAHGz25lYnSDVsXD8Go6pWu4Z/r4B9+65Rk
        sJTeKGJUmkihXOHlJy+8h+hLHg==
X-Google-Smtp-Source: APXvYqy5m7WXR82TGiKLzUKRK5dIkDwBpWW76BT4IPAI9S17eKjcG0T3L3UMRJusuZR2a49OjlSk7g==
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr3761956wmm.35.1573566646507;
        Tue, 12 Nov 2019 05:50:46 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id j3sm17948565wrs.70.2019.11.12.05.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 05:50:46 -0800 (PST)
Date:   Tue, 12 Nov 2019 14:50:45 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Po Liu <po.liu@nxp.com>
Cc:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Jerry Huang <jerry.huang@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [EXT] Re: [net-next, 1/2] enetc: Configure the Time-Aware
 Scheduler via tc-taprio offload
Message-ID: <20191112135045.5qaau7kqdxrrpqo4@netronome.com>
References: <20191111042715.13444-1-Po.Liu@nxp.com>
 <20191112094128.mbfil74gfdnkxigh@netronome.com>
 <VE1PR04MB6496CE5A0DA25D7AF9FD666492770@VE1PR04MB6496.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6496CE5A0DA25D7AF9FD666492770@VE1PR04MB6496.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:19:43AM +0000, Po Liu wrote:

...

> > > +/* class 5, command 0 */
> > > +struct tgs_gcl_conf {
> > > +     u8      atc;    /* init gate value */
> > > +     u8      res[7];
> > > +     union {
> > > +             struct {
> > > +                     u8      res1[4];
> > > +                     __le16  acl_len;
> > 
> > Given that u* types are used in this structure I think le16 would be more
> > appropriate than __le16.
>  
> Here keep the same code style of this .h file. I think it is better to have another patch to fix them all. Do you agree?
> 
> > 

> > > +                     u8      res2[2];
> > > +             };
> > > +             struct {
> > > +                     u32 cctl;
> > > +                     u32 ccth;
> > > +             };
> > 
> > I'm a little surprised to see host endian values in a structure that appears to be
> > written to hardware. Is this intentional?
> 
> Will remove.

If the HW defines these fields then I think its fine to leave them,
though with the correct byte-order.

I was more asking if it is intentional that the value for these
fields, when sent to the HW, is always zero in the context of this
patch-set. Likewise elsewhere.

...

> > > +
> > > +     gcl_data->ct = cpu_to_le32(admin_conf->cycle_time);
> > > +     gcl_data->cte = cpu_to_le32(admin_conf->cycle_time_extension);
> > > +
> > > +     for (i = 0; i < gcl_len; i++) {
> > > +             struct tc_taprio_sched_entry *temp_entry;
> > > +             struct gce *temp_gce = gce + i;
> > > +
> > > +             temp_entry = &admin_conf->entries[i];
> > > +
> > > +             temp_gce->gate = cpu_to_le32(temp_entry->gate_mask);
> > 
> >         Gate is a u8 followed by 3 reserved bytes.
> >         Perhaps there needs to be some bounds checking on
> >         the value stored there given that the source is 32bits wide.
> > 
> >         Also, its not clear to me that the above logic, which I assume
> >         takes the last significant byte of a 32bit value, works on
> >         big endian systems as the 32bit value is always little endian.
> 
> temp_entry->gate_mask is 32bit for wide possible input. Here change to hardware set 8bit wide.
> Can it just be like:
> 	temp_gce->gate = (u8) temp_entry->gate_mask;

I think that would be better.
Perhaps its best to also mask out the unwanted bits.

...
