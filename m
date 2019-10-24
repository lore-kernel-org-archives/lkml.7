Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3116ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6AA20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571902077;
	bh=fgT7IamvkaDSulA7YYTpY8PTrrEwCzQuYdtLVExDsEU=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=tyDgX+aLgRxgvSZ4ANNWfvnkv4HSZizf97NIEzMjIdFXdISTxDSPbJvb4Op3qUzA2
	 dT73g4T7AkleKkIr2drIRYI3fvyhssQiP+DAb4S8k7YSGDUE3G/qhP7nUiTY6ixp4k
	 MzGRZ0OoyUiv3Dh4ahJ+R+mZBj7ALRRTUOd3SRMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408599AbfJXH1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:27:55 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:33725 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408571AbfJXH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:27:55 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNXXE-0002IH-M6; Thu, 24 Oct 2019 09:27:52 +0200
To:     Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] irqchip: Skip contexts other supervisor in  =?UTF-8?Q?plic=5Finit=28=29?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 08:27:52 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <alan.mikhak@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
In-Reply-To: <20191024070311.GA16652@infradead.org>
References: <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com>
 <mhng-aefb3209-29c4-46db-8cf2-e12db46d9a6e@palmer-si-x1c4>
 <20191024013019.GA675@infradead.org> <20191024075116.48055961@why>
 <20191024070311.GA16652@infradead.org>
Message-ID: <67fff4d811c27017e7b34267365c8c0f@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: hch@infradead.org, palmer@sifive.com, paul.walmsley@sifive.com, alan.mikhak@sifive.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-24 08:03, Christoph Hellwig wrote:
> On Thu, Oct 24, 2019 at 07:51:16AM +0100, Marc Zyngier wrote:
>> > > > Will this need to change for RISC-V M-mode Linux support?
>> > > >
>> > > > 
>> https://lore.kernel.org/linux-riscv/20191017173743.5430-1-hch@lst.de/
>> > >
>> > > Yes.
>> >
>> > For M-mode we'll want to check IRQ_M_EXT above.  So we should just
>> > merge this patch ASAP and then for my rebased M-mode series I'll
>> > fix the check to do that for the M-Mode case, which is much 
>> cleaner
>> > than my hack.
>>
>> Does this need to be taken as a fix, potentially Cc to stable? Or is
>> that 5.5 material?
>
> So I though that the S-mode context were kinda aways to be sorted 
> before
> M-mode, but I can't find anything guranteeing it.  So I think this
> actually is a fix, and getting this queued up in the next -rc would
> really help me with the nommu stuff - otherwise we'd need to take it
> through the riscv tree for 5.5 to avoid conflicts.
>
> Btw, here is my:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> for the patch.

Thanks for that.

Alan, if you can respin this patch with an updated commit message, I'll 
queue
it with a couple of other nits I have lying around, and send it to 
Thomas by
the end of the week.

         M.
-- 
Jazz is not dead. It just smells funny...
