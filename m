Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB59C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8EA206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556960440;
	bh=7HXqKzpxUiSs04dSG1RdKuXbafCjffLyeVJkF8NBEOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d0Y3LNlHkPuciWTVGncwajVv1VHEX3HkSVK+0dkZjucRGUPitc6iApWnhVjIn82F9
	 xq5DlvN7jZXkWp0zcDHrKbsgBqpTip8r1gX0KAbuTQlQ+9eT/JwIZ85fCCTye/Y7Tf
	 5qfqi0jeOy7Ft48gKtz3ozDXIwLiw9R7RjThLJKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfEDJA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 05:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfEDJA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 05:00:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD44206BB;
        Sat,  4 May 2019 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556960428;
        bh=7HXqKzpxUiSs04dSG1RdKuXbafCjffLyeVJkF8NBEOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=puUuzFkkzwwSmbdSjWHix07/cvUiyDGyk0+FIz9i4YcJ7oA6H7JhGuDTt7y30D2zN
         eCdZKfgo7WOKsnlgmcJ93LF816InzU+PNYuJpGhQOM+HiUwVpwCiZstZvYR2idVS9/
         YWJc88yVVZkIVYsvxgD8/JipbwxoZNuKsOaMrxW0=
Date:   Sat, 4 May 2019 11:00:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: Re: [PATCH V3 07/12] misc: xilinx_sdfec: Add ability to configure
 LDPC
Message-ID: <20190504090025.GB13840@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-8-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172713.GD1874@kroah.com>
 <BL0PR02MB5681D386363988CB2CA4D040CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB5681D386363988CB2CA4D040CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 04:49:19PM +0000, Dragan Cvetic wrote:
> Hi Greg,
> 
> Please find inline comments below.

As they should be, no need to mention it :)

> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Thursday 2 May 2019 18:27
> > To: Dragan Cvetic <draganc@xilinx.com>
> > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > Subject: Re: [PATCH V3 07/12] misc: xilinx_sdfec: Add ability to configure LDPC
> > 
> > On Sat, Apr 27, 2019 at 11:05:01PM +0100, Dragan Cvetic wrote:
> > > --- a/include/uapi/misc/xilinx_sdfec.h
> > > +++ b/include/uapi/misc/xilinx_sdfec.h
> > 
> > <snip>
> > 
> > > +/**
> > > + * xsdfec_calculate_shared_ldpc_table_entry_size - Calculates shared code
> > > + * table sizes.
> > > + * @ldpc: Pointer to the LPDC Code Parameters
> > > + * @table_sizes: Pointer to structure containing the calculated table sizes
> > > + *
> > > + * Calculates the size of shared LDPC code tables used for a specified LPDC code
> > > + * parameters.
> > > + */
> > > +inline void
> > > +xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
> > > +	struct xsdfec_ldpc_param_table_sizes *table_sizes)
> > > +{
> > > +	/* Calculate the sc_size in 32 bit words */
> > > +	table_sizes->sc_size = (ldpc->nlayers + 3) >> 2;
> > > +	/* Calculate the la_size in 256 bit words */
> > > +	table_sizes->la_size = ((ldpc->nlayers << 2) + 15) >> 4;
> > > +	/* Calculate the qc_size in 256 bit words */
> > > +	table_sizes->qc_size = ((ldpc->nqc << 2) + 15) >> 4;
> > > +}
> > 
> > Why do you have an inline function in a user api .h file?  That's really
> > not a good idea.
> 
> This is just a Helper function for users aligning the calculations.
> Please advise, is this acceptable?

Not really, just have actual api functions in a uapi .h file, why would
userspace care about this type of thing?

thanks,

greg k-h
