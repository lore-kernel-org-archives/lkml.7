Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D5E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T/lY1fHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCDTyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:54:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45889 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:54:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so6458735qtg.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X6Y8iExaiXetD91Man6/qdqhOVahCq446nFmMUqaAmw=;
        b=T/lY1fHWqGFk23ncovG8fBFPFUFvXBV7k1ukT452qi6Uszy+/i12mnUb4JxJ0PIR43
         DTnPRByoWwj6jr/rFQoEajHdmIXkVVJN59TTzHezJjO1J8cCr9se/MVlUvNXyIWYBApO
         wjrXWNoRxcW9G7BEATLMejlFDYSdNKRfCTs2OTP+Qzae9x3NxBZmNscZfhxHuIKhe2ku
         fHB5bbFBzzdYaAFlDY2OF71SyK4DnPnmxvAuKMzq7qOv4+vYeCixyjJmXgsbuUUtZbA5
         EqBAyAIfCckbnqVMszxX9hclSzqLyoqWDAd2S7Wwkbfqvzvraia49xQR4+0rR+J+yHy+
         CpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X6Y8iExaiXetD91Man6/qdqhOVahCq446nFmMUqaAmw=;
        b=GTLB+2aitA8V7O8ylCfecppoujn3Vc1AyklT2roK1HeVSzwP4SAYjsF6KEpOolsfpo
         PkbArwsXBzR/2X6mpyA7Ez5GVXBzw6bLIFcU8DunDxbqEGkyWyH3chqbfl7bnZgUppFU
         xYZaxvWByIAMReYbhkW2Ji5ljQ89taiJbc0ud3/pgJTY5AOMzhOXlepCJaGj/ysQjq2Y
         PW4ORrYWwWsMEyc6PipgiuSfn6E//uyjvRT+3bu9YItL3em5V0beddghoM1tmSeV2+mM
         2+YIgeSOsTR9z0Oq4oLsPbweku0YBxDAZhM08xs1QgYAg36bLjXry30fkQ4CLAmbpmpT
         a5Bw==
X-Gm-Message-State: APjAAAXIbPykm1sDWQeV/NOENE7M590vmbjG+no6fLSaTkJgcZhkLqvI
        WO0Oal8fBBHkKtL7nOH6mmaBrA==
X-Google-Smtp-Source: APXvYqxQbn/6sOfi37x7xxkhdoKWr2Z1bzq5FX52garMKz/2r6HYVwOPksen/jVI2SB0SPfWI/yqOQ==
X-Received: by 2002:ac8:2d7a:: with SMTP id o55mr16444056qta.158.1551729287773;
        Mon, 04 Mar 2019 11:54:47 -0800 (PST)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id o29sm4666041qtk.56.2019.03.04.11.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 11:54:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h0tfi-00021s-6u; Mon, 04 Mar 2019 15:54:46 -0400
Date:   Mon, 4 Mar 2019 15:54:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shaobo He <shaobo@cs.utah.edu>
Cc:     linux-rdma@vger.kernel.org, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxgb4: fix undefined behavior in mem.c
Message-ID: <20190304195446.GA7751@ziepe.ca>
References: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 03:38:38PM -0700, Shaobo He wrote:
> In function `c4iw_dealloc_mw`, variable mhp's value is printed after
> freed, which triggers undefined behavior according to this post:
> https://trust-in-soft.com/dangling-pointer-indeterminate/.
> 
> This commit fixes it by swapping the order of `kfree` and `pr_debug`.
> 
> Signed-off-by: Shaobo He <shaobo@cs.utah.edu>
> ---
>  drivers/infiniband/hw/cxgb4/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Discussion aside, this is a worthwile fix. I rewrote the commit
message to avoid referencing 'undefined behavior' though, this is just
a straight up bug in the logging. Another thread could get the same
pointer value for the mhp before the print creating a confusing log.

    cxgb4: kfree mhp after the debug print
    
    In function `c4iw_dealloc_mw`, variable mhp's value is printed after
    freed, it is clearer to have the print before the kfree.
    
    Otherwise racing threads could allocate another mhp with the same pointer
    value and create confusing tracing.

Jason
