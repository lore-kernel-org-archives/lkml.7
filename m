Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BBDC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4EA214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbfDRHZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:25:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfDRHZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:25:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 451913007426;
        Thu, 18 Apr 2019 07:25:44 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA3DF600C2;
        Thu, 18 Apr 2019 07:25:42 +0000 (UTC)
Message-ID: <25e684a4d347181aa6b6dc1e41d1794203bbae03.camel@redhat.com>
Subject: Re: [PATCH] nvme: determine the number of IO queues
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Aaron Ma <aaron.ma@canonical.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, axboe@fb.com
Date:   Thu, 18 Apr 2019 10:25:41 +0300
In-Reply-To: <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
         <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
         <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
         <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 18 Apr 2019 07:25:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-18 at 14:21 +0800, Aaron Ma wrote:
> On 4/18/19 1:33 AM, Maxim Levitsky wrote:
> > On Wed, 2019-04-17 at 20:32 +0300, Maxim Levitsky wrote:
> > > On Wed, 2019-04-17 at 22:12 +0800, Aaron Ma wrote:
> > > > Some controllers support limited IO queues, when over set
> > > > the number, it will return invalid field error.
> > > > Then NVME will be removed by driver.
> > > > 
> > > > Find the max number of IO queues that controller supports.
> > > > When it still got invalid result, set 1 IO queue at least to
> > > > bring NVME online.
> > > 
> > > To be honest a spec compliant device should not need this.
> > > The spec states:
> > > 
> > > "Number of I/O Completion Queues Requested (NCQR): Indicates the number of
> > > I/O
> > > Completion
> > > Queues requested by software. This number does not include the Admin
> > > Completion
> > > Queue. A
> > > minimum of one queue shall be requested, reflecting that the minimum
> > > support
> > > is
> > > for one I/O
> > > Completion Queue. This is a 0’s based value. The maximum value that may be
> > > specified is 65,534
> > > (i.e., 65,535 I/O Completion Queues). If the value specified is 65,535,
> > > the
> > > controller should return
> > > an error of Invalid Field in Command."
> > > 
> > > 
> > > This implies that you can ask for any value and the controller must not
> > > respond
> > > with an error, but rather indicate how many queues it supports.
> > > 
> > > Maybe its better to add a quirk for the broken device, which needs this?
> 
> Adding quirk only makes the code more complicated.
> This patch doesn't change the default behavior.
> Only handle the NVME error code.
> 
> Yes the IO queues number is 0's based, but driver would return error and
> remove the nvme device as dead.

No, no, the spec says that no matter what the number queues you ask for, unless
it is 65,535, the controller should not fail with an error, but rather indicate
in the return value (in the completion entry) the actual number of queues it
allocated which can be larger or smaller that what you asked for.

If controller returns an error, that means its firmware has a bug, which is not
something unusual but usually those cases are handled with a quirk rather than
with general code change.

But anyway that is just my opinion, as someone who studied and implemented
(hopefully mostly correctly) the spec very recently (I am the author of nvme-
mdev device).

It doesn't really matter to me if this is implemented this or another way as
long as it doesn't break things.

Best regards,
	Maxim Levitsky



> 
> So set it as 1 at least the NVME can be probed properly.
> 
> Regards,
> Aaron
> 
> > I forgot to add the relevant paragraph:
> > 
> > "Note: The value allocated may be smaller or larger than the number of
> > queues
> > requested, often in virtualized
> > implementations. The controller may not have as many queues to allocate as
> > are
> > requested. Alternatively,
> > the controller may have an allocation unit of queues (e.g. power of two) and
> > may
> > supply more queues to
> > host software to satisfy its allocation unit."




> > 
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 


