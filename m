Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98230C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705E920820
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405324AbfFKKYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:24:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405151AbfFKKYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:24:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8A5331628E2;
        Tue, 11 Jun 2019 10:24:31 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FA1660BF1;
        Tue, 11 Jun 2019 10:24:31 +0000 (UTC)
Date:   Tue, 11 Jun 2019 18:24:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: The current SME implementation fails kexec/kdump kernel booting.
Message-ID: <20190611102428.GF26148@MiWiFi-R3L-srv>
References: <20190604134952.GC26891@MiWiFi-R3L-srv>
 <508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com>
 <20190605005600.GF26891@MiWiFi-R3L-srv>
 <0d9fba9d-7bbe-a7c7-dfe4-696da0dfecc4@amd.com>
 <2fe0e56c-9286-b71d-3d6d-c2a6fbcfba89@redhat.com>
 <33b9237f-5e8c-fe49-4f55-220ce9a492fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b9237f-5e8c-fe49-4f55-220ce9a492fb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 11 Jun 2019 10:24:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 06/11/19 at 05:52pm, lijiang wrote:
> After applied Tom's patch, i changed the reserved memory(for crash kernel) to the
> above 256M(>256M), such as crashkernel=320M or 384M,512M..., the kdump kernel can
> work and successfully dump the vmcore.
> 
> But the kdump kernel always happened the panic or could not boot successfully in
> the 256M(<= 256M) case, and on HP machine, i noticed that it printed OOM, the kdump
> kernel was too smaller memory. But i never see the OOM on speedway machine(probably
> related to the earlyprintk, it doesn't work and it loses many logs).
> 
> After removing the option 'CONFIG_DEBUG_INFO' from .config, i tested again, the kdump
> kernel did not happen the panic in the 256M(crashkernel=256M), the kdump kernel can
> work and succeed to dump the vmcore on HP machine or speedway machine.
> 
> It seems that the small memory caused the previous failure in kdump kernel. I would
> suggest to post this patch to upstream. What's your opinion? Tom, Baoquan and other
> people. Or do you have any comment?

As Lianbo said at above, the previous failure in kdump kernel is caused
by OOM. Just the log on speedway is incomplete, I am not sure what
happened. Now after investigation, your patch works to fix the issue.
Could you post it for riviewing?

Thanks
Baoquan
