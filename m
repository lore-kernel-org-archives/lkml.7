Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84172075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bfvv12wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfCLNiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:38:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39880 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:38:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id p8so2743189wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pkOq70z0V2Mh6Wal5v9/f24QC4UGA2XeBsqevzSnW2s=;
        b=bfvv12wqHb+EXuA063WCqNNXTeITvw9on6qOX00e5htjCl44yofJTAPBGRGWpoEGiD
         v/lD6292XM3jiwFbviBp4BGRqYeM5gdaY6iS2w8+4bVK/+yIKH3h0vEaJ3U8f6cUYCYc
         cWabzA84uQ5aL7Bkf94TFwzZ/ly2GIri9BlSG4jRIXwqXh8yB/Fjr6N+qsKqn7JIkURt
         GcsyoKpfEC00+sLSzyX4YPvQ3vYxxYsUjyMTX+WuPVB7oG7giY9vbw1/yNmEH1Z/MSQ1
         uX6z3CbNZgGnGvOYh38M18F34g954IiqNUzhP0ul6o6O5hlXdszYTpEXxBF03eRYgy+v
         2pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pkOq70z0V2Mh6Wal5v9/f24QC4UGA2XeBsqevzSnW2s=;
        b=P0rxqustCBW6TEyMtDB6trMEp27q4vhjb4KqisV+t+HaoNEurV0ClagtGnScaSQEq/
         2KYIPV0J+/OSs4qI/rogedQArrRR3DTqpiFmxLKt1dAdZeWzZqUGruTk4imoqBVm4pdp
         FaBvlQetPBk1lbx6JhK3jID5vI6nKaE7acJEHu5Nf0Q3ZHhJNKoCi2+dDubVdt01ts8k
         Vtb3majibUJ4R+w+ZKc8Yc68KRS9pJqCxdnQr91uzMqrhk3A2bwRddbAGOv7MT1zzU8q
         iKCgOIcF1CY36Mqq6dI/1U0Kgr91YQ4MK8OHYiSH4XjypKSyWgUe8E6wvJG54gCqYvid
         GwBw==
X-Gm-Message-State: APjAAAUrzvj6+8HA6MymA9X2vDiCe14whhdVfZJklKK2oZp+0bvJztv/
        Iagw5sLbcK3IgsnJgbn8pcpPDQ==
X-Google-Smtp-Source: APXvYqy3M/AmvhF/hOAOsBV9tVKj08J24T+utPIe9Dzs+60S8tL52+uRG8iwftz7qS4NqDmCtrhqwA==
X-Received: by 2002:adf:e64c:: with SMTP id b12mr15663571wrn.112.1552397891218;
        Tue, 12 Mar 2019 06:38:11 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w12sm7725658wrt.97.2019.03.12.06.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:38:10 -0700 (PDT)
Date:   Tue, 12 Mar 2019 14:38:08 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        axboe@kernel.dk, b.zolnierkie@samsung.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Message-ID: <20190312133808.GA9336@Red>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
 <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
 <20190312104102.GA28302@Red>
 <20190312120623.46ca7286@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312120623.46ca7286@alans-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:06:23PM +0000, Alan Cox wrote:
> On Tue, 12 Mar 2019 11:41:02 +0100
> LABBE Corentin <clabbe@baylibre.com> wrote:
> 
> > On Mon, Dec 10, 2018 at 05:52:35PM +0300, Sergei Shtylyov wrote:
> > > Hello!
> > > 
> > > On 12/10/2018 04:46 PM, Corentin Labbe wrote:
> > >   
> > > > When playing with a virtual SPARC machine with qemu, I found that the
> > > > IDE emulated device was not probing with the ata/pata_oldpiix driver.  
> > > 
> > >    Correctly, it should probe with ata_piix,
> > >   
> > > > But with the old ide/piix, it was probed.> 
> > > > This is due to this PCI devid was not migrated from the old ide/piix.  
> > > 
> > >    It wasn't on purpose -- the IDE driver supports the original PIIX
> > > incorrectly.
> > >   
> > 
> > Hello
> > 
> > What about removing this old driver totally if it dont work ?
> 
> If the virtual Sparc emulator is using it does that also mean actual
> Sparc hardware has it. In which case presumably it needs fixing, or at
> least moving to the generic driver assuming the firmware sets it up ?
> 

The qemu works perfectly with the new Linux driver.
