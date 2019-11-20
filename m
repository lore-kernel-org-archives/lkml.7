Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DF2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1964D20898
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574277527;
	bh=LpPuYMvyFIdAPrnBkAwX0LIkqA67lt7WNCj3z+XgAho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Azbyv5bueIxy3RQNYDMiikGQ4z9RQ1rjr5Dh0oMI9usfiZk2A6rUHlXm75Wl4HeiW
	 2OUJvh5udGeQyIM3Kkl1AglXBgF+kGSvm1MLVaSPOs7KqKG/9JWpM0EAAP2DWzYhV3
	 LTL0+U6DlhXpb9vPCeZzJs7C6xx/owHgHTRKDatQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfKTTSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:18:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfKTTSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:18:45 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 375A020895;
        Wed, 20 Nov 2019 19:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574277525;
        bh=LpPuYMvyFIdAPrnBkAwX0LIkqA67lt7WNCj3z+XgAho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTYecq8ZWrPybQxUE4GijPIWqQdUnwRR/GRLImxxHxFeZha4+2bn2yNyBXwgsl3y6
         j3BnVJdtF0Etud0fXa3mNiD5gQV80lg8FAOr8XhfPOUhf4lveI155ZlJ3GJQWb/GTo
         1JA2ThiTxyq54+zbYM4lepRihtYSsMtaSIImECjc=
Date:   Wed, 20 Nov 2019 19:18:40 +0000
From:   Will Deacon <will@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux@armlinux.org.uk, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, vincent.whitchurch@axis.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rabinv@axis.com,
        Richard.Earnshaw@arm.com
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read
 hazard
Message-ID: <20191120191839.GF4799@willie-the-truck>
References: <20191113104945.GC25900@willie-the-truck>
 <20191114132848.55atqtjshjmi2udl@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114132848.55atqtjshjmi2udl@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 09:28:48PM +0800, Herbert Xu wrote:
> Will Deacon <will@kernel.org> wrote:
> >
> > which is what can happen due to this erratum. It's generally good practice
> > to use READ_ONCE() when reading something which can be updated concurrently
> > because:
> > 
> >        * It ensures that the value is (re-)loaded from memory
> > 
> >        * It prevents the compiler from performing harmful optimisations,
> >          such as merging or tearing (although in this case I suspect
> >          these are ok because we're dealing with a single bit)
> > 
> >        * On Alpha, it gives you a barrier so that dependency ordering
> >          can be relied upon from the load
> 
> The Alpha barrier matters for pointers, how could it make a
> difference for individual bits?

I guess you could use the result of test_bit to index into an array or
something?

Will
