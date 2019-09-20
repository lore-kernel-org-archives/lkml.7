Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFA7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64AC20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OdjC06zX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="bEOK5oau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405721AbfITC4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:56:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53730 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404240AbfITC4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:56:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66E8D27046;
        Thu, 19 Sep 2019 22:56:18 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=DxwA3Xb/j2BmQm76HYP5HmvpMK0=; b=OdjC06
        zXUq8YTULHORUItoAvRfnXd08ov9T5VOAE7PUdURZvaXDFIBu2tDUneLwCI+u7fT
        8mXT3pACfe7gXr29NpHrQYUEgX2U0XuXnEASOXyJEKp9gFxnprvG7b5Ppg5d6AQJ
        g/BbnQeuxyLK697twtLUq9bztkvA8FT9mEJtY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C03527044;
        Thu, 19 Sep 2019 22:56:18 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=KxVWMOQwuPubePImZVl5t1gqR2PwuYXiHV8sMvllCO4=; b=bEOK5oauHGt+2Vquj2cCGyyusTHwIBz7dSIQCFCFQG5bJPfYxBM4DfrV9G6Wp5h1lDlmtrWow6/NGlKOO4VamWy5uu8+7gLlg9l46wQ/aJROI+9TPnUhwtdcw1TzNR8Jjz9N6VgstxIPcIDslC88UAhXyJrHjwt7haI6LUHU4zU=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE87527043;
        Thu, 19 Sep 2019 22:56:16 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id DB46D2DA01D7;
        Thu, 19 Sep 2019 22:56:15 -0400 (EDT)
Date:   Thu, 19 Sep 2019 22:56:15 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Xiaoming Ni <nixiaoming@huawei.com>, penberg@cs.helsinki.fi,
        jslaby@suse.com, textshell@uchuujin.de, sam@ravnborg.org,
        daniel.vetter@ffwll.ch, mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        yuehaibing@huawei.com, zengweilin@huawei.com
Subject: Re: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
In-Reply-To: <20190919092933.GA2684163@kroah.com>
Message-ID: <nycvar.YSQ.7.76.1909192251210.24536@knanqh.ubzr>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com> <20190919092933.GA2684163@kroah.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 36F541B0-DB52-11E9-A06F-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019, Greg KH wrote:

> On Thu, Sep 19, 2019 at 05:18:15PM +0800, Xiaoming Ni wrote:
> > Using kzalloc() to allocate memory in function con_init(), but not
> > checking the return value, there is a risk of null pointer references
> > oops.
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> 
> We keep having this be "reported" :(

Something probably needs to be "communicated" about that.

> >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > +		if (unlikely(!vc)) {
> > +			pr_warn("%s:failed to allocate memory for the %u vc\n",
> > +					__func__, currcons);
> > +			break;
> > +		}
> 
> At init, this really can not happen.  Have you see it ever happen?

This is maybe too subtle a fact. The "communication" could be done with 
some GFP_WONTFAIL flag, and have the allocator simply pannic() if it 
ever fails.


Nicolas
