Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7063C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B272077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="LofytUg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfLKBuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:50:32 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:16140 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfLKBuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:50:32 -0500
X-AuditID: 0a650161-78bff700000078a3-59-5df061f0b2de
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 8F.91.30883.0F160FD5; Wed, 11 Dec 2019 11:26:40 +0800 (HKT)
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1576029033; h=from:subject:to:date:message-id;
        bh=GDP4lwpnPGHSml2nz6UBsKaZA9PARfPjveD395Vnf3U=;
        b=LofytUg4JkjMkVo9cdYJYOQwtup1Slaag3ycBmWZTXmu1OhZwHs8Ar3fo0YVrO0DQY9DGR7oPsO
        KyXdZ7wpnhQgpLme0qMfIdRkyhwIPnjlVt4bGWy1mNAZ7Rucco9LcuJbbc+1a6xciP68/fHHxiHjM
        7w0bgf61iF90khRLiEs=
Received: from hsj-Precision-5520 (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Wed, 11 Dec 2019 09:50:31 +0800
Date:   Wed, 11 Dec 2019 09:50:21 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Jason Baron <jbaron@akamai.com>
CC:     <linux-kernel@vger.kernel.org>, <1537577747@qq.com>,
        Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH V2] lib/dynamic_debug: make better dynamic log output
Message-ID: <20191211015021.GA2693@hsj-Precision-5520>
References: <20191209094437.14866-1-sjhuang@iluvatar.ai>
 <20191210063820.26766-1-sjhuang@iluvatar.ai>
 <f6ec7ce2-278c-4795-6f19-c31592b8868f@akamai.com>
MIME-Version: 1.0
In-Reply-To: <f6ec7ce2-278c-4795-6f19-c31592b8868f@akamai.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXClcqYpvsh8UOswbPtLBaTrx5gs5ix+Dir
        xbW3d1gtLu+aw+bA4jH5yAJmj52z7rJ73Hq2ltXj8ya5AJYoLpuU1JzMstQifbsEroy+le8Z
        C06ZVfw5eoC5gXGPThcjB4eEgInEjld1XYxcHEICJxglJq2fxdrFyMnBLKAjsWD3JzaQGmYB
        aYnl/zhAalgE3jJJ7Jp3hgmi4TujxPEHm8EaWARUJV5vOs4IYrMJaEjMPXGXGcQWEVCWuPLx
        BtTQGIk7N46C1QgLeEp82v6HDcTmFTCTuHN1MwvE0NmMEifnt0IlBCVOznzCAmJzCthJNPzt
        B7NFgYYe2HacCeQ6IQEFiRcrtUDCEgJKEkv2zmKCsAslZkxcwTiBUXgWkn9mIfwzC8mCBYzM
        qxj5i3PT9TJzSssSSxKL9BIzNzFCwj5xB+ONzpd6hxgFOBiVeHgFzr+PFWJNLCuuzD3EKMHB
        rCTCe7ztXawQb0piZVVqUX58UWlOavEhRmkOFiVxXqF/T2OEBNITS1KzU1MLUotgskwcnFIN
        TP7c3uJbEs/wvnim2nazaVGbyqaZPMw/pdrYxBnmfpmg/ik45dvOKUvq+b2mKn93vKpQ7//n
        2Pdv1w8u/DRpedARPcepm95zH75TweS5Wvbs2uCO1PcbjrNPz433NM7qNEw4lP8l1c+QUUkg
        Znbjltpti9r0d53fGmYQMf211xMbuUgHHc7XqdcPRf5eerZw2g/BnMPHPlyKuak4vWiC1Iqp
        IbpfzE+JPF6zznnD1qnfju/c77da6tHZ5RV1P1w+eU4p2v9AbwKjb5bsqX+zbvt0nm3lbr9V
        zj3NLKI8RP1tqLrSyslJaqsanOwbdcIqqh7+vLRgd6vCy/6HdT6rJa6s/FplKTDriBjbZMMS
        13lKLMUZiYZazEXFiQC7/8TK+AIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 01:16:10PM -0500, Jason Baron wrote:
> 
> 
> On 12/10/19 1:38 AM, Huang Shijie wrote:
> > The driver strings and device name is not changed for the driver's dynamic
> > log output. But the dynamic_emit_prefix() which contains the function names
> > may change when the function names change.
> > 
> > So the patch makes the better dynamic log output.
> > 
> > Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> > ---
> > v1 -- >v2
> >    Add a whitespace between driver strings and dev name.
> > ---
> >  lib/dynamic_debug.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index c60409138e13..f6665af6abd4 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -589,9 +589,9 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
> >  	} else {
> >  		char buf[PREFIX_SIZE];
> >  
> > -		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
> > -				dynamic_emit_prefix(descriptor, buf),
> > +		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s %s %s: %pV",
> >  				dev_driver_string(dev), dev_name(dev),
> > +				dynamic_emit_prefix(descriptor, buf),
> >  				&vaf);
> >  	}
> >  
> > 
> 
> 
> Hi Huang,
> 
> So this is just reversing the order of output. All the other dynamic
> debug calls emit the 'prefix' first, so if we were to change this it
> seems like we'd also want to change the other ones to be consistent.
okay, I will check that.

> 
> That said, I'm not sure why reversing things here is better?
I quote the some output log here:

Before this patch:
        ------------------------------------------------------------
	[   66.159851] [1412] bi_ioctl: iluvatar-bi 0000:00:03.0: ioctl : AIP_MEM_CREATE
	[   66.159855] [1412] bi_ioctl_aip_mem_create: iluvatar-bi 0000:00:03.0: start bi_ioctl_aip_mem_create
	[   66.159874] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: [mem_handle: 0xffff88814ff56000](bi_ioctl_aip_mem_create) vdev:0xffff888157951200:8
	[   66.159877] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	ctx           : 0xffff888157950d80
	[   66.159879] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	heap          : host
	[   66.159882] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	flags         : user ptr:0, fence:1, exe:0
	[   66.159886] [1412] mem_handle_print_submit_refcnt: iluvatar-bi 0000:00:03.0: mem_handle_print_submit_refcnt:532[mem_handle_get_submit_refcnt] mem ffff88814ff56000, ref_cnt 0
	[   66.159888] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	status        : free
	[   66.159890] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	location      : un set
	[   66.159893] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	size          : 0x64, pg num 0x0
	[   66.159895] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	sys va (user) : 0x0
	[   66.159898] [1412] mem_handle_dump_pte: iluvatar-bi 0000:00:03.0: 		invld_host_ava[0]   : 0x0
	[   66.159900] [1412] mem_handle_dump_pte: iluvatar-bi 0000:00:03.0: 		invld_host_ava[1]   : 0x0
	[   66.159902] [1412] mem_handle_dump_pte: iluvatar-bi 0000:00:03.0: 		invld_host_ava[2]   : 0x0
	[   66.159905] [1412] mem_handle_dump_pte: iluvatar-bi 0000:00:03.0: 		invld_host_ava[3]   : 0x0
	[   66.159907] [1412] mem_handle_dump_pte: iluvatar-bi 0000:00:03.0: 		invld_host_ava[4]   : 0x0
	[   66.159909] [1412] mem_handle_dump_pte: iluvatar-bi 0000:00:03.0: 		invld_host_ava[5]   : 0x0
	[   66.159911] [1412] mem_handle_dump_pte: iluvatar-bi 0000:00:03.0: 		invld_host_ava[6]   : 0x0
	[   66.159914] [1412] mem_handle_dump_pte: iluvatar-bi 0000:00:03.0: 		invld_host_ava[7]   : 0x0
	[   66.159916] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	dev_va        : 0x0
	[   66.159918] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	dev_pa        : 0x0
	[   66.159920] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	refcount      : 0x0
	[   66.159923] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	destroy delay : false
	[   66.159925] [1412] __mem_handle_dump: iluvatar-bi 0000:00:03.0: 	pinned pages  : 0x0 (0, 0)
        ------------------------------------------------------------

After this patch, the log looks like this:
        ------------------------------------------------------------
	[ 8523.289844] iluvatar-bi 0000:00:03.0 [1491] bi_ioctl: : ioctl : AIP_MEM_CREATE
	[ 8523.290494] iluvatar-bi 0000:00:03.0 [1491] bi_ioctl_aip_mem_create: : start bi_ioctl_aip_mem_create
	[ 8523.290646] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : [mem_handle: 0xffff888158b7ec80](bi_ioctl_aip_mem_create) vdev:0xffff8881574d9b00:8
	[ 8523.290649] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	ctx           : 0xffff888150b3a880
	[ 8523.290651] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	heap          : device
	[ 8523.290654] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	flags         : user ptr:0, fence:0, exe:0
	[ 8523.290659] iluvatar-bi 0000:00:03.0 [1491] mem_handle_print_submit_refcnt: : mem_handle_print_submit_refcnt:532[mem_handle_get_submit_refcnt] mem ffff888158b7ec80, ref_cnt 0
	[ 8523.290661] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	status        : free
	[ 8523.290664] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	location      : un set
	[ 8523.290666] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	size          : 0x10000, pg num 0x10
	[ 8523.290669] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	sys va (user) : 0x0
	[ 8523.290671] iluvatar-bi 0000:00:03.0 [1491] mem_handle_dump_pte: : 		invld_host_ava[0]   : 0x0
	[ 8523.290674] iluvatar-bi 0000:00:03.0 [1491] mem_handle_dump_pte: : 		invld_host_ava[1]   : 0x0
	[ 8523.290676] iluvatar-bi 0000:00:03.0 [1491] mem_handle_dump_pte: : 		invld_host_ava[2]   : 0x0
	[ 8523.290678] iluvatar-bi 0000:00:03.0 [1491] mem_handle_dump_pte: : 		invld_host_ava[3]   : 0x0
	[ 8523.290681] iluvatar-bi 0000:00:03.0 [1491] mem_handle_dump_pte: : 		invld_host_ava[4]   : 0x0
	[ 8523.290683] iluvatar-bi 0000:00:03.0 [1491] mem_handle_dump_pte: : 		invld_host_ava[5]   : 0x0
	[ 8523.290685] iluvatar-bi 0000:00:03.0 [1491] mem_handle_dump_pte: : 		invld_host_ava[6]   : 0x0
	[ 8523.290688] iluvatar-bi 0000:00:03.0 [1491] mem_handle_dump_pte: : 		invld_host_ava[7]   : 0x0
	[ 8523.290690] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	dev_va        : 0x0
	[ 8523.290692] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	dev_pa        : 0x0
	[ 8523.290694] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	refcount      : 0x0
	[ 8523.290697] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	destroy delay : false
	[ 8523.290699] iluvatar-bi 0000:00:03.0 [1491] __mem_handle_dump: : 	pinned pages  : 0x0 (0, 0)
        ------------------------------------------------------------

IMHO, I think the log become more tidy after the patch.

Thanks
Huang Shijie
