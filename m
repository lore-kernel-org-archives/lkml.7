Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B7BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51002148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TNCp7lyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfDXGCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:02:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfDXGCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X3h64l/wY0EE4rZccIp76Io2Tn8JB+21FPtnVxtmP2g=; b=TNCp7lyNV3qKsrfkkabg3FMsI
        hh2bl6pgG93CzJhpPNs0hQ47OFZbmkBjzrsYlRAkiYSzodRYjGH0T4PAbSGz2SBvhkZjR/7gBHkLp
        lVINV25Q6NX7yhcZQpV7RaWkw+PcHp5O8oHTuP+sFBuWGaqKFdtlzy3Mt3ZMAI0VKpk0Bp1quygQx
        mvwkbrcAaUP6FNTt/TDZW0ydimlk1tHWZy2Qwfn2MXnkg6CzZyCS2197ZOXAgfAQlaU75ekTBc2Gt
        EfvJw/JnKZuwVYsndMXgh6H5O+C7ch4x0613v13xM2rjRdnqM2Np5DNe798P9BryAli4KEzzc8ql2
        3SMAUZGzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJAyy-0004tV-Hu; Wed, 24 Apr 2019 06:02:12 +0000
Date:   Tue, 23 Apr 2019 23:02:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fdomain: Resurrect driver (core)
Message-ID: <20190424060212.GA5506@infradead.org>
References: <20190422173323.15365-1-linux@zary.sk>
 <20190422173323.15365-2-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422173323.15365-2-linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* FIFO_COUNT: The host adapter has an 8K cache (host adapters based on the
> + * 18C30 chip have a 2k cache).  When this many 512 byte blocks are filled by
> + * the SCSI device, an interrupt will be raised.  Therefore, this could be as
> + * low as 0, or as high as 16.  Note, however, that values which are too high
> + * or too low seem to prevent any interrupts from occurring, and thereby lock
> + * up the machine.
> + */

Normally we use

/*
 * ...
 */

style comments.  I'm not sure it is worth bothering to change it in this
driver, though.

> +		cmd->SCp.ptr += len;
> +		cmd->SCp.this_residual -= len;
> +		if (!cmd->SCp.this_residual && cmd->SCp.buffers_residual) {
> +			--cmd->SCp.buffers_residual;
> +			++cmd->SCp.buffer;
> +			cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);

This isn't safe on highmem systems.  At very least we need a depends on
!HIGHMEM for the drivers selecting this core driver.  If you feel like
doing the work it should use scsi_kmap_atomic_sg and
scsi_kunmap_atomic_sg.

> +static void fdomain_work(struct work_struct *work)
> +{
> +	struct fdomain *fd = container_of(work, struct fdomain, work);
> +	struct Scsi_Host *sh = container_of((void *)fd, struct Scsi_Host,
> +					    hostdata);

This looks odd.  We should never need a void cast for container_of.

> +	/* Abort calls fdomain_finish_cmd, so we do nothing here. */
> +	if (cmd->SCp.phase & aborted)
> +		;

This is a no-op..

> +	if (fd->chip == tmc1800 && !cmd->SCp.have_data_in
> +	    && (cmd->SCp.sent_command >= cmd->cmd_len)) {

&& goes on the first line, no need for the inner braces on the second
line.

> +int fdomain_host_reset(struct scsi_cmnd *cmd)

Should be static.

> +struct scsi_host_template fdomain_template = {

Should be marked const.

> +	if (fdomain_test_loopback(base))
> +		return NULL;
> +
> +	if (!irq) {
> +		if (dev_is_pci(dev)) {
> +			dev_err(dev, "PCI card has no IRQ assigned");
> +			return NULL;
> +		}
> +		irq = irqs[(inb(base + Configuration1) & 0x0e) >> 1];

The irqs lookup should probably go into the callers that need it.

> +	else if (sig && (sig->bios_major > 0) &&

No need for the inner braces.

> +EXPORT_SYMBOL(fdomain_create);

EXPORT_SYMBOL_GPL for internals like this and fdomain_destroy.
