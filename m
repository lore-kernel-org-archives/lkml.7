Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA9C1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800B12190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="txxpP80f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="f3NnrhSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbfKENoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:44:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65182 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbfKENoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:44:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E07E79F251;
        Tue,  5 Nov 2019 08:44:18 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=QRL6lDJwPIhr0aPJSM491ZqazIM=; b=txxpP8
        0fMJ5oS2tW/G2dmf3ue7aryydtOs2tcfegSnlxJv/JqNs1IWSq+RNBEA8k8bnt1z
        QM0oWJ9zngaR4f8mup3Al+j4hjbZAQM6KFLgGtp/T/pq10kJj7Ph/bCSjEEe5KCM
        Si0wFFRu1sK4wpyMMINCCIhZ+BDgshiGfZbNc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D795D9F24D;
        Tue,  5 Nov 2019 08:44:18 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=q3pLhWjndSWDxdR1GJbLTbPdN+s1QCbqTauwlpf9/H4=; b=f3NnrhSGx8TT6rGOslw2Fezqyr76RvvVR4n2DlO7qDdzNf6EbHxtYeoGhDGY1csM3tNF4F1V8DgT3LtAKJziXqVUpv/Ymb9f0g/ebHrcIFutSs+w+k8uzkKuueiyqeyNy9K6IYOKbmJ7ufnmGqDXKvJQbJ3rgn8AJAnXdQo3nt8=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A95689F24C;
        Tue,  5 Nov 2019 08:44:15 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 9D3812DA01C8;
        Tue,  5 Nov 2019 08:44:13 -0500 (EST)
Date:   Tue, 5 Nov 2019 14:44:13 +0100 (CET)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jiri Slaby <jslaby@suse.com>
cc:     Or Cohen <orcohen@paloaltonetworks.com>,
        Greg KH <gregkh@linuxfoundation.org>, textshell@uchuujin.de,
        Daniel Vetter <daniel.vetter@ffwll.ch>, sam@ravnborg.org,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
In-Reply-To: <fb1744cd-2680-1459-16de-8d6a4afd666d@suse.com>
Message-ID: <nycvar.YSQ.7.76.1911051430050.30289@knanqh.ubzr>
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com> <20191104152428.GA2252441@kroah.com> <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr> <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr> <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com> <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com> <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com> <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
 <fb1744cd-2680-1459-16de-8d6a4afd666d@suse.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 5BA28726-FFD2-11E9-BA90-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Jiri Slaby wrote:

> On 05. 11. 19, 10:33, Nicolas Pitre wrote:
> > Subject: [PATCH] vcs: prevent write access to vcsu devices
> > 
> > Commit d21b0be246bf ("vt: introduce unicode mode for /dev/vcs") guarded
> > against using devices containing attributes as this is not yet
> > implemented. It however failed to guard against writes to any devices
> > as this is also unimplemented.
> > 
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > Cc: <stable@vger.kernel.org> # v4.19+
> > 
> > diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> > index fa07d79027..ef19b95b73 100644
> > --- a/drivers/tty/vt/vc_screen.c
> > +++ b/drivers/tty/vt/vc_screen.c
> > @@ -456,6 +456,9 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
> >  	size_t ret;
> >  	char *con_buf;
> >  
> > +	if (use_unicode(inode))
> > +		return -EOPNOTSUPP;
> 
> Looks good to me. I am also thinking about a ban directly in open:
> 
> if (use_unicode(inode) && (filp->f_flags & O_ACCMODE) != O_RDONLY)
>   return -EOPNOTSUPP;
> 
> Would that break the unicode users?

The user I know about uses a common helper that uses O_RDWR.
So yes, in that case that would break it.


Nicolas
