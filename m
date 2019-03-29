Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF39C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2932183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553842694;
	bh=RbNngW5JANBeUp2EDQ6gAcz9e4ymVPSRuGPUlOCvfPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TuOV8OgC4B4t8LTVwqVDVM6BU8m0QTuBfzcUmySqPG8oayb1BNWdY8brMUgFSyO7u
	 3WmtpZMl/DgT+rteij6iZMHTxtapZFUKVuttbVQAZ7/PcNSNzy2yOcDbAffIZJeKPh
	 DrFUd2zXM+Y9NbivdiowcgjBLmCc7bJ067+hrpHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfC2G6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfC2G6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:58:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB662173C;
        Fri, 29 Mar 2019 06:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553842691;
        bh=RbNngW5JANBeUp2EDQ6gAcz9e4ymVPSRuGPUlOCvfPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocs8bxR9gamjHpGaOJPE/v/dgF74iSbxjpvLtLbJsEM6tlnLZubCFxDLgfOS47P9g
         dW1dtScL7cYYUyFffWH685ApEYPTTL5gvqAKXtARQRoc4VXXaLBvESJ0zTx/LkbyUt
         211lR89DiYmZzzyPsbRnAdQ07pnBPcarw2qLAoiw=
Date:   Fri, 29 Mar 2019 07:58:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: kernfs: can read/write method grow buffer size?
Message-ID: <20190329065809.GA3908@kroah.com>
References: <20190329040922.34ab01c6@nic.cz>
 <20190329062253.GA9659@kroah.com>
 <20190329075107.0b4d8c9f@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329075107.0b4d8c9f@nic.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 07:51:07AM +0100, Marek Behun wrote:
> > If this is just for kernfs, and you have your own filesystem, sure, we
> > can probably do something here.  But if this is for sysfs, no, you all
> > need to keep to the "one value per file" rule that we have there
> > please.
> 
> Greg, the file satisfies the "one value per file" rule. That value is
> the currently selected trigger. Writing a trigger name changes this
> value. It is just that reading also prints all the supported triggers.

"all supported triggers" is not a "single value" :)
