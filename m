Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6077C4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 19:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722CE216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 19:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="jlQNJiAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfIHTk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 15:40:26 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:41383 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfIHTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 15:40:26 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 4B168214; Sun,  8 Sep 2019 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567971623;
        bh=Vd55c8Am4HzVLce0/fah1MmvqNZ1LcggOOpKi92SLsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlQNJiAXGoSPD3Gv3UhryuubeenyTJ7bW9tuV6fjpF0Ya86MkuKfo2dgHdlLvox6z
         HO7n/Que7mZTYuaHFfLDX5CGRQXPmXwsYELvRfFKHAuWW2zrHaPGUWsRGTugMLxmRM
         FA7xyVhz17EhD/M2GftvSV+/WgVcu2pDOwt4YEl+kzo0/pV7k0fjecVQ8vfWVOS2UV
         ZM9FJblzxlbnOUYevffii2GAuXXKGlC9vwCDaF18HUKODDei36GzjgVC30Xl+82GA3
         MtZOTxpPBU1WaCjSGZgUyvRAqKwOJWXKqgewm+08eYPjvP6HgjyIP/j98BZHug8yQ+
         E0gA9b7X7dQ6Q==
Date:   Sun, 8 Sep 2019 19:40:23 +0000
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] staging: exfat: drop duplicate date_time_t struct
Message-ID: <20190908194023.GE7664@valentin-vidic.from.hr>
References: <20190908173539.26963-1-vvidic@valentin-vidic.from.hr>
 <20190908173539.26963-2-vvidic@valentin-vidic.from.hr>
 <20190908185031.GA10011@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908185031.GA10011@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 07:50:31PM +0100, Greg Kroah-Hartman wrote:
> Wait, how are these "duplicate"?  The fields are in different order,
> don't these refer to things on-disk?

On-disk combines the values from these structures in a different form:

          offset  bits
DoubleSeconds  0  5
Minute         5  6
Hour          11  5
Day           16  5
Month         21  4
Year          25  7

> Did you test this?

Just compile tested for now.

> > -struct date_time_t {
> > -	u16      Year;
> > -	u16      Month;
> > -	u16      Day;
> > -	u16      Hour;
> > -	u16      Minute;
> > -	u16      Second;
> > -	u16      MilliSecond;
> > -};
> > -
> >  struct part_info_t {
> >  	u32      Offset;    /* start sector number of the partition */
> >  	u32      Size;      /* in sectors */
> > @@ -289,6 +279,16 @@ struct file_id_t {
> >  	u32      hint_last_clu;
> >  };
> >  
> > +struct timestamp_t {
> > +	u16      millisec;   /* 0 ~ 999              */
> > +	u16      sec;        /* 0 ~ 59               */
> > +	u16      min;        /* 0 ~ 59               */
> > +	u16      hour;       /* 0 ~ 23               */
> > +	u16      day;        /* 1 ~ 31               */
> > +	u16      mon;        /* 1 ~ 12               */
> > +	u16      year;       /* 0 ~ 127 (since 1980) */
> > +};
> 
> They really look "backwards" to me, how are these the same?  What am I
> missing?

date_time_t was only used in a few functions and there was a lot of
copying of the same fields between the two structs. Also some code was
duplicated to do the same thing for each of the structs.

-- 
Valentin
