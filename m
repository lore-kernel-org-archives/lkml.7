Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DFBC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108AC21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556613735;
	bh=hEJeedReyrvMTpELjkKW1DKI7hOCgymeSH+xAu+sczM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XNL3juyT9FvQx+JRfXkhLRuLusbH50tCEADaILyvf5dnJXgvsPr8wkAQj7DPGn0zz
	 pjRHMofmFU0h+jTWtclB0B14wofw0Kudd2wp6bf72zrqcxg+Ehkv9kp1fUoWN18NSS
	 SZVvEIPrDnUt9yrTBfVzpXlevnULVIzhsea13WUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfD3ImN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfD3ImN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:42:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36AE12080C;
        Tue, 30 Apr 2019 08:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556613732;
        bh=hEJeedReyrvMTpELjkKW1DKI7hOCgymeSH+xAu+sczM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEg27DCShWwjcKfJpSN7jb8hw9W+I6X7E2sxVT9Fj4EuClzFAADCY696yzjHssROH
         W/LnxaInMXg7CCA0UWJMYF1LKPkU087xraspvXQRxJVPYA9N5OdPaZ7W/OsV4BBFW/
         R2FFmGMugS74G/TSkL1aMwotBDq30UBehjlQcb9s=
Date:   Tue, 30 Apr 2019 10:42:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix kobject memleak
Message-ID: <20190430084210.GA11737@kroah.com>
References: <20190430010923.17092-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430010923.17092-1-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:09:23AM +1000, Tobin C. Harding wrote:
> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

