Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB1E206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfDRO6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:58:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388277AbfDRO6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:58:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A496E30EBB48;
        Thu, 18 Apr 2019 14:58:34 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 251A95C21F;
        Thu, 18 Apr 2019 14:58:34 +0000 (UTC)
Date:   Thu, 18 Apr 2019 10:58:32 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Patrick Brunner <brunner@stettbacher.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU Page faults when running DMA transfers from PCIe device
Message-ID: <20190418145832.GC3288@redhat.com>
References: <2987837.CvKyUSae8N@jona>
 <20190416153307.GB3254@redhat.com>
 <7bcd438c9e85449e97554d5248d580ca@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bcd438c9e85449e97554d5248d580ca@AcuMS.aculab.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 18 Apr 2019 14:58:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:37:58AM +0000, David Laight wrote:
> From: Jerome Glisse
> > Sent: 16 April 2019 16:33
> ...
> > I am no expert but i am guessing your FPGA set the request field in the
> > PCIE TLP write packet to 00:00.0 and this might work when IOMMU is off but
> > might not work when IOMMU is on ie when IOMMU is on your device should set
> > the request field to the FPGA PCIE id so that the IOMMU knows for which
> > device the PCIE write or read packet is and thus against which IOMMU page
> > table.
> 
> Interesting.
> Does that mean that a malicious PCIe device can send write TLP
> that contain the 'wrong' id (IIRC that is bus:dev:fn) and so
> write to areas that it shouldn't access?

Yes it does, they are bunch of paper on that look for IOMMU DMA
attack.

> 
> For any degree of security the PCIe bridge nearest the target
> needs to verify the id as well.
> Actually all bridges need to verify the 'bus' part.
> Then boards with 'dodgy' bridges can only write to locations
> that other dev:fn on the same board can access.

Yes they should but it has a cost and AFAIK no bridges, not even
the root port, does that. PCIE bandwidth is big and it means a
lot of packets can go through a PCIE switch or PCIE bridge and
i believe that such PCIE packet inspection have been considered
too costly. Afterall if someone can plug a rogue device to your
computer (ignoring laptop) then he can do more harm with easier
method. FGPA accelerator as PCIE device, might open a door for
clever and _resourceful_ people to try to use them as a remote
vector attack.

Cheers,
Jérôme
