Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D781C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611D6207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575916603;
	bh=hhbUlAid62Nmj6QnboRKYMrqoC20ui0184h6mt7BBVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=v/oz7jXylrEcuiMoaFC0B9qzcPact6AGmbrH7htq6Gy9BJAFwWMBuufHf3iQfRKE6
	 7345IQL6SX8bo8GbfiYDKkgAL1MHDMkklbmERdWYCPLCRCMGzc4V6azKphvM5iiEm3
	 zC7uIFr7y+m6dEhQraINdCL46qCy+m3YhaoO7XOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLISgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:36:42 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:33655 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfLISgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:36:42 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ieNtd-0005gq-O4; Mon, 09 Dec 2019 19:36:37 +0100
Date:   Mon, 9 Dec 2019 18:36:36 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Add iProc IDM device support
Message-ID: <20191209183636.6d708bfd@why>
In-Reply-To: <bd90ba80-9aac-e406-9066-64e975e5b10b@broadcom.com>
References: <20191202233127.31160-1-ray.jui@broadcom.com>
        <20191207173914.353f768d@why>
        <bd90ba80-9aac-e406-9066-64e975e5b10b@broadcom.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ray.jui@broadcom.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rayagonda.kokatanur@broadcom.com, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 10:02:53 -0800
Ray Jui <ray.jui@broadcom.com> wrote:

> On 12/7/19 9:39 AM, Marc Zyngier wrote:
> > On Mon,  2 Dec 2019 15:31:25 -0800
> > Ray Jui <ray.jui@broadcom.com> wrote:
> >   
> >> The Broadcom iProc IDM device allows control and monitoring of ASIC internal
> >> bus transactions. Most importantly, it can be configured to detect bus
> >> transaction timeout. In such case, critical information such as transaction
> >> address that caused the error, bus master ID of the transaction that caused
> >> the error, and etc., are made available from the IDM device.  
> > 
> > This seems to have many of the features of an EDAC device reporting
> > uncorrectable errors.
> > 
> > Is there any reason why it is not implemented as such?
> > 
> > Thanks,
> > 
> > 	M.
> >   
> 
> I thought EDAC errors (in fact, in our case, that's fatal rather than
> uncorrectable) are mostly for DDR. Is my understanding incorrect?

No, they are for HW errors in general. There is no real limitation of
scope, as far as I understand. Recently, the Annapurna guys came up
with a similar HW block, and were convinced to make it an EDAC device.

See [1] for details.

Thanks,

	M.

[1] https://lore.kernel.org/linux-devicetree/1570707681-865-1-git-send-email-talel@amazon.com/
-- 
Jazz is not dead. It just smells funny...
