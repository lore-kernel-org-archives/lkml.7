Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83954C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F6021883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567631195;
	bh=YIZN2wM55zKdgwL+0xN86o81SzNdsgWSw7Svn4BwB44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BKd+m9drv2Nlsyd4b3ggzsioBehth0titySX9LKzcCnNWvqf10La9iaw+1sUCGmCe
	 92yTXRtHeKpCkPNFuio6+IgOBODy0ONacRwFvdNB9iVbd10uFTYOtLlbovEZ5gGJCY
	 brsya57GJycKh96WD0AWvLcptnmKLHD/crNZJsV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfIDVGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:06:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37441 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbfIDVGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:06:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id s28so404444otd.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIZN2wM55zKdgwL+0xN86o81SzNdsgWSw7Svn4BwB44=;
        b=KrI/WeVz1Q87wpkYDsgiu39HziiqZw1TTr1fWqZ5pyphtbeRtvuWLULKDvKyPzDDxj
         j/vF4J1p58RAAB4NmPrOelfOW6oEhG2Y6fBFq1h54WStLlU9Pa1svDLhofDdyzGuWzJC
         ZieeODDV7km8sdp/2UaiBqsBi+1yAD8HpevV6IKnX3E6sex/0mrWk3LOe79mxmWDxL1R
         JlXSPwa1MsGNUam6e+3wX2pNUloaDfRAy7hSsuPArkryJuOKhsyF8CYfywhNNFOttrAV
         NHQAi9BTezlzmnXGQ4ZLy3xt5FstMM4Zd95Hb2WiT2BXQjl7aln5z2yBXWrVLunDVuFL
         QjFA==
X-Gm-Message-State: APjAAAXzk6o2OzsGJnvBvjHyHMqov3UDEsETCmwCm8pwAyPpwFnahP7b
        kx8pjZr/i9JYWHfTH95MWHaPBIUldKsUITNp0JQ=
X-Google-Smtp-Source: APXvYqyMjenX8y8SBV0Gg3SVH0N+zZcrn+GaGc7vuiriVI7wzdJ34CEHNXpGDQCpXcbFQIxYpc8TWfe+oUnoHD4Vlug=
X-Received: by 2002:a9d:7411:: with SMTP id n17mr14551012otk.118.1567631192682;
 Wed, 04 Sep 2019 14:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190830075156.76873-1-heikki.krogerus@linux.intel.com>
 <20190830075156.76873-3-heikki.krogerus@linux.intel.com> <20190904120732.GB15829@kroah.com>
In-Reply-To: <20190904120732.GB15829@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Sep 2019 23:06:21 +0200
Message-ID: <CAJZ5v0h_UUu8ATkK0t7ffSg6hQiFf0JsHYNTSGZeELkNrxoe5g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] software node: Initialize the return value in software_node_find_by_name()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 2:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 30, 2019 at 10:51:56AM +0300, Heikki Krogerus wrote:
> > The software node is searched from a list that may be empty
> > when the function is called. This makes sure that the
> > function returns NULL if the list is empty.
> >
> > Fixes: 1666faedb567 ("software node: Add software_node_get_reference_args()")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thanks!
