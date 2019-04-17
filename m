Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED65E20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbfDQRdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56033 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732321AbfDQRdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:33:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 398BA307EA8F;
        Wed, 17 Apr 2019 17:33:39 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B10F8608C1;
        Wed, 17 Apr 2019 17:33:37 +0000 (UTC)
Message-ID: <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
Subject: Re: [PATCH] nvme: determine the number of IO queues
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Aaron Ma <aaron.ma@canonical.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, axboe@fb.com
Date:   Wed, 17 Apr 2019 20:33:36 +0300
In-Reply-To: <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
         <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 17 Apr 2019 17:33:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-17 at 20:32 +0300, Maxim Levitsky wrote:
> On Wed, 2019-04-17 at 22:12 +0800, Aaron Ma wrote:
> > Some controllers support limited IO queues, when over set
> > the number, it will return invalid field error.
> > Then NVME will be removed by driver.
> > 
> > Find the max number of IO queues that controller supports.
> > When it still got invalid result, set 1 IO queue at least to
> > bring NVME online.
> 
> To be honest a spec compliant device should not need this.
> The spec states:
> 
> "Number of I/O Completion Queues Requested (NCQR): Indicates the number of I/O
> Completion
> Queues requested by software. This number does not include the Admin
> Completion
> Queue. A
> minimum of one queue shall be requested, reflecting that the minimum support
> is
> for one I/O
> Completion Queue. This is a 0’s based value. The maximum value that may be
> specified is 65,534
> (i.e., 65,535 I/O Completion Queues). If the value specified is 65,535, the
> controller should return
> an error of Invalid Field in Command."
> 
> 
> This implies that you can ask for any value and the controller must not
> respond
> with an error, but rather indicate how many queues it supports.
> 
> Maybe its better to add a quirk for the broken device, which needs this?

I forgot to add the relevant paragraph:

"Note: The value allocated may be smaller or larger than the number of queues
requested, often in virtualized
implementations. The controller may not have as many queues to allocate as are
requested. Alternatively,
the controller may have an allocation unit of queues (e.g. power of two) and may
supply more queues to
host software to satisfy its allocation unit."


Best regards,
	Maxim Levitsky

