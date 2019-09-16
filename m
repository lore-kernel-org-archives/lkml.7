Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC89C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF1E214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568636682;
	bh=kEGjavWLM0vbDXJ8cxrYtukR2OaYgF4ldAp/Hbo44EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F01fT6LNFcOV/4xGAE1KN0YOXWSdk/RIa/nMUaoFjXpcv6zSrJrzPNCBGxAj3OJe0
	 RRmPfoyXTg7iT4bFqDJ9kjmF8lI39+v4UfqpIsL8Ch758kIoOx4ap/oNfOSMRdxFIW
	 DPddHdIiHZNVRhm3c6HGUaQRpZcW5caFhFw5pCR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfIPMYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbfIPMYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:24:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F895B643;
        Mon, 16 Sep 2019 12:24:37 +0000 (UTC)
Date:   Mon, 16 Sep 2019 14:23:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
        bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com,
        chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com,
        jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        tbogendoerfer@suse.de, linux-mips@vger.kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v4] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190916122359.GG10231@dhcp22.suse.cz>
References: <1568535656-158979-1-git-send-email-linyunsheng@huawei.com>
 <20190916084328.GC10231@dhcp22.suse.cz>
 <8df06e27-ad21-bf14-dbd6-cc8f5a274ec2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df06e27-ad21-bf14-dbd6-cc8f5a274ec2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-09-19 20:07:22, Yunsheng Lin wrote:
[...]
> >> @@ -861,9 +861,12 @@ void numa_remove_cpu(int cpu)
> >>   */
> >>  const struct cpumask *cpumask_of_node(int node)
> >>  {
> >> -	if (node >= nr_node_ids) {
> >> +	if (node == NUMA_NO_NODE)
> >> +		return cpu_online_mask;
> >> +
> >> +	if ((unsigned int)node >= nr_node_ids) {
> >>  		printk(KERN_WARNING
> >> -			"cpumask_of_node(%d): node > nr_node_ids(%u)\n",
> >> +			"cpumask_of_node(%d): node >= nr_node_ids(%u)\n",
> >>  			node, nr_node_ids);
> >>  		dump_stack();
> >>  		return cpu_none_mask;
> > 
> > Why do we need this?
> 
> As the commit log says, the above cpumask_of_node() is for debugging,
> it should catch other "node < 0" cases except NUMA_NO_NODE.

OK, I would just make it a separate patch.

-- 
Michal Hocko
SUSE Labs
