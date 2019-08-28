Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC2DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E46214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kraav.com header.i=@kraav.com header.b="dXbBqNAW";
	dkim=pass (1024-bit key) header.d=kraav.com header.i=@kraav.com header.b="dXbBqNAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfH1KrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:47:21 -0400
Received: from mail-out.elkdata.ee ([185.7.252.64]:31339 "EHLO
        mail-out.elkdata.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfH1KrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:47:21 -0400
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-out.elkdata.ee (Postfix) with ESMTP id 8F5A4372F99
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:47:16 +0300 (EEST)
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id 8DCE4830881
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:47:16 +0300 (EEST)
X-Virus-Scanned: amavisd-new at elkdata.ee
Received: from mail-relay2.elkdata.ee ([185.7.252.69])
        by mail-relay2.elkdata.ee (mail-relay2.elkdata.ee [185.7.252.69]) (amavisd-new, port 10024)
        with ESMTP id f6fMxR7F8B_F for <linux-kernel@vger.kernel.org>;
        Wed, 28 Aug 2019 13:47:13 +0300 (EEST)
Received: from mail.elkdata.ee (unknown [185.7.252.68])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id ABDFD83088C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:47:13 +0300 (EEST)
Received: from mail.meie.biz (21-182-190-90.sta.estpak.ee [90.190.182.21])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: leho@jaanalind.ee)
        by mail.elkdata.ee (Postfix) with ESMTPSA id A6D6760BF3B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:47:13 +0300 (EEST)
Received: by mail.meie.biz (Postfix, from userid 500)
        id 88F3EA83EC6; Wed, 28 Aug 2019 13:47:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1566989233; bh=9Go7CWmyKZXk3qBxkNYiEELDakRvGKjVtCVkhs1F/+Q=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=dXbBqNAWOPE2KKQjUZ9tueT/ZrK0KBIg1tjBYiy2HULunLcxoaimi9Mt6VlY92PsV
         CZ6l7dXNVjHAnVPRKhrjtr+4NR/3D2DeLnBpyWwri2i7N44tXaEItL0ebwmOpP76Db
         qKtgv9JWOUFTgH1/08nctfHHqZVtleXH9SNPytu8=
Received: from papaya (papaya-vpn.meie.biz [192.168.48.157])
        by mail.meie.biz (Postfix) with ESMTPA id 5E3B7A83EC4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:47:13 +0300 (EEST)
Authentication-Results: mail.meie.biz; dmarc=fail (p=none dis=none) header.from=kraav.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1566989233; bh=9Go7CWmyKZXk3qBxkNYiEELDakRvGKjVtCVkhs1F/+Q=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=dXbBqNAWOPE2KKQjUZ9tueT/ZrK0KBIg1tjBYiy2HULunLcxoaimi9Mt6VlY92PsV
         CZ6l7dXNVjHAnVPRKhrjtr+4NR/3D2DeLnBpyWwri2i7N44tXaEItL0ebwmOpP76Db
         qKtgv9JWOUFTgH1/08nctfHHqZVtleXH9SNPytu8=
Received: (nullmailer pid 3392 invoked by uid 1000);
        Wed, 28 Aug 2019 10:47:13 -0000
Date:   Wed, 28 Aug 2019 13:47:13 +0300
From:   Leho Kraav <leho@kraav.com>
To:     linux-kernel@vger.kernel.org
Subject: Re: 5.3.0-rc6: i915 fails at typec_displayport 5120x1440
Message-ID: <20190828104713.GA3319@papaya>
References: <20190827080834.GB4124@papaya>
 <20190827082043.GC4124@papaya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827082043.GC4124@papaya>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.500000, version=1.2.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:20:44AM +0300, Leho Kraav wrote:
> On Tue, Aug 27, 2019 at 11:08:34AM +0300, Leho Kraav wrote:
> > Hardware: Dell Latitude 7400 2-in-1, Whiskey Lake, Intel 620
> > 
> > 5120x1440 fails to display.
> 
> Looks like I'm not alone, either
> 
> https://www.reddit.com/r/linuxquestions/comments/cddpne/linux_and_ultrawide/

Solved via https://bugs.freedesktop.org/show_bug.cgi?id=111501#c5

This is probably due to commit 372b9ffb5799 ("drm/i915: Fix skl+ max plane width")

Tyvm Ville.
