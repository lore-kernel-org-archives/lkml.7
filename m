Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD669C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD5B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="f0nyRU3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfC2GvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:51:10 -0400
Received: from mail.nic.cz ([217.31.204.67]:40077 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbfC2GvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:51:09 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id CD8526334D;
        Fri, 29 Mar 2019 07:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1553842267; bh=6kwZjFrCY4G1pujXAJohdftLAdytGFnzRD5AMinmrng=;
        h=Date:From:To;
        b=f0nyRU3AgSlExd08vrnlrYVqAdDUdZ9t1kPkyehDZJZTRHK0D/Bhgun4jRIGhcwMO
         qaGCpSDJg6g9/0+W6WFSutlVVgcc/gJ6rIRo3YyKaanFmLuBFmjhagNPmB0t2iwiXq
         +nOLCWX7J+0WfasuuE9D9zouvKasosdWhjxElEJU=
Date:   Fri, 29 Mar 2019 07:51:07 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: kernfs: can read/write method grow buffer size?
Message-ID: <20190329075107.0b4d8c9f@nic.cz>
In-Reply-To: <20190329062253.GA9659@kroah.com>
References: <20190329040922.34ab01c6@nic.cz>
        <20190329062253.GA9659@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If this is just for kernfs, and you have your own filesystem, sure, we
> can probably do something here.  But if this is for sysfs, no, you all
> need to keep to the "one value per file" rule that we have there
> please.

Greg, the file satisfies the "one value per file" rule. That value is
the currently selected trigger. Writing a trigger name changes this
value. It is just that reading also prints all the supported triggers.
