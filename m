Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9014CC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6746C216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569852548;
	bh=R8eiJJTzcyo1yGN0aQ9ZsBckQuDguFk2uTpXskUiW1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GlIYQj3cyUMSlnotMqf8DtJxG7GJiwk9dBg7VGloGEc3M3pjNFMgjSSZSLKEvAF+S
	 ca1yG7iupuLjTAlSq6pm5bKkCU2CgVBpgsCBfovaOYNqrbIQK2AkJWAiHSQe7U7x1p
	 DwqQ5C/w3Uhyi93yw//m7G8+5xxGAalhXTyMU59k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfI3OJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbfI3OJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:09:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9C621855;
        Mon, 30 Sep 2019 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852544;
        bh=R8eiJJTzcyo1yGN0aQ9ZsBckQuDguFk2uTpXskUiW1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIs88nSuxyAskoZMsBGB2UXyVECbgNLhEJKqQDenYOunFdkOmk+WtYp9X58uyeqoD
         Y9QU7ZMNCHiSBN8gaQ4NNqwoP31pKCe59/6nsv72OaXMHqryOaf/lpRGqMdyifCtLP
         MEmimYrwR90Ec6oSbuaA6apvwkvtEwJ0k/KFhj1Y=
Date:   Mon, 30 Sep 2019 16:06:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Enrico Weigelt <lkml@metux.net>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        jan.kiszka@siemens.com, Frank Iwanitz <friw@hms-networks.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 3/5] staging: fieldbus core: add support for device
 configuration
Message-ID: <20190930140621.GB2280096@kroah.com>
References: <20190918183552.28959-1-TheSven73@gmail.com>
 <20190918183552.28959-4-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918183552.28959-4-TheSven73@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 02:35:50PM -0400, Sven Van Asbroeck wrote:
> Support device configuration by adding
> 
> - an in-kernel driver config API, and
> - a configfs-based userspace config ABI
> 
> In short, drivers pick a subset from a set of standardized config
> properties. This is exposed by the fieldbus core as configfs files.
> Userspace may then configure the device by writing to these configfs
> files, prior to enabling the device.

Why is a new way of doing configuration needed here?  What does this
provide that the current code doesn't already do?

And have you looked at the recent configfs fixes to make sure this code
still works with them?  I can't test this so rebasing this on 5.4-rc1
would be good for you to do first.

thanks,

greg k-h
