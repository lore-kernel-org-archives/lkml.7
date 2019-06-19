Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1C8C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEF4208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560949256;
	bh=VX2WANL03gblB2MwxQNNRKPubFvAzDWLoRm2P0Rr+z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sxvZYe0wj/ypPKbQWpz2eQpDVZrceyqh15O7+WVEef8CiLD4/WOTsGXHejPUcjBfF
	 vqz05wXCgt+kfmfqbORPTMe++aO4+26abDspUHpHZMzWarxoShe5T9BvvoaFca0LDv
	 rI8hyIHYCkjmkvSR1qzCcUzNqEBTmnzi8KEwe+8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbfFSNAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfFSNAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:00:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBCE1208CB;
        Wed, 19 Jun 2019 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560949254;
        bh=VX2WANL03gblB2MwxQNNRKPubFvAzDWLoRm2P0Rr+z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Sqs+Cokecyz02B4F8511aOCWOi5lKBv9R/sOaIszsnE/gi/eSEttBURWkUM1s7e9
         44+HL+MpCfoMbDi3XtmknDuGyGfXhOY4xS56YjQP03w90RRLlnZp/9zj5UDhAc20Ig
         7GNCID/Uy4330A6nrzrVMHoFb81mfu7SjXxVDIZE=
Date:   Wed, 19 Jun 2019 15:00:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mei: no need to check return value of debugfs_create
 functions
Message-ID: <20190619130051.GC27090@kroah.com>
References: <20190611183357.GA32008@kroah.com>
 <20190611183816.GA952@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DC4B6C4@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DC4B6C4@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 08:25:58AM +0000, Winkler, Tomas wrote:
> > 
> > When calling debugfs functions, there is no need to ever check the return
> > value.  The function can work or not, but the code logic should never do
> > something different based on this.
> 
> Maybe need to mention that API has changed in patch ' ff9fb72bc07705c00795ca48631f7fffe24d2c6b' in 5.0 
> and create_dir() doesn't return NULL but ERR_PTR() and proper checking is done inside the debugfs functions.
> Not sure how critical is that but, but this should go probably to stable 5.0+ as well. 

It's not critical at all, the odds of an error ever returning, or NULL,
from debugfs before is just as rare as it is today :)

> Ack otherwise. 

great, thanks for reviewing it.

greg k-h
