Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9472C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DE020730
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI9SwzAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfKTRdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:33:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37469 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728072AbfKTRdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574271199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nR1ThSYkPSj6EKFsdnP0qYjK76PkXaOodYqjHyh+W0=;
        b=jI9SwzAl31T4SgOtx+le6OomISUgEos1uLtZ6tgzDUOL6qlyXfTt2HuQI35906rbok/K4n
        hXH0eykZqQ98YqWA8USOcAI7ngfyOELKEHLSiART44mHkr7RqnhnFkb0Qu0ZZBpQ3nuSEY
        Ru0a9CaUDbyg8XO2COTOOXHtbdz+LhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-t-OIAHNFMFmrkkvPBSjsMQ-1; Wed, 20 Nov 2019 12:33:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B82708018A3;
        Wed, 20 Nov 2019 17:33:15 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-117-3.phx2.redhat.com [10.3.117.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D86D42AAB4;
        Wed, 20 Nov 2019 17:33:14 +0000 (UTC)
Date:   Wed, 20 Nov 2019 11:33:14 -0600
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        arnd@arndb.de, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>, zaitcev@redhat.com
Subject: Re: possible deadlock in mon_bin_vma_fault
Message-ID: <20191120113314.761fce32@suzdal.zaitcev.lan>
In-Reply-To: <Pine.LNX.4.44L0.1911201109500.1498-100000@iolanthe.rowland.org>
References: <0000000000002da08e0597c5efbd@google.com>
        <Pine.LNX.4.44L0.1911201109500.1498-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: t-OIAHNFMFmrkkvPBSjsMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 11:14:05 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> As it happens, I spent a little time investigating this bug report just
> yesterday.  It seems to me that the easiest fix would be to disallow
> resizing the buffer while it is mapped by any users.  (Besides,
> allowing that seems like a bad idea in any case.)
>=20
> Pete, does that seem reasonable to you?

Actually, please hold on a little, I think to think more about this.
The deadlock is between mon_bin_read and mon_bin_vma_fault.
To disallow resizing isn't going to fix _that_.

-- Pete

