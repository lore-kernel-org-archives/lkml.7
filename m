Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A2CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55959222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KzhFXzPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505159AbfJRRBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:01:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39595 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502169AbfJRRBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:01:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so4254351pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=IOez4AH3FAxesTF0200hHYoiJIV2V8NUCCJGXlYSsIw=;
        b=KzhFXzPgLEaLHhBO7ptqMUiewe2hpO3sKQrkBTIS2eSa/S2OQK8ED1Lh62fietylGI
         Qxc98BpQoE6+T6m85d+BX5F9OGCmvuJyKwHs5EvTb8bcOasDPEgd4sXfcyqdynDwOgmU
         f/zk4LYzxayvko1ULjUgZsXIIUE4bet0Tef1a8qXOogeM1rM7ra71MHZ0UE/EzH5Juvk
         HeZas9YAZzfTsICtbivvQ0oS99a0+O+oOeY8yjnxY2aS6AuMpX2CK+8W9HhOvDHzCUnh
         GscyJu3Y1GcOL89BM6kSeU9uPrLmTBgjFriQ+KSWPTCYntykbTKCnmXaDCZkGguf3b2c
         i8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=IOez4AH3FAxesTF0200hHYoiJIV2V8NUCCJGXlYSsIw=;
        b=d7L37/iNcsqZNdlYpDhZDsLBsUSYFt9+Kwur8yWWyCvz90l/k3k0D+GiRXjk0Adquj
         QDjDH8nC5R0yFeAsIeEehyKMD6lmUqWwe2OsDUHHQz6N4MP337tI/IzEk36BDbcYG+m1
         PjcKuHX6EiBPEw/3jkqQTTcvabhb4zt1hBlvemXfkPoVGcmRiPm3X9E1jc7ijcYpKmL5
         mHdUEEVvAs/wFlme6mj+gFTDPfdqVTT0IdN8FqP1Rm5vZrP471bmqu7gVD0m9lKIP/Fj
         C3GLCKvmJwitl0bo3nUFVBp/VopO/9+GbrjpQNUdV0GizFFFHKFVG92QHJX8cOQxhiL8
         UUlQ==
X-Gm-Message-State: APjAAAV6xdI2GTp64oMBAl40hklYqKoBInEsKS3E+T0wjtz+DuiZRb5F
        sL/BraEmICgQprINR1mUzTtKGQ==
X-Google-Smtp-Source: APXvYqwzevGKycLkBZbX4mzdTO0J3iEaO1hoIehHH68zRvsQumKhkkhbW3a/N3b0FbN81mCFnTDHDg==
X-Received: by 2002:aa7:98c9:: with SMTP id e9mr8125740pfm.142.1571418091182;
        Fri, 18 Oct 2019 10:01:31 -0700 (PDT)
Received: from cakuba.netronome.com (ip-184-250-188-81.sanjca.spcsdns.net. [184.250.188.81])
        by smtp.gmail.com with ESMTPSA id j26sm6489404pgl.38.2019.10.18.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:01:31 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:01:22 -0700
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
Message-ID: <20191018100122.4cf12967@cakuba.netronome.com>
In-Reply-To: <CAACQVJrO_PN8LBY0ovwkdxGsyvW_gGN7C3MxnuW+jjdS_75Hhw@mail.gmail.com>
References: <1571313682-28900-1-git-send-email-sheetal.tigadoli@broadcom.com>
        <1571313682-28900-4-git-send-email-sheetal.tigadoli@broadcom.com>
        <20191017122156.4d5262ac@cakuba.netronome.com>
        <CAACQVJrO_PN8LBY0ovwkdxGsyvW_gGN7C3MxnuW+jjdS_75Hhw@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 12:04:35 +0530, Vasundhara Volam wrote:
> On Fri, Oct 18, 2019 at 12:52 AM Jakub Kicinski wrote:
> > On Thu, 17 Oct 2019 17:31:22 +0530, Sheetal Tigadoli wrote:  
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > index 51c1404..1596221 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > @@ -3311,6 +3311,23 @@ static int bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
> > >       return rc;
> > >  }
> > >
> > > +static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
> > > +{
> > > +     struct bnxt *bp = netdev_priv(dev);
> > > +
> > > +#ifndef CONFIG_TEE_BNXT_FW
> > > +     return -EOPNOTSUPP;
> > > +#endif  
> >
> >         if (!IS_ENABLED(...))
> >                 return x;
> >
> > reads better IMHO  
> Okay.
> 
> >
> > But also you seem to be breaking live dump for systems with
> > CONFIG_TEE_BNXT_FW=n  
> Yes, we are supporting set_dump only if crash dump is supported.

It's wrong.

> > > +     if (dump->flag > BNXT_DUMP_CRASH) {
> > > +             netdev_err(dev, "Supports only Live(0) and Crash(1) dumps.\n");  
> >
> > more of an _info than _err, if at all  
> I made this err, as we are returning error on invalid flag value. I
> can modify the log to
> something like "Invalid dump flag. Supports only Live(0) and Crash(1)
> dumps.\n" to make
> it more like error log.

Not an error.
