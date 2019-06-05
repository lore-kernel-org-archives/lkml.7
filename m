Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870FCC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615382075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFEVUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:20:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEVUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69BACA00F9;
        Wed,  5 Jun 2019 21:20:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C7EE196F8;
        Wed,  5 Jun 2019 21:19:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190605165530.GA15790@vmlxhi-102.adit-jv.com>
References: <20190605165530.GA15790@vmlxhi-102.adit-jv.com> <20190605090556.17792-1-erosca@de.adit-jv.com> <20190605100337.GA9350@kroah.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     dhowells@redhat.com
CC:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-ID: <6438.1559769583.1@warthog.procyon.org.uk>
Date:   Wed, 05 Jun 2019 22:19:43 +0100
Message-ID: <6439.1559769583@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 05 Jun 2019 21:20:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

>  - Looking at commit [4], it seems that the new "notifier" interface/api
>    forces userspace applications to link against -lkeyutils [5].

No.  The keyctl(2) syscall is implemented in -lkeyutils library, and not in
-lc.  That's all.  If you want to call KEYCTL_NOTIFY to watch a key or
keyring, you need it; not otherwise.

>    Assuming the latter is designed for ("Kernel key management") [6],
>    it may look like the keyutils library is being abused to handle
>    the "USB (or really any hardware events)". Do you really plan to
>    extend the scope of the library to handle these new tasks?

No.

That said, it's probably worth providing some userspace library to wrap the
ring management.

David
