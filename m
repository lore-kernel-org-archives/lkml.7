Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383E1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6821783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="HW0zuoAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfKLNql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:46:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37685 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfKLNql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:46:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so18599255wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AGYm3Nys6XNVIKZhVZx5YWFiErVNUCXgDLyv4whlig8=;
        b=HW0zuoArggOG6Z0bsLtd6adS4hfPVsBG21SBvDJOl3w0lsyPEnUnsBaoc4RPklkmnu
         7evAnkiPn4npIts2eC0uYef6S4PHzTtwVHJ9JQynQV/VZRSfL1gUrsp16SUVrQHuFGIo
         oGObSsSqHi86vE13Gm+1z7Xal8pUhm489jeJBGd++pMjg13qJXU0KQlbUQtEppt0XZF+
         e8NFr0twVAI1Nux6P6nDTkuvQLUmSMKoKUKoRfyR9nxsb5crwu2130sQ8cCaHW46reQA
         rHu8Z7r0z6B9ryaa30DZDNzxisg40MSVlDKwgwhVx7hOfnZ30NCDPbC2APjoxckNibUG
         deyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AGYm3Nys6XNVIKZhVZx5YWFiErVNUCXgDLyv4whlig8=;
        b=A48t+da7/81nHju+bYuuq8I/DOjuRSt36qKi1VmGNv5t2szHmZwNSkXJ9ds6cfSeEK
         BAHyuakBXFiILeYeQpPUW65tYa8sAoP+qWyNii4pgUlWpp0OglDKqbrN8sTygfl9PRaE
         8zyesRHnAAh8XZ1eO9rF91Rtz/6H7ExsWCs7B4CllDz1M6rm2rsXCBes7knOwhiV1O2O
         b3IyEdvnB3EykYnK8DWZSMBEEN4228eGZrWj7vXNO0QDDxLYImgevY5CspitEw2Uikd0
         /s9xaezD20zwUlCrteHQh+QDCYZ7gYEaUO9RL9P1xK/X60zjBi5ZEvpluHkUI+nVWNxM
         8/fg==
X-Gm-Message-State: APjAAAVZ9S0pikpngNzr4wxcb4ucDosbU7CjjCTx9+yAl7CBWLQWQtgP
        3cZqayv/rahgWJU0NyjkfpKQbQ==
X-Google-Smtp-Source: APXvYqydFPlOcZbZIDcdPbW4STt5Cvv8h0V6pr+w0+76FV1R4AoslUCyN2wslw/wb2BYA/ph3+wQvw==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr19329663wra.246.1573566397760;
        Tue, 12 Nov 2019 05:46:37 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id 205sm5207269wmb.3.2019.11.12.05.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 05:46:37 -0800 (PST)
Date:   Tue, 12 Nov 2019 14:46:36 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Po Liu <po.liu@nxp.com>,
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
Message-ID: <20191112134635.qxcyf4bzyiwazdmn@netronome.com>
References: <20191111042715.13444-1-Po.Liu@nxp.com>
 <20191112094128.mbfil74gfdnkxigh@netronome.com>
 <VE1PR04MB6496CE5A0DA25D7AF9FD666492770@VE1PR04MB6496.eurprd04.prod.outlook.com>
 <VI1PR04MB4880B514857A147B2634B27896770@VI1PR04MB4880.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4880B514857A147B2634B27896770@VI1PR04MB4880.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:54:29AM +0000, Claudiu Manoil wrote:
> >-----Original Message-----
> >From: Po Liu <po.liu@nxp.com>
> [...]
> >> -----Original Message-----
> >> From: Simon Horman <simon.horman@netronome.com>
> [...]
> >> > +/* class 5, command 0 */
> >> > +struct tgs_gcl_conf {
> >> > +     u8      atc;    /* init gate value */
> >> > +     u8      res[7];
> >> > +     union {
> >> > +             struct {
> >> > +                     u8      res1[4];
> >> > +                     __le16  acl_len;
> >>
> >> Given that u* types are used in this structure I think le16 would be more
> >> appropriate than __le16.
> >
> >Here keep the same code style of this .h file. I think it is better to have
> >another patch to fix them all. Do you agree?
> >
> 
> I don't see why "le16" would be more appropriate than "__le16" in this context.
> The "__leXX" types are widely used in kernel drivers and not only, to annotate the
> endianess of the hardware.  These are generic types defined din "include/uapi/linux/types.h".
> Whereas "leXX" are defined in "fs/ntfs/types.h", and there's no usage of these types
> in other h/w device drivers (I didn't find any).  Am I missing anything?

My point is a cosmetic one:
I think that __u8 goes with __le16, while u8 goes with le16.
