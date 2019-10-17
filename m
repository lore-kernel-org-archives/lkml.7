Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EA4ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C8220869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="dAqxCBcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393663AbfJQPrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:47:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46270 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732271AbfJQPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:47:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so1895602pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=RHyZYAsncwO+1y3gT7p2kMm026xbVHy1Bz1QKVwtduw=;
        b=dAqxCBcgExWa9d/zXtebu/wc8XkmW9tWdF82oFnqCZR2Es8twMiKkrirmiQwjRn/8L
         QdQ+WbvwDET5R9mk1bcvsLcCUBdJ+8NG3vnrfUOZNpW3bz8ezax8GyuMrt06yacVoH/S
         rQpghiyy0p/elKkZRl3Xurxq8e4aiINYRyq1ILf4Wl1ywsQrOSZrTspb02e/Gez4Kn1O
         AoWCPQLrYoTWmKNInqWJKxc0AHqNwIJAvFVxX0AFWvM2vVZkGnz7p6TZgIZFtQZbAAkP
         XtFue3lYGhIYhIW0IThMugWjdKukXm/diiFnapRhOwsncxld3zzwuQqnvy5ZtCPEeh3f
         R+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RHyZYAsncwO+1y3gT7p2kMm026xbVHy1Bz1QKVwtduw=;
        b=RlUIYvv+iLP1iScHVTbNVf8My6LHOZYc2PzQ41y9WYe30dYt2L3RDbliJHMoAyPaaF
         rLT6U7qS7dFbN8FgsYd350QUpwFnOq98+QAkZHZrepEBp4HRoxhbHC8Q4Zk+uAE/kfwh
         01ioLqWOIg2nMCjX2JcrT4L4+WUl8Afy06dyYTwIKuBmWB/ThEXXVC/k46bxrN/gNyO0
         Vo4paqdng2OAc+T/6bUg4Wj8Tu06e4dc+RWvubjcKVNDLVAhCxaxKvrrx08r/x8IpCtg
         HnpEpYoq1eZOXA7WijuJ3vKCAHnA7PwpJrlY5ObFfDHUmijSVh2KzEEILPRmlnDCWDMw
         8k7A==
X-Gm-Message-State: APjAAAUBHxiYRElJFaAwX7DP+4T5CHTqLazGFRneXoTFEF1v6XV80eP0
        jrNdgPU0Ria0kpJH+BHl4vU7ag==
X-Google-Smtp-Source: APXvYqzaiwFpMLi7/mP+QP4mSVnfKtonlpByAzTy67XnrO4kd6FegbAEBo7+1C75ocpNjMK8sA0GLQ==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr4763645pgb.185.1571327267773;
        Thu, 17 Oct 2019 08:47:47 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id l22sm2596138pgj.4.2019.10.17.08.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 08:47:47 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:47:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     tanhuazhong <tanhuazhong@huawei.com>
Cc:     David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 00/12] net: hns3: add some bugfixes and
 optimizations
Message-ID: <20191017084743.1a5875ff@cakuba.netronome.com>
In-Reply-To: <d76b854c-5f6d-27b6-d40e-e3c0404b5695@huawei.com>
References: <1571210231-29154-1-git-send-email-tanhuazhong@huawei.com>
        <20191016101943.415d73cf@cakuba.netronome.com>
        <20191016.135003.672960397161023411.davem@davemloft.net>
        <d76b854c-5f6d-27b6-d40e-e3c0404b5695@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 11:27:09 +0800, tanhuazhong wrote:
> On 2019/10/17 1:50, David Miller wrote:
> > From: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Date: Wed, 16 Oct 2019 10:19:43 -0700
> >   
> >> On Wed, 16 Oct 2019 15:16:59 +0800, Huazhong Tan wrote:  
> >>> This patch-set includes some bugfixes and code optimizations
> >>> for the HNS3 ethernet controller driver.  
> >>
> >> The code LGTM, mostly, but it certainly seems like patches 2, 3 and 4
> >> should be a separate series targeting the net tree :(  
> > 
> > Agreed, there are legitimate bug fixes.
> > 
> > I have to say that I see this happening a lot, hns3 bug fixes targetting
> > net-next in a larger series of cleanups and other kinds of changes.
> > 
> > Please handle this delegation properly.  Send bug fixes as a series targetting
> > 'net', and send everything else targetting 'net-next'.
> >   
> 
> Hi, David & Jakub.
> 
> BTW, patch01 is a cleanup which is needed by patch02,
> if patch01 targetting 'net-next', patch02 targetting 'net',
> there will be a gap again. How should I deal with this case?

You'll need to reorder the cleanup so that the fixes apply to the
unmodified net tree.

Then preferably wait for the net tree to be merged back to net-next
before posting the cleanup that'd conflict.  If the conflict is not 
too hard to resolve you can just post the net-next patches and give
some instructions on how to resolve the merge conflict under the ---
lines in the commit message.
