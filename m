Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA40CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D02217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572714654;
	bh=fZkewWYuXTeElpKvFb4vXZ0PDkAB2kjd3Z1zk+ormOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f8DEkozdMLll9HKfJcjnBjbH2sM/Q4/6zDIOErJYZ3/s7xxs8hJLU1h0gNy8OY/Ff
	 g2TbzZVLZJniWvrMDxGfAmUEoCQ2Plq3197U+MCTXDXtGbxMdcbPOhfdylMC2+y3gU
	 VgSYyw7svjm86FcIoZLpfUsL3R9EcELjgX5jXK48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKBRKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfKBRKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:10:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D148920862;
        Sat,  2 Nov 2019 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572714652;
        bh=fZkewWYuXTeElpKvFb4vXZ0PDkAB2kjd3Z1zk+ormOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVC5iBHKzgLhuG1k/wU2jKqC+IpHhbDldsQsExkVTS0DmhBnV+yzREsBwNAmcBTrL
         bgYxZVS96AhudIYfZy5jgq5mrWQKHGOmW1hCR8YSF/9Kg+s9HT/aHMJi85vtmUANeq
         YO4PZTUB2ziU+QASc8CfIzKgz4oYI7mXXSW0dpmU=
Date:   Sat, 2 Nov 2019 18:10:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akinobu.mita@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] fault-inject: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Message-ID: <20191102171050.GB479906@kroah.com>
References: <1572486977-14195-1-git-send-email-zhongjiang@huawei.com>
 <1572486977-14195-3-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572486977-14195-3-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:56:17AM +0800, zhong jiang wrote:
> It is more clearly to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
> operation rather than DEFINE_SIMPLE_ATTRIBUTE.
> 
> Meanwhile, debugfs_create_file() in debugfs_create_stacktrace_depth() can
> be replaced by debugfs_create_file_unsafe().

Why is it ok to do this replacement?  You should describe in detail how
you determined this was ok to do.

thanks,

greg k-h
