Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03B1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8827021841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558676893;
	bh=cu3fgmZ61U1QNRF9hTI2jmlv8OcBkPCDvxz3VlIuRbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZGYKMcFVhuAQWIT2KrY/NduV6jkGrBIRE+ddJFNFlOaVoMBsxn5pRuCZ7wUt6hErS
	 s6xIUcQaVO+e2JQvXLolgmcJHnsRQppEUjSF2Vk8H5Yuu6yESHkDVEGnsrqxD0iPKk
	 v8+NRQT9bdApX9T6beWQjOzsPmpLIUDVUxDeQHT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfEXFsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387535AbfEXFsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:48:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B0B2168B;
        Fri, 24 May 2019 05:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558676891;
        bh=cu3fgmZ61U1QNRF9hTI2jmlv8OcBkPCDvxz3VlIuRbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSv05xAXy4GZ91iYshndffZcKJ4RMlakkSmMiu4pbnGjCqW+gLCQi0C6H7ZSZNk6J
         NTVBzl3znH5OTnDncLVvvXJY1IcrQP/pFE+opBUi7NxEvvFBR7fMwIH4WiToZ4FH2o
         n11OiBJpve9x3rnIOFcKGFWn0x0veVBccaAu6mmI=
Date:   Fri, 24 May 2019 07:48:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v1 2/5] driver core: Add device links support for pending
 links to suppliers
Message-ID: <20190524054809.GA31664@kroah.com>
References: <20190524010117.225219-1-saravanak@google.com>
 <20190524010117.225219-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524010117.225219-3-saravanak@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 06:01:13PM -0700, Saravana Kannan wrote:
> When consumer devices are added, they might not have a supplier device
> to link to despite needing mandatory resources/functionality from one
> or more suppliers. Add a waiting_for_suppliers list to track such
> consumers and add helper functions to manage the list.
> 
> Marking/unmarking a consumer device as waiting for suppliers is
> generally expected to be done by the entity that's creating the
> device.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 67 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  5 ++++
>  2 files changed, 72 insertions(+)

This looks fine to me, I'll let the dt people argue if the new entry is
valid or not :)

Feel free to add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

to this if the dt people want to take it through their tree.  Or, I
guess I should really take it through mine...

thanks,

greg k-h
