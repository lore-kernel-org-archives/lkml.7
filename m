Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA5CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AD621850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553075166;
	bh=JZBy2iw9o99cjWnxJcjag01IU+ALDYqZ/OQbaelwo+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=POnF3ZRwaOYl/BgK58fhyMi6PZAfnzo1QKzy46DmPf3hs2GlGdGU9XvG83eDxtEro
	 n3YyvQB5jWa/1ZabVwxJjjq0urwflgINXV45UPZrf1LHenA49tlj+cVV6b1uiYHyp7
	 39r2j7WgHIvEVczmyDa55+1Lk5ImDdcy1M/VVTBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCTJqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfCTJqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:46:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86E92175B;
        Wed, 20 Mar 2019 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553075164;
        bh=JZBy2iw9o99cjWnxJcjag01IU+ALDYqZ/OQbaelwo+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiUgbpd6ACxLPoNX8u0bD/o0YIJqeyit2SvNXHpSXeQCAloFh7nsMchntqikuxtha
         vXXsdGzvpm9VZx/lSAwDRBhTYPUb77PQyOELrVK8j5HvpqecIWKOs3fEXCOfWuj8wB
         sQpbjocznO5o31YNeelohow4watGFA4WFXFJg6GI=
Date:   Wed, 20 Mar 2019 10:46:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        "Knut St . Osmundsen" <knut.osmundsen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virt: vbox: Implement passing requestor info to the host
 for VirtualBox 6.0.x
Message-ID: <20190320094601.GA30735@kroah.com>
References: <20190320093519.26029-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320093519.26029-1-hdegoede@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:35:19AM +0100, Hans de Goede wrote:
> VirtualBox 6.0.x has a new feature where the guest kernel driver passes
> info about the origin of the request (e.g. userspace or kernelspace) to
> the hypervisor.
> 
> If we do not pass this information then when running the 6.0.x userspace
> guest-additions tools on a 6.0.x host, some requests will get denied
> with a VERR_VERSION_MISMATCH error, breaking vboxservice.service and
> the mounting of shared folders marked to be auto-mounted.
> 
> This commit implements passing the requestor info to the host, fixing this.
> 
> Cc: stable@vger.kernel.org

This feels like support for a "new feature", so why would this need to
go to older kernels?

It's not our fault that vb implemented a non-backwards-compatible change
for their new release, right?  So why should we be forced to add new
features to stable kernels?

I have no problem to add this for 5.2, but not for older stuff.

thanks,

greg k-h
