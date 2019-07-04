Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73546C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483BB21721
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 17:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cck1/oH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfGDRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 13:24:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43999 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfGDRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 13:24:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so3346524plb.10;
        Thu, 04 Jul 2019 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=55QfSNtbMpn+MJxisNfI6ew+wl/zossrT+kRgSB+uK8=;
        b=cck1/oH35+TwFzlHwtp8kI9dhL7sa7e0x16TEOFTU8wG1hlmZ2SNQqOFWQuLhrWd8v
         LULq0Oy78tMkxMBHSeWbuTcylNGO8i2mnHtZIzMGQwp2RrTpnfdSwJWH33HLce1OKxaJ
         A+X+OO2r6yE58l9QVLe+DiuIESi77WQqLr5Nx3hvq68OSoKTPzSHUo2HhvzkxpVMBkvi
         DN4yrrmMaCqWsabjAUZyIJ3kN0WlzYtXbthr2DateTQv1FlyNcy4yWtGfDceoBslsGQ7
         ljvxpI5gGdlH+wAe7TDhDDdmWvQPnV9beCqTq52z+2MYQJHZgoE+6jQ4d6jxTOF7NpZC
         YJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=55QfSNtbMpn+MJxisNfI6ew+wl/zossrT+kRgSB+uK8=;
        b=MrFY2hUvkU8tjruhOJxfiTbdDYn7t902UL8pNlFZK5fRH4QBcJgSER3zJNKLrSA0KL
         /yR0zEC4gHE2D1oYKEookK3hEKzpHTN2uqglGudADCk1hdDLVWmG3pVAjuzYqFZ10Z7g
         E6G6JHZkkLTlGwqOd2uCc4qVcCcwqX/B8COsZe1O/JRjgLJW2Ho5KUVNxdXc/lXIGcob
         ZNSIltj+pBkRBBedcVUTxvKsXr7/OE3K/vPf6W5wijJmaQ9McKII7fgajCYHiOd/OYR5
         w03yvHXu1OyJd2WOtBIXm8GBKr4RIaZyjKyWdhLo8DAB/IthIaxBrNkZIamjbQPQZG1R
         YLDA==
X-Gm-Message-State: APjAAAXpRLgWxc8rmpav1sAi1OLFll796U+OYYMN0G+3NRa0pzzMW6vf
        DzWwGSIZ6RnOdLqHly5KZuE=
X-Google-Smtp-Source: APXvYqw070wr57pOgxmvfwOzrmdszFf8Ygs+RZ20bau1tLRpA0P9ugWeweLchEeESdNY9W2e8U3xQA==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr48065179pla.50.1562261083171;
        Thu, 04 Jul 2019 10:24:43 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id s20sm6739366pfe.169.2019.07.04.10.24.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 10:24:42 -0700 (PDT)
Date:   Fri, 5 Jul 2019 02:24:37 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usbip: Implement SG support to vhci
Message-ID: <20190704172435.GA11673@localhost.localdomain>
References: <20190624145852.GC7547@localhost.localdomain>
 <Pine.LNX.4.44L0.1906241322140.1609-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906241322140.1609-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 01:24:15PM -0400, Alan Stern wrote:
> On Mon, 24 Jun 2019, Suwan Kim wrote:
> 
> > > > +	hcd->self.sg_tablesize = ~0;
> > > > +	hcd->self.no_sg_constraint = 1;
> > > 
> > > You probably shouldn't do this, for two reasons.  First, sg_tablesize
> > > of the server's HCD may be smaller than ~0.  If the client's value is
> > > larger than the server's, a transfer could be accepted on the client
> > > but then fail on the server because the SG list was too big.
> 
> On the other hand, I don't know of any examples where an HCD has 
> sg_tablesize set to anything other than 0 or ~0.  vhci-hcd might end up 
> being the only one.
> 
> > > Also, you may want to restrict the size of SG transfers even further,
> > > so that you don't have to allocate a tremendous amount of memory all at
> > > once on the server.  An SG transfer can be quite large.  I don't know 
> > > what a reasonable limit would be -- 16 perhaps?
> > 
> > Is there any reason why you think that 16 is ok? Or Can I set this
> > value as the smallest value of all HC? I think that sg_tablesize
> > cannot be a variable value because vhci interacts with different
> > machines and all machines has different sg_tablesize value.
> 
> I didn't have any good reason for picking 16.  Using the smallest value 
> of all the HCDs seems like a good idea.

I also have not seen an HCD with a value other than ~0 or 0 except for
whci which uses 2048, but is not 2048 the maximum value of sg_tablesize?
If so, ~0 is the minimum value of sg_tablesize that supports SG. Then
can vhci use ~0 if we don't consider memory pressure of the server?

If all of the HCDs supporting SG have ~0 as sg_tablesize value, I
think that whether we use an HCD locally or remotely, the degree of
memory pressure is same in both local and remote usage.

Regards

Suwan Kim
