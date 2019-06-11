Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BC62089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560247142;
	bh=6Bh7Pmi1wYitq3SDdcV/dHDabKgX0W7RapgIq/UJbaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=olKFmP+OCWHpMAd18dk1ZIkNwWNuEO//NLBbg0e8EzS0hyCkHkVOLGM66FDKoyk6g
	 Dfd7edi1InRQof5U0eTxQE/lQ2DMkYfLKcj8LLyIL72e4ILmUHXos2Bqm4MgtiZL0R
	 bX9r2YRBZ1J5krR9VBrhN0s9w78eUzz0f03gnu9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404989AbfFKJ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404084AbfFKJ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:59:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBB622086A;
        Tue, 11 Jun 2019 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560247140;
        bh=6Bh7Pmi1wYitq3SDdcV/dHDabKgX0W7RapgIq/UJbaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfXp/WzAc8D34BhjNGsEauGsum4V3I1uK5WfFCoJr4MRoPRvU+evwC5Dy7wJhwYET
         UAeS85B5df/3fkusbdohttsvD+U+4aTbPftkBW1wrLA7oB330vK0SVkSolZno1Dk9y
         ItVhiph4ZnnetzLuUsbu5bh/fPuFniC1ASjIRpVQ=
Date:   Tue, 11 Jun 2019 11:58:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190611095857.GB24058@kroah.com>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611092144.11194-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 12:21:44PM +0300, Oded Gabbay wrote:
> +bool hl_pci_parent_is_phb4(struct hl_device *hdev)
> +{
> +	struct pci_dev *parent_port = hdev->pdev->bus->self;
> +
> +	if ((parent_port->vendor == PCI_VENDOR_ID_IBM) &&
> +			(parent_port->device == PCI_DEVICE_ID_IBM_PHB4)) {
> +		hdev->power9_64bit_dma_enable = 1;
> +		return true;
> +	}
> +
> +	hdev->power9_64bit_dma_enable = 0;
> +	return false;
> +}

That feels like a big hack.  ppc doesn't have any "what arch am I
running on?" runtime call?  Did you ask on the ppc64 mailing list?  I'm
ok to take this for now, but odds are you need a better fix for this
sometime...

thanks,

greg k-h
