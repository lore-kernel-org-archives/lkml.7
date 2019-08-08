Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD76C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3278021874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565268157;
	bh=H3Xm8TVT+2ZXNimGkZTlU8kaRfKXyQSpxg1WVh70iLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OqKGkbGNLMfrDZH/EjbCkeew/W47/sgf2CIjATHlJvpLoqW/E3qZfVab3234FUWiO
	 Pk4zl94Z9FWiR3aJo1D7Rr5X81Vxz2MDdh62n0ozFB4/Y1yaZx1sv4wOOIIJJiAQci
	 Ht3XNSJRjbEdPnGqmRtL5XK0DGDRT5cKxVF6ZHV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfHHMmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbfHHMmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:42:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D102171F;
        Thu,  8 Aug 2019 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565268154;
        bh=H3Xm8TVT+2ZXNimGkZTlU8kaRfKXyQSpxg1WVh70iLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJa/AClplyDnhtCu5fn8WkR83+bJajnIKx+Y4J/LT90BwsHTPtDpOtcgvGdDDQlbd
         IRrhenCSxisAAJhQynis+WiF7IQpOcrPUH0La7Cj68dREP9+aJBzFgC77voWxfueNH
         jSfQXHMTJZxEwws2i/ZtP+jMwgtRbtPCP0JEjFdY=
Date:   Thu, 8 Aug 2019 14:42:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     amit@kernel.org, mst@redhat.com, arnd@arndb.de,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio_ring: packed ring: fix
 virtqueue_detach_unused_buf
Message-ID: <20190808124232.GA32144@kroah.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
 <20190808113606.19504-3-pagupta@redhat.com>
 <20190808115630.GB2015@kroah.com>
 <1512438873.7425183.1565267326035.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512438873.7425183.1565267326035.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:28:46AM -0400, Pankaj Gupta wrote:
> 
> 
> > > This patch makes packed ring code compatible with split ring in function
> > > 'virtqueue_detach_unused_buf_*'.
> > 
> > What does that mean?  What does this "fix"?
> 
> Patch 1 frees the buffers When a port is unplugged from the virtio
> console device. It does this with the help of 'virtqueue_detach_unused_buf_split/packed'
> function. For split ring case, corresponding function decrements avail ring index.
> For packed ring code, this functionality is not available, so this patch adds the
> required support and hence help to remove the unused buffer completely.

Explain all of this in great detail in the changelog comment.  What you
have in there today does not make any sense.

thanks,

greg k-h
