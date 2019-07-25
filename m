Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1642C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9464321951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564075355;
	bh=C59y+TIcXE94/c+pnA6p7SwFPzlfoDKIQzMbTuOMPnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zbn94TxpM1YRH7nruD9JyLVb6JWKaqdmNNfxN3h7ikhmKKZti+rJk07+XA4yWSuzi
	 AiFtlybDMP23BtTLSWD2Qf3X1duMiFaryHvGW2IiRdfFTHgVWjQsDNbU0zoeJsB0ZD
	 H/iYL+DkppFnS3Jx8RQAq/IzeKFEcMKI8ZzySnZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfGYRWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:22:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37072 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGYRWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:22:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so23087493pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eL1HSchY4smbgjXqlJbm9OwKjrtCybSa9ZhZ0bGd0qc=;
        b=O6ggdqoXdxWS8sMmTbOLCHUBqkXk/V+zkU2I8fC0hw2mVjRQwh17sH2FBf7D8u/A0u
         3BkALsk5/6aNO9Muijnd37+subw0Zj9d0HW8plEH0ZAk8Y1QQ13rgXGHmzvZDGzLt1T6
         tSpI0Y+afxYqYyDAIt+u25VkBkMT23ixd9+4dJRM74IEP28cl2ufN7q4gH04QxgBeKkt
         0REbxaeIxp3J+RA0GKWmx5ObOJu6/Nbf9Pe4Qx0nOo3JL5S7V0lmg92lWPD01SR4Tam6
         XWpOh8m4kf4bxtv9F/VluW+HGP9dWeQr0PiKVN0dpp919XO+Ert0zCVLOvc8WWeKGf91
         VkJg==
X-Gm-Message-State: APjAAAXWxkUXtO2fwlH2A/HMS5pB9OeZ0VrwqoZ0Df0/cTiF4vWbXl38
        PfvJQj59kibJxqnzP50EOswu+w==
X-Google-Smtp-Source: APXvYqw6g/t+kwkzMzCg95KnrFkBICauD8uaMQbuX807kZZ/ogEmop7p/DADMkENl73VKq/2OSWodw==
X-Received: by 2002:a62:5487:: with SMTP id i129mr18293770pfb.69.1564075353183;
        Thu, 25 Jul 2019 10:22:33 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id y10sm51485076pfm.66.2019.07.25.10.22.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 10:22:32 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:22:31 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     mdf@kernel.org, richard.gong@linux.intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/3] fpga: altera-cvp: Add Stratix10 Support
Message-ID: <20190725172231.GA9274@archbox>
References: <1564067808-21173-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564067808-21173-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thor,

On Thu, Jul 25, 2019 at 10:16:45AM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Newer versions (V2) of Altera/Intel FPGAs CvP have different PCI
> Vendor Specific Capability offsets than the older (V1) Altera/FPGAs.
> 
> Most of the CvP registers and their bitfields remain the same
> between both the older parts and the newer parts.
> 
> This patchset implements changes to discover the Vendor Specific
> Capability offset and then add Stratix10 CvP support.
> 
> V2 Changes:
>   Remove inline designator from abstraction functions.
>   Reverse Christmas Tree format for local variables
>   Remove redundant mask from credit calculation
>   Add commment for the delay(1) function in wait_for_credit()
> 
> V3 Changes
>   Return int instead of void for abstraction functions
>   Check the return code from read in altera_cvp_chk_error()
>   Move reset of current_credit_byte to clear_state().
>   Check return codes of read/writes in added functions.
> 
> Thor Thayer (3):
>   fpga: altera-cvp: Discover Vendor Specific offset
>   fpga: altera-cvp: Preparation for V2 parts.
>   fpga: altera-cvp: Add Stratix10 (V2) Support
> 
>  drivers/fpga/altera-cvp.c | 348 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 277 insertions(+), 71 deletions(-)
> 
> -- 
> 2.7.4
> 

this doesn't apply since I applied Carlos' patch 998c1de56dac7
("fpga: altera-cvp: Fix function definition argument") yesterday to

git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git

'for-next' branch.

Would you mind resending it on top of that and drop the extra dev_dbg()
for the offset in Patch [1/3]?

Sorry about that. Things are moving around a bit, but hopefully settle
down soon :)

- Moritz
