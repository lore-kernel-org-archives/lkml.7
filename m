Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8E9C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13E1218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556179966;
	bh=dzvg8r7LenpJPUo2SY6YKZ7erVH9axG3FJkU3QI4yjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m6NXU66kM8fLnqNqbe7O+3PEf7LE6XUW0q67+0OJLNHT/Hh6MAtTvFezR8q8js8zc
	 q6yh0rnH1/HCy5hUNHCwRWc+LKWDI0zipWdrRDe+2HruKQHOa7Gws2IA8JC9eE0sC+
	 agSn1znU1o4i4YCc7Uam+z34V7Fa6x3jBZ3qQDtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfDYIMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfDYIMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:12:45 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87632214AE;
        Thu, 25 Apr 2019 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556179965;
        bh=dzvg8r7LenpJPUo2SY6YKZ7erVH9axG3FJkU3QI4yjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=accFpFd14v2LGIIJKJ6b9ytThaMpTpMStjAAufV9A99BBdLq7g1OSnjMdrNYXYUuS
         WR+n+MxdVUCkFtI3ZCyM6oQPzJdV8bb1GgUd53TRgcImslp7aTfc+xsi2Ybhh6vC4n
         Q7qdLb7hLt+UdnyCFwj8jBIjB5kjYT3nM9qRTlvU=
Date:   Thu, 25 Apr 2019 10:12:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 051/168] e1000e: fix cyclic resets at link up with
 active tx
Message-ID: <20190425081242.GB7745@kroah.com>
References: <20190424170923.452349382@linuxfoundation.org>
 <20190424170926.817047361@linuxfoundation.org>
 <0913eebd-edc7-1d33-0c07-08f9640d65ee@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0913eebd-edc7-1d33-0c07-08f9640d65ee@yandex-team.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 08:31:47PM +0300, Konstantin Khlebnikov wrote:
> Please skip this. It's going to be reverted upstream:
> https://patchwork.ozlabs.org/patch/1086838/
> 
> while original problem fixed differently:
> https://patchwork.ozlabs.org/patch/1086839/
> 
> same for 3.18 branch

Ok, I'll drop it from these two trees.  But note that this commit is
already in 4.9.168, 4.14.111, 4.19.34, and 5.0.7, so someone should make
sure to send that revert and "real" fix to the stable tree so we can fix
the issue in those trees too, when it hits Linus's tree.

thanks,

greg k-h
