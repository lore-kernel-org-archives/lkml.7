Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFB3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D9F2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576052299;
	bh=AMX2uELmZXc9JMz1ZWkm2WGiRI+cSmDE7Gcp+CImNNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HU1RPxNt24s8VrsPBYoZDhrawtb+zXCJWo2IoJX0ALtnNWif3fhZ9ZPgybCfGBHDl
	 7wf7UV6Lmsfod7gv/jrnQypW2/tARFVzoSq8wd9yw5hR14LoOVwhcHgraq6J/RjVtY
	 da3ncXkBh/Y7im42//B/jQ3uW0JlGtIF1w7Vmhtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfLKISR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:18:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLKISR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:18:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C69020652;
        Wed, 11 Dec 2019 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576052297;
        bh=AMX2uELmZXc9JMz1ZWkm2WGiRI+cSmDE7Gcp+CImNNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gz12lYuFWJWlmv5qypG1JMFKv9my/1gUc+04R83nktw3i8iKYDVVHkfAZL9OgFXsc
         ktan+5WFlUEOwKmyxBT7TKicY6RUxV+qYOuixSBhkdn8FD+13Uy8tOLQNYgh2y9bFp
         S34QlzAG0iwNWv+sH0I7yC3rrVD3691DySoIQdB4=
Date:   Wed, 11 Dec 2019 09:18:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon Schwartz <kern.simon@theschwartz.xyz>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Prevent overflow from causing infinite loops
Message-ID: <20191211081814.GA433262@kroah.com>
References: <2201ce63a2a171ffd2ed14e867875316efcf71db.camel@theschwartz.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2201ce63a2a171ffd2ed14e867875316efcf71db.camel@theschwartz.xyz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 05:41:37PM -0500, Simon Schwartz wrote:
> num_resources in the platform_device struct is declared as a u32.
> The for loops that iterate over num_resources use an int as the counter,
> which can cause infinite loops on architectures with smaller ints.

What arch is that that has so many resources and yet is only a 32bit
system?

thanks,

greg k-h
