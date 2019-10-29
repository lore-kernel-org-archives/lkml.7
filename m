Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEFFCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962BC21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nr6YRwwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfJ2Mnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:43:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45062 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfJ2Mnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:43:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id x21so2711415qto.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TXsJHSoo6XYJ6cmw4QLnIObYGsRpmUKQyLd9uZ7wkHU=;
        b=Nr6YRwwQAv3WVwHvATui1+4gY5n5S8nFygstH9Q5D323z59Z3JruQgQ+HRdrMgI4bs
         G9qKb6cS8Khxj3VGfjZrw0zyCwF5dQ3Ytbl1NTMkcA+56R+CfpSWTDLl1h/xpZMB33GF
         cVwbZV3NkKw4AlZluIZhIG2PqkyOfPlmy0fIMbx7v0tM9ox3J/QoNKx+SiDOJ9rXbAKa
         y1GY3OWy+G6pBoKm8pP9t+uGMCVVpbafIaeCvjF4fr4r8Tp8eTsYdVyBOel4nH88BmXX
         RYUwlar+4f7BEBpzq1gFW7G1RSWX23DaGgBd2pL1u1DkwlERb+REM2UTFsN4HlOHfG57
         wm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXsJHSoo6XYJ6cmw4QLnIObYGsRpmUKQyLd9uZ7wkHU=;
        b=ms+3TN8IBpsEERcQCpaqEP9ROp4zieoUpf0lhp3XXwHEU5kZUP6XsZpxmdIW86ghOt
         bjQZLOTEepY4kde3+0lBdybs7T3hn5hHaLh0YDOasQvLYcuhmE5jskMaHix5eNQe5d/b
         IXlv3oC6xgYmJm4wq3jFnCaC0PdpQGIbEXrHl+WNkdCkp91BGaHjRL+5E+KjsQTNNl1a
         dDYGol9p+E8GXhksXq6WS0iKgGwpzz890bRLMClGLzmpq8cMc9+d+swBH+Hx7Ioro9bI
         ANfzI52+Pmq+hyeJRHQ9rI3RyhG+dABf1e1OYmrRE0AX6JbOsFVkuEN0zxE66S9wZasP
         9nCw==
X-Gm-Message-State: APjAAAWV/Zr6jUfePAXL8Wy+iS8lb+JBd0ZXQkfpsgfRPM9l2Gm6BU5D
        vH3cTKw4s5MZIvTrJbDlqB+Xkw==
X-Google-Smtp-Source: APXvYqxhLDu2NJgtfVpKNZoOd8Py5ETo03oMHFBh2QF1rLrNBcF8YR0Vgy/whPMeWBNCa2VLR1BbWA==
X-Received: by 2002:aed:3baf:: with SMTP id r44mr3939570qte.255.1572353023797;
        Tue, 29 Oct 2019 05:43:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id y28sm7329951qky.25.2019.10.29.05.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 05:43:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPQqc-0004sy-GP; Tue, 29 Oct 2019 09:43:42 -0300
Date:   Tue, 29 Oct 2019 09:43:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191029124342.GB6128@ziepe.ca>
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
 <20191028210507.7i6d6b5olw72shm3@cantor>
 <20191029091731.GC9896@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029091731.GC9896@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:17:31AM +0200, Jarkko Sakkinen wrote:
> On Mon, Oct 28, 2019 at 02:05:07PM -0700, Jerry Snitselaar wrote:
> > On Mon Oct 28 19, Jarkko Sakkinen wrote:
> > > On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar wrote:
> > > > +	return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
> > > > +		       ? "2.0" : "1.2");
> > > 
> > > This is not right. Should be either "1" or "2".
> > > 
> > > /Jarkko
> > 
> > Okay I will fix that up. Do we have a final decision on the file name,
> > major_version versus version_major?
> 
> Well, I don't see how major_version would make any sense. It is
> not as future proof as version_major. Still waiting for Jason's
> feedback for this.

$ find /sys/ -name  "*version*"
/sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/ahci_host_version
/sys/devices/virtual/net/docker0/bridge/multicast_mld_version
/sys/devices/virtual/net/docker0/bridge/multicast_igmp_version
/sys/firmware/efi/esrt/entries/entry0/lowest_supported_fw_version
/sys/firmware/efi/esrt/entries/entry0/last_attempt_version
/sys/firmware/efi/esrt/entries/entry0/fw_version
/sys/module/acpi/parameters/acpica_version

etc..

Not a single example of the backward version.

Most likely it should be called 'tpm_version'

Jason
