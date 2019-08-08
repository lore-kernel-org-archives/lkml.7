Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635E7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341472187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565258467;
	bh=CXGx44GqUVtH0apYlJlTI8Umn34XvELg2oJSMNqJIpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q1hBj/eeU6FtmzPwdDeuMzGXvcfbsjqs/2N4O6pN5yeaYmEMSHslAX7JyTFG2ou0/
	 UEjsp/2PwU0Cn5vJ89+iz+NvM76/Ty4ethke1bz7WP/djrAzlQKN64T3kYJzJ80VAr
	 MSUV6TZgj7IVRSyx1kcmHtLNldYbiA/9F6AZlt48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfHHKBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfHHKBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:01:05 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF54221874;
        Thu,  8 Aug 2019 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565258464;
        bh=CXGx44GqUVtH0apYlJlTI8Umn34XvELg2oJSMNqJIpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSjghN36wTkmO+sdaV5suvU5gI8yEJg20nbiyId9rjvm243B3d9VxgVaE4YMkp/DE
         RHH1k1r9NA2oQEW1edym22OFYv3jLpE1XfzvCWJpsALgmvr3G3yvFI8E7fOqhkfIEY
         MWcEmat6pET6Wq6VlxpkYDejweSzieKMjQmO4+JY=
Date:   Thu, 8 Aug 2019 12:01:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V37 04/29] Enforce module signatures if the kernel is
 locked down
Message-ID: <20190808100059.GA30260@linux-8ccs>
References: <20190731221617.234725-1-matthewgarrett@google.com>
 <20190731221617.234725-5-matthewgarrett@google.com>
 <20190801142157.GA5834@linux-8ccs>
 <CACdnJusD_9W9tFqwKptDTA8fZU8HrSvsEQhKo0WS9QxLpgz5tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACdnJusD_9W9tFqwKptDTA8fZU8HrSvsEQhKo0WS9QxLpgz5tA@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthew Garrett [01/08/19 13:42 -0700]:
>On Thu, Aug 1, 2019 at 7:22 AM Jessica Yu <jeyu@kernel.org> wrote:
>> Apologies if this was addressed in another patch in your series (I've
>> only skimmed the first few), but what should happen if the kernel is
>> locked down, but CONFIG_MODULE_SIG=n? Or shouldn't CONFIG_SECURITY_LOCKDOWN_LSM
>> depend on CONFIG_MODULE_SIG? Otherwise I think we'll end up calling
>> the empty !CONFIG_MODULE_SIG module_sig_check() stub even though
>> lockdown is enabled.
>
>Hm. Someone could certainly configure their kernel in that way. I'm
>not sure that tying CONFIG_SECURITY_LOCKDOWN_LSM to CONFIG_MODULE_SIG
>is the right solution, since the new LSM approach means that any other
>LSM could also impose the same policy. Perhaps we should just document
>this?

Hi Matthew,

If you're confident that a hard dependency is not the right approach,
then perhaps we could add a comment in the Kconfig (You could take a
look at the comment under MODULE_SIG_ALL in init/Kconfig for an
example)? If someone is configuring the kernel on their own then it'd
be nice to let them know, otherwise having a lockdown kernel without
module signatures would defeat the purpose of lockdown no? :-)

Thank you,

Jessica
