Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA4FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0EC2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553750912;
	bh=OivgbXJG+68tUwFH4XkMsfkEqPCFZVgWEvFNJtZgBMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1HbICfOuIRkRPEJNGdMd7NsIxv9dOF70/pJdlFuuAaYGKhYWB7ofzTvu5jBYmuSV+
	 wXasq0Gy6zBgrOWr3a6OQIkTQKA7YX44GR+oCkknK61jyDwDEdr1ip3+uZjevXDrGw
	 Vu1B4tPzYTI11inrnD/GZraa4sr/9QWKn/fuX1yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfC1F2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfC1F2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:28:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA07820811;
        Thu, 28 Mar 2019 05:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553750910;
        bh=OivgbXJG+68tUwFH4XkMsfkEqPCFZVgWEvFNJtZgBMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwHdwHGHW1zx4+VpcB/p1BmeKvDiOt4KRx4GyJDysK6fxCuoj9qc0HyvyB4NYGPVY
         JuHyIcC7KN1V5CWZcWitXv07T0pi2qjFvLZvg2pV3zoNHEs0SZeHCiyuIiBH8mFZpG
         UyxuWKoE3QIxCQ1nbNmSh9gDtJA9yEBuuvEMOLIU=
Date:   Thu, 28 Mar 2019 06:28:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Zhang, Jun" <jun.zhang@intel.com>
Cc:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "He, Bo" <bo.he@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: Re: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Message-ID: <20190328052826.GA18668@kroah.com>
References: <20190322111210.465931067@linuxfoundation.org>
 <20190322111220.102008032@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A646D1@SHSMSX104.ccr.corp.intel.com>
 <20190323063315.GB31361@kroah.com>
 <20190325160017.GD4102@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A6526B@SHSMSX104.ccr.corp.intel.com>
 <20190326155537.GO4102@linux.ibm.com>
 <88DC34334CA3444C85D647DBFA962C2735B04EB8@SHSMSX104.ccr.corp.intel.com>
 <20190327151012.GY4102@linux.ibm.com>
 <88DC34334CA3444C85D647DBFA962C2735B0510F@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88DC34334CA3444C85D647DBFA962C2735B0510F@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:36:12AM +0000, Zhang, Jun wrote:
> Hello, Paul
> 
> Yes, I only use original V3.18.136 to test. Because system run very slowly, I give up.
> 
> Device: NUC (made in 2017)
> OS:        ubuntu 16.04
> Kernel: V3.18.136 (come from https://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.136/) 
> System can boot, but run very slowly, and couldn't connect the network.
> This make me not to work with terminal, because system very slowly. 
> So I don’t use V3.18.136+patch to test.

Please do not worry about 3.18.y if it is any problem, I only keep it
alive for a few users and if they have not reported issues yet, it is
fine.  Please do not do any extra work for this kernel tree at all, it
is just too old :)

thanks,

greg k-h
