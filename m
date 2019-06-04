Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A595724020
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559636651;
	bh=6slerfuNDoj7Is3gV1c++tUMoScJL8Np9rrWGf3bwEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dkmqO1Dj5AzmmBBB9ZiRByPaY+TuNWkFXK/qvV9HNSJlYnestyCdocLlM4aypEAJh
	 /cD42LdfuRg3uB8roL0+Slwgv9qCtNsyRujTraKeH0IXvMYAEmNRS2Ebr3iMMVuqaJ
	 mpP3mQbD2o18XrwjbpWqANhb1B9225z+B9Q9+gb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfFDIYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfFDIYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:24:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C76423CCA;
        Tue,  4 Jun 2019 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559636649;
        bh=6slerfuNDoj7Is3gV1c++tUMoScJL8Np9rrWGf3bwEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pw0FhfzT3SowGqAs0l+j0iJWvItPv9FKYOSML2mpYzvbDof5UrR+5denSGgQQVuki
         fFuryBzfBU4uCZOyvIOnnbCd5c6MKY9rHsQvHf9KfeS8aq2Sn6NX0RYuYn/x3dQDcF
         yDZh82G+aEB+uVzt6qhfr5ir0z309DLzk/ERXiMU=
Date:   Tue, 4 Jun 2019 10:24:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4] usb: create usb_debug_root for gadget only
Message-ID: <20190604082407.GA3783@kroah.com>
References: <1559633647-29040-1-git-send-email-chunfeng.yun@mediatek.com>
 <20190604073706.GA25045@kroah.com>
 <87k1e123mc.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1e123mc.fsf@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 10:47:55AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >> +struct dentry *usb_debugfs_init(void)
> >> +{
> >> +	if (!usb_debug_root)
> >> +		usb_debug_root = debugfs_create_dir("usb", NULL);
> >> +
> >> +	atomic_inc(&usb_debug_root_refcnt);
> >> +
> >> +	return usb_debug_root;
> >> +}
> >> +EXPORT_SYMBOL_GPL(usb_debugfs_init);
> >> +
> >> +void usb_debugfs_cleanup(void)
> >> +{
> >> +	if (atomic_dec_and_test(&usb_debug_root_refcnt)) {
> >> +		debugfs_remove_recursive(usb_debug_root);
> >> +		usb_debug_root = NULL;
> >> +	}
> >> +}
> >> +EXPORT_SYMBOL_GPL(usb_debugfs_cleanup);
> >
> > Only remove the debugfs subdir if the usbcore module is removed.  Create
> > the debugfs subdir when the usbcore module is loaded.  No need for any
> > reference counting of any sort at all.  No need to overthink this :)
> 
> There is a slight need to overthink. He wants to use the same directory
> for gadget-only builds too :-)

Again, that's fine, this file will be loaded for those builds as well,
right?  Otherwise, how would this code even be present?  :)

thanks,

greg k-h
