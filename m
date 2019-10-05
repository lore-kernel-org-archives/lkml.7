Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA47C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2F3222CC
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570300839;
	bh=RWuY0RSvkUj2zaP9FkesiWE2O7HQPq1rvX2ddcue8vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WEXy02v+WsqHdEmJUtChhsJOdh7sTK9f87NFvsSaNAJyzGYryxcIqHWPPDxMwSd9z
	 OSEb5FlAst5hsY65ikSCm3bqRfRfiQgj+khGBWrXaW37p2RABCllUa8dxPkPurIhSl
	 md+EyFqQu81CK1kIExzbS4VRBRN7F0DxiIfhq96k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfJESkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 14:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387791AbfJESki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 14:40:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3478222CA;
        Sat,  5 Oct 2019 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570300838;
        bh=RWuY0RSvkUj2zaP9FkesiWE2O7HQPq1rvX2ddcue8vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuDQBTf27tJ/syv9eY4jSxOcMtKfYqkusdHd0rK27nz/xQvJbJ0PKX5ktBzm9RAwY
         +60XGaBoNV66J2AKN5x/aokPrI+lzXEpNe6Jf0M5DsyuSLJGXS+FHra9LbCqE3EPYT
         0NCtMa+xZZWjnpRhaqWQodNHEn/NUGr5xqOTJ8oE=
Date:   Sat, 5 Oct 2019 20:40:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Kangjie Lu <kjlu@umn.edu>, linux-kernel@vger.kernel.org,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Forest Bond <forest@alittletooquiet.net>,
        Stephen McCamant <smccaman@umn.edu>
Subject: Re: [PATCH] staging: vt6655: Fix memory leak in vt6655_probe
Message-ID: <20191005184035.GA2062613@kroah.com>
References: <20191004200319.22394-1-navid.emamdoost@gmail.com>
 <1d0ba4c6-99ed-e2c9-48a2-ce34b0042876@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0ba4c6-99ed-e2c9-48a2-ce34b0042876@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 06:30:13PM +0200, Markus Elfring wrote:
> > In vt6655_probe, if vnt_init() fails the cleanup code needs to be called
> > like other error handling cases. The call to device_free_info() is
> > added.
> 
> Please improve this change description.

It is fine as-is, please do not confuse people.
