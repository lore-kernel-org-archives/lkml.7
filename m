Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF35C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D253F2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553560551;
	bh=L3xeVJYdIRTDqBMvYIMi/pypjlVgS/mBndEZYjyhDUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YllPK+vBPF3Nb8K230TE8mRm8QnDb4Epne9jMF8mrSCwSmM/ZfGjoxikRVJrALsbC
	 sSOGJMRpuhADVN5/ngTSNPWnJa//HfDrmJb07sdTvkQN8mt/S6aJKJMi4HXeFEnWbL
	 q95Tm/mF74ehhGrFubef/lUo2ZF38yOp7suaRdk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfCZAfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbfCZAfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:35:50 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E96206DF;
        Tue, 26 Mar 2019 00:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553560549;
        bh=L3xeVJYdIRTDqBMvYIMi/pypjlVgS/mBndEZYjyhDUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwmkqScAeT0lY5ymYZ1DleQZwen9mwDTZ04ZKgut6J4JVKIQIl5CYm2SuTxaruPod
         /tep/+zpLQgM4Rg+i/ULYprS5Ud2cHOoxOT4RtWwiQ3FPpwXOmFvLHkhuAGFIbjZcF
         owF8v8WW/U3uKxBs2J9ai9ELpcIphT+IISKjVvGs=
Date:   Tue, 26 Mar 2019 09:31:37 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 25/27] debugfs: Restrict debugfs when the kernel is
 locked down
Message-ID: <20190326003137.GB5112@kroah.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-26-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325220954.29054-26-matthewgarrett@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:09:52PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Disallow opening of debugfs files that might be used to muck around when
> the kernel is locked down as various drivers give raw access to hardware
> through debugfs.  Given the effort of auditing all 2000 or so files and
> manually fixing each one as necessary, I've chosen to apply a heuristic
> instead.  The following changes are made:
> 
>  (1) chmod and chown are disallowed on debugfs objects (though the root dir
>      can be modified by mount and remount, but I'm not worried about that).
> 
>  (2) When the kernel is locked down, only files with the following criteria
>      are permitted to be opened:
> 
> 	- The file must have mode 00444
> 	- The file must not have ioctl methods
> 	- The file must not have mmap
> 
>  (3) When the kernel is locked down, files may only be opened for reading.
> 
> Normal device interaction should be done through configfs, sysfs or a
> miscdev, not debugfs.

Then why not just not allow debugfs at all if it is such a "big
problem"?

Actually, it is a big problem, and I am pushing for systems to not mount
debugfs at all these days, but that's a different story...

Just "disabling" it entirely for this crazy dream of a "locked down"
kernel is fine for me.

thanks,

greg k-h
