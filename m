Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CDEC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD738217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfHZG4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:56:43 -0400
Received: from verein.lst.de ([213.95.11.211]:46222 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfHZG4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:56:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B993E68B20; Mon, 26 Aug 2019 08:56:39 +0200 (CEST)
Date:   Mon, 26 Aug 2019 08:56:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
Message-ID: <20190826065639.GA11036@lst.de>
References: <20190712180211.26333-1-sagi@grimberg.me> <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de> <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me> <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 12:10:23PM -0700, Sagi Grimberg wrote:
>> You are correct that this information can be derived from sysfs, but the
>> main reason why we add these here, is because in udev rule we can't
>> just go ahead and start looking these up and parsing these..
>>
>> We could send the discovery aen with NVME_CTRL_NAME and have
>> then have systemd run something like:
>>
>> nvme connect-all -d nvme0 --sysfs
>>
>> and have nvme-cli retrieve all this stuff from sysfs?
>
> Actually that may be a problem.
>
> There could be a hypothetical case where after the event was fired
> and before it was handled, the discovery controller went away and
> came back again with a different controller instance, and the old
> instance is now a different discovery controller.
>
> This is why we need this information in the event. And we verify this
> information in sysfs in nvme-cli.

Well, that must be a usual issue with uevents, right?  Don't we usually
have a increasing serial number for that or something?

If I look at other callers of kobject_uevent_env none throws in such
a huge context.

>
> Makes sense?
---end quoted text---
