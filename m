Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A487DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E17C21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570131564;
	bh=u5LDX4VP7zjWjiWiV93K8jB/kbdhhPtqMeRlPcoINN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WzwRSP1/6CX9S7E1FWSgebDyYxochyxrDW+WQK8xIz5VZ2jOdMo33MhDSpPBwNsUQ
	 j4wyRwDK0yQtRVEFgj3xNI2DalQp41WgcM+YViq5NsH+zWfZe4P3dxYeNKto9U78wA
	 OqPR7n1uIKYZwN9kl7oYbWXcwSLJ5KTSxCflBsj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbfJCTjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:39:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbfJCTjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/TI97UwnUtCUh/ketzcCjD3YZ+yCnk0mwMvAyFffhq4=; b=qKTUPA9aLACEr9wxYj2aWAU2A
        jZ+qGbPmVxBaJ2adNTzFICrcaDYufzvPvHExyOWBgWgoeaku2eHhI7SNKeHasF70VBAKtXxwjzLdm
        /qYgnUr1CcTyGuCBgBQGjImXBwL8Vums3oBlTwFU4ovz6G3JTJf1zKmJt2GJeBYTgfTVQejZf4CYl
        0oLmmlLgsTSDG0og7PwrPx2arjlx/pgCYihf545BwMtKs2yx7H9WRrmiV4IH2U18I3oxZ6+S27M3F
        fT3GymwAA0OQt828zLNQxy4nPTgajQBADoRfr61QxFODUkSrDWMA/Wa7EqbV3NMmS38o+dJqNJ8Ve
        udRjx7j6A==;
Received: from 177.133.68.49.dynamic.adsl.gvt.net.br ([177.133.68.49] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG6wY-0001gK-SF; Thu, 03 Oct 2019 19:39:19 +0000
Date:   Thu, 3 Oct 2019 16:39:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Gonsolo <gonsolo@gmail.com>
Cc:     JP <jp@jpvw.nl>, crope@iki.fi, Sean Young <sean@mess.org>,
        linux-media@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] si2157: Add support for Logilink VG0022A.
Message-ID: <20191003163914.7c384d36@coco.lan>
In-Reply-To: <CANL0fFQms9oyec_1UevbJ7aLp+KNJ3h6UhGEbqrnCNO286rbGg@mail.gmail.com>
References: <29ab2e43-4374-a3ea-6ae1-a4267867eaa4@jpvw.nl>
        <20191002154922.7f1cfc76@coco.lan>
        <CANL0fFRJZBfEDWK_c2w1TomvB5-i4g09LopyJUbO5NtOwKdDTg@mail.gmail.com>
        <20191003080539.2b13c03b@coco.lan>
        <CANL0fFSmvEEJhnA=qjTuEPr4N8q8eWLeYC5du+OoTMxe1Gnh5Q@mail.gmail.com>
        <20191003120238.75811da6@coco.lan>
        <20191003160336.GA5125@Limone>
        <20191003130909.01d29b77@coco.lan>
        <20191003162326.GA2727@Limone>
        <20191003144225.0137bf6c@coco.lan>
        <20191003183200.GA2631@Limone>
        <e468b867-1b45-8220-a5d2-ac40fdb4e0e6@jpvw.nl>
        <CANL0fFQms9oyec_1UevbJ7aLp+KNJ3h6UhGEbqrnCNO286rbGg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 3 Oct 2019 21:19:16 +0200
Gonsolo <gonsolo@gmail.com> escreveu:

> > try other firmware?
> > http://palosaari.fi/linux/v4l-dvb/firmware/Si2168/  
> 
> I tried all of them. No difference.

Maybe the vendor of this device wrote a different firmware. That happens.

Thanks,
Mauro
