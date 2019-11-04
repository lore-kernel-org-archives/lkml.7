Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E4ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E61D2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VooYNBPZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="YljOLRyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfKDSeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:34:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52880 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:34:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B56C03E03C;
        Mon,  4 Nov 2019 13:33:58 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=e7PwpGAxLaK9hITw0k2+J0F+lgA=; b=VooYNB
        PZ41R4Uru+sbw9DVsoeNvJ7dB5upcYUp0d2bxO9/pYcpnnqTBJx4CzoQ2jFaGK0H
        Pef/38YS49LVDkmhlarklKr5F+dx1OMNGOJ69mII1aniev3p6lsNZ26wuJBAVbNd
        gjcQbKYlUH9MdUUUg/t4OUFMB9yAYw2xdHnIo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC3273E03B;
        Mon,  4 Nov 2019 13:33:58 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=hQNJPUfM0xyDSLDp5OyD+58Z145FE/Z/cw3WPuEF1CE=; b=YljOLRyhL1it1+4zUaIj9VyNrM0PEkwhiEbsehzIXtpIZsi74ItN6kJUuEptVK3HExhxl/inKpr1msmBUu/mb69BnavFdRa5886U5CrFNuiPVQioaUtYG4k7AO8CtIGN4teU8aATonPYq+tpE5/fFGGaxp7YGg3xyDwkEhzVWZs=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21DD23E03A;
        Mon,  4 Nov 2019 13:33:58 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 482EA2DA01A9;
        Mon,  4 Nov 2019 13:33:57 -0500 (EST)
Date:   Mon, 4 Nov 2019 19:33:57 +0100 (CET)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Or Cohen <orcohen@paloaltonetworks.com>
cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        textshell@uchuujin.de, Daniel Vetter <daniel.vetter@ffwll.ch>,
        sam@ravnborg.org, mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
In-Reply-To: <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr>
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com> <20191104152428.GA2252441@kroah.com> <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr> <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: A9F8731E-FF31-11E9-9E0C-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019, Or Cohen wrote:

> @gregkh@linuxfoundation.org @nico@fluxnic.net  - Thanks for the quick response.
> @gregkh@linuxfoundation.org  - Regarding your question, I don't think
> the 1 byte buffer is related to the problem. (  it's just was there in
> the initial reproducer the fuzzer created, and I forgot to remove it
> while reducing code from the reproducer ).

I think I know what the problem is. I have no time to test it though.

Please try this (untested) patch. Also please try running the same test 
code but with vcsa6 in addition to vcsu6 to be sure.

---------- >8
Subject: [PATCH] vcs: add missing validation on vcs_size() returned value

One usage instance didn't account for the fact that vcs_size() may
return a negative error code.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 1f042346e7..fa07d79027 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -474,6 +474,10 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		goto unlock_out;
 
 	size = vcs_size(inode);
+	if (size < 0) {
+		ret = size;
+		goto unlock_out;
+	}
 	ret = -EINVAL;
 	if (pos < 0 || pos > size)
 		goto unlock_out;
