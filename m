Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB19C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0171120818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SgnaZlRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfDOP5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:57:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOP5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uYbands8A7hvg7R0rJXQgpW8vvSABlyLkpry63I4iY0=; b=SgnaZlRSLi792UND9B+1D8Ctr
        wQc6Ek0lvhARW604uBt2zCMmJSPNEj6l2UhsqRRI6BJaXc0bFl9ua/SOitIlbRlToDK6uuRsxvZ3j
        ofAdqAPuDphvfvD1qL2088hC+1HG35v27c+CbC7ExAWYmFqgj8ISDJUnZiBZPbC8n3dMyZdLwYrOx
        QpFI2EaBlt1wcAf3zP5RhOFCr/NwFe+42Al3+qtGWYabS32SXZ6qFtf6GnMTNKL9jNE9UBK69I7sM
        qcbC04hNFr2EJia777i166LZRE1rEH1FAuHY77mY7GIFNimZIemhBPzdYApNb5qUc4DCtLsenvNUH
        ZvfTZ0sxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG3zM-0001RH-4s; Mon, 15 Apr 2019 15:57:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 781E9213A0759; Mon, 15 Apr 2019 17:57:42 +0200 (CEST)
Date:   Mon, 15 Apr 2019 17:57:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, kan.liang@intel.com, mingo@elte.hu,
        nelson.dsouza@intel.com, jolsa@redhat.com, tonyj@suse.com
Subject: Re: [PATCH v2 2/2] perf/x86/intel: force resched when TFA sysctl is
 modified
Message-ID: <20190415155742.GI12232@hirez.programming.kicks-ass.net>
References: <20190408173252.37932-1-eranian@google.com>
 <20190408173252.37932-3-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408173252.37932-3-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:32:52AM -0700, Stephane Eranian wrote:
> +static ssize_t set_sysctl_tfa(struct device *cdev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	bool val;
> +	ssize_t ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* no change */
> +	if (val == allow_tsx_force_abort)
> +		return count;
> +
> +	allow_tsx_force_abort = val;
> +
> +	get_online_cpus();
> +	on_each_cpu(update_tfa_sched, NULL, 1);
> +	put_online_cpus();
> +
> +	return count;
> +}

So we care about concurrent writing to that file?
