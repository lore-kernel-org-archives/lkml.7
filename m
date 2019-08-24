Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B3C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8919E22CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566672110;
	bh=klhdQxW+ylkwb44+otVt9hIaZBoTVgPq4ulwpYeqyCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RsAyOmvsybv0B6l4G3sKgCVQH0zLNoR75ZAatVoScnPbD3qKdyfbn0WvHmaHaSVBs
	 S9ZPZywUsfW7W4wcdN7+djFvitZTIwTJ6w+wgJmr0l3CQn5Nan1Orsjsssm95yqZsv
	 XwHjkLBJ7eVW3lWAQ+eJH/J6baDzS6yf9secyzBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfHXSlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:41:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44084 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHXSlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:41:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so7825190pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 11:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSuVLTI0onJLfu3gp/vEaHHc7h5yJt6US9JDWx7JKa0=;
        b=V6wrdBMRgljHOKZ4NWDCZEHQMnkGCSj5R471wHNtSB3HcuaTIfwxXm2Q5K8EscG4fy
         1rGFtBuqxq6fU/hqUJHzqosTQjGNDaS0+9NKd26DmXZNV8RSjijTA++o1eqKpAUkYfNn
         7kSbPPxQnWoKN9hPe1geeUVlGc6NObEOEzgdmAMj7eDYAZojF45EKRDl5ogOz6kElg+k
         pdYD5duEx/1dcIDw74V0XMXIqXeq7Mm188H37ntTH3bUmaQ4N66SUKQj6PxdUbmzlny6
         e2eBQiVMMOgEcgtNlR6ybZ3XV8ey9U91oIhZalPpXwkZhrKVHXJX8R85qy4i+sX9l+Iq
         CMzg==
X-Gm-Message-State: APjAAAV2unz3eCWYbJzMmLGJyC5QrYVj89IsjABm3523MH18E56OV4mu
        gwzerKJVshaxD4mQtVD5svmUoQ==
X-Google-Smtp-Source: APXvYqwSkuq5leKgzEmlCl+2ZE690hz4vBXdTXbt48rpARtKdrGGqPgzG1p3WrzU7mJM0UNYD3NQlQ==
X-Received: by 2002:aa7:90c9:: with SMTP id k9mr11489616pfk.171.1566672108421;
        Sat, 24 Aug 2019 11:41:48 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id a189sm7105980pfa.60.2019.08.24.11.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 11:41:47 -0700 (PDT)
Date:   Sat, 24 Aug 2019 11:41:46 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCHv4 0/3] fpga: altera-cvp: Add Stratix10 Support
Message-ID: <20190824184146.GA12399@archbox>
References: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thor,

On Mon, Aug 19, 2019 at 03:48:05PM -0500, thor.thayer@linux.intel.com wrote:
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
> V4 Changes
>   Rename delta_credit to space
>   Simplify wait for credit do-while loop.
>   Change from udelay() to usleep_range()
>   Use min() to find length to send
>   Remove NULL initialization from private structure
>   Use #define for Version1 offsets
>   Change current_credit_byte to u32 sent_packets.
>   Changes to Kconfig title and description to support Stratix10.
> 
> Thor Thayer (3):
>   fpga: altera-cvp: Discover Vendor Specific offset
>   fpga: altera-cvp: Preparation for V2 parts.
>   fpga: altera-cvp: Add Stratix10 (V2) Support
> 
>  drivers/fpga/Kconfig      |   6 +-
>  drivers/fpga/altera-cvp.c | 339 ++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 271 insertions(+), 74 deletions(-)
> 
> -- 
> 2.7.4
> 

Applied to for-next. If all goes well I'll send it out with next PR.

- Moritz
