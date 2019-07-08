Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB33C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA6B205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JeKYvjEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfGHWxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:53:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37436 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfGHWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:53:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so14626772qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0m3NEjwvz2dxO9bQhFlPhZbVrX0uYb3It/HKmn2RbMY=;
        b=JeKYvjEHv0d4lyie/kiBQRbHspieZhhHk1xlxebuNCuhUGu2Ujj2J5Hn94dfSTuN5U
         ib5PxKy6G0Fdrb8Kf9ZgN46yBcwla5TU9ZmG2/D+e81sTwZio+uWzaJAYYn6t99E6fno
         HZfkywo1Z3Y+s5YbXpcAAhsdJMHg7y81D9tjheXnlxscc6Y0jHCY1EmbsmteXyTI+F0g
         vZaVU90UeK6qQBW4YH523XTj9x4L3JVIFaq9mSiXf478G+zEYS7E6QoXBHxc8xOLnQh+
         s6UjLSgZgRdsU1nZlZA9ZjPbJAueUs8VveDaz+i6ViBZwsNp9BacpUNiDce5RoXVLNln
         V29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0m3NEjwvz2dxO9bQhFlPhZbVrX0uYb3It/HKmn2RbMY=;
        b=W/qxR+v1VPMzsfhKxYEGWCIvUxcg3sa9yH4SZvXpxeMCmnBUtjyjT7YUSr+wutvDfk
         CR0XIGs4MfFJaXDCTKi7O+K0RSQaL5ejnk+7UFZhu3t5lbgrhCWgaZqz/qVEtVM/N3qK
         tpqPdkFuHOve89MNAtCoG84rs5gS1mjty9k1Y6LcOZ/1SAo6Vz1woqXFpiFYiiW1FEnX
         id4sHIwvGUlMy5kglfNOGmlIUeQ8lh5hYLoyFHD0bZIAEsWnLKWd4Rg5HM1ZybdL8G7q
         zULEGNIXS3I63GtpYgeZKtY1F/m2FmRuhG5MrNC/9pj6kseIrU4ej591rRZu97+TsHZE
         hLjw==
X-Gm-Message-State: APjAAAUQa5V727PZKn8fN4kDQ8MMvcLth/Ea3H8xRGbyyeGwg4gPqbcV
        ErjsNGDgXbKoObVz+2mI4rhP/A==
X-Google-Smtp-Source: APXvYqyFDUHN3AlkoWFUd96BfJL00iwdanUkLj+AoJmRBkQWg8dkdiXjQmnE8o1TBO3LPzxpRgT1Kw==
X-Received: by 2002:a37:4a04:: with SMTP id x4mr16546587qka.408.1562626404157;
        Mon, 08 Jul 2019 15:53:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n18sm7889774qtr.28.2019.07.08.15.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 15:53:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkcVf-000384-Ac; Mon, 08 Jul 2019 19:53:23 -0300
Date:   Mon, 8 Jul 2019 19:53:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] tpm: tpm_ibm_vtpm: Fix unallocated banks
Message-ID: <20190708225323.GG23996@ziepe.ca>
References: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
 <586c629b6d3c718f0c1585d77fe175fe007b27b1.camel@linux.intel.com>
 <1562624644.11461.66.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562624644.11461.66.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 06:24:04PM -0400, Mimi Zohar wrote:
> Hi Jarkko,
> 
> On Mon, 2019-07-08 at 18:11 +0300, Jarkko Sakkinen wrote:
> > On Sat, 2019-07-06 at 20:18 -0400, Nayna Jain wrote:
> > > +/*
> > > + * tpm_get_pcr_allocation() - initialize the chip allocated banks for PCRs
> > > + * @chip: TPM chip to use.
> > > + */
> > > +static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> > > +{
> > > +	int rc;
> > > +
> > > +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > > +		rc = tpm2_get_pcr_allocation(chip);
> > > +	else
> > > +		rc = tpm1_get_pcr_allocation(chip);
> > > +
> > > +	return rc;
> > > +}
> > 
> > It is just a trivial static function, which means that kdoc comment is
> > not required and neither it is useful. Please remove that. I would
> > rewrite the function like:
> > 
> > static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> > {
> > 	int rc;
> > 
> > 	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> >      	     tpm2_get_pcr_allocation(chip) :
> >      	     tpm1_get_pcr_allocation(chip);
> 
> > 
> > 	return rc > 0 ? -ENODEV : rc;
> > }
> > 
> > This addresses the issue that Stefan also pointed out. You have to
> > deal with the TPM error codes.
> 
> Hm, in the past I was told by Christoph not to use the ternary
> operator.  Have things changed?  Other than removing the comment, the
> only other difference is the return.

I also dislike most use of ternary expressions..

Also, it is not so nice that TPM error codes and errno are multiplexed
on the same 'int' type - very hard to get this right. I'm not sure
anything actually needs the tpm error, and if it does maybe we should
be mapping those special cases to errno instead.

Jason
