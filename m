Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D88ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218DF20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571162915;
	bh=2vnG9zvitjyN5YRzL5mKaObhzjkQF1sodt7gWZ0dIcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jv6Pi69RojslmdUQNyyMSTaDnohVPxic/OYQn9V12z8vM5goA3nKUzbecYknaDUj1
	 C/5izwZcL6FUD40RiEluXheWFgWa7eprZFMXtlx0e43ibgcGhoh34p+/CaNmtA7WF/
	 X1h7lCzq5Mmnw6S82Imigoc0bz2gc26dTWr7RZFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbfJOSIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfJOSId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:08:33 -0400
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CBB2086A;
        Tue, 15 Oct 2019 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571162912;
        bh=2vnG9zvitjyN5YRzL5mKaObhzjkQF1sodt7gWZ0dIcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yAT3GUSAolCquTvf0Pp53cAn87OGSGsmXvt3fY4x0HaTP066nxrMrhNi7XLAlokKE
         NWsDhq+FLeSto9SRMOpINc6fpIPqogRq0L018DXZmvmzfgy4z30ezv6OJoGgL3JTax
         /P2UHzW5dXogVigVJRFOU5dlh8rj9MaA1vY2KC/Q=
Date:   Tue, 15 Oct 2019 19:55:55 +0200
From:   reg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v5 2/3] uacce: add uacce driver
Message-ID: <20191015175555.GB1072965@kroah.com>
References: <1571035735-31882-1-git-send-email-zhangfei.gao@linaro.org>
 <1571035735-31882-3-git-send-email-zhangfei.gao@linaro.org>
 <20191014113231.00002967@huawei.com>
 <e71edf57-8449-e8d1-01ba-aed3ecf379e1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e71edf57-8449-e8d1-01ba-aed3ecf379e1@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:39:00PM +0800, zhangfei wrote:
> Hi, Jonathan
> 
> On 2019/10/14 下午6:32, Jonathan Cameron wrote:
> > On Mon, 14 Oct 2019 14:48:54 +0800
> > Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> > 
> > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > > 
> > > Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
> > > provide Shared Virtual Addressing (SVA) between accelerators and processes.
> > > So accelerator can access any data structure of the main cpu.
> > > This differs from the data sharing between cpu and io device, which share
> > > data content rather than address.
> > > Since unified address, hardware and user space of process can share the
> > > same virtual address in the communication.
> > > 
> > > Uacce create a chrdev for every registration, the queue is allocated to
> > > the process when the chrdev is opened. Then the process can access the
> > > hardware resource by interact with the queue file. By mmap the queue
> > > file space to user space, the process can directly put requests to the
> > > hardware without syscall to the kernel space.
> > > 
> > > Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> > > Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> > > Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> > > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Hi,
> > 
> > Some superficial comments from me.
> Thanks for the suggestion.
> > > +/*
> > > + * While user space releases a queue, all the relatives on the queue
> > > + * should be released immediately by this putting.
> > This one needs rewording but I'm not quite sure what
> > relatives are in this case.
> > > + */
> > > +static long uacce_put_queue(struct uacce_queue *q)
> > > +{
> > > +	struct uacce_device *uacce = q->uacce;
> > > +
> > > +	mutex_lock(&uacce_mutex);
> > > +
> > > +	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
> > > +		uacce->ops->stop_queue(q);
> > > +
> > > +	if ((q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED) &&
> > > +	     uacce->ops->put_queue)
> > > +		uacce->ops->put_queue(q);
> > > +
> > > +	q->state = UACCE_Q_ZOMBIE;
> > > +	mutex_unlock(&uacce_mutex);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > ..
> > 
> > > +
> > > +static ssize_t qfrs_size_show(struct device *dev,
> > > +				struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct uacce_device *uacce = to_uacce_device(dev);
> > > +	unsigned long size;
> > > +	int i, ret;
> > > +
> > > +	for (i = 0, ret = 0; i < UACCE_QFRT_MAX; i++) {
> > > +		size = uacce->qf_pg_size[i] << PAGE_SHIFT;
> > > +		if (i == UACCE_QFRT_SS)
> > > +			break;
> > > +		ret += sprintf(buf + ret, "%lu\t", size);
> > > +	}
> > > +	ret += sprintf(buf + ret, "%lu\n", size);
> > > +
> > > +	return ret;
> > > +}
> > This may break the sysfs rule of one thing per file.  If you have
> > multiple regions, they should probably each have their own file
> > to give their size.
> Is the rule must be applied?

Yes, it always must be followed.  Please fix.

