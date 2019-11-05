Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB25AC49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E6C21D7C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TGd/Jq0h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="VHxL22Xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfKEJdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:33:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50913 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfKEJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:33:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C368923272;
        Tue,  5 Nov 2019 04:33:18 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=UI3sGkR+m+FxKVkxeX7FyuZcwwk=; b=TGd/Jq
        0hG6Tm9Z110b9Fn4OhNBW9OcNWFWLg1l3dBkZ0flDHj5679dAsgA4hjmINTbxADH
        D19cWQk0Y+r4gFs4/Vapf0SlyJ3eAAcATGDMobGEmHz0WElLtpQbKbbayKvim7gR
        ug8nIZtRn8M59sssaRexvGyjDR4fQTBLOLbx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8B5123270;
        Tue,  5 Nov 2019 04:33:18 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=zQ0sgijWpvq8TVQaO2Q8qgIXrldRTox7VuE3XUJ16aM=; b=VHxL22XpDsujIBPRyVYXAZxo/kJoRymv7PtQAIYqRQcDRfaL2EEQJZhv0fNLULJuCbA+4NMoP5+JxaBacrUIwwvy9QnTkfe1phraR+WzfPqqA9VE1euHA/84OIjQWuYGPQBnN/CRkOBa/rnZL+7I5IugtjZo/wzGn+dfZBziYn8=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E14B42326F;
        Tue,  5 Nov 2019 04:33:17 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 10ABF2DA01C8;
        Tue,  5 Nov 2019 04:33:17 -0500 (EST)
Date:   Tue, 5 Nov 2019 10:33:16 +0100 (CET)
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
In-Reply-To: <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com>
Message-ID: <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com> <20191104152428.GA2252441@kroah.com> <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr> <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr> <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com> <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com> <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 4C824268-FFAF-11E9-928C-C28CBED8090B-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Jiri Slaby wrote:

> Because unicode uses 4 bytes. The issue is that there is no handling for
> unicode in vcs_write at all. (Compare with vcs_read.)

Exact.

----- >8

Subject: [PATCH] vcs: prevent write access to vcsu devices

Commit d21b0be246bf ("vt: introduce unicode mode for /dev/vcs") guarded
against using devices containing attributes as this is not yet
implemented. It however failed to guard against writes to any devices
as this is also unimplemented.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Cc: <stable@vger.kernel.org> # v4.19+

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index fa07d79027..ef19b95b73 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -456,6 +456,9 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	size_t ret;
 	char *con_buf;
 
+	if (use_unicode(inode))
+		return -EOPNOTSUPP;
+
 	con_buf = (char *) __get_free_page(GFP_KERNEL);
 	if (!con_buf)
 		return -ENOMEM;

