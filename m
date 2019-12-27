Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5550C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 02:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963D920409
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 02:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5UJca2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfL0CmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 21:42:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfL0CmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577414530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCaJpVVbrNTx225OC6iD9vkkqz51AJ51Qi1CAzobeDQ=;
        b=W5UJca2fvXw01Eo0Dmu1b1B4MpdS6jwi4EzWwbC9bIWPH+kfhbr9cbwypeU2JGQljU5+/2
        MA38aWgKN524DT2kwiLoN59lP/6a5yz8xX3RF1Revd0Xl/PhX3DUfyd8kcLcRNqQac5lgE
        5jkJwI2gxehL/s1pf3UaIVjGYBxTeHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-UHILjgpLPwyL298YdwwCfg-1; Thu, 26 Dec 2019 21:42:06 -0500
X-MC-Unique: UHILjgpLPwyL298YdwwCfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 655C18014D7;
        Fri, 27 Dec 2019 02:42:05 +0000 (UTC)
Received: from localhost (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19C1D81768;
        Fri, 27 Dec 2019 02:42:01 +0000 (UTC)
Date:   Fri, 27 Dec 2019 10:41:58 +0800
From:   "'bhe@redhat.com'" <bhe@redhat.com>
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Cc:     "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'ebiederm@xmission.com'" <ebiederm@xmission.com>,
        "'dyoung@redhat.com'" <dyoung@redhat.com>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'vgoyal@redhat.com'" <vgoyal@redhat.com>
Subject: Re: [RFD] kdump, kaslr: how to fix the failure of reservation of
 crashkernel low memory due to physical kaslr
Message-ID: <20191227024158.GD3355@MiWiFi-R3L-srv>
References: <OSBPR01MB4006AF8B4D355200E385850E95280@OSBPR01MB4006.jpnprd01.prod.outlook.com>
 <20191225065914.GC3355@MiWiFi-R3L-srv>
 <TYAPR01MB4014912D759953FC24D6EE1B952B0@TYAPR01MB4014.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB4014912D759953FC24D6EE1B952B0@TYAPR01MB4014.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/19 at 09:22am, d.hatayama@fujitsu.com wrote:
> 
> > -----Original Message-----
> > 
> > Hi HATAYAMA,
> > 
> > On 12/25/19 at 04:26am, d.hatayama@fujitsu.com wrote:
> > > Currently, reservation of crashkernel low memory sometimes fails due
> > > to a sparse memory caused by physical kaslr with the following
> > > message:
> > >
> > >     Cannot reserve 256MB crashkernel low memory, please try smaller size.
> > 
> > I don't understand, may not get your point. KASLR will randomize the
> > position of kernel image. However, kernel image usually takes up 50M
> > memory. Under low 4G memory, how come it can't reserve 256M crashkernel
> > low memory. Do you have the boot log of the failed case?
> 
> Thanks for your comments and sorry for the insufficient explanation.
> 
> Low 4GB memory in our system is considerably limited. The size of the largest
> contiguous free physical pages at the timing when kernel attempts at
> reserving low memory for crash kernel is less than 512MB. Hence, if physical
> kaslr inserts kernel image into the center of the chunk, every remaining
> chunks have less than 256M size. Then, the failure occurs.

OK, this is truly extreme case, thanks for sharing.

Then I have several questions about it:

1) Can we use crashkernel=high, crashkernel=low, to fix this issue?
I believe in this system you told, it must be a high-end server, should
have hardware iommu depolyed. It doesn't need 256M low memory actually,
maybe 128M, even 64M is enough?

Asking this is because the 256M is default setting, default value only
covers general cases.

2) What if the system becomes more extreme, like the largest contiguous
free physical pages is less than 256M, even less than 128M?

Even though kernel image is limited to above 4G, whose fault is it? and
how can we fix it in this case?

3) If we really add limitation, maybe add kaslr_high to limit KASLR to
only put kernel image above 4G? 

 
> > 
...
 
> > Someone ever told that some systems may not have low 4G memory since
> > they own hardware iommu. In real life, I never see such kind of system,
> > and most of them can give 256M crashkernel memory a satisfactory result.
> > Unless you reserve more than 1G under low 4G, it could fail because of
> > kinds of complicated memory reservations there.
> 
> I'm surprised to hear such system without low 4GB memory and I wonder
> how such system works well without restriction of memory access range
> in early runtime mode on x86 such as real mode.

I think they meant almost no low memory, and it's a prototype machine to
experiment. Can't remember the detail.

Thanks
Baoquan

