Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F06C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668E72064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M/xogNKD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="g1zqEcF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfKZVzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:55:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64681 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZVzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:55:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C4513CCCE;
        Tue, 26 Nov 2019 16:55:33 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=P1UU6Z+LWUxmaHzDSzTQosS3wg8=; b=M/xogN
        KDFqkytSirUSXQfuw2+LwlAkeZIy/XXRvxrfdX5XXhC+xSFgr9sF7V19cxiP6ERj
        VIsAOwv0NN/r8WsAbchUWVf/YRwcEJgfmoatlv0ZzL6V+ubR2lC0PKqJKRRHPGws
        HXHkuT1ApftKsWCEoAMxNvjwkdxo6tz5g/juQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 910653CCCD;
        Tue, 26 Nov 2019 16:55:33 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=ow40iNd6Ls1JDoeg0ZPVyxjWAQ2J8KE2uekBNvGq++I=; b=g1zqEcF8icvo4by6C0az6szytmVtdbOxAsXZEpJYZtWgytRRWk50VwkEh2j9aABVWWbyk3JbKSICp/q2zFxrYB3KYS+j98eSgN2qFwOqP5HomgOpbI0axC/dWrz3sIU4H4QLCt4clGS9eNyysCrBaRNejpkj9y05JZ9JGUVQ7lA=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEC583CCCC;
        Tue, 26 Nov 2019 16:55:32 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 24B992DA010B;
        Tue, 26 Nov 2019 16:55:32 -0500 (EST)
Date:   Tue, 26 Nov 2019 16:55:32 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jslaby@suse.com>,
        Or Cohen <orcohen@paloaltonetworks.com>, textshell@uchuujin.de,
        Daniel Vetter <daniel.vetter@ffwll.ch>, sam@ravnborg.org,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
In-Reply-To: <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1911261652290.8537@knanqh.ubzr>
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com> <20191104152428.GA2252441@kroah.com> <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr> <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr> <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com> <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com> <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com>
 <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 78243216-1097-11EA-8A1A-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, could you apply this please?


On Tue, 5 Nov 2019, Nicolas Pitre wrote:

> Subject: [PATCH] vcs: prevent write access to vcsu devices
> 
> Commit d21b0be246bf ("vt: introduce unicode mode for /dev/vcs") guarded
> against using devices containing attributes as this is not yet
> implemented. It however failed to guard against writes to any devices
> as this is also unimplemented.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Cc: <stable@vger.kernel.org> # v4.19+
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index fa07d79027..ef19b95b73 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -456,6 +456,9 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
>  	size_t ret;
>  	char *con_buf;
>  
> +	if (use_unicode(inode))
> +		return -EOPNOTSUPP;
> +
>  	con_buf = (char *) __get_free_page(GFP_KERNEL);
>  	if (!con_buf)
>  		return -ENOMEM;
> 
> 
