Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6915EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F82147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711445;
	bh=FEebj0502C3pFhHspUOoBenpKH2Cm67GYCFW9wmbjw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H8xW7KY+sj+Rgtd6Pa6d2IHjWZsM6EUVHSTX31Pu7SqUvNUL9x49ufEgyi9vYjTrL
	 9qndOsrIg+dcFXpNit8aA0MKW/ylmy6ThPYot+Rj4rXfGATQRXyqkhgMtqVmmxQtUP
	 msDx3lQ05pWPE6yIkF1age2zleE7phPG91UPq79U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391925AbfC0Sao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391656AbfC0Sal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:30:41 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E0A02147C;
        Wed, 27 Mar 2019 18:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711441;
        bh=FEebj0502C3pFhHspUOoBenpKH2Cm67GYCFW9wmbjw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Qhbn+l7hFrMmzWdg7Yr9Y6H0SOHHOCJRbFUQH5kJJCmHIEcnAFTJx2W6uSnQgmMO
         rIisQtBgpwc3estXTCtwc7+yOfAw8otbXa9OcZt7S35U4yxaH6xRtQQthYZylPVM8D
         0mb0AqbGyqke+Kq+7PQkZmk1RtfS6fbA/teowemQ=
Date:   Thu, 28 Mar 2019 03:29:47 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked
 down
Message-ID: <20190327182947.GA9371@kroah.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com>
 <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
 <20190327003057.GA27311@kroah.com>
 <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com>
 <20190327050615.GA548@kroah.com>
 <16124107-70D3-4CA0-9766-36FC6DC10128@amacapital.net>
 <20190327053342.GA17484@kroah.com>
 <CALCETrUW=r=xyr4pGiGnn9zUEevf=z6PP3111Ds6qguV5SjYUQ@mail.gmail.com>
 <CACdnJus=zXgmNas+XVkWfe+ohAHEGMYLtfuYe0TH-eE=4p0oRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJus=zXgmNas+XVkWfe+ohAHEGMYLtfuYe0TH-eE=4p0oRw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:42:18AM -0700, Matthew Garrett wrote:
> On Wed, Mar 27, 2019 at 10:40 AM Andy Lutomirski <luto@kernel.org> wrote:
> > As far as I'm concerned, preventing root from crashing the system
> > should not be a design goal of lockdown at all.  And I think that the
> > "integrity" mode should be as non-annoying as possible, so I think we
> > should allow reading from debugfs.
> 
> I have no horse in this game - I'm happy to bring back the previous
> approach for integrity mode and block reads entirely in
> confidentiality mode, but I'd rather not spend another release cycle
> arguing about it.

I really do not care either way about any of this :)

greg k-h
