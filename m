Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0C3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 19:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F99C216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 19:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="Q8SQWK8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfIHTbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 15:31:55 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:55207 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfIHTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 15:31:55 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id A3653214; Sun,  8 Sep 2019 19:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567971109;
        bh=CxPKTjvXFh/sMGEUjANehOfpQ0XuIiMOouyRvsLS4YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8SQWK8hQ696VqsOJ5xZ4Yu1jAfLv/DY1zQ13ItbpLR0FTyJPYpjQSa7Hqek7fr4i
         Az5hz+ie82ZvCpZ0bLuOxwOuc+JJbQIFl+xjI0emRUW7ycGwcXgmr+hy6frtBuhS12
         5uZUa4ZN38YHoMWbBISpU6vLj7z0d9/k+lmX1+hTiEa1cA1736x6O0IWZZbYbmH0CN
         Qgvc3yXXDSlWy3Fp1W/BF+255yqUNB7ymY4Ow0A0LkymuhWGTLRBoJXgnz8qDJRIYu
         x5ErRns5+KaX9mlbCQT3Je0VbccbrkUTfgwpxSFVeX636bkTiXDRy7hnOC1QElBxdq
         OuGP6YQYKyvHA==
Date:   Sun, 8 Sep 2019 19:31:49 +0000
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] staging: exfat: drop duplicate date_time_t struct
Message-ID: <20190908193149.GD7664@valentin-vidic.from.hr>
References: <20190908173539.26963-1-vvidic@valentin-vidic.from.hr>
 <20190908173539.26963-2-vvidic@valentin-vidic.from.hr>
 <20190908185424.GB10011@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908185424.GB10011@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 07:54:24PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Sep 08, 2019 at 05:35:37PM +0000, Valentin Vidic wrote:
> > +struct timestamp_t {
> > +	u16      millisec;   /* 0 ~ 999              */
> 
> You added this field to this structure, why?  You did not document that
> in the changelog text above.  Are you _sure_ you can do this and that
> this does not refer to an on-disk layout?

Both date_time_t and timestamp_t were used in memory only, but
date_time_t had the additional MilliSecond field. To keep the
functionality I added the millisec field to timestamp_t and
replaced all usages of date_time_t with timestamp_t.

For storing on disk the values from timestamp_t get shifted
and combined (exfat_set_entry_time).

-- 
Valentin
