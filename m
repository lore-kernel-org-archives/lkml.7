Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC5C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA6B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="v6DWPkD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEUXQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:16:00 -0400
Received: from ozlabs.org ([203.11.71.1]:56745 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfEUXQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:16:00 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 457s7x3n3fz9sBV; Wed, 22 May 2019 09:15:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1558480557; bh=EcL5jNMwirXTp1nwjLDv8azqx1af2nZDnWeeqODaWl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6DWPkD5rk7OkfCPQ49WmTUhjcF2pXpXnUrZJUWrYhes3yM7IQ52M3VzX4qFS5OS1
         ZLXtu3eTdfgvc5SRKiQEs4sFrzRizQg+Qhx03pOJfaxieNKjuocfy+7fsSbXrEuVbI
         ndHDx1830swdI81Tpp1TR4NaPYsFMu4/hM/C4MSsbI9ftiMyBrjJXQoadH96F4BeTB
         VriDTasIUIp6n14H05L2JNHNYBYj4wi+mq13YJ0avuuAvPw1OeU7HuwNs3C4iWhzaa
         mqmgipgEwEJFSYPyfUjwqceWTuTVHBUhSaVv59RXGsH0hSMA996B8k5Sl6r59r71de
         SRXEa4pymY3CA==
Date:   Wed, 22 May 2019 09:15:54 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [RFC PATCH 02/12] powerpc: Add support for adding an ESM blob to
 the zImage wrapper
Message-ID: <20190521231554.GB3874@blackberry>
References: <20190521044912.1375-1-bauerman@linux.ibm.com>
 <20190521044912.1375-3-bauerman@linux.ibm.com>
 <20190521051326.GC29120@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521051326.GC29120@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 07:13:26AM +0200, Christoph Hellwig wrote:
> On Tue, May 21, 2019 at 01:49:02AM -0300, Thiago Jung Bauermann wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > For secure VMs, the signing tool will create a ticket called the "ESM blob"
> > for the Enter Secure Mode ultravisor call with the signatures of the kernel
> > and initrd among other things.
> > 
> > This adds support to the wrapper script for adding that blob via the "-e"
> > option to the zImage.pseries.
> > 
> > It also adds code to the zImage wrapper itself to retrieve and if necessary
> > relocate the blob, and pass its address to Linux via the device-tree, to be
> > later consumed by prom_init.
> 
> Where does the "BLOB" come from?  How is it licensed and how can we
> satisfy the GPL with it?

The blob is data, not code, and it will be created by a tool that will
be open source.  My understanding is that most of it will be encrypted
with a session key that is encrypted with the secret key of the
ultravisor.  Ram Pai's KVM Forum talk last year explained how this
works.

Paul.
