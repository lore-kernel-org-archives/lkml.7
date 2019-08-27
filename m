Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF479C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC5B2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codon.org.uk header.i=@codon.org.uk header.b="i4yWR/AG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfH0RtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:49:02 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:38406 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfH0Rs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:48:58 -0400
X-Greylist: delayed 2265 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 13:48:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lLYloM0Ywjig+ulU3rxirWB2hunInBTjYfHlRq1yag0=; b=i4yWR/AGXeNk0efti4p+I0xxR
        He1mnoWyZPL4x55cesht2sxmTyNiXHwOuyL7xB8q7GvUg6p1hZTfzm6vrlxwxsP1almCB6XTL6qQX
        mNAr7uZ6CkFnOz2D9Rv+/voSIbzTRnLqlT1cD7Ggd9yTJu/17YA07WnjiesVVv023Nins=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1i2ezq-00079w-HA; Tue, 27 Aug 2019 18:11:06 +0100
Date:   Tue, 27 Aug 2019 18:11:06 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
Message-ID: <20190827171106.owkvt6slwwg5ypyl@srcf.ucam.org>
References: <20190826081752.57258-1-kkamagui@gmail.com>
 <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
 <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
 <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:36:30AM +0900, Seunghun Han wrote:

> I got your point. Is there any problem if some regions which don't
> need to be handled in NVS area are saved and restored? If there is a
> problem, how about adding code for ignoring the regions in NVS area to
> the nvs.c file like Jarkko said? If we add the code, we can save and
> restore NVS area without driver's interaction.

The only thing that knows which regions should be skipped by the NVS 
driver is the hardware specific driver, so the TPM driver needs to ask 
the NVS driver to ignore that region and grant control to the TPM 
driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
