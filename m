Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB09C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40A3206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfFEVXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:23:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEVXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:23:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A5D6C057F4B;
        Wed,  5 Jun 2019 21:23:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEA292C8F4;
        Wed,  5 Jun 2019 21:22:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6439.1559769583@warthog.procyon.org.uk>
References: <6439.1559769583@warthog.procyon.org.uk> <20190605165530.GA15790@vmlxhi-102.adit-jv.com> <20190605090556.17792-1-erosca@de.adit-jv.com> <20190605100337.GA9350@kroah.com>
Cc:     dhowells@redhat.com, Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Kento Kobayashi <Kento.A.Kobayashi@sony.com>,
        Hui Peng <benquike@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        Bin Liu <b-liu@ti.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jon Flatley <jflat@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        "George G . Davis" <george_davis@mentor.com>,
        yuichi.kusakabe@denso-ten.com, yohhei.fukui@denso-ten.com,
        natsumi.kamei@denso-ten.com, yasano@jp.adit-jv.com,
        sliu@de.adit-jv.com, Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: hub: report failure to enumerate uevent to userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6723.1559769775.1@warthog.procyon.org.uk>
Date:   Wed, 05 Jun 2019 22:22:55 +0100
Message-ID: <6724.1559769775@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 05 Jun 2019 21:23:04 +0000 (UTC)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> >  - Looking at commit [4], it seems that the new "notifier" interface/api
> >    forces userspace applications to link against -lkeyutils [5].
> 
> No.  The keyctl(2) syscall is implemented in -lkeyutils library, and not in
> -lc.  That's all.  If you want to call KEYCTL_NOTIFY to watch a key or
> keyring, you need it; not otherwise.

Sorry, KEYCTL_WATCH_KEY, not KEYCTL_NOTIFY.  I've changed my mind about the
naming of things a couple of times and should probably harmonise them.

David
