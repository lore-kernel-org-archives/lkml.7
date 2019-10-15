Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE550ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24422084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D4ShOz3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfJOREy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:04:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45333 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfJOREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:04:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so12853106pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqEuhvlTqp14S8mH0iL/2lPaSLcfm7VaqiIgGEqKWMk=;
        b=D4ShOz3TQih7NmaeEtKqlb0TSvP7KSMCGM5nw1Meu4R/O3TiGC5gvdoT71EV93zC00
         o3P+2MuiEwb0x991JYgWp8RdsnPrBq2eyzFNkZDCqtcKJGPHCCnvf1W4QrN3VlTGqVij
         zRnQqqWnEEhxFpafxdGrn/uS+QEnde8vqvC29bWx5046vcTH9kQMcaZetBfWiLZkgUN8
         hjnNumZcvEZx1UUhlUQZRyKKjXyIKIV7KPwAirH1UN6EHwD6GCbdBelziTqbqa4CSk17
         wk9w51KIJ5QnnvrCOdhBE3ZGCWGrQSqbFk5WguDuNE5KJN3rwt7Xu/CYbFfh28G9P7bq
         JqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqEuhvlTqp14S8mH0iL/2lPaSLcfm7VaqiIgGEqKWMk=;
        b=o+ajFR1xPTrLW56iGd75e6SAm3KN0OFeLviFyUab0AsdUxxsT1vVaJVWXlNCaUIuyL
         7FNehtju0tYlZHm8PKswj4t/W6vM7EPsERkAatTKwNigOOirPxEb47GOaSdHWdbSXSfp
         VMKjDcUbPBbFG31rp47CdYY8XVivlB63MyY0ZzyfWjdqYUxtepM/VndqwOh36wXxU84I
         foQQQkoEJn0SkG7k/tZXvTE0aGnnFbIunf2wWLz9ofOnWAT7w/dn5AWVPpnT+q5jsUeW
         qOos9oH9g8Vg9VyJIGtiMjM/uFwAncNeDD6XoBu3Dq6JqA/pwf7xui1R8vAF9nRzZnId
         Ltrg==
X-Gm-Message-State: APjAAAU6mmNmhB5REA1jyyt4F2uAx7EGbU38efOS6216C6+Zl9NCDi0W
        tHrzSfgLifvr6tdgJfg6TiMgdg==
X-Google-Smtp-Source: APXvYqyhmYECdW43MhFhTN7//aeS41RHJ10Z2yDljk0yyhfJjbjM1mu84/PDw5uP6av+TuznHBaj2A==
X-Received: by 2002:a63:6949:: with SMTP id e70mr39295261pgc.226.1571159092733;
        Tue, 15 Oct 2019 10:04:52 -0700 (PDT)
Received: from ziepe.ca ([72.143.229.181])
        by smtp.gmail.com with ESMTPSA id t125sm26439052pfc.80.2019.10.15.10.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 10:04:51 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKQFe-0001TU-HP; Tue, 15 Oct 2019 14:04:50 -0300
Date:   Tue, 15 Oct 2019 14:04:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
Message-ID: <20191015170450.GB5444@ziepe.ca>
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:47:02PM +0300, Jarkko Sakkinen wrote:
> Salt the result that comes from the TPM RNG with random bytes from the
> kernel RNG. This will allow to use tpm_get_random() as a substitute for
> get_random_bytes().  TPM could have a bug (making results predicatable),
> backdoor or even an inteposer in the bus. Salting gives protections
> against these concerns.

Seems like a dangerous use case, why would any kernel user that cared
about quality of randomness ever call a tpm_* API to get quality
random data?

Jason
