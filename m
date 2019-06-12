Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD21DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9D2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="yII/WyQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437957AbfFLKHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:07:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39460 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405946AbfFLKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:07:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so11613934lfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=InU/Lj35akDd3Wyfc3JTPKg/OWStN5q+3o8HMF9TC+c=;
        b=yII/WyQSRic/HvbG9WcCZmWLNXAli/YN11WteFhUHe4F+lvc7tMwvc+WrOKQpnhVWn
         SeIIQneJc5ik97bsE5DUfwdCY+VHYnvDPlZ5DjINgdwcd7Ew2HvIw/TFURFv45aalmwK
         GCr9lmJY/s8EKRx6Hca0pEu4bFZumPyZq2mhGn1cQ4vlizwDOr40LKIbYq++A3yyN4Ys
         BXJYGjLttISSsgzBbO0BWNe1LJto5hh49Oanf3DYdwJ1nzwj+ZNZOhForjDZ+419WFE3
         CZqVze8DrTJDRrGR9NxXsL3g7gSNEXigZTJrrtXKmHiDp6amyHeD/fyLGymIYeUOsjvI
         9Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=InU/Lj35akDd3Wyfc3JTPKg/OWStN5q+3o8HMF9TC+c=;
        b=uWgFHKxd1sOyXRK7Jj9SNGK+zcvCVReifU/WMozFmENjGzk3aqlGsC3icOXLcoEXtg
         cBxe7/0pYKpc5G03KK8sZHOiXs37wunXl8UxQg3oLham0TG65VnCHEm3WgG9qhqm3kLR
         J8K1B6t8HTgplIml/MinSINjJTO80awtUX3MF1u0Rc0MPjt9DEjF0/Lg5jiB7UHRizMO
         ItVfTBiEp7H+XeQapkr9LffnYxOhEYkvZZTLq9OT0FoKBKVPRWHU3i4hHpissLLDn9c+
         CC3rR+hNZkTDvHftPW6EuVVVO/zsRSLqCacBZIHowmt5YdbYtGShCeotnQuXUqBfKxLk
         39CA==
X-Gm-Message-State: APjAAAX2taI/uDpQQWO4vbl6sZuPz6LTLSzdX55UgVqjEYpcri8Ce/VB
        i9MKwVBiRhbgJ02vGX44eRAIWA==
X-Google-Smtp-Source: APXvYqyklnno8AkiHQfR3VreFWXsSlFhmRPu73QFtpxa+Tw32wsXBxOAfwd1RtQW9gpoMuktAgGUbA==
X-Received: by 2002:ac2:5225:: with SMTP id i5mr30644019lfl.157.1560334072156;
        Wed, 12 Jun 2019 03:07:52 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id v12sm2181698lje.14.2019.06.12.03.07.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:07:51 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:07:49 +0200
From:   Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: kpc2000: remove unnecessary comments in
 kp2000_pcie_probe
Message-ID: <20190612100749.srpsz5er4ebwepls@dev.nikanor.nu>
References: <20190610200535.31820-1-simon@nikanor.nu>
 <20190610200535.31820-3-simon@nikanor.nu>
 <20190612073936.GD1915@kadam>
 <20190612074600.GA17100@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612074600.GA17100@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06, Greg KH wrote:
> On Wed, Jun 12, 2019 at 10:39:36AM +0300, Dan Carpenter wrote:
> > On Mon, Jun 10, 2019 at 10:05:35PM +0200, Simon Sandström wrote:
> > > @@ -349,9 +340,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
> > >  		goto err_remove_ida;
> > >  	}
> > >  
> > > -	/*
> > > -	 * Step 4: Setup the Register BAR
> > > -	 */
> > > +	// Setup the Register BAR
> > 
> > Greg, are we moving the C++ style comments?  Linus is fine with them.  I
> > don't like them but whatever...
> 
> I don't like them either.  I'm only "ok" with them on the very first
> line of the file.  Linus chose // to make it "stand out" from the normal
> flow of the file, which is fine for an SPDX line.  So putting these in
> here like this is not ok to me.
> 
> thanks,
> 
> greg k-h

I changed them to C++ style so that they would match the other comments
in the file, which are C++ style, but I guess that it should have been
done the other way around with the C++ style changed to C style.

Good to know. I'll change them back and send a v2.

- Simon
