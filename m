Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8558BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BA6206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D4O/PX7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfCLKlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:41:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54107 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCLKlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:41:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so2057255wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2HFQV2y8hskAx25njtTZlnSgLWBuB/+pMIlMUpHEdxE=;
        b=D4O/PX7tKBm1JomFHZG4wVbtczKMWRtbjO0/pf3PLZcHEZjqjs0dPm4+dRddLtOZQC
         lfhv609b/mVtU8HEjoZ6pwy4QskayPNuuHvnQjN1buBdiuaGAW8jI1FmE/V6jQSMAFJe
         DDiwzYy4ilFjHQ6PAbZ3v6y9DxkXYStpRoD/Cc0sZUCCWwcCLflTjrx7oOMYwkRREFBP
         rH2vL5ke5vXbJg0iu16toDEFdpwy4yYIc1C98OXrQXeKcHWBjbrR40pHlUzzmOPQvWqn
         x3q//Pg9WyLaeRFX7pID98KwMGY6evdcAgDn4Lg43/Q0drKbInARP+hWGzlBAXDf/oCm
         kieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2HFQV2y8hskAx25njtTZlnSgLWBuB/+pMIlMUpHEdxE=;
        b=b7hGMRlbEp3OFeBsC4l9G1Yh2GiS0pjp7cnYAZhHQoQJ9Z0QHCgjs5/Cbt0cEma3SZ
         B9GZ9x5pq9BePBovqVqzBHc+0k57hocAZ1UR4UNwmwLuPSh3jcGeqqK3PLYM0kmITvx3
         c9QCYwKR6k01iTDNST95JoQ2G0tAiwDbUd0N1boTON39ZfzDDv9wQEO+ss2wqeTuxKBX
         64nPn0tMnAB9Mw94DJVtjj424vHrYiq8lesfFCpSvbOkefFlGjM8WDtEpDQuZss5mSD7
         ZwWFH/rFbML0cF6aEG353x2eu5LW2zSxzf0ENZSWHM0oQvnTE+lAlIqbtleo1+xSyhGP
         H7sQ==
X-Gm-Message-State: APjAAAWulGR0DhTLP6PNtK39Fm4PC0AXcjttrhJaCUbJBQOsJaWXERCE
        8teYb74UUBmsSSOHMZQGwMfTng==
X-Google-Smtp-Source: APXvYqzly4TMxeNNywfTTxuG4sdpQlAn07jyd9PtWBXskc9KrO2ZXFQ56IcdRQrbdSH95cC5u4r/rw==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr1912080wmg.101.1552387266112;
        Tue, 12 Mar 2019 03:41:06 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id o30sm12517078wro.57.2019.03.12.03.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 03:41:05 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:41:02 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     axboe@kernel.dk, b.zolnierkie@samsung.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Message-ID: <20190312104102.GA28302@Red>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
 <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:52:35PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 12/10/2018 04:46 PM, Corentin Labbe wrote:
> 
> > When playing with a virtual SPARC machine with qemu, I found that the
> > IDE emulated device was not probing with the ata/pata_oldpiix driver.
> 
>    Correctly, it should probe with ata_piix,
> 
> > But with the old ide/piix, it was probed.> 
> > This is due to this PCI devid was not migrated from the old ide/piix.
> 
>    It wasn't on purpose -- the IDE driver supports the original PIIX
> incorrectly.
> 

Hello

What about removing this old driver totally if it dont work ?

Regards
