Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E07BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DCD2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796223;
	bh=8mtfgyPBWTm7Ix0WaVBLA8i85Em+XBWhR65cpJnrFTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+J8E/h/eKQvqr4TzPd7pDzCR0od0IcKNHQakG62UEtz3s8y8j1HIkHDf7dZ8fFHl
	 NNmnMclkhgiX9JCMpcWrJWX7wH2829jT4FsatdmNqBdP3mGzw/B+gbaQd+QqtXuLZO
	 4uqACwsU7CHkAUKoOZIOjGPtVt/A5U/K+RqhCfW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKZTXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:23:42 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34663 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:23:41 -0500
Received: by mail-il1-f196.google.com with SMTP id p6so18754048ilp.1;
        Tue, 26 Nov 2019 11:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5HQvc+ebgeUpvGjHDXPpgN7hbbmKJO3hU3E3sjzKKD4=;
        b=EqJd8nzttabnecWFtvigXgc4xaHV6iASnnuBDEOSWKc/cSfcvhp/n+hhd0mT1vZ+1Z
         uyYI3QN8hgD9BmHaTy6Et744bcFToCE2254ULsHCVKek6Rki0ZNrvEDwlzdK8E3QEo0T
         VLdZq2MW/GXjQnChIeiycLbaUq+Ob9T6+tCobM4Y/+1Kkw+Qldrf1H+mOUDzPbKc6isk
         MP8YFSeh6ZjyZJHmx8z9Xr6iUTPC/cE8y/St7tHOscjf8AeAmk1UlVEpwP39qDuwwV3c
         JXPfQl6QmCe4ySrtlrLqH9+EuDiUyikr4xWGczgt/l9Az8a1ql6II8yPBmQoGO3xbWKw
         bijg==
X-Gm-Message-State: APjAAAWck6/rqoc5fnFGDwhG3e/nJw0HTm2OcKidlfKHreTe9jKxEwxr
        x9DsiJ9V1I49R7iq7aE7Pg==
X-Google-Smtp-Source: APXvYqxLi2BPHhib7tuA5K/dBdXW6V5zjrGNxJcK95S9arb/wV5mxmiHCV0Wk/se2VVXlbX81tL0FA==
X-Received: by 2002:a92:6406:: with SMTP id y6mr41484371ilb.70.1574796219273;
        Tue, 26 Nov 2019 11:23:39 -0800 (PST)
Received: from localhost ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q9sm2846876iod.79.2019.11.26.11.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 11:23:38 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:23:37 -0700
From:   Rob Herring <robh@kernel.org>
To:     Erhard Furtner <erhard_f@mailbox.org>
Cc:     linuxppc-dev@ozlabs.org, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Erhard Furtner <erhard_f@mailbox.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH v2] of: unittest: fix memory leak in
 attach_node_and_children
Message-ID: <20191126192337.GA13881@bogus>
References: <20191126014804.28267-1-erhard_f@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126014804.28267-1-erhard_f@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 02:48:04 +0100, Erhard Furtner wrote:
> In attach_node_and_children memory is allocated for full_name via
> kasprintf. If the condition of the 1st if is not met the function
> returns early without freeing the memory. Add a kfree() to fix that.
> 
> This has been detected with kmemleak:
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205327
> 
> It looks like the leak was introduced by this commit:
> Fixes: 5babefb7f7ab ("of: unittest: allow base devicetree to have symbol metadata")
> 
> Signed-off-by: Erhard Furtner <erhard_f@mailbox.org>
> Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
> Changes in v2:
>   - Make the commit message more clearer.
> 
>  drivers/of/unittest.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Rob
