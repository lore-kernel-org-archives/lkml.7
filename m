Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D5C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEC620C01
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557731697;
	bh=0vjm7BJSAo+A2YxcnfzZfoWM4WgRO7sXAA6JkaduZuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ClQwqtptCQAgCWq/Z04lMGNyoYBKk2NmwmbWM1PlTKdXNJDsAZ2Drt9rX1ktLuE4j
	 MsvBgbjXjxVxlvaoO6URSpRTkcaj5TxVJLnUwD59SmfjUL5Pkfj0ZX9pL3g7cdvwRV
	 vhof7G23ZrGHgLbMs8JFuzWhXTjC8vuKvEp2tosc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfEMHOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfEMHOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:14:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464F820578;
        Mon, 13 May 2019 07:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557731694;
        bh=0vjm7BJSAo+A2YxcnfzZfoWM4WgRO7sXAA6JkaduZuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJEwu0+rMPfOroLHfuKpLy6OEqzgxhviAsu/PambX+89fgLAEd5NLSIpPFndrBt4e
         RoGlSIre7yR+cOD3UhXSK94qHFCWhh+7WM8gvSAF9XwqL+AvZbOCzSl8hiDIgOeUha
         KJFZ4RNTw1j8eo4Z2P3gVSjR/A0A8bkrv83c7vHw=
Date:   Mon, 13 May 2019 09:14:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ocfs2: Fix error path kobject memory leak
Message-ID: <20190513071452.GG2868@kroah.com>
References: <20190513033458.2824-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513033458.2824-1-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 01:34:58PM +1000, Tobin C. Harding wrote:
> If a call to kobject_init_and_add() fails we should call kobject_put()
> otherwise we leak memory.
> 
> Add call to kobject_put() in the error path of call to
> kobject_init_and_add().  Please note, this has the side effect that
> the release method is called if kobject_init_and_add() fails.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
